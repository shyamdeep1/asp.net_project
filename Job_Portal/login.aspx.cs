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
    public partial class login : System.Web.UI.Page
    {

        string cs = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ddlRole.Items.Clear();
                ddlRole.Items.Add("Job Seeker");
                ddlRole.Items.Add("Recruiter");

                // Only show admin if ?admin=true in URL
                if (Request.QueryString["admin"] == "true")
                {
                    ddlRole.Items.Add("Admin");
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();
            string role = ddlRole.SelectedValue;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "";
                if (role == "Job Seeker")
                {
                    query = "SELECT JobSeekerID, FullName FROM JobSeekers WHERE Email=@Email AND Password=@Password";
                }
                else if (role == "Recruiter")
                {
                    query = "SELECT RecruiterID, CompanyName FROM Recruiters WHERE Email=@Email AND Password=@Password";
                }
                else if (role == "Admin")
                {
                    query = "SELECT AdminID, FullName FROM Admins WHERE Email=@Email AND Password=@Password";
                }

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Password", password);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    // Store Session Data
                    Session["Role"] = role;
                    Session["UserID"] = dr[0].ToString();
                    Session["FullName"] = dr[1].ToString();

                    // Redirect based on role
                    if (role == "Job Seeker")
                        Response.Redirect("JobSeekerDashboard.aspx");
                    else if (role == "Recruiter")
                        Response.Redirect("RecruiterDashboard.aspx");
                    else if (role == "Admin")
                        Response.Redirect("AdminDashboard.aspx");
                }
                else
                {
                    lblMessage.Text = "Invalid email or password.";
                }
                con.Close();
            }
        }
    }
}