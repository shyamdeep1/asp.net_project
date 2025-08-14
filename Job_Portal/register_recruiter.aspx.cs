using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace Job_Portal
{
    public partial class register_recruiter : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["JobPortalConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Prevent master page from blocking this page
            HttpContext.Current.Items["BypassAuth"] = true;
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
                SqlTransaction transaction = null;

                try
                {
                    con.Open();
                    transaction = con.BeginTransaction();

                    // Check if email exists in Users
                    SqlCommand checkEmail = new SqlCommand(
                        "SELECT COUNT(*) FROM Users WHERE Email=@Email", con, transaction);
                    checkEmail.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    int exists = (int)checkEmail.ExecuteScalar();

                    if (exists > 0)
                    {
                        lblMessage.Text = "Email already registered.";
                        transaction.Rollback();
                        return;
                    }

                    // Insert into Users table
                    SqlCommand cmdUser = new SqlCommand(
                        @"INSERT INTO Users (FullName, Email, Password, Role) 
                          OUTPUT INSERTED.UserID
                          VALUES (@FullName, @Email, @Password, @Role)", con, transaction);

                    cmdUser.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
                    cmdUser.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    cmdUser.Parameters.AddWithValue("@Password", HashPassword(txtPassword.Text.Trim()));
                    cmdUser.Parameters.AddWithValue("@Role", "Recruiter");

                    int newUserId = (int)cmdUser.ExecuteScalar();

                    // Insert into Recruiters table
                    SqlCommand cmdRecruiter = new SqlCommand(
                        @"INSERT INTO Recruiters (UserID, CompanyName, CompanyAddress) 
                          VALUES (@UserID, @CompanyName, @CompanyAddress)", con, transaction);

                    cmdRecruiter.Parameters.AddWithValue("@UserID", newUserId);
                    cmdRecruiter.Parameters.AddWithValue("@CompanyName", txtCompany.Text.Trim());
                    cmdRecruiter.Parameters.AddWithValue("@CompanyAddress", txtCompanyAddress.Text.Trim());

                    cmdRecruiter.ExecuteNonQuery();

                    // Commit transaction
                    transaction.Commit();

                    lblMessage.CssClass = "text-success";
                    lblMessage.Text = "Registration successful! You can now login.";
                    ClearForm();
                }
                catch (Exception ex)
                {
                    if (transaction != null)
                        transaction.Rollback();

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

        private void ClearForm()
        {
            txtFullName.Text = "";
            txtCompany.Text = "";
            txtCompanyAddress.Text = "";
            txtEmail.Text = "";
            txtPassword.Text = "";
            txtConfirmPassword.Text = "";
        }
    }
}
