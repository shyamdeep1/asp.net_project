using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Job_Portal
{
    public partial class jobseeker_applied_jobs : System.Web.UI.Page
    {
        String s = ConfigurationManager.ConnectionStrings["JobPortalConnection"].ConnectionString;
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] == null || Session["Role"] == null || Session["Role"].ToString() != "JobSeeker")
                {
                    Response.Redirect("login.aspx");
                }
                else
                {
                    LoadUserInfo();
                    LoadAppliedJobs();
                }
            }
        }

        private void LoadUserInfo()
        {
            if (Session["FullName"] != null)
            {
                lblUserName.Text = "Welcome, " + Session["FullName"].ToString();
            }
        }

        private void LoadAppliedJobs(string statusFilter = "")
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            getcon();

            string query = @"SELECT ja.ApplicationID, ja.JobID, j.JobTitle, j.Location, j.Salary, j.Category, 
                               j.JobType, j.Company_Logo, ja.ApplicationDate, ja.Status, r.CompanyName
                               FROM JobApplications ja 
                               INNER JOIN Jobs j ON ja.JobID = j.JobID 
                               INNER JOIN Recruiters r ON j.RecruiterID = r.RecruiterID
                               WHERE ja.JobSeekerID = @UserID";

            if (!string.IsNullOrEmpty(statusFilter))
            {
                query += " AND ja.Status = @Status";
            }

            query += " ORDER BY ja.ApplicationDate DESC";

            cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@UserID", userId);

            if (!string.IsNullOrEmpty(statusFilter))
            {
                cmd.Parameters.AddWithValue("@Status", statusFilter);
            }

            da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    if (row["CompanyName"] == DBNull.Value || string.IsNullOrEmpty(row["CompanyName"].ToString()))
                    {
                        row["CompanyName"] = "Company Name Not Available";
                    }

                    if (row["Company_Logo"] == DBNull.Value || string.IsNullOrEmpty(row["Company_Logo"].ToString()))
                    {
                        row["Company_Logo"] = "~/images/job_logo_1.jpg";
                    }
                }

                dlAppliedJobs.DataSource = ds;
                dlAppliedJobs.DataBind();
                dlAppliedJobs.Visible = true;
                pnlNoApplications.Visible = false;

                int totalApplications = ds.Tables[0].Rows.Count;
                lblResultsCount.Text = $"Showing {totalApplications} Application{(totalApplications != 1 ? "s" : "")}";
                lblApplicationCount.Text = $"You have {totalApplications} job application{(totalApplications != 1 ? "s" : "")} on record";
            }
            else
            {
                dlAppliedJobs.Visible = false;
                pnlNoApplications.Visible = true;
                lblResultsCount.Text = "No Applications Found";
                lblApplicationCount.Text = "You have 0 job applications on record";
            }

            con.Close();
        }

        protected void ddlFilterStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            string statusFilter = ddlFilterStatus.SelectedValue;
            LoadAppliedJobs(statusFilter);
        }

        protected void dlAppliedJobs_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "ViewJob")
            {
                string jobId = e.CommandArgument.ToString();
                Response.Redirect("job_details.aspx?JobID=" + jobId);
            }
            else if (e.CommandName == "ViewApplication")
            {
                string applicationId = e.CommandArgument.ToString();
                Response.Redirect("application_details.aspx?ApplicationID=" + applicationId);
            }
        }

        protected string GetStatusBadgeClass(string status)
        {
            switch (status.ToLower())
            {
                case "pending":
                    return "badge-warning";
                case "reviewed":
                    return "badge-info";
                case "shortlisted":
                    return "badge-primary";
                case "accepted":
                    return "badge-success";
                case "rejected":
                    return "badge-danger";
                default:
                    return "badge-secondary";
            }
        }
    }
}