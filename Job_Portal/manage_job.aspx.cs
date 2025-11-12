using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Job_Portal
{
    public partial class manage_job : System.Web.UI.Page
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
                    LoadJobStatistics();
                    LoadJobsGrid();
                    LoadRecentActivities();
                    LoadTopJobs();
                    LoadTodayStats();
                }
            }
        }

        private void LoadJobStatistics()
        {
            lblCurrentDate.Text = DateTime.Now.ToString("MMMM dd, yyyy");

            getcon();

            cmd = new SqlCommand("SELECT COUNT(*) FROM Jobs", con);
            lblTotalJobs.Text = cmd.ExecuteScalar().ToString();

            cmd = new SqlCommand("SELECT COUNT(*) FROM Jobs WHERE Status = 'Active'", con);
            lblActiveJobs.Text = cmd.ExecuteScalar().ToString();

            cmd = new SqlCommand("SELECT COUNT(*) FROM Jobs WHERE Status = 'Pending'", con);
            lblPendingJobs.Text = cmd.ExecuteScalar().ToString();

            cmd = new SqlCommand("SELECT COUNT(*) FROM JobApplications", con);
            lblTotalApplications.Text = cmd.ExecuteScalar().ToString();

            con.Close();
        }

        private void LoadTodayStats()
        {
            getcon();

            cmd = new SqlCommand(@"SELECT COUNT(*) FROM Jobs 
                                 WHERE CAST(PostedDate AS DATE) = CAST(GETDATE() AS DATE)", con);
            lblTodayPosted.Text = cmd.ExecuteScalar().ToString();

            cmd = new SqlCommand(@"SELECT COUNT(*) FROM JobApplications 
                                 WHERE CAST(AppliedDate AS DATE) = CAST(GETDATE() AS DATE)", con);
            lblTodayApplications.Text = cmd.ExecuteScalar().ToString();

            cmd = new SqlCommand(@"SELECT COUNT(*) FROM Jobs 
                                 WHERE Status = 'Active' AND CAST(PostedDate AS DATE) = CAST(GETDATE() AS DATE)", con);
            lblTodayApproved.Text = cmd.ExecuteScalar().ToString();

            cmd = new SqlCommand("SELECT ISNULL(AVG(CAST(Salary AS FLOAT)), 0) FROM Jobs WHERE Salary IS NOT NULL", con);
            object avgSalary = cmd.ExecuteScalar();
            if (avgSalary != DBNull.Value)
            {
                lblAvgSalary.Text = "$" + string.Format("{0:N0}", Convert.ToDecimal(avgSalary));
            }
            else
            {
                lblAvgSalary.Text = "$0";
            }

            cmd = new SqlCommand(@"SELECT 
                                 CASE 
                                     WHEN COUNT(*) = 0 THEN 0
                                     ELSE (COUNT(CASE WHEN Status = 'Active' THEN 1 END) * 100.0 / COUNT(*))
                                 END
                                 FROM Jobs 
                                 WHERE PostedDate >= DATEADD(DAY, -7, GETDATE())", con);
            object approvalRate = cmd.ExecuteScalar();
            lblWeeklyApprovalRate.Text = string.Format("{0:F1}%", approvalRate);

            lblAvgTimeToApprove.Text = "2.5 hrs";

            con.Close();
        }

        private void LoadJobsGrid()
        {
            getcon();

            string whereClause = "WHERE 1=1";
            
            if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
            {
                whereClause += " AND (j.JobTitle LIKE @Search OR r.CompanyName LIKE @Search)";
            }

            if (!string.IsNullOrEmpty(ddlStatus.SelectedValue))
            {
                whereClause += " AND j.Status = @Status";
            }

            if (!string.IsNullOrEmpty(ddlDateRange.SelectedValue))
            {
                int days = Convert.ToInt32(ddlDateRange.SelectedValue);
                whereClause += " AND j.PostedDate >= DATEADD(DAY, -@Days, GETDATE())";
            }

            if (!string.IsNullOrEmpty(txtLocation.Text.Trim()))
            {
                whereClause += " AND j.Location LIKE @Location";
            }

            string query = @"SELECT 
                           j.JobID,
                           j.JobTitle,
                           r.CompanyName,
                           j.Location,
                           j.PostedDate,
                           j.Salary,
                           j.Status,
                           ISNULL(app.ApplicationCount, 0) as ApplicationCount
                           FROM Jobs j
                           LEFT JOIN Recruiters r ON j.RecruiterID = r.RecruiterID
                           LEFT JOIN (
                               SELECT JobID, COUNT(*) as ApplicationCount 
                               FROM JobApplications 
                               GROUP BY JobID
                           ) app ON j.JobID = app.JobID " + whereClause + @"
                           ORDER BY j.PostedDate DESC";

            cmd = new SqlCommand(query, con);

            if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
            {
                cmd.Parameters.AddWithValue("@Search", "%" + txtSearch.Text.Trim() + "%");
            }

            if (!string.IsNullOrEmpty(ddlStatus.SelectedValue))
            {
                cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
            }

            if (!string.IsNullOrEmpty(ddlDateRange.SelectedValue))
            {
                cmd.Parameters.AddWithValue("@Days", Convert.ToInt32(ddlDateRange.SelectedValue));
            }

            if (!string.IsNullOrEmpty(txtLocation.Text.Trim()))
            {
                cmd.Parameters.AddWithValue("@Location", "%" + txtLocation.Text.Trim() + "%");
            }

            da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                gvJobs.DataSource = ds.Tables[0];
                gvJobs.DataBind();
                lblResultsInfo.Text = $"Showing {ds.Tables[0].Rows.Count} jobs";
            }
            else
            {
                gvJobs.DataSource = null;
                gvJobs.DataBind();
                lblResultsInfo.Text = "No jobs found";
            }

            con.Close();
        }

        private void LoadRecentActivities()
        {
            getcon();

            string query = @"SELECT TOP 10 
                           'Job Posted' as Activity,
                           j.JobTitle,
                           r.CompanyName,
                           j.PostedDate as ActivityDate
                           FROM Jobs j
                           LEFT JOIN Recruiters r ON j.RecruiterID = r.RecruiterID
                           WHERE j.PostedDate >= DATEADD(DAY, -7, GETDATE())
                           UNION ALL
                           SELECT TOP 10
                           'Job Applied' as Activity,
                           j.JobTitle,
                           r.CompanyName,
                           ja.AppliedDate as ActivityDate
                           FROM JobApplications ja
                           INNER JOIN Jobs j ON ja.JobID = j.JobID
                           LEFT JOIN Recruiters r ON j.RecruiterID = r.RecruiterID
                           WHERE ja.AppliedDate >= DATEADD(DAY, -7, GETDATE())
                           ORDER BY ActivityDate DESC";

            cmd = new SqlCommand(query, con);
            da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataTable dtLimited = ds.Tables[0].Clone();
                for (int i = 0; i < Math.Min(5, ds.Tables[0].Rows.Count); i++)
                {
                    dtLimited.ImportRow(ds.Tables[0].Rows[i]);
                }

                rptRecentActivities.DataSource = dtLimited;
                rptRecentActivities.DataBind();
            }

            con.Close();
        }

        private void LoadTopJobs()
        {
            getcon();

            string query = @"SELECT TOP 5 
                           j.JobTitle,
                           r.CompanyName,
                           COUNT(ja.ApplicationID) as ApplicationCount
                           FROM Jobs j
                           LEFT JOIN Recruiters r ON j.RecruiterID = r.RecruiterID
                           LEFT JOIN JobApplications ja ON j.JobID = ja.JobID
                           WHERE j.PostedDate >= DATEADD(DAY, -7, GETDATE())
                           GROUP BY j.JobID, j.JobTitle, r.CompanyName
                           HAVING COUNT(ja.ApplicationID) > 0
                           ORDER BY ApplicationCount DESC";

            cmd = new SqlCommand(query, con);
            da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                rptTopJobs.DataSource = ds.Tables[0];
                rptTopJobs.DataBind();
            }

            con.Close();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadJobsGrid();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlStatus.SelectedIndex = 0;
            ddlDateRange.SelectedIndex = 0;
            txtLocation.Text = "";
            LoadJobsGrid();
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            LoadJobStatistics();
            LoadJobsGrid();
            LoadRecentActivities();
            LoadTopJobs();
            LoadTodayStats();
        }

        protected void btnBulkApprove_Click(object sender, EventArgs e)
        {
            getcon();

            cmd = new SqlCommand("UPDATE Jobs SET Status = 'Active' WHERE Status = 'Pending'", con);
            int affectedRows = cmd.ExecuteNonQuery();
            
            LoadJobStatistics();
            LoadJobsGrid();
            
            ClientScript.RegisterStartupScript(this.GetType(), "alert", 
                $"alert('Successfully approved {affectedRows} pending jobs!');", true);

            con.Close();
        }

        protected void btnExpireOld_Click(object sender, EventArgs e)
        {
            getcon();

            cmd = new SqlCommand(@"UPDATE Jobs SET Status = 'Expired' 
                                 WHERE Status = 'Active' AND PostedDate < DATEADD(DAY, -90, GETDATE())", con);
            int affectedRows = cmd.ExecuteNonQuery();
            
            LoadJobStatistics();
            LoadJobsGrid();
            
            ClientScript.RegisterStartupScript(this.GetType(), "alert", 
                $"alert('Successfully expired {affectedRows} old jobs!');", true);

            con.Close();
        }

        protected void gvJobs_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvJobs.PageIndex = e.NewPageIndex;
            LoadJobsGrid();
        }

        protected void gvJobs_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int jobId = Convert.ToInt32(e.CommandArgument);

            switch (e.CommandName)
            {
                case "ViewJob":
                    Response.Redirect($"job_details.aspx?id={jobId}");
                    break;

                case "ApproveJob":
                    UpdateJobStatus(jobId, "Active");
                    break;

                case "RejectJob":
                    UpdateJobStatus(jobId, "Rejected");
                    break;

                case "DeactivateJob":
                    UpdateJobStatus(jobId, "Closed");
                    break;
            }
        }

        private void UpdateJobStatus(int jobId, string status)
        {
            getcon();

            cmd = new SqlCommand("UPDATE Jobs SET Status = @Status WHERE JobID = @JobID", con);
            cmd.Parameters.AddWithValue("@Status", status);
            cmd.Parameters.AddWithValue("@JobID", jobId);
            
            cmd.ExecuteNonQuery();
            
            LoadJobStatistics();
            LoadJobsGrid();
            
            ClientScript.RegisterStartupScript(this.GetType(), "alert", 
                $"alert('Job status updated to {status} successfully!');", true);

            con.Close();
        }

        protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            gvJobs.PageSize = Convert.ToInt32(ddlPageSize.SelectedValue);
            LoadJobsGrid();
        }

        protected string GetTimeDifference(DateTime pastDate)
        {
            TimeSpan diff = DateTime.Now - pastDate;
            
            if (diff.Days > 0)
                return $"{diff.Days} day{(diff.Days > 1 ? "s" : "")} ago";
            else if (diff.Hours > 0)
                return $"{diff.Hours} hour{(diff.Hours > 1 ? "s" : "")} ago";
            else if (diff.Minutes > 0)
                return $"{diff.Minutes} minute{(diff.Minutes > 1 ? "s" : "")} ago";
            else
                return "Just now";
        }

        protected void btnExportReport_Click(object sender, EventArgs e)
        {
            Response.Redirect("print_applications.aspx");
        }
    }
}