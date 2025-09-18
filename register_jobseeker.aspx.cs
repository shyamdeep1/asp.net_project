using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Reflection;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Job_Portal
{
    public partial class register_jobseeker : System.Web.UI.Page

    {
        string connStr = ConfigurationManager.ConnectionStrings["JobPortalConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {


        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (txtPassword.Text != txtConfirmPassword.Text)
            {
                lblMessage.Text = "Passwords do not match.";
                return;
            }

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

]                SqlCommand checkEmail = new SqlCommand(
                    "SELECT COUNT(*) FROM Users WHERE Email='"+txtEmail.Text+"'", con);
                int exists = (int)checkEmail.ExecuteScalar();

                if (exists > 0)
                {
                    lblMessage.Text = "Email already registered.";
                    return;
                }

                SqlCommand cmd = new SqlCommand(
                    "INSERT INTO Users (FullName, Email, Password, Role) VALUES ('"+txtFullName.Text+"', '"+txtEmail.Text+"', '"+HashPassword(txtPassword.Text)+"','JobSeeker')", con);

               

                int rows = cmd.ExecuteNonQuery();
                if (rows > 0)
                {
                    lblMessage.CssClass = "text-success";
                    lblMessage.Text = "Registration successful! You can now login.";
                    ClearForm();
                }
                else
                {
                    lblMessage.Text = "Registration failed. Try again.";
                }
            }

        }
        

             private string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder sb = new StringBuilder();
                foreach (byte b in bytes)
                    sb.Append(b.ToString("x2"));
                return sb.ToString();
            }
        }


        private void ClearForm()
        {
            txtFullName.Text = "";
            txtEmail.Text = "";
            txtPassword.Text = "";
            txtConfirmPassword.Text = "";
        }
    }
}