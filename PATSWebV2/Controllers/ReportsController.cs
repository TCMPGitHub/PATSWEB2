using System.Collections;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;
using Telerik.Reporting;
using Telerik.Reporting.Cache.File;
using Telerik.Reporting.Processing;
using Telerik.Reporting.Services;
using Telerik.Reporting.Services.Engine;
using Telerik.Reporting.Services.WebApi;

namespace PATSWebV2.Controllers
{

    public class ReportsController : ReportsControllerBase
    {
        static ReportServiceConfiguration preservedConfiguration;
        // GET: Reports
        static IReportServiceConfiguration PreservedConfiguration
        {
            get
            {
                if (null == preservedConfiguration)
                {
                    preservedConfiguration = new ReportServiceConfiguration
                    {
                        HostAppId = "MvcApp",
                        Storage = new FileStorage(),
                        ReportResolver = CreateResolver(),
                        // ReportSharingTimeout = 0,
                        // ClientSessionTimeout = 15,
                    };
                }
                return preservedConfiguration;
            }


        }
        public ReportsController()
        {
            this.ReportServiceConfiguration = PreservedConfiguration;
        }

        protected override HttpStatusCode SendMailMessage(MailMessage mailMessage)
        {
            throw new System.NotImplementedException("This method should be implemented in order to send mail messages.");
            //using (var smtpClient = new SmtpClient("smtp01.mycompany.com", 25))
            //{
            //    smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
            //    smtpClient.EnableSsl = false;

            //    smtpClient.Send(mailMessage);
            //}
            //return HttpStatusCode.OK;
        }

        static IReportResolver CreateResolver()
        {
            var appPath = HttpContext.Current.Server.MapPath("~/");
            var reportsPath = System.IO.Path.Combine(appPath, @"PatsReportLibrary");

            return new ReportFileResolver(reportsPath)
                .AddFallbackResolver(new ReportTypeResolver());
        }


        //public RenderingResult RenderReport(string format,ReportSource reportSource,Hashtable deviceInfo)
        //{
        //    Telerik.Reporting.Processing.ReportProcessor reportProcessor =
        //         new Telerik.Reporting.Processing.ReportProcessor();

        //    // set any deviceInfo settings if necessary
        //    deviceInfo = new System.Collections.Hashtable();

        //    Telerik.Reporting.TypeReportSource typeReportSource = new Telerik.Reporting.TypeReportSource();

        //    // reportName is the Assembly Qualified Name of the report
        //    typeReportSource.TypeName = reportName;

        //    Telerik.Reporting.Processing.RenderingResult result = reportProcessor.RenderReport("PDF", typeReportSource, deviceInfo);

        //    string fileName = result.DocumentName + "." + result.Extension;
        //    string path = System.IO.Path.GetTempPath();
        //    string filePath = System.IO.Path.Combine(path, fileName);

        //    using (System.IO.FileStream fs = new System.IO.FileStream(filePath, System.IO.FileMode.Create))
        //    {
        //        fs.Write(result.DocumentBytes, 0, result.DocumentBytes.Length);
        //    }

        //}
    }
}