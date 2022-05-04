using IdentityManagement.Entities;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using PATSWebV2.ViewModels.Reports;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Telerik.Reporting.Pats.Reports;

namespace PATSWebV2.Controllers
{
    [RoutePrefix("Reports")]
    public class HomeController : PATSBassController
    {
        [Route("~/Reports")]
        public ActionResult Index()
        {
            ViewBag.ControllerID = ControllerID.Reports;
            ViewBag.CurrentUser = (ApplicationUser)Session["CurrentUser"];
            ReportsViewmodel model = new ReportsViewmodel();
            model.RptInfo = new ReportManager().GetReports().Select(s => new SelectListItem
            { Value = s.AssemblyQualifiedName, Text = s.Name }).ToList();
            return View(model);
        }

        public JsonResult GetAllReports([DataSourceRequest] DataSourceRequest request)
        {
            return Json(new ReportManager().GetReports().ToDataSourceResult(request));
        }

        public ActionResult Error()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }
    }
}