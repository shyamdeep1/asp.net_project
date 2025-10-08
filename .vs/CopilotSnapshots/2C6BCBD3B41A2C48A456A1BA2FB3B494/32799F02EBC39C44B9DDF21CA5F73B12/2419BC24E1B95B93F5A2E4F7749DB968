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

            
        }
    }
}
