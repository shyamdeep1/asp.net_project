using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
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
    public partial class job_applicants : System.Web.UI.Page
    {
        String s = ConfigurationManager.ConnectionStrings["JobPortalConnection"].ConnectionString;
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataTable dt;
        ReportDocument cr = new ReportDocument();

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] == null || Session["Role"] == null || Session["Role"].ToString() != "Recruiter")
                {
                    Response.Redirect("login.aspx");
                }
                else
                {
                    LoadJobsWithApplications();
                }
            }
        }

        private void LoadJobsWithApplications()
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            getcon();

            string jobQuery = @"SELECT j.JobID, j.JobTitle, j.JobDescription, j.Location, j.Salary, 
                               j.JobType, j.Category, j.PostedDate,
                               (SELECT COUNT(*) FROM JobApplications WHERE JobID = j.JobID) as TotalApplications,
                               (SELECT COUNT(*) FROM JobApplications WHERE JobID = j.JobID AND Status = 'Pending') as PendingApplications,
                               (SELECT COUNT(*) FROM JobApplications WHERE JobID = j.JobID AND Status = 'Reviewed') as ReviewedApplications,
                               (SELECT COUNT(*) FROM JobApplications WHERE JobID = j.JobID AND Status = 'Shortlisted') as ShortlistedApplications
                               FROM Jobs j 
                               INNER JOIN Recruiters r ON j.RecruiterID = r.RecruiterID 
                               WHERE r.UserID = @UserID 
                               ORDER BY j.PostedDate DESC";

            cmd = new SqlCommand(jobQuery, con);
            cmd.Parameters.AddWithValue("@UserID", userId);
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                rptJobs.DataSource = dt;
                rptJobs.DataBind();
                pnlJobs.Visible = true;
                pnlNoJobs.Visible = false;
            }
            else
            {
                pnlJobs.Visible = false;
                pnlNoJobs.Visible = true;
            }

            con.Close();
        }

        protected void rptJobs_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                int jobId = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "JobID"));

                Repeater rptApplications = (Repeater)e.Item.FindControl("rptApplications");
                Panel pnlNoApplications = (Panel)e.Item.FindControl("pnlNoApplications");

                if (rptApplications != null)
                {
                    DataTable applicationsData = GetApplicationsForJob(jobId);

                    if (applicationsData != null && applicationsData.Rows.Count > 0)
                    {
                        rptApplications.DataSource = applicationsData;
                        rptApplications.DataBind();
                        pnlNoApplications.Visible = false;
                    }
                    else
                    {
                        pnlNoApplications.Visible = true;
                    }
                }
            }
        }

        private DataTable GetApplicationsForJob(int jobId)
        {
            getcon();

            string query = @"SELECT ja.ApplicationID, ja.JobID, ja.FullName, ja.Email, ja.Phone, 
                           ja.ApplicationDate, ja.Status, ja.Resume, ja.JobSeekerID
                           FROM JobApplications ja 
                           WHERE ja.JobID = @JobID 
                           ORDER BY ja.ApplicationDate DESC";

            cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@JobID", jobId);
            da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            con.Close();

            return dt;
        }

        protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddlStatus = (DropDownList)sender;
            RepeaterItem item = (RepeaterItem)ddlStatus.NamingContainer;
            HiddenField hdnApplicationID = (HiddenField)item.FindControl("hdnApplicationID");

            if (hdnApplicationID != null && !string.IsNullOrEmpty(ddlStatus.SelectedValue))
            {
                int applicationId = Convert.ToInt32(hdnApplicationID.Value);
                string newStatus = ddlStatus.SelectedValue;

                UpdateApplicationStatus(applicationId, newStatus);

                Response.Redirect(Request.RawUrl);
            }
        }

        private void UpdateApplicationStatus(int applicationId, string status)
        {
            getcon();

            string query = "UPDATE JobApplications SET Status = @Status WHERE ApplicationID = @ApplicationID";
            cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Status", status);
            cmd.Parameters.AddWithValue("@ApplicationID", applicationId);

            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void btnPrintAll_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] != null)
            {
                int userId = Convert.ToInt32(Session["UserID"]);
                int recruiterId = GetRecruiterId(userId);

                if (recruiterId > 0)
                {
                    GenerateReport(recruiterId);
                }
                else
                {
                    Response.Write("<script>alert('Recruiter not found for this user.');</script>");
                }
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }

        private int GetRecruiterId(int userId)
        {
            getcon();
            SqlCommand cmd = new SqlCommand("SELECT RecruiterID FROM Recruiters WHERE UserID = @UserID", con);
            cmd.Parameters.AddWithValue("@UserID", userId);
            object result = cmd.ExecuteScalar();
            con.Close();

            if (result != null && result != DBNull.Value)
                return Convert.ToInt32(result);
            else
                return 0;
        }

        private void GenerateReport(int recruiterId)
        {
            getcon();

            DataSet ds = new DataSet();

            SqlDataAdapter daJob = new SqlDataAdapter(
                "SELECT * FROM Jobs WHERE RecruiterID = @RecruiterID", con);
            daJob.SelectCommand.Parameters.AddWithValue("@RecruiterID", recruiterId);
            daJob.Fill(ds, "Jobs");

            SqlDataAdapter daRec = new SqlDataAdapter(
                "SELECT * FROM Recruiters WHERE RecruiterID = @RecruiterID", con);
            daRec.SelectCommand.Parameters.AddWithValue("@RecruiterID", recruiterId);
            daRec.Fill(ds, "Recruiters");

            SqlDataAdapter daApp = new SqlDataAdapter(
                @"SELECT * FROM JobApplications 
          WHERE JobID IN (SELECT JobID FROM Jobs WHERE RecruiterID = @RecruiterID)", con);
            daApp.SelectCommand.Parameters.AddWithValue("@RecruiterID", recruiterId);
            daApp.Fill(ds, "JobApplications");

            ds.WriteXmlSchema(Server.MapPath("~/AllApplicationData.xml"));

            string rptPath = Server.MapPath("~/PrintAllJobs.rpt");

            cr.Load(rptPath);
            cr.SetDataSource(ds);

            cr.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, "Recruiter_Jobs_" + recruiterId);

            cr.Close();
            cr.Dispose();
            con.Close();
        }

        protected void rptJobs_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "ViewApplications")
            {
                int jobId = Convert.ToInt32(e.CommandArgument);
                Response.Redirect("print_applications.aspx?JobID=" + jobId);
            }
        }
    }
}
