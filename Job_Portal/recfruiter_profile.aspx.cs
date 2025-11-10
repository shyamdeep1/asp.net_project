using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Job_Portal
{
    public partial class recfruiter_profile : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["JobPortalConnection"].ConnectionString;
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataTable dt;

        void getcon()
        {
            con = new SqlConnection(cs);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] == null || Session["Role"] == null || Session["Role"].ToString() != "Recruiter")
                {
                    Response.Redirect("login.aspx");
                }
                else
                {
                    LoadProfileData();
                    LoadStatistics();
                    LoadRecentActivity();
                }
            }
        }

        private void LoadProfileData()
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            getcon();

            string query = @"SELECT u.UserID, u.FullName, u.Email,
                           r.RecruiterID, r.CompanyName, r.CompanyAddress
                           FROM Users u
                           INNER JOIN Recruiters r ON u.UserID = r.UserID
                           WHERE u.UserID = @UserID";

            cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@UserID", userId);

            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                txtFullName.Text = reader["FullName"].ToString();
                txtEmail.Text = reader["Email"].ToString();
                txtCompanyName.Text = reader["CompanyName"].ToString();

                lblDisplayName.Text = reader["FullName"].ToString();
                lblDisplayCompany.Text = reader["CompanyName"].ToString();
                lblDisplayEmail.Text = reader["Email"].ToString();

                string initials = GetInitials(reader["FullName"].ToString());
                lblInitials.Text = initials;

                lblMemberSince.Text = DateTime.Now.AddMonths(-6).ToString("MMM yyyy");

                if (reader["CompanyAddress"] != DBNull.Value)
                {
                    txtCompanyAddress.Text = reader["CompanyAddress"].ToString();
                }
            }

            reader.Close();
            
            if (CheckColumnExists("Recruiters", "Phone"))
            {
                cmd = new SqlCommand("SELECT Phone FROM Recruiters WHERE UserID = @UserID", con);
                cmd.Parameters.AddWithValue("@UserID", userId);
                object phoneObj = cmd.ExecuteScalar();
                if (phoneObj != null && phoneObj != DBNull.Value)
                {
                    txtPhone.Text = phoneObj.ToString();
                }
            }

            if (CheckColumnExists("Recruiters", "Website"))
            {
                cmd = new SqlCommand("SELECT Website FROM Recruiters WHERE UserID = @UserID", con);
                cmd.Parameters.AddWithValue("@UserID", userId);
                object websiteObj = cmd.ExecuteScalar();
                if (websiteObj != null && websiteObj != DBNull.Value)
                {
                    txtWebsite.Text = websiteObj.ToString();
                }
            }

            if (CheckColumnExists("Recruiters", "Description"))
            {
                cmd = new SqlCommand("SELECT Description FROM Recruiters WHERE UserID = @UserID", con);
                cmd.Parameters.AddWithValue("@UserID", userId);
                object descObj = cmd.ExecuteScalar();
                if (descObj != null && descObj != DBNull.Value)
                {
                    txtDescription.Text = descObj.ToString();
                }
            }

            if (CheckColumnExists("Recruiters", "CompanySize"))
            {
                cmd = new SqlCommand("SELECT CompanySize FROM Recruiters WHERE UserID = @UserID", con);
                cmd.Parameters.AddWithValue("@UserID", userId);
                object sizeObj = cmd.ExecuteScalar();
                if (sizeObj != null && sizeObj != DBNull.Value && !string.IsNullOrEmpty(sizeObj.ToString()))
                {
                    ddlCompanySize.SelectedValue = sizeObj.ToString();
                }
            }

            if (CheckColumnExists("Recruiters", "Industry"))
            {
                cmd = new SqlCommand("SELECT Industry FROM Recruiters WHERE UserID = @UserID", con);
                cmd.Parameters.AddWithValue("@UserID", userId);
                object industryObj = cmd.ExecuteScalar();
                if (industryObj != null && industryObj != DBNull.Value && !string.IsNullOrEmpty(industryObj.ToString()))
                {
                    ddlIndustry.SelectedValue = industryObj.ToString();
                }
            }

            con.Close();

            lblLastLogin.Text = "Today at " + DateTime.Now.ToString("hh:mm tt");
        }

        private bool CheckColumnExists(string tableName, string columnName)
        {
            string query = @"SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS 
                           WHERE TABLE_NAME = @TableName AND COLUMN_NAME = @ColumnName";
            
            SqlCommand checkCmd = new SqlCommand(query, con);
            checkCmd.Parameters.AddWithValue("@TableName", tableName);
            checkCmd.Parameters.AddWithValue("@ColumnName", columnName);
            
            int count = Convert.ToInt32(checkCmd.ExecuteScalar());
            return count > 0;
        }

        private void LoadStatistics()
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            getcon();

            cmd = new SqlCommand("SELECT RecruiterID FROM Recruiters WHERE UserID = @UserID", con);
            cmd.Parameters.AddWithValue("@UserID", userId);
            object recruiterIdObj = cmd.ExecuteScalar();

            if (recruiterIdObj != null)
            {
                int recruiterId = Convert.ToInt32(recruiterIdObj);

                cmd = new SqlCommand("SELECT COUNT(*) FROM Jobs WHERE RecruiterID = @RecruiterID", con);
                cmd.Parameters.AddWithValue("@RecruiterID", recruiterId);
                lblTotalJobs.Text = cmd.ExecuteScalar().ToString();

                cmd = new SqlCommand(@"SELECT COUNT(*) FROM JobApplications ja
                                     INNER JOIN Jobs j ON ja.JobID = j.JobID
                                     WHERE j.RecruiterID = @RecruiterID", con);
                cmd.Parameters.AddWithValue("@RecruiterID", recruiterId);
                lblTotalApplications.Text = cmd.ExecuteScalar().ToString();

                cmd = new SqlCommand("SELECT COUNT(*) FROM Jobs WHERE RecruiterID = @RecruiterID AND Status = 'Active'", con);
                cmd.Parameters.AddWithValue("@RecruiterID", recruiterId);
                lblStatsActiveJobs.Text = cmd.ExecuteScalar().ToString();

                cmd = new SqlCommand(@"SELECT COUNT(*) FROM JobApplications ja
                                     INNER JOIN Jobs j ON ja.JobID = j.JobID
                                     WHERE j.RecruiterID = @RecruiterID AND ja.Status = 'Pending'", con);
                cmd.Parameters.AddWithValue("@RecruiterID", recruiterId);
                lblStatsPendingApps.Text = cmd.ExecuteScalar().ToString();

                cmd = new SqlCommand(@"SELECT COUNT(*) FROM JobApplications ja
                                     INNER JOIN Jobs j ON ja.JobID = j.JobID
                                     WHERE j.RecruiterID = @RecruiterID AND ja.Status = 'Shortlisted'", con);
                cmd.Parameters.AddWithValue("@RecruiterID", recruiterId);
                lblStatsShortlisted.Text = cmd.ExecuteScalar().ToString();

                cmd = new SqlCommand(@"SELECT COUNT(*) FROM JobApplications ja
                                     INNER JOIN Jobs j ON ja.JobID = j.JobID
                                     WHERE j.RecruiterID = @RecruiterID AND ja.Status = 'Accepted'", con);
                cmd.Parameters.AddWithValue("@RecruiterID", recruiterId);
                lblStatsHired.Text = cmd.ExecuteScalar().ToString();
            }

            con.Close();
        }

        private void LoadRecentActivity()
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            getcon();

            cmd = new SqlCommand("SELECT RecruiterID FROM Recruiters WHERE UserID = @UserID", con);
            cmd.Parameters.AddWithValue("@UserID", userId);
            object recruiterIdObj = cmd.ExecuteScalar();

            if (recruiterIdObj != null)
            {
                int recruiterId = Convert.ToInt32(recruiterIdObj);

                string query = @"SELECT TOP 5 
                               'New Application' AS ActivityTitle,
                               'Application received for ' + j.JobTitle AS ActivityDescription,
                               ja.ApplicationDate AS ActivityDate
                               FROM JobApplications ja
                               INNER JOIN Jobs j ON ja.JobID = j.JobID
                               WHERE j.RecruiterID = @RecruiterID
                               UNION ALL
                               SELECT TOP 5
                               'Job Posted' AS ActivityTitle,
                               'Posted job: ' + JobTitle AS ActivityDescription,
                               PostedDate AS ActivityDate
                               FROM Jobs
                               WHERE RecruiterID = @RecruiterID
                               ORDER BY ActivityDate DESC";

                cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@RecruiterID", recruiterId);

                da = new SqlDataAdapter(cmd);
                dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    rptRecentActivity.DataSource = dt;
                    rptRecentActivity.DataBind();
                    pnlNoActivity.Visible = false;
                }
                else
                {
                    pnlNoActivity.Visible = true;
                }
            }

            con.Close();
        }

        protected void btnUpdateProfile_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                int userId = Convert.ToInt32(Session["UserID"]);

                getcon();

                SqlTransaction transaction = con.BeginTransaction();

                string updateUser = "UPDATE Users SET FullName = @FullName, Email = @Email WHERE UserID = @UserID";
                cmd = new SqlCommand(updateUser, con, transaction);
                cmd.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@UserID", userId);
                cmd.ExecuteNonQuery();

                string updateRecruiter = "UPDATE Recruiters SET CompanyName = @CompanyName, CompanyAddress = @CompanyAddress";
                
                if (CheckColumnExists("Recruiters", "Phone"))
                {
                    updateRecruiter += ", Phone = @Phone";
                }
                if (CheckColumnExists("Recruiters", "Website"))
                {
                    updateRecruiter += ", Website = @Website";
                }
                if (CheckColumnExists("Recruiters", "Description"))
                {
                    updateRecruiter += ", Description = @Description";
                }
                if (CheckColumnExists("Recruiters", "CompanySize"))
                {
                    updateRecruiter += ", CompanySize = @CompanySize";
                }
                if (CheckColumnExists("Recruiters", "Industry"))
                {
                    updateRecruiter += ", Industry = @Industry";
                }
                
                updateRecruiter += " WHERE UserID = @UserID";

                cmd = new SqlCommand(updateRecruiter, con, transaction);
                cmd.Parameters.AddWithValue("@CompanyName", txtCompanyName.Text.Trim());
                cmd.Parameters.AddWithValue("@CompanyAddress", string.IsNullOrEmpty(txtCompanyAddress.Text) ? (object)DBNull.Value : txtCompanyAddress.Text.Trim());
                
                if (CheckColumnExists("Recruiters", "Phone"))
                {
                    cmd.Parameters.AddWithValue("@Phone", string.IsNullOrEmpty(txtPhone.Text) ? (object)DBNull.Value : txtPhone.Text.Trim());
                }
                if (CheckColumnExists("Recruiters", "Website"))
                {
                    cmd.Parameters.AddWithValue("@Website", string.IsNullOrEmpty(txtWebsite.Text) ? (object)DBNull.Value : txtWebsite.Text.Trim());
                }
                if (CheckColumnExists("Recruiters", "Description"))
                {
                    cmd.Parameters.AddWithValue("@Description", string.IsNullOrEmpty(txtDescription.Text) ? (object)DBNull.Value : txtDescription.Text.Trim());
                }
                if (CheckColumnExists("Recruiters", "CompanySize"))
                {
                    cmd.Parameters.AddWithValue("@CompanySize", string.IsNullOrEmpty(ddlCompanySize.SelectedValue) ? (object)DBNull.Value : ddlCompanySize.SelectedValue);
                }
                if (CheckColumnExists("Recruiters", "Industry"))
                {
                    cmd.Parameters.AddWithValue("@Industry", string.IsNullOrEmpty(ddlIndustry.SelectedValue) ? (object)DBNull.Value : ddlIndustry.SelectedValue);
                }
                
                cmd.Parameters.AddWithValue("@UserID", userId);
                cmd.ExecuteNonQuery();

                transaction.Commit();
                con.Close();

                Session["FullName"] = txtFullName.Text.Trim();

                ShowMessage("Profile updated successfully!", "success");
                LoadProfileData();
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            LoadProfileData();
            ShowMessage("Changes cancelled.", "info");
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtCurrentPassword.Text) || 
                string.IsNullOrEmpty(txtNewPassword.Text) || 
                string.IsNullOrEmpty(txtConfirmPassword.Text))
            {
                ShowMessage("All password fields are required.", "danger");
                return;
            }

            if (txtNewPassword.Text != txtConfirmPassword.Text)
            {
                ShowMessage("New passwords do not match.", "danger");
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);
            string currentPasswordHash = HashPassword(txtCurrentPassword.Text.Trim());

            getcon();

            cmd = new SqlCommand("SELECT Password FROM Users WHERE UserID = @UserID", con);
            cmd.Parameters.AddWithValue("@UserID", userId);
            string storedPassword = cmd.ExecuteScalar().ToString();

            if (currentPasswordHash != storedPassword)
            {
                con.Close();
                ShowMessage("Current password is incorrect.", "danger");
                return;
            }

            string newPasswordHash = HashPassword(txtNewPassword.Text.Trim());

            cmd = new SqlCommand("UPDATE Users SET Password = @Password WHERE UserID = @UserID", con);
            cmd.Parameters.AddWithValue("@Password", newPasswordHash);
            cmd.Parameters.AddWithValue("@UserID", userId);
            cmd.ExecuteNonQuery();

            con.Close();

            txtCurrentPassword.Text = "";
            txtNewPassword.Text = "";
            txtConfirmPassword.Text = "";

            ShowMessage("Password changed successfully!", "success");
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

        private string GetInitials(string fullName)
        {
            if (string.IsNullOrEmpty(fullName))
                return "RC";

            string[] names = fullName.Trim().Split(' ');
            if (names.Length == 1)
                return names[0].Substring(0, Math.Min(2, names[0].Length)).ToUpper();

            return (names[0].Substring(0, 1) + names[names.Length - 1].Substring(0, 1)).ToUpper();
        }

        private void ShowMessage(string message, string type)
        {
            pnlMessage.Visible = true;
            lblMessage.Text = message;
            pnlMessage.CssClass = "alert alert-custom alert-" + type;
        }
    }
}