using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Job_Portal
{
    public partial class recruiter_dashboard : System.Web.UI.Page
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
                if (Session["UserId"] == null || Session["Role"] == null || Session["Role"].ToString() != "Recruiter")
                {
                    Response.Redirect("login.aspx");
                }
                else
                {
                    LoadDashboardData();
                    LoadRecentApplications();
                    LoadActiveJobs();
                    LoadPerformanceMetrics();
                }
            }
        }

        private void LoadDashboardData()
        {
            try
            {
                int recruiterId = Convert.ToInt32(Session["UserId"]);

                getcon();

                // Load Recruiter Info
                lblRecruiterName.Text = Session["FullName"] != null ? Session["FullName"].ToString() : "Recruiter";
                lblCurrentDate.Text = DateTime.Now.ToString("MMMM dd, yyyy");

                // Get Company Name
                cmd = new SqlCommand("SELECT CompanyName FROM Recruiters WHERE RecruiterID = @RecruiterID", con);
                cmd.Parameters.AddWithValue("@RecruiterID", recruiterId);
                object companyName = cmd.ExecuteScalar();
                lblCompanyName.Text = companyName != null ? companyName.ToString() : "Your Company";

                // Get Total Jobs
                cmd = new SqlCommand("SELECT COUNT(*) FROM Jobs WHERE RecruiterID = @RecruiterID", con);
                cmd.Parameters.AddWithValue("@RecruiterID", recruiterId);
                lblTotalJobs.Text = cmd.ExecuteScalar().ToString();

                // Get Active Jobs
                cmd = new SqlCommand("SELECT COUNT(*) FROM Jobs WHERE RecruiterID = @RecruiterID AND Status = 'Active'", con);
                cmd.Parameters.AddWithValue("@RecruiterID", recruiterId);
                lblActiveJobs.Text = cmd.ExecuteScalar().ToString();

                // Get Total Applications
                cmd = new SqlCommand(@"SELECT COUNT(*) FROM JobApplications ja 
                                     INNER JOIN Jobs j ON ja.JobID = j.JobID 
                                     WHERE j.RecruiterID = @RecruiterID", con);
                cmd.Parameters.AddWithValue("@RecruiterID", recruiterId);
                lblApplications.Text = cmd.ExecuteScalar().ToString();

                // Get Shortlisted Candidates
                cmd = new SqlCommand(@"SELECT COUNT(*) FROM JobApplications ja 
                                     INNER JOIN Jobs j ON ja.JobID = j.JobID 
                                     WHERE j.RecruiterID = @RecruiterID AND ja.Status = 'Shortlisted'", con);
                cmd.Parameters.AddWithValue("@RecruiterID", recruiterId);
                lblShortlisted.Text = cmd.ExecuteScalar().ToString();

                con.Close();
            }
            catch (Exception ex)
            {
                // Handle error
                Response.Write("<script>alert('Error loading dashboard: " + ex.Message + "');</script>");
            }
        }

        private void LoadRecentApplications()
        {
            try
            {
                int recruiterId = Convert.ToInt32(Session["UserId"]);

                getcon();

                string query = @"SELECT TOP 5 
                                js.FullName AS ApplicantName, 
                                j.JobTitle, 
                                ja.ApplicationDate, 
                                ja.Status
                                FROM JobApplications ja
                                INNER JOIN Jobs j ON ja.JobID = j.JobID
                                INNER JOIN JobSeekers js ON ja.JobSeekerID = js.JobSeekerID
                                WHERE j.RecruiterID = @RecruiterID
                                ORDER BY ja.ApplicationDate DESC";

                cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@RecruiterID", recruiterId);

                da = new SqlDataAdapter(cmd);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    rptRecentApplications.DataSource = ds;
                    rptRecentApplications.DataBind();
                    pnlRecentApplications.Visible = true;
                    pnlNoApplications.Visible = false;
                }
                else
                {
                    pnlRecentApplications.Visible = false;
                    pnlNoApplications.Visible = true;
                }

                con.Close();
            }
            catch (Exception ex)
            {
                pnlNoApplications.Visible = true;
            }
        }

        private void LoadActiveJobs()
        {
            try
            {
                int recruiterId = Convert.ToInt32(Session["UserId"]);

                getcon();

                string query = @"SELECT TOP 5 
                                j.JobTitle, 
                                j.Location, 
                                j.PostedDate,
                                (SELECT COUNT(*) FROM JobApplications WHERE JobID = j.JobID) AS ApplicationCount
                                FROM Jobs j
                                WHERE j.RecruiterID = @RecruiterID AND j.Status = 'Active'
                                ORDER BY j.PostedDate DESC";

                cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@RecruiterID", recruiterId);

                da = new SqlDataAdapter(cmd);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    rptActiveJobs.DataSource = ds;
                    rptActiveJobs.DataBind();
                    pnlActiveJobs.Visible = true;
                    pnlNoActiveJobs.Visible = false;
                }
                else
                {
                    pnlActiveJobs.Visible = false;
                    pnlNoActiveJobs.Visible = true;
                }

                con.Close();
            }
            catch (Exception ex)
            {
                pnlNoActiveJobs.Visible = true;
            }
        }

        private void LoadPerformanceMetrics()
        {
            try
            {
                int recruiterId = Convert.ToInt32(Session["UserId"]);

                getcon();

                // Average Applications per Job
                cmd = new SqlCommand(@"SELECT 
                                     CASE WHEN COUNT(DISTINCT j.JobID) > 0 
                                     THEN COUNT(ja.ApplicationID) / COUNT(DISTINCT j.JobID) 
                                     ELSE 0 END AS AvgApplications
                                     FROM Jobs j
                                     LEFT JOIN JobApplications ja ON j.JobID = ja.JobID
                                     WHERE j.RecruiterID = @RecruiterID", con);
                cmd.Parameters.AddWithValue("@RecruiterID", recruiterId);
                object avgApps = cmd.ExecuteScalar();
                lblAvgApplications.Text = avgApps != null ? avgApps.ToString() : "0";

                // Hired Candidates (Accepted Applications)
                cmd = new SqlCommand(@"SELECT COUNT(*) FROM JobApplications ja
                                     INNER JOIN Jobs j ON ja.JobID = j.JobID
                                     WHERE j.RecruiterID = @RecruiterID AND ja.Status = 'Accepted'", con);
                cmd.Parameters.AddWithValue("@RecruiterID", recruiterId);
                lblHiredCandidates.Text = cmd.ExecuteScalar().ToString();

                // Pending Review
                cmd = new SqlCommand(@"SELECT COUNT(*) FROM JobApplications ja
                                     INNER JOIN Jobs j ON ja.JobID = j.JobID
                                     WHERE j.RecruiterID = @RecruiterID AND ja.Status = 'Pending'", con);
                cmd.Parameters.AddWithValue("@RecruiterID", recruiterId);
                lblPendingReview.Text = cmd.ExecuteScalar().ToString();

                // Profile Views (simulate with random number for now)
                Random rnd = new Random();
                lblProfileViews.Text = rnd.Next(100, 500).ToString();

                // Calculate Response Rate
                cmd = new SqlCommand(@"SELECT 
                                     CASE WHEN COUNT(*) > 0 
                                     THEN (CAST(SUM(CASE WHEN Status != 'Pending' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*)) * 100
                                     ELSE 0 END AS ResponseRate
                                     FROM JobApplications ja
                                     INNER JOIN Jobs j ON ja.JobID = j.JobID
                                     WHERE j.RecruiterID = @RecruiterID", con);
                cmd.Parameters.AddWithValue("@RecruiterID", recruiterId);
                object responseRate = cmd.ExecuteScalar();
                int responseRateInt = responseRate != null ? Convert.ToInt32(responseRate) : 0;
                lblResponseRate.Text = responseRateInt + "%";

                // Calculate Completion Rate (Jobs filled / Total jobs)
                cmd = new SqlCommand(@"SELECT 
                                     CASE WHEN COUNT(*) > 0 
                                     THEN (CAST(SUM(CASE WHEN Status = 'Closed' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*)) * 100
                                     ELSE 0 END AS CompletionRate
                                     FROM Jobs WHERE RecruiterID = @RecruiterID", con);
                cmd.Parameters.AddWithValue("@RecruiterID", recruiterId);
                object completionRate = cmd.ExecuteScalar();
                int completionRateInt = completionRate != null ? Convert.ToInt32(completionRate) : 0;
                lblCompletionRate.Text = completionRateInt + "%";

                // Satisfaction Rate (simulate with random high number)
                int satisfactionRate = rnd.Next(75, 95);
                lblSatisfactionRate.Text = satisfactionRate + "%";

                // Register script to update progress bars
                string script = @"
                    <script>
                        $(document).ready(function() {
                            $('#progressResponse').css('width', '" + responseRateInt + @"%');
                            $('#progressCompletion').css('width', '" + completionRateInt + @"%');
                            $('#progressSatisfaction').css('width', '" + satisfactionRate + @"%');
                        });
                    </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ProgressBars", script);

                con.Close();
            }
            catch (Exception ex)
            {
                // Default values on error
                lblAvgApplications.Text = "0";
                lblHiredCandidates.Text = "0";
                lblPendingReview.Text = "0";
                lblProfileViews.Text = "0";
                lblResponseRate.Text = "0%";
                lblCompletionRate.Text = "0%";
                lblSatisfactionRate.Text = "0%";
            }
        }

        protected string GetStatusClass(string status)
        {
            switch (status.ToLower())
            {
                case "pending":
                    return "badge badge-warning";
                case "reviewed":
                case "shortlisted":
                    return "badge badge-info";
                case "accepted":
                    return "badge badge-success";
                case "rejected":
                    return "badge badge-danger";
                default:
                    return "badge badge-secondary";
            }
        }
    }
}
