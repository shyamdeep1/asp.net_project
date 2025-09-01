using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Job_Portal
{
    public partial class post_job : System.Web.UI.Page
    {
        string conn = ConfigurationManager.ConnectionStrings["JobPortalConnection"].ConnectionString;


        SqlCommand cmd;
        
        void getcon()
        {
            SqlConnection con=new SqlConnection(conn);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Ensure recruiter is logged in
                if (Session["RecruiterID"] == null)
                {
                    Response.Redirect("login.aspx"); // redirect if not logged in
                }
            }
        }


        protected void btnSaveJob_Click(object sender, EventArgs e)
        {
            getcon();

        }
        private void ClearForm()
        {
            txtJobTitle.Text = "";
            txtDescription.Text = "";
            txtLocation.Text = "";
            txtSalary.Text = "";
            txtSkills.Text = "";
            txtDeadline.Text = "";
        }
    }
}