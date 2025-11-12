using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Job_Portal
{
    public partial class admin_contact_messages : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["JobPortalConnection"].ConnectionString;
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;
        private int currentMessageId = 0;

        void getcon()
        {
            con = new SqlConnection(cs);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check admin authentication
                if (Session["UserId"] == null || Session["Role"] == null || Session["Role"].ToString() != "Admin")
                {
                    Response.Redirect("login.aspx");
                    return;
                }

                LoadStatistics();
                LoadMessages();
            }
        }

        private void LoadStatistics()
        {
            try
            {
                getcon();

                // Total messages
                cmd = new SqlCommand("SELECT COUNT(*) FROM ContactMessages", con);
                int totalMessages = (int)cmd.ExecuteScalar();
                lblTotalMessages.Text = totalMessages.ToString();

                // Pending messages
                cmd = new SqlCommand("SELECT COUNT(*) FROM ContactMessages WHERE Status = 'Pending'", con);
                int pendingMessages = (int)cmd.ExecuteScalar();
                lblPendingMessages.Text = pendingMessages.ToString();

                // Today's messages
                cmd = new SqlCommand("SELECT COUNT(*) FROM ContactMessages WHERE CAST(SubmittedDate AS DATE) = CAST(GETDATE() AS DATE)", con);
                int todayMessages = (int)cmd.ExecuteScalar();
                lblTodayMessages.Text = todayMessages.ToString();

                // Newsletter subscribers
                cmd = new SqlCommand("SELECT COUNT(DISTINCT Email) FROM ContactMessages WHERE NewsletterSubscription = 1", con);
                int newsletterSubscribers = (int)cmd.ExecuteScalar();
                lblNewsletterSubscribers.Text = newsletterSubscribers.ToString();

                con.Close();
            }
            catch (Exception ex)
            {
                if (con?.State == ConnectionState.Open)
                    con.Close();

                // Handle error gracefully - set default values if ContactMessages table doesn't exist
                lblTotalMessages.Text = "0";
                lblPendingMessages.Text = "0";
                lblTodayMessages.Text = "0";
                lblNewsletterSubscribers.Text = "0";
                
                // Log error
                System.Diagnostics.Debug.WriteLine("Error loading statistics: " + ex.Message);
            }
        }

        private void LoadMessages()
        {
            try
            {
                getcon();

                string whereClause = "WHERE 1=1";
                
                // Apply filters
                if (!string.IsNullOrEmpty(ddlStatusFilter.SelectedValue))
                {
                    whereClause += " AND Status = @Status";
                }

                if (!string.IsNullOrEmpty(ddlSubjectFilter.SelectedValue))
                {
                    if (ddlSubjectFilter.SelectedValue == "Other")
                    {
                        whereClause += " AND Subject LIKE 'Other:%'";
                    }
                    else
                    {
                        whereClause += " AND Subject = @Subject";
                    }
                }

                if (!string.IsNullOrEmpty(ddlDateFilter.SelectedValue))
                {
                    int days = Convert.ToInt32(ddlDateFilter.SelectedValue);
                    whereClause += " AND SubmittedDate >= DATEADD(DAY, -@Days, GETDATE())";
                }

                if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
                {
                    whereClause += " AND (FullName LIKE @Search OR Email LIKE @Search)";
                }

                string query = $@"SELECT MessageID, FullName, Email, Phone, Subject, Message, 
                                SubmittedDate, Status, IsRead, NewsletterSubscription, 
                                AdminResponse, ResponseDate
                                FROM ContactMessages 
                                {whereClause} 
                                ORDER BY IsRead ASC, SubmittedDate DESC";

                cmd = new SqlCommand(query, con);

                // Add parameters
                if (!string.IsNullOrEmpty(ddlStatusFilter.SelectedValue))
                {
                    cmd.Parameters.AddWithValue("@Status", ddlStatusFilter.SelectedValue);
                }

                if (!string.IsNullOrEmpty(ddlSubjectFilter.SelectedValue) && ddlSubjectFilter.SelectedValue != "Other")
                {
                    cmd.Parameters.AddWithValue("@Subject", ddlSubjectFilter.SelectedValue);
                }

                if (!string.IsNullOrEmpty(ddlDateFilter.SelectedValue))
                {
                    cmd.Parameters.AddWithValue("@Days", Convert.ToInt32(ddlDateFilter.SelectedValue));
                }

                if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
                {
                    cmd.Parameters.AddWithValue("@Search", "%" + txtSearch.Text.Trim() + "%");
                }

                da = new SqlDataAdapter(cmd);
                ds = new DataSet();
                da.Fill(ds);

                gvMessages.DataSource = ds.Tables[0];
                gvMessages.DataBind();

                // Update result count
                lblResultCount.Text = $"Showing {ds.Tables[0].Rows.Count} message(s)";

                con.Close();
            }
            catch (Exception ex)
            {
                if (con?.State == ConnectionState.Open)
                    con.Close();
                
                // Show error message
                ScriptManager.RegisterStartupScript(this, GetType(), "error", 
                    $"alert('Error loading messages: {ex.Message}');", true);
            }
        }

        protected void FilterMessages(object sender, EventArgs e)
        {
            LoadMessages();
        }

        protected void ClearFilters(object sender, EventArgs e)
        {
            ddlStatusFilter.SelectedIndex = 0;
            ddlSubjectFilter.SelectedIndex = 0;
            ddlDateFilter.SelectedIndex = 0;
            txtSearch.Text = "";
            LoadMessages();
        }

        protected void gvMessages_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int messageId = Convert.ToInt32(e.CommandArgument);
            currentMessageId = messageId;

            switch (e.CommandName)
            {
                case "ViewMessage":
                    ViewMessage(messageId);
                    break;
                case "RespondMessage":
                    ViewMessage(messageId);
                    break;
                case "MarkRead":
                    MarkAsRead(messageId);
                    break;
            }
        }

        private void ViewMessage(int messageId)
        {
            try
            {
                getcon();

                string query = @"SELECT MessageID, FullName, Email, Phone, Subject, Message, 
                               SubmittedDate, Status, IsRead, NewsletterSubscription, 
                               AdminResponse, ResponseDate
                               FROM ContactMessages 
                               WHERE MessageID = @MessageID";

                cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@MessageID", messageId);

                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    lblModalName.Text = reader["FullName"].ToString();
                    lblModalEmail.Text = reader["Email"].ToString();
                    lblModalPhone.Text = reader["Phone"].ToString() ?? "Not provided";
                    lblModalDate.Text = Convert.ToDateTime(reader["SubmittedDate"]).ToString("MMMM dd, yyyy - HH:mm");
                    lblModalSubject.Text = reader["Subject"].ToString();
                    lblModalMessage.Text = reader["Message"].ToString().Replace("\n", "<br/>");
                    ddlModalStatus.SelectedValue = reader["Status"].ToString();
                    lblModalNewsletter.Text = Convert.ToBoolean(reader["NewsletterSubscription"]) ? "Subscribed" : "Not Subscribed";
                    txtAdminResponse.Text = reader["AdminResponse"]?.ToString() ?? "";

                    pnlMessageDetails.Visible = true;

                    // Mark as read if not already
                    if (!Convert.ToBoolean(reader["IsRead"]))
                    {
                        reader.Close();
                        MarkAsRead(messageId, false); // Don't reload grid
                    }
                    else
                    {
                        reader.Close();
                    }

                    con.Close();

                    // Show modal
                    ScriptManager.RegisterStartupScript(this, GetType(), "showModal", 
                        "$('#messageModal').modal('show');", true);
                }
                else
                {
                    reader.Close();
                    con.Close();
                    ScriptManager.RegisterStartupScript(this, GetType(), "error", 
                        "alert('Message not found.');", true);
                }
            }
            catch (Exception ex)
            {
                if (con?.State == ConnectionState.Open)
                    con.Close();
                
                ScriptManager.RegisterStartupScript(this, GetType(), "error", 
                    $"alert('Error loading message: {ex.Message}');", true);
            }
        }

        private void MarkAsRead(int messageId, bool reloadGrid = true)
        {
            try
            {
                getcon();

                string query = "UPDATE ContactMessages SET IsRead = 1 WHERE MessageID = @MessageID";
                cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@MessageID", messageId);
                
                cmd.ExecuteNonQuery();
                con.Close();

                if (reloadGrid)
                {
                    LoadMessages();
                    LoadStatistics();
                }
            }
            catch (Exception ex)
            {
                if (con?.State == ConnectionState.Open)
                    con.Close();
                
                ScriptManager.RegisterStartupScript(this, GetType(), "error", 
                    $"alert('Error marking message as read: {ex.Message}');", true);
            }
        }

        protected void MarkAllAsRead(object sender, EventArgs e)
        {
            try
            {
                getcon();

                string query = "UPDATE ContactMessages SET IsRead = 1 WHERE IsRead = 0";
                cmd = new SqlCommand(query, con);
                
                int affectedRows = cmd.ExecuteNonQuery();
                con.Close();

                LoadMessages();
                LoadStatistics();

                ScriptManager.RegisterStartupScript(this, GetType(), "success", 
                    $"alert('Marked {affectedRows} message(s) as read.');", true);
            }
            catch (Exception ex)
            {
                if (con?.State == ConnectionState.Open)
                    con.Close();
                
                ScriptManager.RegisterStartupScript(this, GetType(), "error", 
                    $"alert('Error marking messages as read: {ex.Message}');", true);
            }
        }

        protected void UpdateMessage(object sender, EventArgs e)
        {
            try
            {
                if (currentMessageId == 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "error", 
                        "alert('No message selected.');", true);
                    return;
                }

                getcon();

                string query = @"UPDATE ContactMessages 
                               SET Status = @Status, 
                                   AdminResponse = @AdminResponse, 
                                   ResponseDate = @ResponseDate,
                                   IsRead = 1
                               WHERE MessageID = @MessageID";

                cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Status", ddlModalStatus.SelectedValue);
                cmd.Parameters.AddWithValue("@AdminResponse", txtAdminResponse.Text.Trim());
                cmd.Parameters.AddWithValue("@ResponseDate", DateTime.Now);
                cmd.Parameters.AddWithValue("@MessageID", currentMessageId);

                cmd.ExecuteNonQuery();
                con.Close();

                // TODO: Send email response to user
                // SendEmailResponse(currentMessageId, txtAdminResponse.Text.Trim());

                LoadMessages();
                LoadStatistics();

                ScriptManager.RegisterStartupScript(this, GetType(), "success", 
                    "alert('Message updated successfully!'); $('#messageModal').modal('hide');", true);

                // Reset
                currentMessageId = 0;
                pnlMessageDetails.Visible = false;
            }
            catch (Exception ex)
            {
                if (con?.State == ConnectionState.Open)
                    con.Close();
                
                ScriptManager.RegisterStartupScript(this, GetType(), "error", 
                    $"alert('Error updating message: {ex.Message}');", true);
            }
        }

        protected void ExportToCSV(object sender, EventArgs e)
        {
            try
            {
                getcon();

                string query = @"SELECT FullName, Email, Phone, Subject, Message, 
                               SubmittedDate, Status, 
                               CASE WHEN NewsletterSubscription = 1 THEN 'Yes' ELSE 'No' END as Newsletter,
                               AdminResponse, ResponseDate
                               FROM ContactMessages 
                               ORDER BY SubmittedDate DESC";

                cmd = new SqlCommand(query, con);
                da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                con.Close();

                if (dt.Rows.Count > 0)
                {
                    StringBuilder csvContent = new StringBuilder();
                    
                    // Add headers
                    csvContent.AppendLine("Full Name,Email,Phone,Subject,Message,Submitted Date,Status,Newsletter,Admin Response,Response Date");
                    
                    // Add data rows
                    foreach (DataRow row in dt.Rows)
                    {
                        csvContent.AppendLine(
                            $"\"{row["FullName"]}\",\"{row["Email"]}\",\"{row["Phone"]}\",\"{row["Subject"]}\",\"{row["Message"]?.ToString().Replace("\"", "\"\"")}\",\"{row["SubmittedDate"]}\",\"{row["Status"]}\",\"{row["Newsletter"]}\",\"{row["AdminResponse"]?.ToString().Replace("\"", "\"\"")}\",\"{row["ResponseDate"]}\""
                        );
                    }

                    // Set response headers for CSV download
                    Response.Clear();
                    Response.ContentType = "text/csv";
                    Response.AddHeader("Content-Disposition", $"attachment; filename=ContactMessages_{DateTime.Now:yyyyMMdd}.csv");
                    Response.Write(csvContent.ToString());
                    Response.End();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "info", 
                        "alert('No data to export.');", true);
                }
            }
            catch (Exception ex)
            {
                if (con?.State == ConnectionState.Open)
                    con.Close();
                
                ScriptManager.RegisterStartupScript(this, GetType(), "error", 
                    $"alert('Error exporting data: {ex.Message}');", true);
            }
        }

        protected void gvMessages_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvMessages.PageIndex = e.NewPageIndex;
            LoadMessages();
        }

        protected string GetStatusBadgeClass(string status)
        {
            switch (status?.ToLower())
            {
                case "pending":
                    return "badge-warning";
                case "in progress":
                    return "badge-info";
                case "responded":
                    return "badge-success";
                case "closed":
                    return "badge-secondary";
                default:
                    return "badge-light";
            }
        }

        // TODO: Implement email response functionality
        private void SendEmailResponse(int messageId, string response)
        {
            // Implementation would go here to send email response to user
            // This would require SMTP configuration in web.config
        }
    }
}