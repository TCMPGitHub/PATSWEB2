using IdentityManagement.Data;
using IdentityManagement.Entities;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using PATSWebV2.ViewModels.Client;
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

    [RoutePrefix("Admin")]
    public class AdminController : PATSBassController
    {
        public class Users
        {
            public int UserID { get; set; }
            public string FirstName { get; set; }
            public string UserName { get; set; }
            public string PasswordHash { get; set; }
            public string LastName { get; set; }
            public bool IsActive { get; set; }
            public int LoginFailures { get; set; }
            public bool IsPOCAdmin { get; set; }
            public bool IsPOCSocialWorker { get; set; }
            public bool IsPOCPsychologist { get; set; }
            public bool IsPOCPsychiatrist { get; set; }
            public bool IsParoleAgent { get; set; }
            public bool IsPOCCaseManager { get; set; }
            public int? CaseWorkerTypeID { get; set; }
            public int? PrimaryLocationID { get; set; }
            public bool IsSysAdmin { get; set; }
            public bool IsLOCBHRAdmin { get; set; }
        }
        public class CaseWorkerType
        {
            public int CaseWorkerTypeId { get; set; }
            public string CaseWorkerTypeDesc { get; set; }
        }
        [Route("~/Admin")]
        public ActionResult Index()
        {
            ViewBag.ControllerID = ControllerID.Admin;
            ViewBag.CurrentUser = (ApplicationUser)Session["CurrentUser"];
            //ReportsViewmodel model = new ReportsViewmodel();
            //model.RptInfo = new ReportManager().GetReports().Select(s => new SelectListItem
            //{ Value = s.AssemblyQualifiedName, Text = s.Name }).ToList();
            return View();
        }
        public ActionResult GetUser()
        {
            var userC = new UserInfo
            {
                UserID = 0,
                UserName = "",
                LastName = "",
                FirstName = "",
                Email = "",
                Password = "",
                PasswordHash = "",
                IsActive = false,
                IsPOCAdmin = false,
                IsPOCSocialWorker = false,
                IsPOCPsychologist = false,
                IsPOCPsychiatrist = false,
                IsPOCCaseManager = false,
                CaseWorkerTypeId = 0,
                PrimaryLocationId = -1,
                LoginFailures = 0,
                IsSysAdmin = false,
                IsLOCBHRAdmin = false
            };            
            return PartialView("_AdminUser", new AdminUser{ UserClass = userC });
        }
        private UserInfo GetSelectedUser(int UserID)
        {
            var query = string.Format(@"SELECT UserID, FirstName, UserName, PasswordHash, LastName, CanEditAllCases,
             IsActive,LoginFailures,IsPOCAdmin, IsPOCSocialWorker, IsPOCPsychologist, IsPOCPsychiatrist, IsParoleAgent,
       IsPOCCaseManager, CaseWorkerTypeId, ISNULL(PrimaryLocationId, -1) as PrimaryLocationId,IsSysAdmin, IsLOCBHRAdmin
  FROM [User] WHERE UserID ={0}", UserID);
            return SqlHelper.ExecuteCommands<UserInfo>(query).FirstOrDefault(); 
        }
        public JsonResult GetCaseWorkerType()
        {
            var resultlist = SqlHelper.ExecuteCommands<CaseWorkerType>(
                @"SELECT CaseWorkerTypeId, CaseWorkerTypeDesc FROM tlkpCaseWorkerType Order By CaseWorkerTypeDesc");

            return Json(resultlist, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetLocation()
        {
            var resultlist = SqlHelper.ExecuteCommands<Location>(
                @"SELECT LocationID, LocationDesc FROM tlkpLocation Order By LocationDesc");

            return Json(resultlist, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetAllUsers(int UserID)
        {
            var query = string.Format(@"SELECT UserID, FirstName, UserName, PasswordHash, LastName, CanEditAllCases,
             IsActive,LoginFailures,IsPOCAdmin, IsPOCSocialWorker, IsPOCPsychologist, IsPOCPsychiatrist, IsParoleAgent,
       IsPOCCaseManager, CaseWorkerTypeId, ISNULL(PrimaryLocationId, -1) as PrimaryLocationId,IsSysAdmin, IsLOCBHRAdmin
  FROM [User] WHERE ISNULL(LastName, '') <> '' AND ISNULL(Firstname , '') <> ''");
            List<UserInfo> userC = SqlHelper.ExecuteCommands<UserInfo>(query).ToList();
            if (UserID > 0)
                userC = userC.Where(x => x.UserID == UserID).ToList();
            return Json(userC, JsonRequestBehavior.AllowGet);
        }
        public ActionResult SaveUser(AdminUser patsuser)
        {
            var userid = 0;
            if (ModelState.IsValid)
            {
                var query = "";
                if (patsuser.UserClass.UserID > 0)
                {
                    query = string.Format(@"UPDATE [dbo].[User] SET [UserName] = {0},[FirstName] ={1}
           ,[LastName]={2},[IsActive] = {3},[LoginFailures] ={4},[IsPOCAdmin] ={5}
           ,[IsPOCSocialWorker] = {6},[IsPOCPsychologist] = {7},[IsPOCPsychiatrist] = {8}
           ,[IsPOCCaseManager] = {9},[CaseWorkerTypeId]={10} ,[PrimaryLocationId] = {11}
           ,[LocationIds] = '',[IsSysAdmin]={12},[IsLOCBHRAdmin] = {13}, ActionBy ={14} WHERE UserID ={15}",
             "'" + RemoveUnprintableChars(patsuser.UserClass.UserName) + "'",
                 "'" + RemoveUnprintableChars(patsuser.UserClass.FirstName) + "'",
                 "'" + RemoveUnprintableChars(patsuser.UserClass.LastName) + "'",
                 patsuser.UserClass.IsActive == true ? 1 : 0, patsuser.UserClass.LoginFailures, 
                 patsuser.UserClass.IsPOCAdmin == true ? 1 : 0,
                 patsuser.UserClass.IsPOCSocialWorker == true ? 1 : 0, 
                 patsuser.UserClass.IsPOCPsychologist == true ? 1 : 0,
                 patsuser.UserClass.IsPOCPsychiatrist == true ? 1 : 0, 
                 patsuser.UserClass.IsPOCCaseManager == true ? 1 : 0,
                 patsuser.UserClass.CaseWorkerTypeId, patsuser.UserClass.PrimaryLocationId, 
                 patsuser.UserClass.IsSysAdmin == true ? 1 : 0, patsuser.UserClass.IsLOCBHRAdmin == true ? 1 : 0,
                 CurrentUser.UserID, patsuser.UserClass.UserID);
                    userid = patsuser.UserClass.UserID;
                    SqlHelper.ExecuteCommand(query);
                }
                else
                {
                    query = string.Format(@"IF EXISTS(SELECT 1 FROM dbo.[User] WHERE FirstName={1} AND LastName = {2})
                    BEGIN SELECT - 1 END
                    ELSE BEGIN
           INSERT INTO[dbo].[User]([UserName],[FirstName],[LastName],
             [IsActive],[IsBenefitWorker],[CanEditAllCases],[CanEditAllNotes],[CanAccessReports],
             [CanAccessSomsUpload],[LoginFailures],[IsPOCAdmin],[IsPOCSocialWorker],[IsPOCPsychologist],
             [IsPOCPsychiatrist],[IsParoleAgent],[IsPOCCaseManager],[CaseWorkerTypeId],[PrimaryLocationId],
             [IsSysAdmin],[IsLOCBHRAdmin],[ActionBy])
          VALUES({0}, {1}, {2}, {3}, 0, 0, 0, 0, 0, {4}, {5}, {6}, {7}, {8}, 0, {9}, {10}, {11}, {12}, {13}, {14})
           select UserID from dbo.[User] WHERE FirstName = {1} AND LastName = {2} END ",
               "'" + RemoveUnprintableChars(patsuser.UserClass.UserName) + "'",
               "'" + RemoveUnprintableChars(patsuser.UserClass.FirstName) + "'",
               "'" + RemoveUnprintableChars(patsuser.UserClass.LastName) + "'",
               patsuser.UserClass.IsActive == true ? 1 : 0, patsuser.UserClass.LoginFailures, 
               patsuser.UserClass.IsPOCAdmin == true ? 1 : 0,
               patsuser.UserClass.IsPOCSocialWorker == true ? 1 : 0, 
               patsuser.UserClass.IsPOCPsychologist == true ? 1 : 0, 
               patsuser.UserClass.IsPOCPsychiatrist == true ? 1 : 0,
               patsuser.UserClass.IsPOCCaseManager == true ? 1 : 0, 
               patsuser.UserClass.CaseWorkerTypeId, patsuser.UserClass.PrimaryLocationId, 
               patsuser.UserClass.IsSysAdmin == true ? 1 : 0,
               patsuser.UserClass.IsLOCBHRAdmin == true ? 1 : 0, CurrentUser.UserID);
                    userid = SqlHelper.ExecuteQueryWithReturnValue(query); ;
                }              
            }
            var model = new AdminUser();
            if (userid == -1)
            {
                ModelState.AddModelError(string.Empty, string.Format(@"User with First Name:{0}, Last Name:{1} already exist ", patsuser.UserClass.FirstName, patsuser.UserClass.LastName));
                model.UserClass = patsuser.UserClass;
            }
            else
            {
                model.UserClass = GetSelectedUser(userid);
            }
            
            return PartialView("_AdminUser", model);           
        }
    }
}