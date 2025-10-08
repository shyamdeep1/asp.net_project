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
                Flnm = "~/Logo/" + fuCompanyLogo.FileName;
                fuCompanyLogo.SaveAs(Server.MapPath(Flnm));
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

                // Check if this is edit mode
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
            string query = "SELECT * FROM Jobs WHERE JobID = @JobID";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@JobID", jobId);

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

                // Handle deadline date format
                if (reader["Deadline"] != DBNull.Value)
                {
                    DateTime deadline = Convert.ToDateTime(reader["Deadline"]);
                    txtDeadline.Text = deadline.ToString("yyyy-MM-dd");
                }

                // Store current logo path
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
                // Insert new job
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

                string query = "INSERT INTO Jobs " +
                               "(RecruiterID, JobTitle, JobDescription, Location, Salary, SkillsRequired, ExperienceRequired, JobType, Category, Deadline, Company_Logo) " +
                               "VALUES (@RecruiterID, @JobTitle, @JobDescription, @Location, @Salary, @Skills, @Experience, @JobType, @Category, @Deadline, @Logo)";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@RecruiterID", recruiterId);
                cmd.Parameters.AddWithValue("@JobTitle", txtJobTitle.Text.Trim());
                cmd.Parameters.AddWithValue("@JobDescription", txtDescription.Text.Trim());
                cmd.Parameters.AddWithValue("@Location", txtLocation.Text.Trim());
                cmd.Parameters.AddWithValue("@Salary", txtSalary.Text.Trim());
                cmd.Parameters.AddWithValue("@Skills", txtSkills.Text.Trim());
                cmd.Parameters.AddWithValue("@Experience", txtExperience.Text.Trim());
                cmd.Parameters.AddWithValue("@JobType", ddlJobType.SelectedValue);
                cmd.Parameters.AddWithValue("@Category", ddlCategory.SelectedValue);
                cmd.Parameters.AddWithValue("@Deadline", txtDeadline.Text.Trim());
                cmd.Parameters.AddWithValue("@Logo", Flnm ?? "");

                cmd.ExecuteNonQuery();

                lblMessage.Text = "Job posted successfully!";
                ClearForm();
                con.Close();
            }
            else if (btnSaveJob.Text == "Update Job")
            {
                // Update existing job
                jobId = Convert.ToInt32(ViewState["JobID"]);

                // Handle file upload for update
                if (fuCompanyLogo.HasFile)
                {
                    fileupld();
                }

                getcon();
                string query = "UPDATE Jobs SET " +
                               "JobTitle = @JobTitle, " +
                               "JobDescription = @JobDescription, " +
                               "Location = @Location, " +
                               "Salary = @Salary, " +
                               "SkillsRequired = @Skills, " +
                               "ExperienceRequired = @Experience, " +
                               "JobType = @JobType, " +
                               "Category = @Category, " +
                               "Deadline = @Deadline";

                // Only update logo if new file was uploaded
                if (fuCompanyLogo.HasFile)
                {
                    query += ", Company_Logo = @Logo";
                }

                query += " WHERE JobID = @JobID";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@JobTitle", txtJobTitle.Text.Trim());
                cmd.Parameters.AddWithValue("@JobDescription", txtDescription.Text.Trim());
                cmd.Parameters.AddWithValue("@Location", txtLocation.Text.Trim());
                cmd.Parameters.AddWithValue("@Salary", txtSalary.Text.Trim());
                cmd.Parameters.AddWithValue("@Skills", txtSkills.Text.Trim());
                cmd.Parameters.AddWithValue("@Experience", txtExperience.Text.Trim());
                cmd.Parameters.AddWithValue("@JobType", ddlJobType.SelectedValue);
                cmd.Parameters.AddWithValue("@Category", ddlCategory.SelectedValue);
                cmd.Parameters.AddWithValue("@Deadline", txtDeadline.Text.Trim());
                cmd.Parameters.AddWithValue("@JobID", jobId);

                if (fuCompanyLogo.HasFile)
                {
                    cmd.Parameters.AddWithValue("@Logo", Flnm);
                }

                cmd.ExecuteNonQuery();

                lblMessage.Text = "Job updated successfully!";
                con.Close();

                // Redirect back to manage jobs page after successful update
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
