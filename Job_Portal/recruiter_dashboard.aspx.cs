using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Job_Portal
{
    public partial class recruiter_dashboard : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["JobPortalConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserId"] == null || Session["Role"].ToString() != "Recruiter")
                {
                    Response.Redirect("login.aspx");
                }
                else
                {
                    LoadDashboardData();
                }
            }
        }

        private void LoadDashboardData()
        {
            int recruiterId = Convert.ToInt32(Session["UserId"]);

            using (SqlConnection con = new SqlConnection(cs))
            {
               /* con.Open();

                // ✅ Total Jobs Posted
                SqlCommand cmdTotal = new SqlCommand("SELECT COUNT(*) FROM Jobs WHERE RecruiterID=@rid", con);
                cmdTotal.Parameters.AddWithValue("@rid", recruiterId);
                lblTotalJobs.Text = cmdTotal.ExecuteScalar().ToString();

                // ✅ Active Jobs
                SqlCommand cmdActive = new SqlCommand("SELECT COUNT(*) FROM Applications WHERE RecruiterID=@rid AND Status='Pending'", con);
                cmdActive.Parameters.AddWithValue("@rid", recruiterId);
                lblActiveJobs.Text = cmdActive.ExecuteScalar().ToString();

                // ✅ Applications Received
                SqlCommand cmdApps = new SqlCommand(@"
                    SELECT COUNT(*) 
                    FROM Applications A 
                    INNER JOIN Jobs J ON A.JobID = J.JobID 
                    WHERE J.RecruiterID=@rid", con);
                cmdApps.Parameters.AddWithValue("@rid", recruiterId);
                lblApplications.Text = cmdApps.ExecuteScalar().ToString();

                // ✅ Shortlisted Applications
                SqlCommand cmdShort = new SqlCommand(@"
                    SELECT COUNT(*) 
                    FROM Applications A 
                    INNER JOIN Jobs J ON A.JobID = J.JobID 
                    WHERE J.RecruiterID=@rid AND A.Status='Shortlisted'", con);
                cmdShort.Parameters.AddWithValue("@rid", recruiterId);
                lblShortlisted.Text = cmdShort.ExecuteScalar().ToString();

                // ✅ Recent Jobs Posted
                SqlCommand cmdJobs = new SqlCommand(@"
                    SELECT TOP 5 JobTitle, JobLocation, PostedDate, Status 
                    FROM Jobs 
                    WHERE RecruiterID=@rid 
                    ORDER BY PostedDate DESC", con);
                cmdJobs.Parameters.AddWithValue("@rid", recruiterId);

                SqlDataAdapter da = new SqlDataAdapter(cmdJobs);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvJobs.DataSource = dt;
                gvJobs.DataBind();
               */
            }
        }
    }
}
