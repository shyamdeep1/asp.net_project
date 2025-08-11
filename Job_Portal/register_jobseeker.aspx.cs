using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Job_Portal
{
    public partial class register_jobseeker : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadQualifications();
            }

        }
        private void LoadQualifications()
        {
            string connStr = ConfigurationManager.ConnectionStrings["JobPortalConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT QualificationID, QualificationName FROM Qualifications";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                ddlQualification.DataSource = cmd.ExecuteReader();
                ddlQualification.DataTextField = "QualificationName";
                ddlQualification.DataValueField = "QualificationID";
                ddlQualification.DataBind();

                ddlQualification.Items.Insert(0, "Select Qualification");
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (txtPassword.Text != txtConfirmPassword.Text)
            {
                lblMessage.Text = "Passwords do not match!";
                return;
            }

            string FullName = txtFullName.Text;
            string email = txtEmail.Text;
            string password = txtPassword.Text;
            string Mobile = txtPhone.Text;
            string dob = txtDOB.Text;
            string gender = ddlGender.SelectedValue;
            string address = txtAddress.Text;
            int qualificationId = Convert.ToInt32(ddlQualification.SelectedValue);
            string skills = txtSkills.Text; // comma-separated skills

            string connStr = ConfigurationManager.ConnectionStrings["JobPortalConnection"].ConnectionString;

            int jobSeekerId = 0;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                // Insert JobSeeker and get the new ID
                string insertQuery = @"
            INSERT INTO JobSeekers 
            (FullName, Email, Password, Mobile, DOB, Gender, Address, QualificationID)
            OUTPUT INSERTED.JobSeekerID
            VALUES (@FullName, @Email, @Password, @Mobile, @DOB, @Gender, @Address, @QualificationID)";

                SqlCommand cmd = new SqlCommand(insertQuery, conn);
                cmd.Parameters.AddWithValue("@FullName", FullName);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Password", password); // Hash in real apps
                cmd.Parameters.AddWithValue("@Mobile", Mobile);
                cmd.Parameters.AddWithValue("@DOB", dob);
                cmd.Parameters.AddWithValue("@Gender", gender);
                cmd.Parameters.AddWithValue("@Address", address);
                cmd.Parameters.AddWithValue("@QualificationID", qualificationId);

                conn.Open();
                jobSeekerId = Convert.ToInt32(cmd.ExecuteScalar()); // Get the new JobSeekerID

                // Insert Skills
                string[] skillArray = txtSkills.Text.Split(',');

                foreach (string skillName in skillArray)
                {
                    string trimmedSkill = skillName.Trim();
                    if (string.IsNullOrEmpty(trimmedSkill)) continue; // Skip empty entries

                    // 1️⃣ Check if the skill already exists in Skills table
                    string selectSkillQuery = "SELECT SkillID FROM Skills WHERE SkillName = @SkillName";
                    SqlCommand selectSkillCmd = new SqlCommand(selectSkillQuery, conn);
                    selectSkillCmd.Parameters.AddWithValue("@SkillName", trimmedSkill);
                    object existingSkill = selectSkillCmd.ExecuteScalar();

                    int skillId;

                    if (existingSkill == null)
                    {
                        // 2️⃣ Insert new skill and get SkillID
                        string insertSkillQuery = "INSERT INTO Skills (SkillName) OUTPUT INSERTED.SkillID VALUES (@SkillName)";
                        SqlCommand insertSkillCmd = new SqlCommand(insertSkillQuery, conn);
                        insertSkillCmd.Parameters.AddWithValue("@SkillName", trimmedSkill);
                        skillId = (int)insertSkillCmd.ExecuteScalar();
                    }
                    else
                    {
                        skillId = Convert.ToInt32(existingSkill);
                    }

                    // 3️⃣ Insert into JobSeekerSkills table
                    string insertJobSeekerSkill = "INSERT INTO JobSeekerSkills (JobSeekerID, SkillID) VALUES (@JobSeekerID, @SkillID)";
                    SqlCommand insertJSSCmd = new SqlCommand(insertJobSeekerSkill, conn);
                    insertJSSCmd.Parameters.AddWithValue("@JobSeekerID", jobSeekerId);
                    insertJSSCmd.Parameters.AddWithValue("@SkillID", skillId);
                    insertJSSCmd.ExecuteNonQuery();
                }
            }

            if (jobSeekerId > 0)
            {
                lblMessage.CssClass = "text-success";
                lblMessage.Text = "Registration successful!";
                ClearForm();
            }
            else
            {
                lblMessage.Text = "Registration failed. Please try again.";
            }
        }

        private void ClearForm()
        {
            txtFullName.Text = "";
            txtEmail.Text = "";
            txtPassword.Text = "";
            txtConfirmPassword.Text = "";
            txtPhone.Text = "";
            txtDOB.Text = "";
            ddlGender.SelectedIndex = 0;
            txtAddress.Text = "";
            ddlQualification.SelectedIndex = 0;
            txtSkills.Text = "";
        }
    }
}