using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Job_Portal
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        string cs = ConfigurationManager.ConnectionStrings["JobPortalConnection"].ConnectionString;

        protected void btnLogin_Click(object sender, EventArgs e)
        {

            using (SqlConnection con = new SqlConnection(cs))
            {
                try
                {
                    con.Open();

                    string query = "SELECT UserID, FullName, Role, Password FROM Users WHERE Email=@Email";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());

                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        string storedHash = reader["Password"].ToString();
                        string enteredHash = HashPassword(txtPassword.Text.Trim());

                        if (storedHash == enteredHash)
                        {
                            // Store session info
                            Session["UserId"] = reader["UserId"];
                            Session["FullName"] = reader["FullName"];
                            Session["Role"] = reader["Role"];

                            string role = reader["Role"].ToString();

                            // Redirect based on role
                            if (role == "JobSeeker")
                                Response.Redirect("index.aspx");
                            else if (role == "Recruiter")
                                Response.Redirect("index.aspx");
                            else
                                Response.Redirect("admin_dashboard.aspx");
                        }
                        else
                        {
                            lblMessage.Text = "Invalid email or password.";
                        }
                    }
                    else
                    {
                        lblMessage.Text = "User not found.";
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error: " + ex.Message;
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
    }
}
