using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace Job_Portal
{
    public partial class post_job : System.Web.UI.Page
    {
        string conn = ConfigurationManager.ConnectionStrings["JobPortalConnection"].ConnectionString;
        SqlConnection con;
        string Flnm;

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
            }
        }

        protected void btnSaveJob_Click(object sender, EventArgs e)
        {
            try
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
                getcon();  // open connection

                string query = "INSERT INTO Jobs " +
                               "(RecruiterID, JobTitle, JobDescription, Location, Salary, SkillsRequired, ExperienceRequired, JobType, Category, Deadline,Company_Logo) " +
                               "VALUES ('" + recruiterId + "', '" + txtJobTitle.Text.Trim() + "', '" + txtDescription.Text.Trim() + "', '" +
                               txtLocation.Text.Trim() + "', '" + txtSalary.Text.Trim() + "', '" + txtSkills.Text.Trim() + "', '" +
                               txtExperience.Text.Trim() + "', '" + ddlJobType.SelectedValue + "', '" + ddlCategory.SelectedValue + "', '" +
                               txtDeadline.Text.Trim() + "', '" + Flnm + "')";

                SqlCommand cmd = new SqlCommand(query, con);  
                cmd.ExecuteNonQuery();

                lblMessage.Text = "Job posted successfully!";
                ClearForm();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
            }
            finally
            {
                if (con != null && con.State == System.Data.ConnectionState.Open)
                {
                    con.Close();
                }
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
