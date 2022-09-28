using IdentityManagement.Data;
using IdentityManagement.Entities;
using IdentityManagement.Entities.Assignment;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using Newtonsoft.Json;
using PATSWebV2.ViewModels.Assignment;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace PATSWebV2.Controllers
{
    
    [RoutePrefix("Assignments")]
    public class AssignmentController : PATSBassController
    {
        public bool CanEdit
        {
            get
            {
                return (CurrentUser.IsPOCAdmin || CurrentUser.IsPOCCaseManager || CurrentUser.IsPOCSocialWorker || CurrentUser.IsPOCPsychiatrist || CurrentUser.IsPOCPsychologist);
            }
        }
        public MvcHtmlString NoEditAllowed
        {
            get
            {
                if (this.CanEdit)
                    return MvcHtmlString.Create("");
                else
                    return HttpContext.Application["NoEditAllowed"] as MvcHtmlString;
            }
        }
        [Route("~/Assignments")]
        // GET: Assignment
        public ActionResult AssignmentIndex()
        {
            ViewBag.ControllerID = ControllerID.Assignment;
            ViewBag.CurrentUser = (ApplicationUser)Session["CurrentUser"];
            return View();
        }
        public ActionResult GetMultiClientAssignment()
        {
            var userList = GetUserByType(0);
            ViewData["SWList"] = userList.Where(x=>x.IsActive == 1 && x.CaseWorkerTypeId == 5 || x.CaseWorkerTypeId == -1).OrderBy(o => o.PATSUserName);
            ViewData["CMList"] = userList.Where(x => x.IsActive == 1 && x.CaseWorkerTypeId == 2 || x.CaseWorkerTypeId == -1).OrderBy(o => o.PATSUserName);
            ViewData["PCTList"] = userList.Where(x => x.IsActive == 1 && x.CaseWorkerTypeId == 3 || x.CaseWorkerTypeId == -1).OrderBy(o => o.PATSUserName);
            ViewData["PCOList"] = userList.Where(x => x.IsActive == 1 && x.CaseWorkerTypeId == 4 || x.CaseWorkerTypeId == -1).OrderBy(o => o.PATSUserName);

            int complexID = -9999;          
            return PartialView("_MultiClientAssignmentEditor", new AssignmentViewModel
            {
                Id = -1,
                ComplexID = complexID,
                CanEdit = this.CanEdit,
                DefaultFilterUserID = CurrentUser.UserID,
                DefaulCaseWorkTypeId = CurrentUser.CaseWorkerTypeId
            });
        }
        public ActionResult AssignmentRead([DataSourceRequest] DataSourceRequest request, int LocationId, int StaffID)
        {
            List<AssignmentViewModel> assignments = GetAllAssignment(0, LocationId, StaffID);
            return Json(assignments.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public ActionResult AssignmentCreate([DataSourceRequest] DataSourceRequest request,
            [Bind(Prefix = "models")]IEnumerable<AssignmentViewModel> assignments)
        {
            var query = string.Empty;
            if (assignments != null && ModelState.IsValid)
            {
                foreach (var assign in assignments)
                {
                    query = query + " " + BuildAssignmentQuery(assign.EpisodeID, assign.SocialWorkerUserId, assign.PsychiatristUserId, assign.PsychologistUserId, assign.ParoleAgentName);
                }
                var results = SqlHelper.ExecuteCommand(query);
            }
            int complexid = 0;
            if (assignments.FirstOrDefault().ComplexID != null)complexid = assignments.FirstOrDefault().ComplexID.Value;           
            var assigns = GetAllAssignment(0, complexid, 0);
            return Json(assigns.ToDataSourceResult(request, ModelState), JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult Excel_Export_Save(string ContentType, string Base64, string Filename)
        {
            var fileContents = Convert.FromBase64String(Base64);
            return File(fileContents, ContentType, Filename);
        }
        public JsonResult GetAllComplex(string text)
        {
            var offices = GetComplexes();
            if (!string.IsNullOrEmpty(text))
            {
                offices = offices.Where(x => x.ComplexDesc.Contains(text)).ToList();
            }
            
            return Json(offices.OrderBy(o => o.ComplexDesc), JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetAllStaffs(string text)
        {
            var list = GetPatsStaff(null, null, null, -1).OrderBy(o => o.StaffName).ToList();
            if (!string.IsNullOrEmpty(text))
                list = list.Where(x => x.StaffName.ToUpper().Contains(text.ToUpper())).ToList();
            return Json(list, JsonRequestBehavior.AllowGet);
        }
        public List<PATSUser> GetUserByType(int UserTypeID) {
            var temp = string.Empty;
            if (UserTypeID > 1)
            {
                temp = " WHERE CaseWorkerTypeId in ( -1," + UserTypeID + ") AND IsActive = 1";
            }
            else
            {
                temp = " WHERE CaseWorkerTypeId in (-1, 2,3,4,5)";
            }
            var query = string.Format(@"SELECT -1 AS PATSUserId, 'No Change' AS PATSUserName, -1 AS CaseWorkerTypeId, 0 AS IsActive UNION SELECT UserID AS PATSUserId, (SELECT Name FROM dbo.fn_GetAsstUserName(UserID))PATSUserName, CaseWorkerTypeId, IsActive FROM [User]" + temp, UserTypeID);
            
            var results = SqlHelper.ExecuteCommands<PATSUser>(query);
            return results;
        }
        
        public JsonResult GetPATSUsers(int UserTypeID)
        {
            var users = GetUserByType(UserTypeID);            
            return Json(users.OrderBy(o => o.PATSUserName), JsonRequestBehavior.AllowGet);
        }
        private string BuildAssignmentQuery(int episodeID, int? socialWorkerUserId, int? psychiatristUserId, int? psychologistUserId, string paroleAgent)
        {
            var query = string.Format(@"INSERT INTO dbo.StaffAssignment ([EpisodeID],[SocialWorkerUserId],[PsychiatristUserId],[PsychologistUserId],[ActionStatus],[ActionBy],[DateAction]) 
                   VALUES ({0},{1},{2},{3},(CASE WHEN (SELECT StaffAssignmentID FROM dbo.EpisodeTrace WHERE EpisodeID = {0}) > 0 THEN 2 ELSE 1 END),{4},GetDate()) 
             UPDATE dbo.EpisodeTrace SET StaffAssignmentID = @@IDENTITY WHERE EpisodeID ={0} 
             IF '{5}' IS NOT NULL AND '{5}'<> '' 
                UPDATE dbo.Episode SET paroleAgent = '{5}' WHERE EpisodeID={0} ", episodeID, (socialWorkerUserId == (int?)null ? 0 : socialWorkerUserId), (psychiatristUserId == (int?)null ? 0 : psychiatristUserId), (psychologistUserId == (int?)null ? 0 : psychologistUserId), CurrentUser.UserID, RemoveUnprintableChars(paroleAgent));
            return query;
        } 
        public ActionResult ClientAssignmentRead([DataSourceRequest] DataSourceRequest request, int EpisodeId)
        {
            List<AssignmentViewModel> assignments = GetAllAssignment(EpisodeId, 0, 0);
            //if (assignments == null || assignments.Count() == 0) assignments.Add(InitialAssignment(EpisodeId));

            return Json(assignments.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public ActionResult ClientAssignmentCreate([DataSourceRequest] DataSourceRequest request,
             [Bind(Prefix = "models")]IEnumerable<AssignmentViewModel> assignments)
        {
            var query = string.Empty;
            if (assignments != null && ModelState.IsValid)
                foreach (var assign in assignments)
                {
                    var temp = BuildAssignmentQuery(assign.EpisodeID, assign.SocialWorkerUserId, 
                    assign.PsychiatristUserId,
                    assign.PsychologistUserId,
                    assign.ParoleAgentName);
                    query = query + temp;
                }
            var results = SqlHelper.ExecuteCommand(query);
            var assigns = GetAllAssignment(assignments.FirstOrDefault().EpisodeID, 0, 0);
            return Json(assigns.ToDataSourceResult(request, ModelState), JsonRequestBehavior.AllowGet);
        }
        public ActionResult AssignmentHisRead([DataSourceRequest] DataSourceRequest request, int EpisodeId)
        {
            List<AssignmentHistoryData> assignments = GetHistoryList(EpisodeId);
            return Json(assignments.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetAssignmentHistory(int EpisodeID)
        {
            return PartialView("_ClientAssignmentHistory");
        }
        public List<AssignmentHistoryData> GetHistoryList(int EpisodeID)
        {
            var query = string.Format(@"SELECT [ID] ,[EpisodeID]episodeId,(DateAction)AssignmentDate
      ,(CASE WHEN SocialWorkerUserId > 0 THEN (SELECT Name From dbo.[fn_GetAsstUserName](SocialWorkerUserId)) ELSE '' END)SocialWorkerName
	  ,(CASE WHEN PsychiatristUserId > 0 THEN (SELECT Name From dbo.[fn_GetAsstUserName](PsychiatristUserId)) ELSE '' END)PsychiatristName
	  ,(CASE WHEN PsychologistUserId > 0 THEN (SELECT Name From dbo.[fn_GetAsstUserName](PsychologistUserId)) ELSE '' END)PsychologistName
	  ,(SELECT Name From dbo.[fn_GetAsstUserName]([ActionBy]))AssignedBy
  FROM [dbo].[StaffAssignment] WHERE EpisodeID ={0}", EpisodeID);
            return SqlHelper.ExecuteCommands<AssignmentHistoryData>(query);
        }
        private List<AssignmentViewModel> GetAllAssignment(int EpisodeId, int LocationId, int StaffID)
        {
            List<ParameterInfo> parms = new List<ParameterInfo> {
                new ParameterInfo { ParameterName= "EpisodeId", ParameterValue= EpisodeId },
                new ParameterInfo { ParameterName = "LocationId", ParameterValue = LocationId },
                new ParameterInfo { ParameterName = "StaffId", ParameterValue = StaffID }
             };
            var assignments = new List<AssignmentViewModel>();

            var query = SqlHelper.GetRecords<StaffAssignmentData>("spGetStaffAssignmentList", parms).ToList();

            if (query != null && query.Count() > 0)
            {
                foreach (var s in query)
                {
                    var data = new AssignmentViewModel
                    {                                    
                        CDCRNum = s.CDCRNum,
                        ClientName = s.ClientName,
                        EpisodeID = s.EpisodeId,
                        Id = s.Id,
                        CanEdit = this.CanEdit,
                        MHStatus = s.MHStatus,
                        CaseStatus = s.CaseStatus,
                        SocialWorkerUserId = s.SocialWorkerUserId.HasValue ? s.SocialWorkerUserId.Value : 0,
                        PsychiatristUserId = s.PsychiatristUserId.HasValue ? s.PsychiatristUserId.Value : 0,
                        PsychologistUserId = s.PsychologistUserId.HasValue ? s.PsychologistUserId.Value : 0,
                        ParoleLocationID = s.ParoleLocationID,
                        Location = s.ComplexDesc,
                        ComplexID = s.ComplexID,
                        SocialWorker = JsonConvert.DeserializeObject<PATSUser>(s.SocialWorker),
                        Psychiatrist = JsonConvert.DeserializeObject<PATSUser>(s.Psychiatrist),
                        Psychologist = JsonConvert.DeserializeObject<PATSUser>(s.Psychologist),
                        ParoleAgentName = s.ParoleAgentName,
                        CaseBankedDate = s.CaseBankedDate
                    };
                    assignments.Add(data);
                }
            }
            return assignments;
        }
        public ActionResult ClientAssignmentIndex(int? episodeID, string ActiveTabIn)
        {
            return PartialView("_ClientAssignmentIndex", new AssignmentViewModel
            {
                Id = -1,
                EpisodeID = (int)episodeID,
                ParoleLocationID = CurrentUser.PrimaryLocationId > 0 ? CurrentUser.PrimaryLocationId : -1,
                DefaultFilterUserID = CurrentUser.UserID,
                DefaulCaseWorkTypeId = CurrentUser.CaseWorkerTypeId,
                ActiveTabIn = ActiveTabIn
            });
        }
        public ActionResult GetClientAssignment(int episodeID)
        {
            var userList = GetUserByType(0);
            ViewData["SWList"] = userList.Where(x => x.IsActive == 1 && x.CaseWorkerTypeId == 5 || x.CaseWorkerTypeId == -1).OrderBy(o => o.PATSUserName);
            ViewData["PCTList"] = userList.Where(x => x.IsActive == 1 && x.CaseWorkerTypeId == 3 || x.CaseWorkerTypeId == -1).OrderBy(o => o.PATSUserName);
            ViewData["PCOList"] = userList.Where(x => x.IsActive == 1 && x.CaseWorkerTypeId == 4 || x.CaseWorkerTypeId == -1).OrderBy(o => o.PATSUserName);
           
            return PartialView("_ClientAssignment", new AssignmentViewModel
            {
                EpisodeID = episodeID,
                DefaultFilterUserID = CurrentUser.UserID,
                DefaulCaseWorkTypeId = CurrentUser.CaseWorkerTypeId,
                CanEdit = this.CanEdit
            });
        }
        [HttpPost]
        public ActionResult SaveGridData(AssignmentViewModel[] assignments)
        {
            var count = 0;
            var query = string.Empty;
            if (assignments != null)
            {
                count = assignments.Count();
                foreach (var assign in assignments)
                {
                    query = query + " " + BuildAssignmentQuery(assign.EpisodeID, assign.SocialWorkerUserId, assign.PsychiatristUserId, assign.PsychologistUserId, assign.ParoleAgentName);
                }
                var results = SqlHelper.ExecuteCommand(query);
            }
            //Returns how many records was posted
            return Json(new { count = count });
        }
    }
}