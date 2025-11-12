using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Job_Portal
{
    public partial class manage_users : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["JobPortalConnection"].ConnectionString;
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;
        ReportDocument cr = new ReportDocument();


        void getcon()
        {
            con = new SqlConnection(cs);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
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
            getcon();

            cmd = new SqlCommand("SELECT COUNT(*) FROM Users", con);
            int totalUsers = Convert.ToInt32(cmd.ExecuteScalar());
            lblTotalUsers.Text = totalUsers.ToString();

            lblActiveUsers.Text = (totalUsers - 2).ToString(); 

            lblPendingUsers.Text = "3";

            lblInactiveUsers.Text = "2";

            lblTotalCount.Text = totalUsers.ToString();

            con.Close();
        }

        private void SetStaticData()
        {
            lblMonthlyRegistrations.Text = "42";
            lblWeeklyRegistrations.Text = "12";
            lblActiveToday.Text = "156";
        }

        private void LoadUserGrid()
        {
            getcon();
            
            string query = @"SELECT UserID, FullName, Email,Role FROM Users";

            if (!string.IsNullOrEmpty(txtSearch.Text))
            {
                query += " WHERE FullName LIKE @Search OR Email LIKE @Search";
            }

            if (!string.IsNullOrEmpty(ddlUserRole.SelectedValue))
            {
                if (query.Contains("WHERE"))
                    query += " AND Role = @Role";
                else
                    query += " WHERE Role = @Role";
            }

            query += " ORDER BY UserID DESC";

            cmd = new SqlCommand(query, con);
            
            

            da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds);

            con.Close();
        }

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

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadUserGrid();
        }

        protected void btnAddUser_Click(object sender, EventArgs e)
        {
            Response.Redirect("add_user.aspx");
        }

        protected void btnExportUsers_Click(object sender, EventArgs e)
        {
            getcon();
            DataSet ds = new DataSet();

            SqlDataAdapter daApp = new SqlDataAdapter(
               "SELECT * FROM Users ", con);
           
            daApp.Fill(ds);

            ds.WriteXmlSchema(Server.MapPath("~/UserReport.xml"));

            string rptPath = Server.MapPath("~/UserReport.rpt");
            cr.Load(rptPath);
            cr.SetDataSource(ds);
            cr.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, "User-Report");

            cr.Close();
            cr.Dispose();
            con.Close();
        }

        private List<int> GetSelectedUsers()
        {
            List<int> selectedUsers = new List<int>();
            
            foreach (GridViewRow row in gvUsers.Rows)
            {
                CheckBox chk = (CheckBox)row.FindControl("chkSelect");
                if (chk != null && chk.Checked)
                {
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

        private void ShowMessage(string message, string type)
        {
            lblMessage.Text = message;
            pnlMessages.Visible = true;
            
            string alertClass = "alert-info";
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

        protected void btnBulkActions_Click(object sender, EventArgs e)
        {
        }

        protected void btnUserReports_Click(object sender, EventArgs e)
        {
        }

        protected void btnSendNotification_Click(object sender, EventArgs e)
        {
        }

        protected void btnSystemMaintenance_Click(object sender, EventArgs e)
        {
        }

        protected void btnActivateSelected_Click(object sender, EventArgs e)
        {
        }

        protected void btnDeactivateSelected_Click(object sender, EventArgs e)
        {
        }

        protected void btnDeleteSelected_Click(object sender, EventArgs e)
        {
        }

        protected void btnSendWelcomeEmail_Click(object sender, EventArgs e)
        {
        }

        protected void btnSendNewsletter_Click(object sender, EventArgs e)
        {
        }

        protected void btnSendAlert_Click(object sender, EventArgs e)
        {
        }

        protected void btnCleanupInactive_Click(object sender, EventArgs e)
        {
        }

        protected void btnGenerateReport_Click(object sender, EventArgs e)
        {
        }

        protected void btnBackupUserData_Click(object sender, EventArgs e)
        {
        }
    }
}