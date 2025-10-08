using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Job_Portal
{
    public partial class logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Clear all session variables
            Session.Clear();
            Session.Abandon();
            
            // Clear any authentication cookies
            if (Request.Cookies["UserType"] != null)
            {
                HttpCookie userTypeCookie = new HttpCookie("UserType");
                userTypeCookie.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(userTypeCookie);
            }
            
            if (Request.Cookies["UserID"] != null)
            {
                HttpCookie userIdCookie = new HttpCookie("UserID");
                userIdCookie.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(userIdCookie);
            }
            
            if (Request.Cookies["UserName"] != null)
            {
                HttpCookie userNameCookie = new HttpCookie("UserName");
                userNameCookie.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(userNameCookie);
            }
            
            // Redirect to login page after a short delay
            Response.AddHeader("REFRESH", "2;URL=login.aspx");
        }
    }
}