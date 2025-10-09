using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace Job_Portal
{
    public partial class job_details : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["JobID"] != null)
                {
                    LoadJobDetails(Request.QueryString["JobID"]);
                }
            }
        }

        private void LoadJobDetails(string jobId)
        {
            string cs = ConfigurationManager.ConnectionStrings["JobPortalConnection"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT JobID, Location, Salary, SkillsRequired, ExperienceRequired, JobType, Category, Deadline, [PostedDate], Status, Company_Logo FROM Jobs WHERE JobID=@JobID", con))
                {
                    cmd.Parameters.AddWithValue("@JobID", jobId);
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        // Example: set values to controls (add controls in .aspx as needed)
                        // lblCategory.Text = dr["Category"].ToString();
                        // lblJobType.Text = dr["JobType"].ToString();
                        // lblLocation.Text = dr["Location"].ToString();
                        // lblSalary.Text = dr["Salary"].ToString();
                        // lblSkills.Text = dr["SkillsRequired"].ToString();
                        // lblExperience.Text = dr["ExperienceRequired"].ToString();
                        // lblDeadline.Text = Convert.ToDateTime(dr["Deadline"]).ToString("MM/dd/yyyy");
                        // imgLogo.ImageUrl = dr["Company_Logo"].ToString();
                    }
                }
            }
        }
    }
}