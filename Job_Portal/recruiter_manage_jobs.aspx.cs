using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Net.Mime.MediaTypeNames;

namespace Job_Portal
{
    public partial class recruiter_manage_jobs : System.Web.UI.Page
    {
        String s = ConfigurationManager.ConnectionStrings["JobPortalConnection"].ConnectionString;
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        string fnm;
        DataSet ds;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] != null)
            {
                fillgrid();
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }
        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void fillgrid()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            int recruiterId = GetRecruiterId(userId);
            getcon();
            da = new SqlDataAdapter("select * from Jobs where RecruiterID=@RecruiterID ", con);
            da.SelectCommand.Parameters.AddWithValue("@RecruiterID", recruiterId);

            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }
        int GetRecruiterId(int userId)
        {
            getcon();
            string query = "SELECT RecruiterID FROM Recruiters WHERE UserID = @UserID";
            cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@UserID", userId);

            object result = cmd.ExecuteScalar();
            return result != null ? Convert.ToInt32(result) : 0;
        }
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_edt")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                Response.Redirect("recruiter_post_job.aspx?JobID=" + id);
            }
            else
            {
                getcon();
                int id = Convert.ToInt32(e.CommandArgument);
                ViewState["Id"] = id;
                cmd = new SqlCommand("delete from Jobs where JobID='" + ViewState["Id"] + "'", con);
                cmd.ExecuteNonQuery();
                fillgrid();
            }
        }
    }
}