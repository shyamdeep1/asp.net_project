using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Job_Portal
{
    public partial class index : System.Web.UI.Page
    {
        String s = ConfigurationManager.ConnectionStrings["JobPortalConnection"].ConnectionString;
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["FullName"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }
            
            lblWelcome.Text = "Welcome " + Session["FullName"].ToString() + " (" + Session["Role"].ToString() + ")";
            
            if (!IsPostBack)
            {
                string role = Session["Role"].ToString();

                phPublic.Visible = true;
                phJobSeeker.Visible = false;
                phAdmin.Visible = false;

                switch (role)
                {
                    case "JobSeeker":
                        phPublic.Visible = true;
                        phJobSeeker.Visible = true;
                        break;
                    case "Admin":
                        phPublic.Visible = false;
                        phAdmin.Visible = true;
                        break;
                }
                BindJobs();
            }
        }

        private void BindJobs(string searchTitle = "", string searchLocation = "", string searchJobType = "")
        {
            getcon();
            
            string query = "SELECT * FROM Jobs WHERE 1=1";
            
            if (!string.IsNullOrEmpty(searchTitle))
            {
                query += " AND Category LIKE '%" + searchTitle + "%'";
            }
            
            if (!string.IsNullOrEmpty(searchLocation))
            {
                query += " AND Location LIKE '%" + searchLocation + "%'";
            }
            
            if (!string.IsNullOrEmpty(searchJobType))
            {
                query += " AND JobType = '" + searchJobType + "'";
            }
            
            query += " ORDER BY JobID DESC";

            cmd = new SqlCommand(query, con);
            da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            
            if (ds.Tables[0].Rows.Count > 0)
            {
                dlJobs.DataSource = ds;
                dlJobs.DataBind();
                dlJobs.Visible = true;
                pnlNoJobs.Visible = false;
            }
            else
            {
                dlJobs.Visible = false;
                pnlNoJobs.Visible = true;
            }
            
            con.Close();
        }

        protected void dlJobs_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "ViewDetails")
            {
                string jobId = e.CommandArgument.ToString();
                Response.Redirect("job_details.aspx?JobID=" + jobId);
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchTitle = TextBox2.Text.Trim();
            string searchLocation = TextBox1.Text.Trim();
            string searchJobType = ddlJobType.SelectedValue;
            
            BindJobs(searchTitle, searchLocation, searchJobType);
        }
    }
}