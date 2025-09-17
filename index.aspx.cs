using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Job_Portal
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }
            lblWelcome.Text = "Welcome " + Session["FullName"] + " (" + Session["Role"] + ")";

            if (!IsPostBack)
            {
                string role = Session["Role"] != null ? Session["Role"].ToString() : "";

                // Default: Show Public Menu
                phPublic.Visible = true;
                phJobSeeker.Visible = false;
               

                switch (role)
                {
                    case "JobSeeker":
                        phJobSeeker.Visible = true;
                        break;

                    
                }
            }

        }
    }
}