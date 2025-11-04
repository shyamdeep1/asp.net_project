using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Job_Portal
{
    public partial class DownloadApplication : System.Web.UI.Page
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
            if (!IsPostBack && Request.QueryString["AppId"] != null)
            {
                int appId = Convert.ToInt32(Request.QueryString["AppId"]);
                GenerateReport(appId);
            }
        }

        private void GenerateReport(int appId)
        {
            getcon();

            DataSet ds = new DataSet();

            SqlDataAdapter daApp = new SqlDataAdapter(
                "SELECT * FROM JobApplications WHERE ApplicationID = @AppId", con);
            daApp.SelectCommand.Parameters.AddWithValue("@AppId", appId);
            daApp.Fill(ds, "JobApplications");

            SqlDataAdapter daJob = new SqlDataAdapter(
                "SELECT * FROM Jobs WHERE JobID = (SELECT JobID FROM JobApplications WHERE ApplicationID = @AppId)", con);
            daJob.SelectCommand.Parameters.AddWithValue("@AppId", appId);
            daJob.Fill(ds, "Jobs");

            SqlDataAdapter daRec = new SqlDataAdapter(
                "SELECT * FROM Recruiters WHERE RecruiterID = (SELECT RecruiterID FROM Jobs WHERE JobID = (SELECT JobID FROM JobApplications WHERE ApplicationID = @AppId))", con);
            daRec.SelectCommand.Parameters.AddWithValue("@AppId", appId);
            daRec.Fill(ds, "Recruiters");

            foreach (DataRow row in ds.Tables["Jobs"].Rows)
            {
                string logoPath = row["Company_Logo"]?.ToString();

                if (!string.IsNullOrEmpty(logoPath))
                {
                        if (logoPath.StartsWith("~"))
                            logoPath = Server.MapPath(logoPath);
                        else if (logoPath.StartsWith("/"))
                            logoPath = Server.MapPath("~" + logoPath);
                        else if (!System.IO.Path.IsPathRooted(logoPath))
                            logoPath = Server.MapPath("~/Uploads/" + logoPath);

                        row["Company_Logo"] = logoPath;
                }
            }

            ds.WriteXmlSchema(Server.MapPath("~/JobApplicationFullData.xml"));

            string rptPath = Server.MapPath("~/ApplicationReport.rpt");
            
            cr.Load(rptPath);
            cr.SetDataSource(ds);

            cr.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, "JobApplication_" + appId);

            cr.Close();
            cr.Dispose();
            con.Close();
        }
    }
}
