using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Job_Portal
{
    public partial class jobseeker_profile : System.Web.UI.Page
    {
        String s = ConfigurationManager.ConnectionStrings["JobPortalConnection"].ConnectionString;
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataTable dt;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if user is logged in and is a job seeker
                if (Session["UserId"] == null || Session["Role"] == null || Session["Role"].ToString() != "JobSeeker")
                {
                    Response.Redirect("login.aspx");
                    return;
                }

                // Ensure the JobSeekers table exists
                EnsureJobSeekersTableExists();

                LoadUserProfile();
                LoadUserStatistics();
                UpdateProfileCompletion();
            }
        }

        private void LoadUserProfile()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            
            getcon();

            // First check if JobSeeker profile exists, if not create it
            string checkQuery = "SELECT COUNT(*) FROM JobSeekers WHERE UserID = @UserID";
            cmd = new SqlCommand(checkQuery, con);
            cmd.Parameters.AddWithValue("@UserID", userId);
            int profileExists = (int)cmd.ExecuteScalar();

            if (profileExists == 0)
            {
                // Create basic JobSeeker profile
                string insertQuery = @"INSERT INTO JobSeekers (UserID, CreatedDate) VALUES (@UserID, @CreatedDate)";
                cmd = new SqlCommand(insertQuery, con);
                cmd.Parameters.AddWithValue("@UserID", userId);
                cmd.Parameters.AddWithValue("@CreatedDate", DateTime.Now);
                cmd.ExecuteNonQuery();
            }

            // Load user and job seeker data
            string query = @"SELECT u.UserID, u.FullName, u.Email, u.CreatedDate,
                            js.Phone, js.ProfessionalTitle, js.Location, js.LinkedInProfile, 
                            js.Website, js.Summary, js.Skills, js.ExperienceLevel, 
                            js.EducationLevel, js.SalaryExpectation, js.JobTypePreference
                            FROM Users u 
                            LEFT JOIN JobSeekers js ON u.UserID = js.UserID 
                            WHERE u.UserID = @UserID";

            cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@UserID", userId);
            
            SqlDataReader reader = cmd.ExecuteReader();
            
            if (reader.Read())
            {
                // Display information
                lblDisplayName.Text = reader["FullName"].ToString();
                lblDisplayEmail.Text = reader["Email"].ToString();
                lblDisplayTitle.Text = reader["ProfessionalTitle"] != DBNull.Value ? reader["ProfessionalTitle"].ToString() : "Job Seeker";
                
                // Generate initials
                string fullName = reader["FullName"].ToString();
                string initials = GetInitials(fullName);
                lblInitials.Text = initials;

                // Member since
                if (reader["CreatedDate"] != DBNull.Value)
                {
                    DateTime createdDate = Convert.ToDateTime(reader["CreatedDate"]);
                    lblMemberSince.Text = createdDate.ToString("MMM yyyy");
                }

                // Fill form fields
                txtFullName.Text = reader["FullName"].ToString();
                txtEmail.Text = reader["Email"].ToString();
                
                if (reader["Phone"] != DBNull.Value)
                    txtPhone.Text = reader["Phone"].ToString();
                
                if (reader["ProfessionalTitle"] != DBNull.Value)
                    txtProfessionalTitle.Text = reader["ProfessionalTitle"].ToString();
                
                if (reader["Location"] != DBNull.Value)
                    txtLocation.Text = reader["Location"].ToString();
                
                if (reader["LinkedInProfile"] != DBNull.Value)
                    txtLinkedIn.Text = reader["LinkedInProfile"].ToString();
                
                if (reader["Website"] != DBNull.Value)
                    txtWebsite.Text = reader["Website"].ToString();
                
                if (reader["Summary"] != DBNull.Value)
                    txtSummary.Text = reader["Summary"].ToString();
                
                if (reader["Skills"] != DBNull.Value)
                    txtSkills.Text = reader["Skills"].ToString();
                
                if (reader["ExperienceLevel"] != DBNull.Value)
                    ddlExperience.SelectedValue = reader["ExperienceLevel"].ToString();
                
                if (reader["EducationLevel"] != DBNull.Value)
                    ddlEducation.SelectedValue = reader["EducationLevel"].ToString();
                
                if (reader["SalaryExpectation"] != DBNull.Value)
                    ddlSalaryRange.SelectedValue = reader["SalaryExpectation"].ToString();

                // Handle job type preferences (if stored as comma-separated values)
                if (reader["JobTypePreference"] != DBNull.Value)
                {
                    string jobTypes = reader["JobTypePreference"].ToString();
                    string[] types = jobTypes.Split(',');
                    
                    foreach (ListItem item in cblJobTypes.Items)
                    {
                        item.Selected = types.Contains(item.Value);
                    }
                }
            }
            
            reader.Close();
            con.Close();
        }

        private void LoadUserStatistics()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            
            getcon();

            // Get application count
            cmd = new SqlCommand("SELECT COUNT(*) FROM JobApplications WHERE JobSeekerID = @UserID", con);
            cmd.Parameters.AddWithValue("@UserID", userId);
            int applicationCount = (int)cmd.ExecuteScalar();
            
            lblTotalApplications.Text = applicationCount.ToString();
            lblStatsApplications.Text = applicationCount.ToString();

            // Get shortlisted count (assuming Status = 'Shortlisted')
            cmd = new SqlCommand("SELECT COUNT(*) FROM JobApplications WHERE JobSeekerID = @UserID AND Status = 'Shortlisted'", con);
            cmd.Parameters.AddWithValue("@UserID", userId);
            int shortlistedCount = (int)cmd.ExecuteScalar();
            lblStatsShortlisted.Text = shortlistedCount.ToString();

            // Set some sample data for profile views and saved jobs (you can implement actual tracking later)
            Random rand = new Random();
            int views = rand.Next(0, 50);
            lblProfileViews.Text = views.ToString();
            lblStatsViews.Text = views.ToString();
            
            // For saved jobs, you'd need to implement a SavedJobs table
            lblStatsSaved.Text = "0";

            con.Close();
        }

        private void UpdateProfileCompletion()
        {
            int completionScore = 25; // Base score for having an account
            
            if (!string.IsNullOrEmpty(txtProfessionalTitle.Text)) completionScore += 15;
            if (!string.IsNullOrEmpty(txtPhone.Text)) completionScore += 10;
            if (!string.IsNullOrEmpty(txtLocation.Text)) completionScore += 10;
            if (!string.IsNullOrEmpty(txtSummary.Text)) completionScore += 15;
            if (!string.IsNullOrEmpty(txtSkills.Text)) 
            {
                completionScore += 15;
                chkSkills.Checked = true;
            }
            if (ddlExperience.SelectedIndex > 0) 
            {
                completionScore += 10;
                chkExperience.Checked = true;
            }
            if (ddlEducation.SelectedIndex > 0) 
            {
                completionScore += 10;
                chkEducation.Checked = true;
            }

            lblProfileCompletion.Text = completionScore + "%";
            
            // Update progress bar width via JavaScript
            string script = $"document.querySelector('.progress-bar').style.width = '{completionScore}%';";
            ClientScript.RegisterStartupScript(this.GetType(), "updateProgress", script, true);
        }

        protected void btnUpdateProfile_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                int userId = Convert.ToInt32(Session["UserId"]);
                
                try
                {
                    getcon();

                    // Update Users table
                    string updateUserQuery = "UPDATE Users SET FullName = @FullName WHERE UserID = @UserID";
                    cmd = new SqlCommand(updateUserQuery, con);
                    cmd.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    cmd.ExecuteNonQuery();

                    // Update JobSeekers table
                    string updateJobSeekerQuery = @"UPDATE JobSeekers SET 
                                                   Phone = @Phone,
                                                   ProfessionalTitle = @ProfessionalTitle,
                                                   Location = @Location,
                                                   LinkedInProfile = @LinkedInProfile,
                                                   Website = @Website,
                                                   Summary = @Summary,
                                                   UpdatedDate = @UpdatedDate
                                                   WHERE UserID = @UserID";

                    cmd = new SqlCommand(updateJobSeekerQuery, con);
                    cmd.Parameters.AddWithValue("@Phone", string.IsNullOrEmpty(txtPhone.Text.Trim()) ? (object)DBNull.Value : txtPhone.Text.Trim());
                    cmd.Parameters.AddWithValue("@ProfessionalTitle", string.IsNullOrEmpty(txtProfessionalTitle.Text.Trim()) ? (object)DBNull.Value : txtProfessionalTitle.Text.Trim());
                    cmd.Parameters.AddWithValue("@Location", string.IsNullOrEmpty(txtLocation.Text.Trim()) ? (object)DBNull.Value : txtLocation.Text.Trim());
                    cmd.Parameters.AddWithValue("@LinkedInProfile", string.IsNullOrEmpty(txtLinkedIn.Text.Trim()) ? (object)DBNull.Value : txtLinkedIn.Text.Trim());
                    cmd.Parameters.AddWithValue("@Website", string.IsNullOrEmpty(txtWebsite.Text.Trim()) ? (object)DBNull.Value : txtWebsite.Text.Trim());
                    cmd.Parameters.AddWithValue("@Summary", string.IsNullOrEmpty(txtSummary.Text.Trim()) ? (object)DBNull.Value : txtSummary.Text.Trim());
                    cmd.Parameters.AddWithValue("@UpdatedDate", DateTime.Now);
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    
                    cmd.ExecuteNonQuery();
                    con.Close();

                    // Update session data
                    Session["FullName"] = txtFullName.Text.Trim();

                    ShowMessage("Profile updated successfully!", "success");
                    LoadUserProfile(); // Reload to show updated data
                    UpdateProfileCompletion();
                }
                catch (Exception ex)
                {
                    ShowMessage("Error updating profile: " + ex.Message, "danger");
                }
            }
        }

        protected void btnUpdateSkills_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            
            try
            {
                getcon();

                // Get selected job types
                List<string> selectedJobTypes = new List<string>();
                foreach (ListItem item in cblJobTypes.Items)
                {
                    if (item.Selected)
                        selectedJobTypes.Add(item.Value);
                }
                string jobTypesString = string.Join(",", selectedJobTypes);

                string updateQuery = @"UPDATE JobSeekers SET 
                                      Skills = @Skills,
                                      ExperienceLevel = @ExperienceLevel,
                                      EducationLevel = @EducationLevel,
                                      SalaryExpectation = @SalaryExpectation,
                                      JobTypePreference = @JobTypePreference,
                                      UpdatedDate = @UpdatedDate
                                      WHERE UserID = @UserID";

                cmd = new SqlCommand(updateQuery, con);
                cmd.Parameters.AddWithValue("@Skills", string.IsNullOrEmpty(txtSkills.Text.Trim()) ? (object)DBNull.Value : txtSkills.Text.Trim());
                cmd.Parameters.AddWithValue("@ExperienceLevel", ddlExperience.SelectedIndex > 0 ? ddlExperience.SelectedValue : (object)DBNull.Value);
                cmd.Parameters.AddWithValue("@EducationLevel", ddlEducation.SelectedIndex > 0 ? ddlEducation.SelectedValue : (object)DBNull.Value);
                cmd.Parameters.AddWithValue("@SalaryExpectation", ddlSalaryRange.SelectedIndex > 0 ? ddlSalaryRange.SelectedValue : (object)DBNull.Value);
                cmd.Parameters.AddWithValue("@JobTypePreference", string.IsNullOrEmpty(jobTypesString) ? (object)DBNull.Value : jobTypesString);
                cmd.Parameters.AddWithValue("@UpdatedDate", DateTime.Now);
                cmd.Parameters.AddWithValue("@UserID", userId);
                
                cmd.ExecuteNonQuery();
                con.Close();

                ShowMessage("Skills and experience updated successfully!", "success");
                UpdateProfileCompletion();
            }
            catch (Exception ex)
            {
                ShowMessage("Error updating skills: " + ex.Message, "danger");
            }
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtCurrentPassword.Text) || string.IsNullOrEmpty(txtNewPassword.Text))
            {
                ShowMessage("Please fill all password fields.", "warning");
                return;
            }

            int userId = Convert.ToInt32(Session["UserId"]);
            
            try
            {
                getcon();

                // Verify current password
                string verifyQuery = "SELECT Password FROM Users WHERE UserID = @UserID";
                cmd = new SqlCommand(verifyQuery, con);
                cmd.Parameters.AddWithValue("@UserID", userId);
                
                string currentHashedPassword = cmd.ExecuteScalar().ToString();
                string enteredCurrentPasswordHash = HashPassword(txtCurrentPassword.Text);

                if (currentHashedPassword != enteredCurrentPasswordHash)
                {
                    ShowMessage("Current password is incorrect.", "danger");
                    con.Close();
                    return;
                }

                // Update password
                string updateQuery = "UPDATE Users SET Password = @NewPassword WHERE UserID = @UserID";
                cmd = new SqlCommand(updateQuery, con);
                cmd.Parameters.AddWithValue("@NewPassword", HashPassword(txtNewPassword.Text));
                cmd.Parameters.AddWithValue("@UserID", userId);
                
                cmd.ExecuteNonQuery();
                con.Close();

                // Clear password fields
                txtCurrentPassword.Text = "";
                txtNewPassword.Text = "";
                txtConfirmPassword.Text = "";

                ShowMessage("Password changed successfully!", "success");
            }
            catch (Exception ex)
            {
                ShowMessage("Error changing password: " + ex.Message, "danger");
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            LoadUserProfile(); // Reload original data
            ShowMessage("Changes cancelled.", "info");
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
            if (string.IsNullOrEmpty(fullName)) return "JS";
            
            string[] names = fullName.Split(' ');
            if (names.Length >= 2)
                return (names[0].Substring(0, 1) + names[1].Substring(0, 1)).ToUpper();
            else
                return fullName.Substring(0, Math.Min(2, fullName.Length)).ToUpper();
        }

        private void ShowMessage(string message, string type)
        {
            lblMessage.Text = message;
            pnlMessage.Visible = true;
            
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
            
            pnlMessage.CssClass = $"alert {alertClass} alert-custom";
            
            // Auto-hide message after 5 seconds
            string script = @"
                setTimeout(function() {
                    var alertPanel = document.getElementById('" + pnlMessage.ClientID + @"');
                    if (alertPanel) {
                        alertPanel.style.display = 'none';
                    }
                }, 5000);";
            ClientScript.RegisterStartupScript(this.GetType(), "hideAlert", script, true);
        }

        // Helper method to check if JobSeekers table exists and create it if needed
        private void EnsureJobSeekersTableExists()
        {
            try
            {
                getcon();
                
                string checkTableQuery = @"SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES 
                                         WHERE TABLE_NAME = 'JobSeekers'";
                
                cmd = new SqlCommand(checkTableQuery, con);
                int tableExists = (int)cmd.ExecuteScalar();

                if (tableExists == 0)
                {
                    string createTableQuery = @"
                        CREATE TABLE [dbo].[JobSeekers](
                            [JobSeekerID] [int] IDENTITY(1,1) NOT NULL,
                            [UserID] [int] NOT NULL,
                            [Phone] [nvarchar](20) NULL,
                            [ProfessionalTitle] [nvarchar](100) NULL,
                            [Location] [nvarchar](200) NULL,
                            [LinkedInProfile] [nvarchar](200) NULL,
                            [Website] [nvarchar](200) NULL,
                            [Summary] [nvarchar](max) NULL,
                            [Skills] [nvarchar](max) NULL,
                            [ExperienceLevel] [nvarchar](50) NULL,
                            [EducationLevel] [nvarchar](50) NULL,
                            [SalaryExpectation] [nvarchar](50) NULL,
                            [JobTypePreference] [nvarchar](200) NULL,
                            [CreatedDate] [datetime] NOT NULL DEFAULT GETDATE(),
                            [UpdatedDate] [datetime] NULL,
                            CONSTRAINT [PK_JobSeekers] PRIMARY KEY CLUSTERED ([JobSeekerID] ASC)
                        )";

                    cmd = new SqlCommand(createTableQuery, con);
                    cmd.ExecuteNonQuery();

                    // Try to add foreign key constraint
                    try
                    {
                        string addFKQuery = @"ALTER TABLE [dbo].[JobSeekers]  
                                            ADD CONSTRAINT [FK_JobSeekers_Users] 
                                            FOREIGN KEY([UserID]) REFERENCES [dbo].[Users] ([UserID]) 
                                            ON DELETE CASCADE";
                        
                        cmd = new SqlCommand(addFKQuery, con);
                        cmd.ExecuteNonQuery();
                    }
                    catch
                    {
                        // Foreign key constraint failed, but table still created
                    }
                }

                // Check and add CreatedDate column to Users table if needed
                string checkColumnQuery = @"SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS 
                                           WHERE TABLE_NAME = 'Users' AND COLUMN_NAME = 'CreatedDate'";
                
                cmd = new SqlCommand(checkColumnQuery, con);
                int columnExists = (int)cmd.ExecuteScalar();

                if (columnExists == 0)
                {
                    string addColumnQuery = "ALTER TABLE Users ADD CreatedDate DATETIME DEFAULT GETDATE()";
                    cmd = new SqlCommand(addColumnQuery, con);
                    cmd.ExecuteNonQuery();

                    // Update existing records
                    string updateQuery = "UPDATE Users SET CreatedDate = GETDATE() WHERE CreatedDate IS NULL";
                    cmd = new SqlCommand(updateQuery, con);
                    cmd.ExecuteNonQuery();
                }

                con.Close();
            }
            catch (Exception)
            {
                if (con.State == ConnectionState.Open)
                    con.Close();
                // Table creation failed, but don't crash the application
                // The application will try to create profiles anyway and may fail gracefully
            }
        }
    }
}