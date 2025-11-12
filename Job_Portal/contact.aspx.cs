using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;

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

                // Set focus to first field
                txtFullName.Focus();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    // Get the final subject (either selected or custom)
                    string finalSubject = ddlSubject.SelectedValue;
                    if (ddlSubject.SelectedValue == "Other" && !string.IsNullOrEmpty(txtCustomSubject.Text.Trim()))
                    {
                        finalSubject = "Other: " + txtCustomSubject.Text.Trim();
                    }

                    // Validate message length
                    if (txtMessage.Text.Trim().Length < 10)
                    {
                        ShowError("Message must be at least 10 characters long.");
                        return;
                    }

                    // Check if table exists, if not create it
                    CreateContactMessagesTableIfNotExists();

                    getcon();

                    string query = @"INSERT INTO ContactMessages (FullName, Email, Phone, Subject, Message, SubmittedDate, Status, IsRead, NewsletterSubscription)
                                   VALUES (@FullName, @Email, @Phone, @Subject, @Message, @SubmittedDate, @Status, @IsRead, @NewsletterSubscription)";

                    cmd = new SqlCommand(query, con);

                    cmd.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim().ToLower());
                    cmd.Parameters.AddWithValue("@Phone", string.IsNullOrEmpty(txtPhone.Text.Trim()) ? (object)DBNull.Value : txtPhone.Text.Trim());
                    cmd.Parameters.AddWithValue("@Subject", finalSubject);
                    cmd.Parameters.AddWithValue("@Message", txtMessage.Text.Trim());
                    cmd.Parameters.AddWithValue("@SubmittedDate", DateTime.Now);
                    cmd.Parameters.AddWithValue("@Status", "Pending");
                    cmd.Parameters.AddWithValue("@IsRead", false);
                    cmd.Parameters.AddWithValue("@NewsletterSubscription", chkNewsletter.Checked);

                    int result = cmd.ExecuteNonQuery();

                    con.Close();

                    if (result > 0)
                    {
                        // Show success message
                        pnlSuccess.Visible = true;
                        pnlError.Visible = false;

                        // Clear form fields
                        ClearForm();

                        // Optional: Send confirmation email to user
                        SendConfirmationEmail(txtEmail.Text.Trim(), txtFullName.Text.Trim(), finalSubject);

                        // Optional: Send notification email to admin
                        SendAdminNotification(txtFullName.Text.Trim(), txtEmail.Text.Trim(), finalSubject, txtMessage.Text.Trim());

                        // Log the successful submission
                        LogContactSubmission(txtEmail.Text.Trim(), finalSubject, "Success");
                    }
                    else
                    {
                        ShowError("Failed to send message. Please try again or contact us directly at +1 (555) 123-4567.");
                    }
                }
                catch (Exception ex)
                {
                    // Log the error
                    LogContactSubmission(txtEmail.Text.Trim(), ddlSubject.SelectedValue, "Error: " + ex.Message);
                    
                    ShowError("We're experiencing technical difficulties. Please try again later or contact us directly at +1 (555) 123-4567.");
                }
            }
        }

        private void CreateContactMessagesTableIfNotExists()
        {
            try
            {
                getcon();

                // Check if table exists
                string checkTableQuery = @"SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES 
                                         WHERE TABLE_NAME = 'ContactMessages'";
                
                cmd = new SqlCommand(checkTableQuery, con);
                int tableExists = (int)cmd.ExecuteScalar();

                if (tableExists == 0)
                {
                    // Create the table
                    string createTableQuery = @"
                        CREATE TABLE [dbo].[ContactMessages](
                            [MessageID] [int] IDENTITY(1,1) NOT NULL,
                            [FullName] [nvarchar](100) NOT NULL,
                            [Email] [nvarchar](100) NOT NULL,
                            [Phone] [nvarchar](20) NULL,
                            [Subject] [nvarchar](200) NOT NULL,
                            [Message] [nvarchar](max) NOT NULL,
                            [SubmittedDate] [datetime] NOT NULL,
                            [Status] [nvarchar](20) NOT NULL DEFAULT ('Pending'),
                            [IsRead] [bit] NOT NULL DEFAULT (0),
                            [AdminResponse] [nvarchar](max) NULL,
                            [ResponseDate] [datetime] NULL,
                            [NewsletterSubscription] [bit] NOT NULL DEFAULT (0),
                            CONSTRAINT [PK_ContactMessages] PRIMARY KEY CLUSTERED ([MessageID] ASC)
                        )";

                    cmd = new SqlCommand(createTableQuery, con);
                    cmd.ExecuteNonQuery();
                }

                con.Close();
            }
            catch (Exception ex)
            {
                if (con.State == ConnectionState.Open)
                    con.Close();
                // Table might already exist or there's a permission issue
                // Continue execution as the main query will handle the error
            }
        }

        private void LogContactSubmission(string email, string subject, string status)
        {
            try
            {
                // Simple logging - you can extend this to write to a log file or separate log table
                System.Diagnostics.Debug.WriteLine($"Contact Form Submission - Email: {email}, Subject: {subject}, Status: {status}, Time: {DateTime.Now}");
            }
            catch
            {
                // Ignore logging errors
            }
        }

        private void SendConfirmationEmail(string userEmail, string userName, string subject)
        {
            try
            {
                // Note: Configure SMTP settings in web.config for this to work
                MailMessage mail = new MailMessage();
                mail.From = new MailAddress("noreply@jobboard.com", "JobBoard Support");
                mail.To.Add(userEmail);
                mail.Subject = "Thank you for contacting JobBoard - We've received your message";
                
                mail.Body = $@"
                    Dear {userName},

                    Thank you for contacting JobBoard! We have successfully received your message regarding: {subject}

                    Our support team will review your inquiry and respond within 24 hours during business days (Monday-Friday, 9AM-6PM EST).

                    In the meantime, you can:
                    • Browse our FAQ section for quick answers
                    • Call us at +1 (555) 123-4567 for urgent matters
                    • Visit our help center at www.jobboard.com/help

                    We appreciate your interest in JobBoard and look forward to assisting you.

                    Best regards,
                    The JobBoard Support Team

                    ---
                    This is an automated message. Please do not reply to this email.
                    For immediate assistance, please contact us at support@jobboard.com
                ";

                mail.IsBodyHtml = false;

                SmtpClient smtp = new SmtpClient();
                // Note: SMTP configuration should be in web.config
                // smtp.Send(mail);
            }
            catch (Exception ex)
            {
                // Log email sending error but don't stop the process
                System.Diagnostics.Debug.WriteLine("Email sending failed: " + ex.Message);
            }
        }

        private void SendAdminNotification(string userName, string userEmail, string subject, string message)
        {
            try
            {
                // Note: Configure SMTP settings in web.config for this to work
                MailMessage mail = new MailMessage();
                mail.From = new MailAddress("system@jobboard.com", "JobBoard System");
                mail.To.Add("admin@jobboard.com");
                mail.Subject = $"New Contact Form Submission - {subject}";
                
                mail.Body = $@"
                    New contact form submission received:

                    Name: {userName}
                    Email: {userEmail}
                    Subject: {subject}
                    Time: {DateTime.Now:yyyy-MM-dd HH:mm:ss}

                    Message:
                    {message}

                    Please respond within 24 hours.
                    
                    ---
                    JobBoard Admin System
                ";

                mail.IsBodyHtml = false;

                SmtpClient smtp = new SmtpClient();
                // Note: SMTP configuration should be in web.config
                // smtp.Send(mail);
            }
            catch (Exception ex)
            {
                // Log email sending error but don't stop the process
                System.Diagnostics.Debug.WriteLine("Admin notification failed: " + ex.Message);
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
            ddlSubject.SelectedIndex = 0;
            txtCustomSubject.Text = "";
            txtMessage.Text = "";
            chkNewsletter.Checked = false;
        }

        private void ShowError(string message)
        {
            pnlError.Visible = true;
            pnlSuccess.Visible = false;
            lblError.Text = message;
        }

        // Method to get contact statistics (for admin dashboard)
        public static ContactStats GetContactStatistics()
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["JobPortalConnection"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    
                    ContactStats stats = new ContactStats();

                    // Total messages
                    string totalQuery = "SELECT COUNT(*) FROM ContactMessages";
                    using (SqlCommand cmd = new SqlCommand(totalQuery, connection))
                    {
                        stats.TotalMessages = (int)cmd.ExecuteScalar();
                    }

                    // Pending messages
                    string pendingQuery = "SELECT COUNT(*) FROM ContactMessages WHERE Status = 'Pending'";
                    using (SqlCommand cmd = new SqlCommand(pendingQuery, connection))
                    {
                        stats.PendingMessages = (int)cmd.ExecuteScalar();
                    }

                    // Today's messages
                    string todayQuery = "SELECT COUNT(*) FROM ContactMessages WHERE CAST(SubmittedDate AS DATE) = CAST(GETDATE() AS DATE)";
                    using (SqlCommand cmd = new SqlCommand(todayQuery, connection))
                    {
                        stats.TodayMessages = (int)cmd.ExecuteScalar();
                    }

                    // Newsletter subscribers
                    string newsletterQuery = "SELECT COUNT(*) FROM ContactMessages WHERE NewsletterSubscription = 1";
                    using (SqlCommand cmd = new SqlCommand(newsletterQuery, connection))
                    {
                        stats.NewsletterSubscribers = (int)cmd.ExecuteScalar();
                    }

                    return stats;
                }
            }
            catch (Exception)
            {
                return new ContactStats();
            }
        }
    }

    // Helper class for contact statistics
    public class ContactStats
    {
        public int TotalMessages { get; set; } = 0;
        public int PendingMessages { get; set; } = 0;
        public int TodayMessages { get; set; } = 0;
        public int NewsletterSubscribers { get; set; } = 0;
    }
}