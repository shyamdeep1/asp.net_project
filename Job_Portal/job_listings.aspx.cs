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
    public partial class job_listings : System.Web.UI.Page
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
                LoadJobListings();
            }
        }

        private void LoadJobListings(string searchTitle = "", string searchLocation = "", string searchJobType = "", string sortBy = "Latest")
        {
            getcon();

            string query = @"SELECT j.JobID, j.JobTitle, j.Location, j.Salary, j.SkillsRequired, j.ExperienceRequired, 
                               j.JobType, j.Category, j.Deadline, j.Status, j.Company_Logo, j.PostedDate, j.JobDescription,
                               r.CompanyName
                               FROM Jobs j 
                               INNER JOIN Recruiters r ON j.RecruiterID = r.RecruiterID 
                               WHERE j.Status = 'Active'";

            if (!string.IsNullOrEmpty(searchTitle))
            {
                query += " AND (j.JobTitle LIKE @searchTitle OR j.Category LIKE @searchTitle OR j.SkillsRequired LIKE @searchTitle)";
            }

            if (!string.IsNullOrEmpty(searchLocation))
            {
                query += " AND j.Location LIKE @searchLocation";
            }

            if (!string.IsNullOrEmpty(searchJobType))
            {
                query += " AND j.JobType = @searchJobType";
            }

            switch (sortBy)
            {
                case "Latest":
                    query += " ORDER BY j.PostedDate DESC, j.JobID DESC";
                    break;
                case "Oldest":
                    query += " ORDER BY j.PostedDate ASC, j.JobID ASC";
                    break;
                case "CompanyAZ":
                    query += " ORDER BY r.CompanyName ASC";
                    break;
                default:
                    query += " ORDER BY j.PostedDate DESC, j.JobID DESC";
                    break;
            }

            cmd = new SqlCommand(query, con);

            if (!string.IsNullOrEmpty(searchTitle))
            {
                cmd.Parameters.AddWithValue("@searchTitle", "%" + searchTitle + "%");
            }
            if (!string.IsNullOrEmpty(searchLocation))
            {
                cmd.Parameters.AddWithValue("@searchLocation", "%" + searchLocation + "%");
            }
            if (!string.IsNullOrEmpty(searchJobType))
            {
                cmd.Parameters.AddWithValue("@searchJobType", searchJobType);
            }

            da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[0];
                foreach (DataRow row in dt.Rows)
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

                dlJobs.DataSource = ds;
                dlJobs.DataBind();
                dlJobs.Visible = true;
                pnlNoJobs.Visible = false;

                int totalJobs = ds.Tables[0].Rows.Count;
                if (!string.IsNullOrEmpty(searchTitle) || !string.IsNullOrEmpty(searchLocation) || !string.IsNullOrEmpty(searchJobType))
                {
                    lblResultsCount.Text = $"Found {totalJobs} Job{(totalJobs != 1 ? "s" : "")}";
                }
                else
                {
                    lblResultsCount.Text = $"All {totalJobs} Job Opportunities";
                }

                lblPaginationInfo.Text = $"Showing all {totalJobs} jobs";
            }
            else
            {
                dlJobs.Visible = false;
                pnlNoJobs.Visible = true;
                lblResultsCount.Text = "No Jobs Found";
                lblPaginationInfo.Text = "No jobs to display";
            }

            con.Close();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchTitle = txtJobTitle.Text.Trim();
            string searchLocation = txtLocation.Text.Trim();
            string searchJobType = ddlJobType.SelectedValue;
            string sortBy = ddlSortBy.SelectedValue;

            LoadJobListings(searchTitle, searchLocation, searchJobType, sortBy);
        }

        protected void btnClearSearch_Click(object sender, EventArgs e)
        {
            txtJobTitle.Text = "";
            txtLocation.Text = "";
            ddlJobType.SelectedIndex = 0;
            ddlSortBy.SelectedIndex = 0;
            LoadJobListings();
        }

        protected void ddlSortBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            string searchTitle = txtJobTitle.Text.Trim();
            string searchLocation = txtLocation.Text.Trim();
            string searchJobType = ddlJobType.SelectedValue;
            string sortBy = ddlSortBy.SelectedValue;

            LoadJobListings(searchTitle, searchLocation, searchJobType, sortBy);
        }

        protected void dlJobs_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "ViewDetails")
            {
                string jobId = e.CommandArgument.ToString();
                Response.Redirect("job_details.aspx?JobID=" + jobId);
            }
            else if (e.CommandName == "QuickApply")
            {
                string jobId = e.CommandArgument.ToString();

                if (Session["UserID"] == null)
                {
                    Response.Redirect("login.aspx?returnUrl=" + Server.UrlEncode("job_details.aspx?JobID=" + jobId));
                }
                else
                {
                    Response.Redirect("job_details.aspx?JobID=" + jobId + "&action=apply");
                }
            }
        }
    }
}