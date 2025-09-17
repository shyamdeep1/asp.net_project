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
            getcon();
            fillgrid();
        }
        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }
        //void select()
        //{
        //    getcon();
        //    da = new SqlDataAdapter("select * from Jobs where Id='" + ViewState["Id"] + "'", con);
        //    ds = new DataSet();
        //    da.Fill(ds);

        //    //Textnm.Text = ds.Tables[0].Rows[0][1].ToString();
        //    //Texteml.Text = ds.Tables[0].Rows[0][3].ToString();
        //    //RadioButtonList1.Text = ds.Tables[0].Rows[0][2].ToString();
        //    //DropDownList1.SelectedValue = ds.Tables[0].Rows[0][4].ToString();
        //}
        void fillgrid()
        {
            getcon();
            da = new SqlDataAdapter("select * from Jobs", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();

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