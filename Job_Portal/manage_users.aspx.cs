using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using System.Linq;

namespace Job_Portal
{
    public partial class manage_users : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["JobPortalConnection"].ConnectionString;
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;

        void getcon()
        {
            con = new SqlConnection(cs);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if user is logged in as admin
                if (Session["UserId"] == null || Session["Role"] == null || Session["Role"].ToString() != "Admin")
                {
                    Response.Redirect("login.aspx");
                }
                else
                {
                    LoadPageData();
                    LoadUserGrid();
                }
            }
        }

        private void LoadPageData()
        {
            lblCurrentDate.Text = DateTime.Now.ToString("MMMM dd, yyyy");
            LoadUserStatistics();
            SetStaticData();
        }

        private void LoadUserStatistics()
        {
            try
            {
                getcon();

                // Total Users from Users table
                cmd = new SqlCommand("SELECT COUNT(*) FROM Users", con);
                int totalUsers = Convert.ToInt32(cmd.ExecuteScalar());
                lblTotalUsers.Text = totalUsers.ToString();

                // Active Users (assuming all users are active for now)
                lblActiveUsers.Text = (totalUsers - 2).ToString(); // Mock data

                // Pending Users (mock data)
                lblPendingUsers.Text = "3";

                // Inactive Users (mock data)
                lblInactiveUsers.Text = "2";

                // Set total count for grid
                lblTotalCount.Text = totalUsers.ToString();

                con.Close();
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading statistics: " + ex.Message, "danger");
            }
        }

        private void SetStaticData()
        {
            // Set some sample analytics data
            lblMonthlyRegistrations.Text = "42";
            lblWeeklyRegistrations.Text = "12";
            lblActiveToday.Text = "156";
        }

        private void LoadUserGrid()
        {
            try
            {
                getcon();
                
                string query = @"SELECT u.UserID, u.FullName, u.Email, u.Role, 
                               CASE WHEN u.UserID % 4 = 0 THEN 'Inactive' 
                                    WHEN u.UserID % 3 = 0 THEN 'Pending' 
                                    ELSE 'Active' END as Status,
                               GETDATE() as CreatedDate
                               FROM Users u";

                // Apply search filter if provided
                if (!string.IsNullOrEmpty(txtSearch.Text))
                {
                    query += " WHERE u.FullName LIKE @Search OR u.Email LIKE @Search";
                }

                // Apply role filter
                if (!string.IsNullOrEmpty(ddlUserRole.SelectedValue))
                {
                    if (query.Contains("WHERE"))
                        query += " AND u.Role = @Role";
                    else
                        query += " WHERE u.Role = @Role";
                }

                query += " ORDER BY u.UserID DESC";

                cmd = new SqlCommand(query, con);
                
                if (!string.IsNullOrEmpty(txtSearch.Text))
                {
                    cmd.Parameters.AddWithValue("@Search", "%" + txtSearch.Text + "%");
                }
                if (!string.IsNullOrEmpty(ddlUserRole.SelectedValue))
                {
                    cmd.Parameters.AddWithValue("@Role", ddlUserRole.SelectedValue);
                }

                da = new SqlDataAdapter(cmd);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    gvUsers.DataSource = ds.Tables[0];
                    gvUsers.DataBind();
                }
                else
                {
                    // Create empty table with proper structure for display
                    DataTable emptyTable = CreateEmptyUserTable();
                    gvUsers.DataSource = emptyTable;
                    gvUsers.DataBind();
                }

                con.Close();
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading user data: " + ex.Message, "danger");
            }
        }

        private DataTable CreateEmptyUserTable()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("UserID", typeof(int));
            dt.Columns.Add("FullName", typeof(string));
            dt.Columns.Add("Email", typeof(string));
            dt.Columns.Add("Role", typeof(string));
            dt.Columns.Add("Status", typeof(string));
            dt.Columns.Add("CreatedDate", typeof(DateTime));
            return dt;
        }

        // Helper methods for GridView display
        protected string GetUserInitials(string fullName)
        {
            if (string.IsNullOrEmpty(fullName)) return "??";
            
            string[] names = fullName.Split(' ');
            if (names.Length >= 2)
                return (names[0].Substring(0, 1) + names[1].Substring(0, 1)).ToUpper();
            else
                return fullName.Substring(0, Math.Min(2, fullName.Length)).ToUpper();
        }

        protected string GetStatusClass(string status)
        {
            if (string.IsNullOrEmpty(status)) return "active";
            return status.ToLower();
        }

        protected string GetFormattedDate(object date)
        {
            if (date == null || date == DBNull.Value) return "N/A";
            DateTime dt = Convert.ToDateTime(date);
            return dt.ToString("MMM dd, yyyy");
        }

        protected string GetRandomLastLogin()
        {
            // Generate mock last login data for display
            Random rand = new Random();
            int daysAgo = rand.Next(0, 30);
            DateTime lastLogin = DateTime.Now.AddDays(-daysAgo);
            
            if (daysAgo == 0)
                return "Today";
            else if (daysAgo == 1)
                return "Yesterday";
            else
                return lastLogin.ToString("MMM dd");
        }

        // Event Handlers
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadUserGrid();
        }

        protected void btnAddUser_Click(object sender, EventArgs e)
        {
            ShowMessage("Add User functionality will be implemented here.", "info");
        }

        protected void btnBulkActions_Click(object sender, EventArgs e)
        {
            ShowMessage("Bulk Actions panel will be implemented here.", "info");
        }

        protected void btnExportUsers_Click(object sender, EventArgs e)
        {
            ShowMessage("User data export functionality will be implemented here.", "info");
        }

        protected void btnUserReports_Click(object sender, EventArgs e)
        {
            ShowMessage("User reports generation will be implemented here.", "info");
        }

        protected void btnSendNotification_Click(object sender, EventArgs e)
        {
            ShowMessage("Notification system will be implemented here.", "info");
        }

        protected void btnSystemMaintenance_Click(object sender, EventArgs e)
        {
            ShowMessage("System maintenance mode will be implemented here.", "warning");
        }

        protected void btnActivateSelected_Click(object sender, EventArgs e)
        {
            ProcessBulkAction("activate");
        }

        protected void btnDeactivateSelected_Click(object sender, EventArgs e)
        {
            ProcessBulkAction("deactivate");
        }

        protected void btnDeleteSelected_Click(object sender, EventArgs e)
        {
            ProcessBulkAction("delete");
        }

        protected void btnSendWelcomeEmail_Click(object sender, EventArgs e)
        {
            ShowMessage("Welcome emails will be sent to new users.", "success");
        }

        protected void btnSendNewsletter_Click(object sender, EventArgs e)
        {
            ShowMessage("Newsletter will be sent to all active users.", "success");
        }

        protected void btnSendAlert_Click(object sender, EventArgs e)
        {
            ShowMessage("System alert will be sent to all users.", "warning");
        }

        protected void btnCleanupInactive_Click(object sender, EventArgs e)
        {
            ShowMessage("Inactive user cleanup process will be initiated.", "info");
        }

        protected void btnGenerateReport_Click(object sender, EventArgs e)
        {
            ShowMessage("Comprehensive user report will be generated.", "info");
        }

        protected void btnBackupUserData_Click(object sender, EventArgs e)
        {
            ShowMessage("User data backup process will be initiated.", "success");
        }

        private void ProcessBulkAction(string action)
        {
            List<int> selectedUsers = GetSelectedUsers();
            
            if (selectedUsers.Count == 0)
            {
                ShowMessage("Please select users to perform bulk action.", "warning");
                return;
            }

            string message = $"{selectedUsers.Count} users will be {action}d. This functionality will be implemented.";
            ShowMessage(message, "info");
        }

        private List<int> GetSelectedUsers()
        {
            List<int> selectedUsers = new List<int>();
            
            foreach (GridViewRow row in gvUsers.Rows)
            {
                CheckBox chk = (CheckBox)row.FindControl("chkSelect");
                if (chk != null && chk.Checked)
                {
                    // Get user ID from the row data
                    int userId = Convert.ToInt32(gvUsers.DataKeys[row.RowIndex].Value);
                    selectedUsers.Add(userId);
                }
            }
            
            return selectedUsers;
        }

        protected void gvUsers_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvUsers.PageIndex = e.NewPageIndex;
            LoadUserGrid();
        }

        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int userId = Convert.ToInt32(e.CommandArgument);
            
            switch (e.CommandName)
            {
                case "ViewUser":
                    Response.Redirect($"view_user.aspx?id={userId}");
                    break;
                case "EditUser":
                    Response.Redirect($"edit_user.aspx?id={userId}");
                    break;
                case "DeleteUser":
                    DeleteUser(userId);
                    break;
            }
        }

        private void DeleteUser(int userId)
        {
            try
            {
                getcon();
                cmd = new SqlCommand("DELETE FROM Users WHERE UserID = @UserID", con);
                cmd.Parameters.AddWithValue("@UserID", userId);
                int result = cmd.ExecuteNonQuery();
                con.Close();

                if (result > 0)
                {
                    ShowMessage("User deleted successfully.", "success");
                    LoadUserGrid();
                    LoadUserStatistics();
                }
                else
                {
                    ShowMessage("Error deleting user.", "danger");
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error: " + ex.Message, "danger");
            }
        }

        private void ShowMessage(string message, string type)
        {
            lblMessage.Text = message;
            pnlMessages.Visible = true;
            
            string alertClass = "alert-info"; // default
            switch (type.ToLower())
            {
                case "success":
                    alertClass = "alert-success";
                    break;
                case "warning":
                    alertClass = "alert-warning";
                    break;
                case "danger":
                    alertClass = "alert-danger";
                    break;
                case "info":
                    alertClass = "alert-info";
                    break;
            }
            
            alertMessage.Attributes["class"] = $"alert {alertClass} alert-dismissible fade show";
        }

        // Auto-hide messages after page load
        protected override void OnLoadComplete(EventArgs e)
        {
            base.OnLoadComplete(e);
            
            if (pnlMessages.Visible)
            {
                string script = @"
                    <script type='text/javascript'>
                        setTimeout(function() {
                            var alertElement = document.getElementById('" + alertMessage.ClientID + @"');
                            if (alertElement) {
                                alertElement.style.display = 'none';
                            }
                        }, 5000);
                    </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "HideAlert", script);
            }
        }
    }
}