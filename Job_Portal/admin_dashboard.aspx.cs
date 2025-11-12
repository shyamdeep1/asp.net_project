using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Job_Portal
{
    public partial class admin_dashboard : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["JobPortalConnection"].ConnectionString;
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;

        void getcon()
        {
            con = new SqlConnection(cs);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserId"] == null || Session["Role"] == null || Session["Role"].ToString() != "Admin")
                {
                    Response.Redirect("login.aspx");
                }
                else
                {
                    LoadDashboardData();
                    LoadRecentUsers();
                    LoadRecentJobs();
                    LoadSystemAnalytics();
                    LoadTopPerformers();
                }
            }
        }

        private void LoadDashboardData()
        {
            lblCurrentDate.Text = DateTime.Now.ToString("MMMM dd, yyyy");

            getcon();

            cmd = new SqlCommand("SELECT COUNT(*) FROM (SELECT JobSeekerID FROM JobSeeker UNION SELECT RecruiterID FROM Recruiters) AS AllUsers", con);
            lblTotalUsers.Text = cmd.ExecuteScalar().ToString();

            cmd = new SqlCommand("SELECT COUNT(*) FROM Jobs", con);
            lblTotalJobs.Text = cmd.ExecuteScalar().ToString();

            cmd = new SqlCommand("SELECT COUNT(*) FROM JobSeeker", con);
            lblJobSeekers.Text = cmd.ExecuteScalar().ToString();

            cmd = new SqlCommand("SELECT COUNT(*) FROM Recruiters", con);
            lblRecruiters.Text = cmd.ExecuteScalar().ToString();

            cmd = new SqlCommand("SELECT COUNT(*) FROM JobApplications", con);
            lblApplications.Text = cmd.ExecuteScalar().ToString();

           

            con.Close();
        }

        private void LoadRecentUsers()
        {
            getcon();
            
            string query = @"SELECT TOP 5 js.FullName, js.Email, js.CreatedDate as RegistrationDate, 'JobSeeker' as Role 
                           FROM JobSeeker js
                           UNION ALL
                           SELECT TOP 5 r.CompanyName as FullName, u.Email, GETDATE() as RegistrationDate, 'Recruiter' as Role 
                           FROM Recruiters r 
                           INNER JOIN Users u ON r.UserID = u.UserID
                           ORDER BY RegistrationDate DESC";

            cmd = new SqlCommand(query, con);
            da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                rptRecentUsers.DataSource = ds.Tables[0];
                rptRecentUsers.DataBind();
                pnlRecentUsers.Visible = true;
                pnlNoUsers.Visible = false;
            }
            else
            {
                pnlRecentUsers.Visible = false;
                pnlNoUsers.Visible = true;
            }

            con.Close();
        }

        private void LoadRecentJobs()
        {
            getcon();

            string query = @"SELECT TOP 5 JobTitle, Location, PostedDate, Status 
                           FROM Jobs 
                           ORDER BY PostedDate DESC";

            cmd = new SqlCommand(query, con);
            da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                rptRecentJobs.DataSource = ds.Tables[0];
                rptRecentJobs.DataBind();
                pnlRecentJobs.Visible = true;
                pnlNoJobs.Visible = false;
            }
            else
            {
                pnlRecentJobs.Visible = false;
                pnlNoJobs.Visible = true;
            }

            con.Close();
        }

        private void LoadSystemAnalytics()
        {
            getcon();

            cmd = new SqlCommand(@"SELECT COUNT(*) FROM JobSeeker 
                                   WHERE MONTH(CreatedDate) = MONTH(GETDATE()) AND YEAR(CreatedDate) = YEAR(GETDATE())", con);
            int jobSeekerCount = Convert.ToInt32(cmd.ExecuteScalar());
            
            cmd = new SqlCommand("SELECT COUNT(*) FROM Recruiters", con);
            int recruiterCount = Convert.ToInt32(cmd.ExecuteScalar());
            
            lblThisMonthRegistrations.Text = (jobSeekerCount + recruiterCount).ToString();

            cmd = new SqlCommand(@"SELECT COUNT(*) FROM JobSeeker 
                                   WHERE DATEPART(WEEK, CreatedDate) = DATEPART(WEEK, GETDATE()) AND YEAR(CreatedDate) = YEAR(GETDATE())", con);
            int jobSeekerWeekCount = Convert.ToInt32(cmd.ExecuteScalar());
            
            cmd = new SqlCommand("SELECT COUNT(*) FROM Recruiters", con);
            int recruiterWeekCount = Convert.ToInt32(cmd.ExecuteScalar());
            
            lblThisWeekRegistrations.Text = (jobSeekerWeekCount + recruiterWeekCount).ToString();

            cmd = new SqlCommand("SELECT COUNT(*) FROM Jobs WHERE Status = 'Active'", con);
            lblActiveJobs.Text = cmd.ExecuteScalar().ToString();

            cmd = new SqlCommand(@"SELECT CASE WHEN COUNT(DISTINCT j.JobID) = 0 THEN 0 
                                         ELSE CAST(COUNT(ja.ApplicationID) * 100.0 / COUNT(DISTINCT j.JobID) AS INT) END 
                                 FROM Jobs j LEFT JOIN JobApplications ja ON j.JobID = ja.JobID", con);
            lblApplicationRate.Text = cmd.ExecuteScalar().ToString() + "%";

            cmd = new SqlCommand("SELECT COUNT(*) FROM Jobs WHERE Status = 'Pending'", con);
            lblPendingJobs.Text = cmd.ExecuteScalar().ToString();

            lblFlaggedContent.Text = "0";

            con.Close();
        }

        private void LoadTopPerformers()
        {
            getcon();

            string topRecruitersQuery = @"SELECT TOP 5 
                                        r.CompanyName,
                                        COUNT(DISTINCT j.JobID) as JobsPosted,
                                        COUNT(ja.ApplicationID) as TotalApplications
                                        FROM Recruiters r
                                        LEFT JOIN Jobs j ON r.RecruiterID = j.RecruiterID
                                        LEFT JOIN JobApplications ja ON j.JobID = ja.JobID
                                        GROUP BY r.RecruiterID, r.CompanyName
                                        ORDER BY JobsPosted DESC, TotalApplications DESC";

            cmd = new SqlCommand(topRecruitersQuery, con);
            da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                gvTopRecruiters.DataSource = ds.Tables[0];
                gvTopRecruiters.DataBind();
            }

            string topCategoriesQuery = @"SELECT TOP 5 
                                        c.CategoryName,
                                        COUNT(DISTINCT j.JobID) as JobCount,
                                        COUNT(ja.ApplicationID) as ApplicationCount
                                        FROM Categories c
                                        LEFT JOIN Jobs j ON c.CategoryID = j.CategoryID
                                        LEFT JOIN JobApplications ja ON j.JobID = ja.JobID
                                        GROUP BY c.CategoryID, c.CategoryName
                                        ORDER BY JobCount DESC, ApplicationCount DESC";

            cmd = new SqlCommand(topCategoriesQuery, con);
            da = new SqlDataAdapter(cmd);
            DataSet dsCategories = new DataSet();

           
            con.Close();
        }
    }
}