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
        }

        private void LoadRecentApplications()
        {
        }

        private void LoadActiveJobs()
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

        private void LoadPerformanceMetrics()
        {
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
