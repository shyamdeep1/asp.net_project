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
                // Check if user is logged in as admin
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

            // Total Users - Fixed to use correct table name and column
            cmd = new SqlCommand("SELECT COUNT(*) FROM (SELECT JobSeekerID FROM JobSeeker UNION SELECT RecruiterID FROM Recruiters) AS AllUsers", con);
            lblTotalUsers.Text = cmd.ExecuteScalar().ToString();

            // Total Jobs
            cmd = new SqlCommand("SELECT COUNT(*) FROM Jobs", con);
            lblTotalJobs.Text = cmd.ExecuteScalar().ToString();

            // Job Seekers - Fixed table name
            cmd = new SqlCommand("SELECT COUNT(*) FROM JobSeeker", con);
            lblJobSeekers.Text = cmd.ExecuteScalar().ToString();

            // Recruiters
            cmd = new SqlCommand("SELECT COUNT(*) FROM Recruiters", con);
            lblRecruiters.Text = cmd.ExecuteScalar().ToString();

            // Applications
            cmd = new SqlCommand("SELECT COUNT(*) FROM JobApplications", con);
            lblApplications.Text = cmd.ExecuteScalar().ToString();

            // Categories (assuming you have a Categories table)
            try
            {
                cmd = new SqlCommand("SELECT COUNT(*) FROM Categories", con);
                lblCategories.Text = cmd.ExecuteScalar().ToString();
            }
            catch
            {
                lblCategories.Text = "0";
            }

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

            // This Month Registrations - Simplified to avoid date column issues
            try
            {
                cmd = new SqlCommand(@"SELECT COUNT(*) FROM JobSeeker 
                                       WHERE MONTH(CreatedDate) = MONTH(GETDATE()) AND YEAR(CreatedDate) = YEAR(GETDATE())", con);
                int jobSeekerCount = Convert.ToInt32(cmd.ExecuteScalar());
                
                cmd = new SqlCommand("SELECT COUNT(*) FROM Recruiters", con);
                int recruiterCount = Convert.ToInt32(cmd.ExecuteScalar());
                
                lblThisMonthRegistrations.Text = (jobSeekerCount + recruiterCount).ToString();
            }
            catch
            {
                lblThisMonthRegistrations.Text = "0";
            }

            // This Week Registrations - Simplified
            try
            {
                cmd = new SqlCommand(@"SELECT COUNT(*) FROM JobSeeker 
                                       WHERE DATEPART(WEEK, CreatedDate) = DATEPART(WEEK, GETDATE()) AND YEAR(CreatedDate) = YEAR(GETDATE())", con);
                int jobSeekerWeekCount = Convert.ToInt32(cmd.ExecuteScalar());
                
                cmd = new SqlCommand("SELECT COUNT(*) FROM Recruiters", con);
                int recruiterWeekCount = Convert.ToInt32(cmd.ExecuteScalar());
                
                lblThisWeekRegistrations.Text = (jobSeekerWeekCount + recruiterWeekCount).ToString();
            }
            catch
            {
                lblThisWeekRegistrations.Text = "0";
            }

            // Active Jobs
            try
            {
                cmd = new SqlCommand("SELECT COUNT(*) FROM Jobs WHERE Status = 'Active'", con);
                lblActiveJobs.Text = cmd.ExecuteScalar().ToString();
            }
            catch
            {
                lblActiveJobs.Text = "0";
            }

            // Application Rate (example calculation)
            try
            {
                cmd = new SqlCommand(@"SELECT CASE WHEN COUNT(DISTINCT j.JobID) = 0 THEN 0 
                                             ELSE CAST(COUNT(ja.ApplicationID) * 100.0 / COUNT(DISTINCT j.JobID) AS INT) END 
                                     FROM Jobs j LEFT JOIN JobApplications ja ON j.JobID = ja.JobID", con);
                lblApplicationRate.Text = cmd.ExecuteScalar().ToString() + "%";
            }
            catch
            {
                lblApplicationRate.Text = "0%";
            }

            // Pending Jobs
            try
            {
                cmd = new SqlCommand("SELECT COUNT(*) FROM Jobs WHERE Status = 'Pending'", con);
                lblPendingJobs.Text = cmd.ExecuteScalar().ToString();
            }
            catch
            {
                lblPendingJobs.Text = "0";
            }

            // Flagged Content (placeholder)
            lblFlaggedContent.Text = "0";

            con.Close();
        }

        private void LoadTopPerformers()
        {
            getcon();

            // Top Recruiters
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

            // Top Categories (if Categories table exists)
            try
            {
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
                da.Fill(dsCategories);

                if (dsCategories.Tables[0].Rows.Count > 0)
                {
                    gvTopCategories.DataSource = dsCategories.Tables[0];
                    gvTopCategories.DataBind();
                }
            }
            catch
            {
                // If Categories table doesn't exist, create dummy data
                DataTable dtDummy = new DataTable();
                dtDummy.Columns.Add("CategoryName");
                dtDummy.Columns.Add("JobCount");
                dtDummy.Columns.Add("ApplicationCount");
                
                DataRow dr = dtDummy.NewRow();
                dr["CategoryName"] = "No categories found";
                dr["JobCount"] = "0";
                dr["ApplicationCount"] = "0";
                dtDummy.Rows.Add(dr);
                
                gvTopCategories.DataSource = dtDummy;
                gvTopCategories.DataBind();
            }

            con.Close();
        }
    }
}