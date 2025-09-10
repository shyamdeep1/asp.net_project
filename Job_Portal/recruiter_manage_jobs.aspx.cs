using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Job_Portal
{
    public partial class recruiter_jobs : System.Web.UI.Page
    {
        // Add protected controls from the ASPX page
        protected GridView gvJobs;
        protected Label lblMessage;
        protected HiddenField hdnJobId;
        protected TextBox txtEditJobTitle;
        protected TextBox txtEditDescription;
        protected TextBox txtEditLocation;
        protected TextBox txtEditSalary;
        protected TextBox txtEditSkills;
        protected TextBox txtEditExperience;
        protected DropDownList ddlEditJobType;
        protected DropDownList ddlEditCategory;
        protected TextBox txtEditDeadline;
        protected CheckBox chkEditActive;
        protected FileUpload fuEditCompanyLogo;
        protected Image imgCurrentLogo;
        protected Label lblEditMessage;
        protected Button btnUpdateJob;

        string conn = ConfigurationManager.ConnectionStrings["JobPortalConnection"].ConnectionString;
        SqlConnection con;
        string LogoFileName;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] == null)
                {
                    Response.Redirect("login.aspx");
                }
                else
                {
                    BindJobsGrid();
                }
            }
        }

        private void getcon()
        {
            con = new SqlConnection(conn);
            con.Open();
        }

        private void BindJobsGrid()
        {
            try
            {
                int userId = Convert.ToInt32(Session["UserID"]);
                int recruiterId = GetRecruiterId(userId);

                if (recruiterId <= 0) return;

                getcon();
                string query = @"SELECT J.JobID, J.JobTitle, J.JobDescription, J.Location, J.Salary, J.SkillsRequired, 
                               J.ExperienceRequired, J.JobType, J.Category, J.Deadline, J.Company_Logo, 
                               CASE WHEN J.IsActive IS NULL THEN 1 ELSE J.IsActive END AS IsActive
                               FROM Jobs J WHERE J.RecruiterID = @RecruiterID
                               ORDER BY J.JobID DESC";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@RecruiterID", recruiterId);

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                gvJobs.DataSource = dt;
                gvJobs.DataBind();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
                lblMessage.CssClass = "text-danger mb-3 d-block";
            }
            finally
            {
                if (con != null && con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
        }

        private int GetRecruiterId(int userId)
        {
            try
            {
                getcon();
                string recruiterQuery = "SELECT RecruiterID FROM Recruiters WHERE UserID = @UserID";
                SqlCommand recruiterCmd = new SqlCommand(recruiterQuery, con);
                recruiterCmd.Parameters.AddWithValue("@UserID", userId);
                object result = recruiterCmd.ExecuteScalar();

                if (result != null)
                {
                    return Convert.ToInt32(result);
                }
                else
                {
                    lblMessage.Text = "Error: Recruiter profile not found.";
                    lblMessage.CssClass = "text-danger mb-3 d-block";
                    return -1;
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
                lblMessage.CssClass = "text-danger mb-3 d-block";
                return -1;
            }
            finally
            {
                if (con != null && con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
        }

        protected void gvJobs_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int jobId = Convert.ToInt32(e.CommandArgument);

            switch (e.CommandName)
            {
                case "EditJob":
                    GetJobDetails(jobId);
                    ClientScript.RegisterStartupScript(this.GetType(), "OpenEditModal", "openEditModal();", true);
                    break;

                case "DeleteJob":
                    DeleteJob(jobId);
                    break;

                case "ViewApps":
                    // Redirect to applications page with job ID
                    Response.Redirect("recruiter_applications.aspx?jobId=" + jobId);
                    break;
            }
        }

        protected void gvJobs_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvJobs.PageIndex = e.NewPageIndex;
            BindJobsGrid();
        }

        protected void btnUpdateJob_Click(object sender, EventArgs e)
        {
            try
            {
                int jobId = Convert.ToInt32(hdnJobId.Value);
                UpdateJob(jobId);
            }
            catch (Exception ex)
            {
                lblEditMessage.Text = "Error: " + ex.Message;
            }
        }

        private void GetJobDetails(int jobId)
        {
            try
            {
                getcon();
                string query = @"SELECT JobID, JobTitle, JobDescription, Location, Salary, SkillsRequired, 
                               ExperienceRequired, JobType, Category, Deadline, Company_Logo, IsActive
                               FROM Jobs WHERE JobID = @JobID";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@JobID", jobId);

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    hdnJobId.Value = jobId.ToString();
                    txtEditJobTitle.Text = reader["JobTitle"].ToString();
                    txtEditDescription.Text = reader["JobDescription"].ToString();
                    txtEditLocation.Text = reader["Location"].ToString();
                    txtEditSalary.Text = reader["Salary"].ToString();
                    txtEditSkills.Text = reader["SkillsRequired"].ToString();
                    txtEditExperience.Text = reader["ExperienceRequired"].ToString();
                    ddlEditJobType.SelectedValue = reader["JobType"].ToString();
                    ddlEditCategory.SelectedValue = reader["Category"].ToString();

                    DateTime deadline;
                    if (DateTime.TryParse(reader["Deadline"].ToString(), out deadline))
                    {
                        txtEditDeadline.Text = deadline.ToString("yyyy-MM-dd");
                    }

                    bool isActive = true;
                    if (reader["IsActive"] != DBNull.Value)
                    {
                        isActive = Convert.ToBoolean(reader["IsActive"]);
                    }
                    chkEditActive.Checked = isActive;

                    string logoPath = reader["Company_Logo"].ToString();
                    if (!string.IsNullOrEmpty(logoPath))
                    {
                        imgCurrentLogo.ImageUrl = logoPath;
                        imgCurrentLogo.Visible = true;
                    }
                    else
                    {
                        imgCurrentLogo.Visible = false;
                    }
                }
                reader.Close();
            }
            catch (Exception ex)
            {
                lblEditMessage.Text = "Error: " + ex.Message;
            }
            finally
            {
                if (con != null && con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
        }

        private void UpdateJob(int jobId)
        {
            try
            {
                string logoPath = string.Empty;
                if (fuEditCompanyLogo.HasFile)
                {
                    LogoFileName = "~/Logo/" + fuEditCompanyLogo.FileName;
                    fuEditCompanyLogo.SaveAs(Server.MapPath(LogoFileName));
                    logoPath = LogoFileName;
                }

                getcon();
                string updateQuery = @"UPDATE Jobs SET 
                                    JobTitle = @JobTitle,
                                    JobDescription = @JobDescription,
                                    Location = @Location,
                                    Salary = @Salary,
                                    SkillsRequired = @SkillsRequired,
                                    ExperienceRequired = @ExperienceRequired,
                                    JobType = @JobType,
                                    Category = @Category,
                                    Deadline = @Deadline,
                                    IsActive = @IsActive";

                if (!string.IsNullOrEmpty(logoPath))
                {
                    updateQuery += ", Company_Logo = @CompanyLogo";
                }

                updateQuery += " WHERE JobID = @JobID";

                SqlCommand cmd = new SqlCommand(updateQuery, con);
                cmd.Parameters.AddWithValue("@JobID", jobId);
                cmd.Parameters.AddWithValue("@JobTitle", txtEditJobTitle.Text.Trim());
                cmd.Parameters.AddWithValue("@JobDescription", txtEditDescription.Text.Trim());
                cmd.Parameters.AddWithValue("@Location", txtEditLocation.Text.Trim());
                cmd.Parameters.AddWithValue("@Salary", txtEditSalary.Text.Trim());
                cmd.Parameters.AddWithValue("@SkillsRequired", txtEditSkills.Text.Trim());
                cmd.Parameters.AddWithValue("@ExperienceRequired", txtEditExperience.Text.Trim());
                cmd.Parameters.AddWithValue("@JobType", ddlEditJobType.SelectedValue);
                cmd.Parameters.AddWithValue("@Category", ddlEditCategory.SelectedValue);
                cmd.Parameters.AddWithValue("@Deadline", Convert.ToDateTime(txtEditDeadline.Text));
                cmd.Parameters.AddWithValue("@IsActive", chkEditActive.Checked);

                if (!string.IsNullOrEmpty(logoPath))
                {
                    cmd.Parameters.AddWithValue("@CompanyLogo", logoPath);
                }

                cmd.ExecuteNonQuery();

                lblMessage.Text = "Job updated successfully!";
                lblMessage.CssClass = "text-success mb-3 d-block";

                BindJobsGrid();
                ClientScript.RegisterStartupScript(this.GetType(), "CloseEditModal", "$('#editJobModal').modal('hide');", true);
            }
            catch (Exception ex)
            {
                lblEditMessage.Text = "Error: " + ex.Message;
            }
            finally
            {
                if (con != null && con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
        }

        private void DeleteJob(int jobId)
        {
            try
            {
                getcon();
                
                // Check if there are applications for this job
                string checkApplicationsQuery = "SELECT COUNT(*) FROM JobApplications WHERE JobID = @JobID";
                SqlCommand checkCmd = new SqlCommand(checkApplicationsQuery, con);
                checkCmd.Parameters.AddWithValue("@JobID", jobId);
                
                int applicationsCount = Convert.ToInt32(checkCmd.ExecuteScalar());
                
                if (applicationsCount > 0)
                {
                    // Instead of deleting, just set the job to inactive
                    string deactivateQuery = "UPDATE Jobs SET IsActive = 0 WHERE JobID = @JobID";
                    SqlCommand deactivateCmd = new SqlCommand(deactivateQuery, con);
                    deactivateCmd.Parameters.AddWithValue("@JobID", jobId);
                    deactivateCmd.ExecuteNonQuery();
                    
                    lblMessage.Text = "Job has been deactivated because it has applications. It will no longer be visible to job seekers.";
                }
                else
                {
                    // If no applications, we can safely delete the job
                    string deleteQuery = "DELETE FROM Jobs WHERE JobID = @JobID";
                    SqlCommand deleteCmd = new SqlCommand(deleteQuery, con);
                    deleteCmd.Parameters.AddWithValue("@JobID", jobId);
                    deleteCmd.ExecuteNonQuery();
                    
                    lblMessage.Text = "Job deleted successfully!";
                }
                
                lblMessage.CssClass = "text-success mb-3 d-block";
                BindJobsGrid();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
                lblMessage.CssClass = "text-danger mb-3 d-block";
            }
            finally
            {
                if (con != null && con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
        }

        protected string GetStatusBadgeClass(string isActive)
        {
            if (string.IsNullOrEmpty(isActive) || isActive == "True")
            {
                return "success";
            }
            else
            {
                return "secondary";
            }
        }
    }
}