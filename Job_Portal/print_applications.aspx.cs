using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
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
    public partial class print_applications : System.Web.UI.Page
    {
        string s = ConfigurationManager.ConnectionStrings["JobPortalConnection"].ConnectionString;
        SqlConnection con;
        ReportDocument cr = new ReportDocument();

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["JobID"] != null)
            {
                int jobId = Convert.ToInt32(Request.QueryString["JobID"]);
                GenerateReport(jobId);
            }
        }
        private void GenerateReport(int jobId)
        {
            getcon();
            DataSet ds = new DataSet();

            SqlDataAdapter daApp = new SqlDataAdapter(
                "SELECT * FROM JobApplications WHERE JobID = @JobId", con);
            daApp.SelectCommand.Parameters.AddWithValue("@JobId", jobId);
            daApp.Fill(ds, "JobApplications");

            SqlDataAdapter daJob = new SqlDataAdapter(
                "SELECT * FROM Jobs WHERE JobID = @JobId", con);
            daJob.SelectCommand.Parameters.AddWithValue("@JobId", jobId);
            daJob.Fill(ds, "Jobs");

            SqlDataAdapter daRec = new SqlDataAdapter(
                "SELECT * FROM Recruiters WHERE RecruiterID = (SELECT RecruiterID FROM Jobs WHERE JobID = @JobId)", con);
            daRec.SelectCommand.Parameters.AddWithValue("@JobId", jobId);
            daRec.Fill(ds, "Recruiters");


            ds.WriteXmlSchema(Server.MapPath("~/AppliedJobs.xml"));

            string rptPath = Server.MapPath("~/AppliedJobs.rpt");
            cr.Load(rptPath);
            cr.SetDataSource(ds);

            cr.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, "JobApplications_" + jobId);

            cr.Close();
            cr.Dispose();
            con.Close();
        }
    }
}