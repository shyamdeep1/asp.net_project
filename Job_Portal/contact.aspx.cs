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
    public partial class contact : System.Web.UI.Page
    {
        String s = ConfigurationManager.ConnectionStrings["JobPortalConnection"].ConnectionString;
        SqlConnection con;
        SqlCommand cmd;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Pre-fill form if user is logged in
                if (Session["UserID"] != null && Session["Email"] != null)
                {
                    txtEmail.Text = Session["Email"].ToString();

                    if (Session["FullName"] != null)
                    {
                        txtFullName.Text = Session["FullName"].ToString();
                    }
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    getcon();

                    string query = @"INSERT INTO ContactMessages (FullName, Email, Phone, Subject, Message, SubmittedDate, Status, IsRead)
                                   VALUES (@FullName, @Email, @Phone, @Subject, @Message, @SubmittedDate, @Status, @IsRead)";

                    cmd = new SqlCommand(query, con);

                    cmd.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@Phone", string.IsNullOrEmpty(txtPhone.Text) ? (object)DBNull.Value : txtPhone.Text.Trim());
                    cmd.Parameters.AddWithValue("@Subject", txtSubject.Text.Trim());
                    cmd.Parameters.AddWithValue("@Message", txtMessage.Text.Trim());
                    cmd.Parameters.AddWithValue("@SubmittedDate", DateTime.Now);
                    cmd.Parameters.AddWithValue("@Status", "Pending");
                    cmd.Parameters.AddWithValue("@IsRead", false);

                    int result = cmd.ExecuteNonQuery();

                    con.Close();

                    if (result > 0)
                    {
                        // Show success message
                        pnlSuccess.Visible = true;
                        pnlError.Visible = false;

                        // Clear form fields
                        ClearForm();

                        // Optional: Send email notification to admin (implement if needed)
                        // SendEmailNotification();
                    }
                    else
                    {
                        ShowError("Failed to send message. Please try again.");
                    }
                }
                catch (Exception ex)
                {
                    ShowError("An error occurred: " + ex.Message);
                }
            }
        }

        private void ClearForm()
        {
            // Don't clear email and name if user is logged in
            if (Session["UserID"] == null)
            {
                txtFullName.Text = "";
                txtEmail.Text = "";
            }

            txtPhone.Text = "";
            txtSubject.Text = "";
            txtMessage.Text = "";
        }

        private void ShowError(string message)
        {
            pnlError.Visible = true;
            pnlSuccess.Visible = false;
            lblError.Text = message;
        }
    }
}