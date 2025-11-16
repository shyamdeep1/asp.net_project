using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Data;

namespace Job_Portal
{
    public partial class post_job : System.Web.UI.Page
    {
        string conn = ConfigurationManager.ConnectionStrings["JobPortalConnection"].ConnectionString;
        SqlConnection con;
        string Flnm;
        int jobId = 0;

        void getcon()
        {
            con = new SqlConnection(conn);
            con.Open();
        }

        void fileupld()
        {
            if (fuCompanyLogo.HasFile)
            {
                try
                {
                    // Create Logo directory if it doesn't exist
                    string logoDirectory = Server.MapPath("~/Logo/");
                    if (!System.IO.Directory.Exists(logoDirectory))
                    {
                        System.IO.Directory.CreateDirectory(logoDirectory);
                    }

                    // Generate unique filename to avoid conflicts
                    string fileName = System.IO.Path.GetFileName(fuCompanyLogo.FileName);
                    string fileExtension = System.IO.Path.GetExtension(fileName);
                    string uniqueFileName = Guid.NewGuid().ToString() + fileExtension;
                    
                    Flnm = "~/Logo/" + uniqueFileName;
                    string fullPath = Server.MapPath(Flnm);
                    
                    fuCompanyLogo.SaveAs(fullPath);
                }
                catch (Exception ex)
                {
                    // Log error and set default logo
                    Flnm = "~/images/job_logo_1.jpg";
                }
            }
            else
            {
                // Set default logo if no file uploaded
                Flnm = "~/images/job_logo_1.jpg";
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] == null)
                {
                    Response.Redirect("login.aspx");
                }

                if (Request.QueryString["JobID"] != null)
                {
                    jobId = Convert.ToInt32(Request.QueryString["JobID"]);
                    ViewState["JobID"] = jobId;
                    btnSaveJob.Text = "Update Job";
                    LoadJobData(jobId);
                }
                else
                {
                    btnSaveJob.Text = "Post Job";
                }
            }
            else
            {
                if (ViewState["JobID"] != null)
                {
                    jobId = Convert.ToInt32(ViewState["JobID"]);
                }
            }
        }

        private void LoadJobData(int jobId)
        {
            getcon();
            string query = "SELECT * FROM Jobs WHERE JobID = '" + jobId + "'";
            SqlCommand cmd = new SqlCommand(query, con);

            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                txtJobTitle.Text = reader["JobTitle"].ToString();
                txtDescription.Text = reader["JobDescription"].ToString();
                txtLocation.Text = reader["Location"].ToString();
                txtSalary.Text = reader["Salary"].ToString();
                txtSkills.Text = reader["SkillsRequired"].ToString();
                txtExperience.Text = reader["ExperienceRequired"].ToString();
                ddlJobType.SelectedValue = reader["JobType"].ToString();
                ddlCategory.SelectedValue = reader["Category"].ToString();

                if (reader["Deadline"] != DBNull.Value)
                {
                    DateTime deadline = Convert.ToDateTime(reader["Deadline"]);
                    txtDeadline.Text = deadline.ToString("yyyy-MM-dd");
                }

                if (reader["Company_Logo"] != DBNull.Value)
                {
                    Flnm = reader["Company_Logo"].ToString();
                }
            }
            reader.Close();
            con.Close();
        }

        protected void btnSaveJob_Click(object sender, EventArgs e)
        {
            if (btnSaveJob.Text == "Post Job")
            {
                int userId = Convert.ToInt32(Session["UserID"]);
                int recruiterId = 0;

                getcon();
                string recruiterQuery = "SELECT RecruiterID FROM Recruiters WHERE UserID = " + userId;
                SqlCommand recruiterCmd = new SqlCommand(recruiterQuery, con);
                object result = recruiterCmd.ExecuteScalar();

                if (result != null)
                {
                    recruiterId = Convert.ToInt32(result);
                }
                else
                {
                    lblMessage.Text = "Error: Recruiter profile not found.";
                    return;
                }
                fileupld();
                getcon();

                string query = "INSERT INTO Jobs (RecruiterID, JobTitle, JobDescription, Location, Salary, SkillsRequired, ExperienceRequired, JobType, Category, Deadline, Company_Logo) VALUES ('" + recruiterId + "', '" + txtJobTitle.Text.Trim() + "', '" + txtDescription.Text.Trim() + "', '" + txtLocation.Text.Trim() + "', '" + txtSalary.Text.Trim() + "', '" + txtSkills.Text.Trim() + "', '" + txtExperience.Text.Trim() + "', '" + ddlJobType.SelectedValue + "', '" + ddlCategory.SelectedValue + "', '" + txtDeadline.Text.Trim() + "', '" + Flnm + "')";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.ExecuteNonQuery();

                lblMessage.Text = "Job posted successfully!";
                ClearForm();
                con.Close();
            }
            else if (btnSaveJob.Text == "Update Job")
            {
                jobId = Convert.ToInt32(ViewState["JobID"]);

                if (fuCompanyLogo.HasFile)
                {
                    fileupld();
                }

                getcon();
                string query = "UPDATE Jobs SET JobTitle = '" + txtJobTitle.Text.Trim() + "', JobDescription = '" + txtDescription.Text.Trim() + "', Location = '" + txtLocation.Text.Trim() + "', Salary = '" + txtSalary.Text.Trim() + "', SkillsRequired = '" + txtSkills.Text.Trim() + "', ExperienceRequired = '" + txtExperience.Text.Trim() + "', JobType = '" + ddlJobType.SelectedValue + "', Category = '" + ddlCategory.SelectedValue + "', Deadline = '" + txtDeadline.Text.Trim() + "'";

                if (fuCompanyLogo.HasFile)
                {
                    query += ", Company_Logo = '" + Flnm + "'";
                }

                query += " WHERE JobID = '" + jobId + "'";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.ExecuteNonQuery();

                lblMessage.Text = "Job updated successfully!";
                con.Close();

                Response.Redirect("recruiter_manage_jobs.aspx");
            }
        }

        private void ClearForm()
        {
            txtJobTitle.Text = "";
            txtDescription.Text = "";
            txtLocation.Text = "";
            txtSalary.Text = "";
            txtSkills.Text = "";
            txtExperience.Text = "";
            ddlJobType.SelectedIndex = 0;
            ddlCategory.SelectedIndex = 0;
            txtDeadline.Text = "";
        }
    }
}
