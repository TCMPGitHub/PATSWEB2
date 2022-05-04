using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using PATSWebV2.Models;
using PATSWebV2.ViewModels;
using Kendo.Mvc.UI;
using Kendo.Mvc.Extensions;
using System.Data;
using System.Web.Script.Serialization;
using IdentityManagement.Entities;
using IdentityManagement.Data;
using IdentityManagement.Entities.Appointment;
using IdentityManagement.Entities.Assignment;
using PATS.Models.HelperModels;
using System.Web.Configuration;
using System.IO;
using iTextSharp.text.pdf;

namespace PATSWebV2.Controllers
{
    public enum CLIENT_STATUS
    {
        Absent = 1,
        Pending,
        Present,
        Excused,
        Canceled,
    }
    [RoutePrefix("Appointments")]
    [ValidateInput(false)]
    public class AppointmentController : PATSBassController
    {
        public bool CanEdit
        {
            get
            {
                if (Session["CurrentUser"] == null)
                    return false;
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
        protected override void OnActionExecuting(ActionExecutingContext ctx)
        {
            base.OnActionExecuting(ctx);
            CurrentUser = (ApplicationUser)ctx.HttpContext.Session["CurrentUser"];
        }

        // GET: Appointment
        [Route("~/Appointments")]
        public ActionResult ApptIndex()
        {
            ViewBag.ControllerID = ControllerID.Appointment;
            ViewBag.CurrentUser = (ApplicationUser)Session["CurrentUser"];
            return View();
        }
        public ActionResult GetAppointmentManagement(string ActiveTabIn)
        {
            var complexID = 5;
            if (CurrentUser.UserID > 0 && CurrentUser.PrimaryLocationId > 0)
            {
                var query = string.Format("SELECT Distinct ComplexID FROM dbo.tlkpLocation WHERE LocationID = {0}", CurrentUser.PrimaryLocationId);
                complexID = SqlHelper.ExecuteQueryWithReturnValue(query);
            }

            var selectStaff = new List<ActivePATSUser>{ new ActivePATSUser {
                StaffId = CurrentUser.UserID,
                StaffName = CurrentUser.UserLFI(),
                LocationId = CurrentUser.PrimaryLocationId > 0 ? CurrentUser.PrimaryLocationId : 0,
                IsCurrentUser = true,
                ComplexId = complexID
            } };

            return PartialView("_Appointmentmanagement", new AppointmentViewModel
            {
                Start = DateTime.Now,
                ActiveTabIn = ActiveTabIn,
                SelectedStaffs = selectStaff,
                SelectedLocationId = selectStaff[0].ComplexId
            });
        }
        public ActionResult GetAppointmentClientManagement(int EpisodeID, int ParoleLocationID, int tab = 0)
        {
            var SelectStaffs = new List<ActivePATSUser> { new ActivePATSUser { StaffId = CurrentUser.UserID, StaffName = CurrentUser.UserLFI(), IsCurrentUser = true } };

            var SelectClients = new List<ApptClient> { new ApptClient { EpisodeID = EpisodeID, ClientStatus = 2, ReleaseLoc = ParoleLocationID } };

            //var locationid = db.Episodes.Where(x => x.EpisodeID == EpisodeID).FirstOrDefault().ParoleLocationID;
            //if (locationid != null && locationid > 0)
            //{
            //    locationid = db.Location_lkups.Where(x => x.LocationID == locationid).Select(s => s.ComplexID).SingleOrDefault();
            //}
            return PartialView("_AppointmentClientManagement", new AppointmentViewModel
            {
                EpisodeId = EpisodeID,
                Start = DateTime.Now,
                CanEdit = this.CanEdit,
                SelectedADAItems = new List<SelectListItem>(),
                SelectedStaffs = SelectStaffs,
                SelectedClients = SelectClients,
                SelectedLocationId = ParoleLocationID,
                TypeID = 5,
                StatusID = 2,
                ClientLocationId = ParoleLocationID,
                SelectTab = tab
            });
        }
        public ActionResult GetDailyActivity(int StaffId, DateTime SchedulerDate)
        {         
            
            var complexID = 0;
            if (CurrentUser.UserID > 0 && CurrentUser.PrimaryLocationId > 0)
            {
                var query = string.Format("SELECT ComplexID FROM dbo.tlkpLocation WHERE LocationID = {0}", CurrentUser.PrimaryLocationId);
                complexID = SqlHelper.ExecuteQueryWithReturnValue(query);
            }

            var selectStaff = new List<ActivePATSUser>{ new ActivePATSUser {
                StaffId = CurrentUser.UserID,
                StaffName = CurrentUser.UserLFI(),
                LocationId = CurrentUser.PrimaryLocationId > 0 ? CurrentUser.PrimaryLocationId : 0,
                IsCurrentUser = true,
                ComplexId = complexID
            } };

            var selectClient = new List<ApptClient>() { new ApptClient {
                 Agent = "",
                 AppointmentId = 0,
                 CDCRNumber = "",
                 ClientName="",
                 EpisodeID = 0,
                 Unit = "",
                 ReleaseLoc = 0,
                 ClientStatus= (int)Appt_Client_Status.Pending
            } };

            SchedulerDate = DateTime.Now;

            return PartialView("_DailyActivity", 
                new AppointmentViewModel{ SelectedStaffs = selectStaff, Start = SchedulerDate, StartTime = SchedulerDate, StaffName = selectStaff[0].StaffName,
                    TypeID = 5, StatusID = 1, End = SchedulerDate, EndTime = SchedulerDate.AddMinutes(15), SelectedLocationId = selectStaff[0].ComplexId,
                    SelectedClients = selectClient, SelectedADAItems = new List<SelectListItem>()
            });
        }
        public ActionResult GetClientDailyActivity(int EpisodeId, DateTime SchedulerDate, int Init, string Mod)
        {
            int appType = 5;
            int loc = 0;

            var qEdit = string.Format(@"SELECT (CASE WHEN ISNULL(CaseClosureDate, 0)=0 THEN 0 ELSE 1 END)CaseClosureDate  from ClientEpisode Where CLientEpisodeID =
(select t2.CLientEpisodeID from Episode t1 INNER JOIN EpisodeTrace t2 ON t1.EpisodeID = t2.EpisodeID Where t1.EpisodeID = {0})", EpisodeId);
            var edit = SqlHelper.ExecuteCommand(qEdit) == 0 ? false : true;

            if (Init == 0)
            {             
                //get the latest scheduled appointment
                //var query1 = db.Appointments.Where(x => x.ActionStatus != 10 && x.EWCS.Any(y => y.EpisodeID == EpisodeId)).GroupBy(g => g.AppointmentTraceID).Select(g => g.OrderByDescending(o => o.AppointmentID).FirstOrDefault()).OrderByDescending(t => t.StartDate).FirstOrDefault();
                var query = string.Format(@"DECLARE @EpisodeID int = {0} 
select TOP 1 t1.StartDate, t1.ActionStatus, t5.ParoleLocationID from Appointment t1 INNER JOIN AppointmentTrace t2 on t1.AppointmentTraceID = t2.AppointmentTraceID INNER JOIN 
(SELECT AppointmentID, EpisodeID FROM AppointmentWithClient WHERE EpisodeID = @EpisodeID) t3 on t1.AppointmentID  = t3.AppointmentID INNER JOIN (SELECT EpisodeID, ISNULl(ParoleLocationID, 0)ParoleLocationID FROM Episode WHERE EpisodeID  = @EpisodeID) t5  ON t3.EpisodeID = t5.EpisodeID
WHERE t1.ActionStatus <> 10 ORDER BY t1.StartDate DESC", EpisodeId);
                var result = SqlHelper.ExecuteCommands<ClientMinInfo>(query).FirstOrDefault();
                if (result != null)
                    SchedulerDate = result.StartDate;
                else
                    SchedulerDate = DateTime.Now;

                loc = result.ParoleLocationID;
            }
            else
            {
                //make sure the day is not weekend
                if (SchedulerDate.DayOfWeek == DayOfWeek.Sunday)
                    SchedulerDate = SchedulerDate.AddDays(1);
                else if (SchedulerDate.DayOfWeek == DayOfWeek.Saturday)
                    SchedulerDate = SchedulerDate.AddDays(2);
            }

            if (Init == 3) appType = 12;
            else if (Init == 7) appType = 13;
            else if (Init == 30) appType = 14;

            var selectStaff = new List<ActivePATSUser>();
            selectStaff.Add(new ActivePATSUser { StaffId = CurrentUser.UserID, StaffName = CurrentUser.UserLFI(), LocationId = CurrentUser.PrimaryLocationId > 0 ? CurrentUser.PrimaryLocationId : 0, IsCurrentUser = true });

            var selectClient = new List<ApptClient>();
            selectClient.Add(new ApptClient { EpisodeID = EpisodeId, AppointmentId = 0, Agent = "", Unit = "", CDCRNumber = "", ClientName = "", ClientStatus = 2, FollowupAppt = "", ReleaseLoc = loc });
            //int loc = db.Episodes.Where(x => x.EpisodeID == EpisodeId).Select(s => s.ParoleLocationID).SingleOrDefault();
            return PartialView("_AppointmentClientManagement", new AppointmentViewModel
            {
                EpisodeId = EpisodeId,
                Start = SchedulerDate,
                StartTime = SchedulerDate,
                StaffName = CurrentUser.UserLFI(),
                TypeID = appType,
                StatusID = 1,
                End = SchedulerDate,
                EndTime = SchedulerDate.AddMinutes(15),
                ClientLocationId = loc,
                SelectedClients = selectClient,
                SelectedStaffs = selectStaff,
                CanEdit = this.CanEdit && edit,
                AppointmentDay = Init,
                ModelAction = Mod,
                SelectedADAItems = new List<SelectListItem>(),
            });
        }

        public ActionResult AppointmentRead([DataSourceRequest] DataSourceRequest request, int StaffId, DateTime StartDate)
        {
            DateTime EndDate = StartDate.AddHours(24);
            List<AppointmentViewModel> events = GetAllAppts(StaffId, 0, 0, 0, StartDate.Date, EndDate.Date);
            if (events.Count() == 1 && events[0].AppointmentId == 0)
                events = new List<AppointmentViewModel>();
            return Json(events.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }
        public JsonResult AppointmentLocationRead([DataSourceRequest] DataSourceRequest request, int StaffId, DateTime StartDate, DateTime EndDate)
        {
            if (StartDate == EndDate)
                EndDate = StartDate.AddHours(24);
            List<AppointmentViewModel> events = GetAllAppts(StaffId == 0 ? CurrentUser.UserID : StaffId, 0, 0, 0, StartDate.Date, EndDate.Date);
            return Json(events.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }
        public ActionResult AppointmentClientRead([DataSourceRequest] DataSourceRequest request, int EpisodeId, DateTime StartDate)
        {
            List<AppointmentViewModel> events = GetAllAppts(0, 0, EpisodeId, 0, StartDate.Date, StartDate.AddHours(24));
            return Json(events.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public ActionResult AppointmentClientHisRead([DataSourceRequest] DataSourceRequest request, int EpisodeId)
        {
            DateTime StartTime = DateTime.Now.AddYears(-2);
            DateTime EndTime = DateTime.Now.AddYears(1);
            List<AppointmentViewModel> events = GetAllAppts(0, 0, EpisodeId, 0, StartTime, EndTime);
            return Json(events.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }
        public ActionResult AppointmentOfficeRead([DataSourceRequest] DataSourceRequest request, int LocationId, DateTime StartDate, DateTime EndDate)
        {
            if (StartDate == EndDate)
            {
                EndDate = StartDate.AddHours(24);
            }
            List<AppointmentViewModel> allevents = GetAllAppts(0, LocationId, 0, 0, StartDate.Date, EndDate.Date);
            return Json(allevents.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }
        public ActionResult AppointmentCreate([DataSourceRequest] DataSourceRequest request, AppointmentViewModel appointment, string ClientIDs, string WorkerIDs)
        {
            bool printapp = appointment.AutoPrint;
            if (appointment != null && ModelState.IsValid)
            {
                //add this line to make start date always the same as end day 
                //we are use the start day with kendo datepicker
                //appointment.End = appointment.Start;
                if (appointment.IsAllDay)
                {
                    appointment.Start = DateTime.Parse(appointment.Start.Month.ToString() + "/" + appointment.Start.Day.ToString() + "/" + appointment.Start.Year.ToString() + " 08:00");
                    appointment.End = appointment.Start.AddHours(9);
                }

                string returnmsg = GetOccupiedReturnMessage(appointment.Start, appointment.End, ClientIDs, WorkerIDs, appointment.TypeID, 0);
                if (!string.IsNullOrEmpty(returnmsg))
                {
                    ModelState.AddModelError(string.Empty, returnmsg);
                }
                else
                {
                    appointment.AppointmentId = SaveAppointment(appointment);
                    if (printapp)
                        appointment.PrintAppointmentID = appointment.AppointmentId;
                }
            }

            return Json(new[] { appointment }.ToDataSourceResult(request, ModelState), JsonRequestBehavior.AllowGet);
        }
        public ActionResult AppointmentLocationCreate([DataSourceRequest] DataSourceRequest request, AppointmentViewModel appointment, string ClientIDs, string WorkerIDs)
        {
            if (appointment != null && ModelState.IsValid)
            {
                var printapp = appointment.AutoPrint;
                //add this line to make start date always the same as end day 
                //we are use the start day with kendo datepicker
                //appointment.End = appointment.Start;
                if (appointment.IsAllDay)
                {
                    appointment.Start = DateTime.Parse(appointment.Start.Month.ToString() + "/" + appointment.Start.Day.ToString() + "/" + appointment.Start.Year.ToString() + " 08:00");
                    appointment.End = appointment.Start.AddHours(9);
                }
                string returnmsg = GetOccupiedReturnMessage(appointment.Start, appointment.End, ClientIDs, WorkerIDs, appointment.TypeID, 0);
                if (!string.IsNullOrEmpty(returnmsg))
                {
                    ModelState.AddModelError(string.Empty, returnmsg);
                }
                else
                {
                    appointment.AppointmentId = SaveAppointment(appointment);
                    if (printapp)
                        appointment.PrintAppointmentID = appointment.AppointmentId;
                }
            }

            return Json(new[] { appointment }.ToDataSourceResult(request, ModelState), JsonRequestBehavior.AllowGet);
        }
        public ActionResult AppointmentOfficeCreate([DataSourceRequest] DataSourceRequest request, AppointmentViewModel appointment, string ClientIDs, string WorkerIDs)
        {
            if (appointment != null && ModelState.IsValid)
            {
                //add this line to make start date always the same as end day 
                //we are use the start day with kendo datepicker
                //appointment.End = appointment.Start;
                bool printappt = appointment.AutoPrint;
                if (appointment.IsAllDay)
                {
                    appointment.Start = DateTime.Parse(appointment.Start.Month.ToString() + "/" + appointment.Start.Day.ToString() + "/" + appointment.Start.Year.ToString() + " 08:00");
                    appointment.End = appointment.Start.AddHours(9);
                }

                string message = GetOccupiedReturnMessage(appointment.Start, appointment.End, ClientIDs, WorkerIDs, appointment.TypeID, 0);
                if (!string.IsNullOrEmpty(message))
                {
                    ModelState.AddModelError(string.Empty, message);
                }
                else
                {
                    appointment.AppointmentId = SaveAppointment(appointment);
                    if (printappt)
                        appointment.PrintAppointmentID = appointment.AppointmentId;
                }
            }

            return Json(new[] { appointment }.ToDataSourceResult(request, ModelState), JsonRequestBehavior.AllowGet);
        }
        public ActionResult AppointmentClientCreate([DataSourceRequest] DataSourceRequest request, AppointmentViewModel appointment, string ClientIDs, string WorkerIDs)
        {
            //var appt = appointment;
            if (appointment != null && ModelState.IsValid)
            {
                //add the selected episode
                bool printappt = appointment.AutoPrint;
                if (appointment.IsAllDay)
                {
                    appointment.Start = DateTime.Parse(appointment.Start.Month.ToString() + "/" + appointment.Start.Day.ToString() + "/" + appointment.Start.Year.ToString() + " 08:00");
                    appointment.End = appointment.Start.AddHours(9);
                }
                if (appointment.SelectedClients == null && appointment.EpisodeId > 0)
                {
                    List<int> epIds = new List<int>() { appointment.EpisodeId };
                    appointment.SelectedClients = GetEpisodesBYID(epIds.ToArray(), appointment.AppointmentId);
                }

                //add this line to make start date always the same as end day 
                //we are use the start day with kendo datepicker             
                string message = GetOccupiedReturnMessage(appointment.Start, appointment.End, ClientIDs, WorkerIDs, appointment.TypeID, 0);
                if (!string.IsNullOrEmpty(message))
                {
                    ModelState.AddModelError(string.Empty, message);
                }
                else
                {
                    appointment.AppointmentId = SaveAppointment(appointment);
                    if (printappt)
                        appointment.PrintAppointmentID = appointment.AppointmentId;
                }
            }

            return Json(new[] { appointment }.ToDataSourceResult(request, ModelState), JsonRequestBehavior.AllowGet);

        }
        public List<AppointmentViewModel> GetAllAppts(int StaffID, int LocationID, int EpisodeID, int ApptTID, DateTime StartDate, DateTime EndDate)
        {
            if (LocationID == 0 && EpisodeID == 0 && ApptTID == 0 && StaffID == 0)
                return new List<AppointmentViewModel>();

            var Parms = new List<ParameterInfo>{
            new ParameterInfo { ParameterName= "StartDate", ParameterValue= StartDate },
            new ParameterInfo { ParameterName = "EpisodeID", ParameterValue = EpisodeID },
            new ParameterInfo { ParameterName = "StaffID", ParameterValue = StaffID },
            new ParameterInfo { ParameterName = "LocationID", ParameterValue = LocationID },
            new ParameterInfo { ParameterName = "AppointmentTraceId", ParameterValue = ApptTID },
            new ParameterInfo { ParameterName = "EndDate", ParameterValue = EndDate }};
            var query = SqlHelper.GetRecords<AppointmentList>("spGetAppointmentList", Parms);
            List<AppointmentViewModel> results = new List<AppointmentViewModel>();
            if (query != null && query.Count() > 0)
            {
                foreach (var item in query)
                {
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    List<ActivePATSUser> apptStaffs = string.IsNullOrEmpty(item.ApptStaff) ? new List<ActivePATSUser>() : serializer.Deserialize<List<ActivePATSUser>>(item.ApptStaff);
                    List<ApptClient> apptClients = string.IsNullOrEmpty(item.ApptClient) ? new List<ApptClient>() : serializer.Deserialize<List<ApptClient>>(item.ApptClient);
                    string cdcr = string.Empty;
                    if (apptClients.Count() >0)
                        cdcr=string.Join(";", apptClients.Select(s => s.CDCRNumber).ToArray());

                    var staffname = string.Empty;
                    if (apptStaffs != null && apptStaffs.Count() > 0)
                    {
                        staffname = string.Join(";", apptStaffs.Select(s => s.StaffName).ToArray());                      
                        foreach (var staff in apptStaffs)
                        {
                            if (staff.StaffId == CurrentUser.UserID)
                                staff.IsCurrentUser = true;
                        }
                    }

                    List<SelectListItem> apptADAEC = item.ADAECs == null ? new List<SelectListItem>() : serializer.Deserialize<List<SelectListItem>>(item.ADAECs);

                    results.Add(new AppointmentViewModel
                    {
                        AppointmentId = item.AppointmentId,
                        AppointmentTraceId = item.AppointmentTraceID,
                        End = item.EndDate,
                        EndTime = item.EndDate,
                        Start = item.StartDate,
                        StartTime = item.StartDate,
                        TypeID = item.TypeID,
                        IsAllDay = item.IsAllDay,
                        IsCompleted = item.IsCompleted,
                        ProcessStatus = item.ProcessStatus,
                        SelectedClients = apptClients,
                        SelectedStaffs = apptStaffs,
                        SelectedStaffNames = staffname,
                        SelectedADAItems = apptADAEC,
                        Title = cdcr,
                        CellColor = item.EvtTCellColor,
                        TypeDesc = item.EvtTShortDescr,
                        Eventstatus = item.ApptShortDescr,
                        StatusID = item.StatusID,
                        SelectedLocationId = item.LocationId,
                        SelectedLocationDesc = item.LocationDesc,
                        Description = item.Note,
                        StaffIds = apptStaffs.Select(s => s.StaffId).ToArray(),
                        CanEdit = this.CanEdit,
                        ClientLocationId = item.ClientLocationID,
                        EpisodeId = EpisodeID
                    });
                }
            }
            return results;
        }
        public ActionResult HierarchyBinding_Appt([DataSourceRequest] DataSourceRequest request, int AppointmentTraceId)
        {
            List<ApptHistory> appts = GetApptDetailList(AppointmentTraceId);
            return Json(appts.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }
        public List<ApptHistory> GetApptDetailList(int AppointmentTraceId)
        {
            if (AppointmentTraceId == 0)
                return new List<ApptHistory>();

            var Parms = new List<ParameterInfo> {
                new ParameterInfo { ParameterName="StartDate", ParameterValue=DateTime.Now},
                new ParameterInfo { ParameterName="EpisodeID", ParameterValue=0},
                new ParameterInfo { ParameterName="StaffID", ParameterValue=0},
                new ParameterInfo { ParameterName="LocationID", ParameterValue=0},
                new ParameterInfo { ParameterName="AppointmentTraceId", ParameterValue=AppointmentTraceId},
                new ParameterInfo { ParameterName="EndDate", ParameterValue=DateTime.Now}
            };
            return SqlHelper.GetRecords<ApptHistory>("spGetAppointmentList", Parms);
           // return result;
        }
        #region All update function start here
        public ActionResult AppointmentUpdate([DataSourceRequest] DataSourceRequest request, AppointmentViewModel appointment, int StaffID, string ClientIDs, string WorkerIDs)
        {
            if (appointment != null && ModelState.IsValid)
            {
                int oldAppointmentId = 0;
                bool printappt = appointment.AutoPrint;
                DateTime retDate = appointment.Start;
                //add this line to make start date always the same as end day 
                //we are use the start day with kendo datepicker
                //appointment.End = appointment.Start;
                if (appointment.IsAllDay)
                {
                    appointment.Start = DateTime.Parse(appointment.Start.Month.ToString() + "/" + appointment.Start.Day.ToString() + "/" + appointment.Start.Year.ToString() + " 08:00");
                    appointment.End = appointment.Start.AddHours(9);
                }
                string returnmsg = GetOccupiedReturnMessage(appointment.Start, appointment.End, ClientIDs, WorkerIDs, appointment.TypeID, appointment.AppointmentTraceId);
                if (!string.IsNullOrEmpty(returnmsg))
                {
                    ModelState.AddModelError(string.Empty, returnmsg);
                }
                else
                {
                    if (appointment.AppointmentTraceId > 0)
                    {
                        retDate = IsTheSameDay(appointment.AppointmentTraceId, appointment.Start);
                        if (retDate != appointment.Start)
                        {
                            oldAppointmentId = appointment.AppointmentId;
                            appointment.AppointmentId = 0;
                            appointment.AppointmentTraceId = 0;
                            if (DateTime.Compare(appointment.Start, DateTime.Today) > 0)
                            {
                                appointment.SelectedClients.Each(e => e.ClientStatus = 2);
                            }
                        }
                    }
                    appointment.AppointmentId = SaveAppointment(appointment);
                    if (printappt)
                    {
                        appointment.PrintAppointmentID = appointment.AppointmentId;
                    }
                    if (oldAppointmentId > 0)
                    {
                        DateTime EndDate = retDate.AddHours(24);
                        List<AppointmentViewModel> events = GetAllAppts(StaffID, 0, 0, 0, retDate, EndDate.Date);
                        if (events.Count() > 0 && appointment.PrintAppointmentID > 0)
                        {
                            events[0].PrintAppointmentID = appointment.PrintAppointmentID;
                        }
                        return Json(events.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
                    }
                }
            }
            return Json(new[] { appointment }.ToDataSourceResult(request, ModelState), JsonRequestBehavior.AllowGet);
        }
        public virtual JsonResult AppointmentDestroy([DataSourceRequest] DataSourceRequest request, AppointmentViewModel appointment)
        {
            if (ModelState.IsValid)
            {
                int apptId = appointment.AppointmentTraceId;
                DeleteAppointment(apptId);
            }

            return Json(new[] { appointment }.ToDataSourceResult(request, ModelState), JsonRequestBehavior.AllowGet);
        }
        public ActionResult AppointmentLocationUpdate([DataSourceRequest] DataSourceRequest request, AppointmentViewModel appointment, int StaffID, string ClientIDs, string WorkerIDs)
        {
            int oldAppointmentId = 0;
            DateTime retDate = appointment.Start;
            var printapp = appointment.AutoPrint;
            if (appointment != null && ModelState.IsValid)
            {
                //add this line to make start date always the same as end day 
                //we are use the start day with kendo datepicker
                //appointment.End = appointment.Start;
                if (appointment.IsAllDay)
                {
                    appointment.Start = DateTime.Parse(appointment.Start.Month.ToString() + "/" + appointment.Start.Day.ToString() + "/" + appointment.Start.Year.ToString() + " 08:00");
                    appointment.End = appointment.Start.AddHours(9);
                }
                string returnmsg = GetOccupiedReturnMessage(appointment.Start, appointment.End, ClientIDs, WorkerIDs, appointment.TypeID, appointment.AppointmentTraceId);
                if (!string.IsNullOrEmpty(returnmsg))
                {
                    ModelState.AddModelError(string.Empty, returnmsg);
                }
                else
                {
                    if (appointment.AppointmentTraceId > 0)
                    {
                        retDate = IsTheSameDay(appointment.AppointmentTraceId, appointment.Start);
                        if (retDate != appointment.Start)
                        {
                            oldAppointmentId = appointment.AppointmentId;
                            appointment.AppointmentId = 0;
                            appointment.AppointmentTraceId = 0;
                            if (DateTime.Compare(appointment.Start, DateTime.Today) > 0)
                            {
                                appointment.SelectedClients.Each(e => e.ClientStatus = 2);
                            }
                        }
                    }
                    appointment.AppointmentId = SaveAppointment(appointment);
                    if (printapp)
                    {
                        appointment.PrintAppointmentID = appointment.AppointmentId;
                    }
                    if (oldAppointmentId > 0)
                    {
                        DateTime EndDate = retDate.AddHours(24);
                        List<AppointmentViewModel> events = GetAllAppts(StaffID, 0, 0, 0, retDate, EndDate.Date);
                        if (events.Count() > 0 && appointment.PrintAppointmentID > 0)
                        {
                            events[0].PrintAppointmentID = appointment.PrintAppointmentID;
                        }
                        return Json(events.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
                    }
                }
            }
            return Json(new[] { appointment }.ToDataSourceResult(request, ModelState), JsonRequestBehavior.AllowGet);
        }
        public virtual JsonResult AppointmentLocationDestroy([DataSourceRequest] DataSourceRequest request, AppointmentViewModel appointment)
        {
            if (ModelState.IsValid)
            {
                int apptId = appointment.AppointmentTraceId;
                DeleteAppointment(apptId);
            }

            return Json(new[] { appointment }.ToDataSourceResult(request, ModelState), JsonRequestBehavior.AllowGet);
        }
        public ActionResult AppointmentOfficeUpdate([DataSourceRequest] DataSourceRequest request, AppointmentViewModel appointment, int LocationID, string ClientIDs, string WorkerIDs)
        {
            var appt = appointment;
            int oldAppointmentId = 0;
            DateTime retDate = appointment.Start;
            bool printappt = appointment.AutoPrint;
            if (appointment != null && ModelState.IsValid)
            {
                //add this line to make start date always the same as end day 
                //we are use the start day with kendo datepicker
                //appointment.End = appointment.Start;
                if (appt.IsAllDay)
                {
                    appt.Start = DateTime.Parse(appt.Start.Month.ToString() + "/" + appt.Start.Day.ToString() + "/" + appt.Start.Year.ToString() + " 08:00");
                    appt.End = appt.Start.AddHours(9);
                }
                string message = GetOccupiedReturnMessage(appt.Start, appt.End, ClientIDs, WorkerIDs, appointment.TypeID, appt.AppointmentTraceId);
                if (!string.IsNullOrEmpty(message))
                {
                    ModelState.AddModelError(string.Empty, message);
                }
                else
                {
                    if (appointment.AppointmentTraceId > 0)
                    {
                        retDate = IsTheSameDay(appointment.AppointmentTraceId, appointment.Start);
                        if (retDate != appointment.Start)
                        {
                            oldAppointmentId = appointment.AppointmentId;
                            appointment.AppointmentId = 0;
                            appointment.AppointmentTraceId = 0;
                            if (DateTime.Compare(appointment.Start, DateTime.Today) > 0)
                            {
                                appointment.SelectedClients.Each(e => e.ClientStatus = 2);
                            }
                        }
                    }
                    appointment.AppointmentId = SaveAppointment(appt);
                    if (printappt)
                        appointment.PrintAppointmentID = appointment.AppointmentId;
                    if (oldAppointmentId > 0)
                    {
                        DateTime EndDate = retDate.AddHours(24);
                        List<AppointmentViewModel> events = GetAllAppts(0, LocationID, 0, 0, retDate, EndDate.Date);
                        if (events.Count() > 0 && appointment.PrintAppointmentID > 0)
                        {
                            events[0].PrintAppointmentID = appointment.PrintAppointmentID;
                        }
                        return Json(events.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
                    }
                }
            }
            return Json(new[] { appointment }.ToDataSourceResult(request, ModelState), JsonRequestBehavior.AllowGet);
        }
        public virtual JsonResult AppointmentOfficeDestroy([DataSourceRequest] DataSourceRequest request, AppointmentViewModel appointment)
        {
            if (ModelState.IsValid)
            {
                int apptId = appointment.AppointmentTraceId;
                DeleteAppointment(apptId);
            }

            return Json(new[] { appointment }.ToDataSourceResult(request, ModelState), JsonRequestBehavior.AllowGet);
        }
        public ActionResult AppointmentClientUpdate([DataSourceRequest] DataSourceRequest request, AppointmentViewModel appointment, int EpisodeID, string ClientIDs, string WorkerIDs)
        {
            //add this line to make start date always the same as end day 
            //we are use the start day with kendo datepicker
            //appointment.End = appointment.Start;
            int oldAppointmentId = 0;
            DateTime retDate = appointment.Start;
            bool printappt = appointment.AutoPrint;
            if (appointment != null && ModelState.IsValid)
            {
                if (appointment.IsAllDay)
                {
                    appointment.Start = DateTime.Parse(appointment.Start.Month.ToString() + "/" + appointment.Start.Day.ToString() + "/" + appointment.Start.Year.ToString() + " 08:00");
                    appointment.End = appointment.Start.AddHours(9);
                }
                string message = GetOccupiedReturnMessage(appointment.Start, appointment.End, ClientIDs, WorkerIDs, appointment.TypeID, appointment.AppointmentTraceId);
                if (!string.IsNullOrEmpty(message))
                {
                    ModelState.AddModelError(string.Empty, message);
                }
                else
                {
                    if (appointment.AppointmentTraceId > 0)
                    {
                        retDate = IsTheSameDay(appointment.AppointmentTraceId, appointment.Start);
                        if (retDate != appointment.Start)
                        {
                            oldAppointmentId = appointment.AppointmentId;
                            appointment.AppointmentId = 0;
                            appointment.AppointmentTraceId = 0;
                            if (DateTime.Compare(appointment.Start, DateTime.Today) > 0)
                            {
                                appointment.SelectedClients.Each(e => e.ClientStatus = 2);
                            }
                        }
                    }
                    appointment.AppointmentId = SaveAppointment(appointment);
                    if (printappt)
                    {
                        appointment.PrintAppointmentID = appointment.AppointmentId;
                    }
                    if (oldAppointmentId > 0)
                    {
                        DateTime EndDate = retDate.AddHours(24);
                        List<AppointmentViewModel> events = GetAllAppts(0, 0, EpisodeID, 0, retDate, EndDate.Date);
                        if (events.Count() > 0 && appointment.PrintAppointmentID > 0)
                        {
                            events[0].PrintAppointmentID = appointment.PrintAppointmentID;
                        }
                        return Json(events.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
                    }
                }
            }
            return Json(new[] { appointment }.ToDataSourceResult(request, ModelState), JsonRequestBehavior.AllowGet);
        }
        public virtual JsonResult AppointmentClientDestroy([DataSourceRequest] DataSourceRequest request, AppointmentViewModel appointment)
        {
            if (ModelState.IsValid)
            {
                int apptId = appointment.AppointmentTraceId;
                DeleteAppointment(apptId);
            }

            return Json(new[] { appointment }.ToDataSourceResult(request, ModelState), JsonRequestBehavior.AllowGet);
        }
        private string GetOccupiedReturnMessage(DateTime StartDate, DateTime EndDate, string ClientIds, string StaffIds, int TypeID, int ApptTraceID)
        {
            var parameters = new Dapper.DynamicParameters();
            parameters.Add("@StartDate", StartDate, dbType: DbType.DateTime);
            parameters.Add("@EndDate", EndDate, dbType: DbType.DateTime);
            parameters.Add("@Staffs", StaffIds, dbType: DbType.String);
            parameters.Add("@Clients", ClientIds, dbType: DbType.String);
            parameters.Add("@TypeID", TypeID, dbType: DbType.Int32);
            parameters.Add("@AppointmentTraceID", ApptTraceID, dbType: DbType.Int32);
            parameters.Add("@retMessage", "", dbType: DbType.String, direction: ParameterDirection.Output);

            string result = SqlHelper.ExecuteOutputParam("spCheckOccupied", parameters);
            string retmsg = parameters.Get<string>("retMessage");
            if (!string.IsNullOrEmpty(retmsg))
                {
                retmsg = retmsg.Replace("||", Environment.NewLine);
                retmsg = retmsg.Replace("|", " ");
                if (retmsg != "Must select one client.")
                    retmsg = retmsg + Environment.NewLine + "Time slot has been occupied.";
            }
            return retmsg;
            
        }
        private int SaveAppointment(AppointmentViewModel appt)
        {
            if (appt != null)
            {
                var actionStatus = appt.AppointmentId == 0 ? (int)ACTION_STATUS.New : (int)ACTION_STATUS.Update;

                //Find out if the appointment status need to be changed
                //if (appt.StatusID == 3 || appt.StatusID == 5)
                //{
                //    var statuscount = 0;
                //    if (appt.SelectedClients != null && appt.SelectedClients.Count() > 0)
                //    {
                //        foreach (var item in appt.SelectedClients)
                //        {
                //            if (item.ClientStatus == (int)CLIENT_STATUS.Canceled)
                //            {
                //                statuscount++;
                //            }
                //        }
                //    }
                    //if (appt.SelectedClients != null && appt.SelectedClients.Count() == statuscount)
                    //{
                    //    appt.StatusID = 3;
                    //}
                //}
                var query = string.Format(@"DECLARE @AppointmentTraceID int = {0} 
                                INSERT INTO dbo.Appointment([AppointmentTraceID],[AppointmentGUID],[TypeID],[StatusID],[IsAllDay],[IsCompleted],[StartDate],[EndDate],[Note],[ActionStatus],[ActionBy],[DateAction],[ActionModel],[ADAECIDs],[ComplexId]) 
                                    VALUES(@AppointmentTraceID,NEWID(), {1},{2}, {3},{4},{5},{6},{7},{8},{9},GetDate(),'Appt',{10},{11})   
                            DECLARE @AppointmentID int = @@IDENTITY 
                            IF @AppointmentTraceID = 0 
                                BEGIN  
                                    UPDATE dbo.Appointment SET AppointmentTraceID = @AppointmentID WHERE AppointmentID = @AppointmentID 
                                    INSERT INTO [dbo].[AppointmentTrace]([AppointmentTraceID],[AppointmentID]) VALUES (@AppointmentID, @AppointmentID) 
                                END 
                            ELSE 
                                BEGIN 
                                    UPDATE dbo.AppointmentTrace Set AppointmentID = @AppointmentID WHERE AppointmentTraceID = @AppointmentTraceID 
                                END ", appt.AppointmentTraceId, appt.TypeID, appt.StatusID, (appt.IsAllDay ? 1 : 0),(appt.IsCompleted ? 1 : 0),
                                (appt.IsAllDay ? "'" + appt.Start + "'" : "'" + DateTime.Parse(appt.Start.Month.ToString() + "/" + appt.Start.Day.ToString() + "/" + appt.Start.Year.ToString() + " " + appt.StartTime.Hour.ToString() + ":" + appt.StartTime.Minute.ToString()) + "'"),
                                (appt.IsAllDay ? "'" + appt.End + "'" : "'" + DateTime.Parse(appt.End.Month.ToString() + "/" + appt.End.Day.ToString() + "/" + appt.End.Year.ToString() + " " + appt.EndTime.Hour.ToString() + ":" + appt.EndTime.Minute.ToString()) + "'"), 
                                (string.IsNullOrEmpty(appt.Description) ? "null" : "'" + RemoveUnprintableChars(appt.Description) + "'"), actionStatus, CurrentUser.UserID, 
                                (string.IsNullOrEmpty(appt.SelectedADAIds) ? "null" : "'" + appt.SelectedADAIds + "'"), appt.SelectedLocationId);
                
                    //insert to appointment With client
                    if (appt.SelectedClients != null && appt.SelectedClients.Count() > 0)
                    {
                        foreach (var item in appt.SelectedClients)
                        {
                             var query1 = string.Format(@" INSERT INTO [dbo].[AppointmentWithClient]([AppointmentID],[EpisodeID],[ClientEventStatus],[ActionStatus],[ActionBy],[DateAction]) VALUES(@AppointmentID,{0},{1},{2},{3},GetDate()) ", 
                                          item.EpisodeID, (appt.StatusID == 3 ? 5 : item.ClientStatus), actionStatus, CurrentUser.UserID);
                              query = query + query1;
                            if (appt.TypeID == 12 || appt.TypeID == 13 || appt.TypeID == 14)
                            {
                                string note = appt.Start.ToString("MM /dd/yyyy hh:mm tt") + "-" + appt.EndTime.ToString("hh:mm tt");
                           
                                var query2 = string.Format(@" DECLARE @ReEntryIMHSID int = (SELECT ISNULL(ReEntryIMHSID, 0) FROM EpisodeTrace WHERE EpisodeID = {0}) 
                                   IF @ReEntryIMHSID = 0 
                                     BEGIN 
                                       INSERT INTO [dbo].[CaseReEntryIMHS]([EpisodeID],[UrgentNextAppointmentNote],[IntermediateNextAppointmentNote],[RoutineNextAppointmentNote],[ActionStatus],[ActionBy],[DateAction]) 
                                            VALUES ({0},{1},{2},{3},1,{4},GetDate())  
                                       UPDATE dbo.EpisodeTrace Set @ReEntryIMHSID = @@IDENTITY WHERE EpisodeID={0} 
                                     END 
                                   ELSE 
                                     BEGIN 
                                      DECLARE @ApptTypeID int = {4}  
                                     IF @ApptTypeID = 12 
                                         UPDATE [dbo].[CaseReEntryIMHS] SET [UrgentNextAppointmentNote] = {1} WHERE ID= @ReEntryIMHSID 
                                     ELSE IF @ApptTypeID = 13 
                                         UPDATE [dbo].[CaseReEntryIMHS] SET [IntermediateNextAppointmentNote] = {2} WHERE ID= @ReEntryIMHSID ELSE IF @ApptTypeID = 14 
                                     UPDATE [dbo].[CaseReEntryIMHS] SET [RoutineNextAppointmentNote] = {3} WHERE ID= @ReEntryIMHSID END ", item.EpisodeID, 
                                     (appt.TypeID == 12 ? ("'" + note + "'") : "null"), (appt.TypeID == 13 ? ("'" + note + "'") : "null"), 
                                     (appt.TypeID == 14 ? ("'" + note + "'") : "null"), appt.TypeID);
                                query = query + query2;
                            }
                        }
                    }
                    //insert to appointment With staff
                    if (appt.SelectedStaffs.Count() > 0)
                    {
                        foreach (var item in appt.SelectedStaffs)
                        {
                            var query3 = string.Format(@" INSERT INTO [dbo].[AppointmentWithStaff]([AppointmentID],[StaffID],[ActionStatus],[ActionBy],[DateAction]) VALUES(@AppointmentID,{0},{1},{2},GetDate()) ", item.StaffId, actionStatus, CurrentUser.UserID);
                            query = query + query3;
                        }
                    }
                query = query + " SELECT @AppointmentID ";
                appt.AppointmentId = SqlHelper.ExecuteQueryWithReturnValue(query);
            }
            return appt.AppointmentId; //appt.AppointmentTraceId;
        }
        #endregion All update function stop
        private DateTime IsTheSameDay(int Apptraceid, DateTime ApptDay)
        {
            var query = string.Format(@"SELECT StartDate, 0 AS ParoleLocationID FROM dbo.Appointment WHERE AppointmentID = (SELECT AppointmentID FROM dbo.AppointmentTrace WHERE AppointmentTraceID = {0})", Apptraceid);
            var sdate = SqlHelper.ExecuteCommands<ClientMinInfo>(query).SingleOrDefault().StartDate;
            
            TimeSpan diff1 = sdate - DateTime.Today;
            TimeSpan diff2 = ApptDay - DateTime.Today;
            return (diff1.Days == diff2.Days) ? ApptDay : sdate;
        }
        public JsonResult GetAllApptComplex(string text)
        {
            var offices = GetComplexes().Where(x=>x.ComplexID != -9999).ToList();
            if (!string.IsNullOrEmpty(text))
            {
                offices = offices.Where(x => x.ComplexDesc.Contains(text)).ToList();
            }

            return Json(offices.OrderBy(o => o.ComplexDesc), JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetEpisodeList(string text)
        {
            var parms = new List<ParameterInfo> {
                new ParameterInfo { ParameterName = "SearchStr", ParameterValue = text },
                new ParameterInfo { ParameterName = "EpisodeIDs", ParameterValue = null },
                new ParameterInfo { ParameterName = "AppointmentID", ParameterValue = 0 }
            };
            var results = SqlHelper.GetRecords<ApptClient>("spGetApptClientList", parms);

            return Json(results, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetAvailability(DateTime StartDate, DateTime EndDate, string ClientIds, string StaffIds)
        {
            if (StartDate == EndDate)
                EndDate = StartDate.AddMinutes(30);
            var Parms = new List<ParameterInfo> {
                new ParameterInfo { ParameterName = "StartDate", ParameterValue=StartDate },
                new ParameterInfo { ParameterName = "EndDate", ParameterValue=EndDate },
                new ParameterInfo { ParameterName = "Staffs", ParameterValue=StaffIds },
                new ParameterInfo { ParameterName = "Clients", ParameterValue=ClientIds },
            };
            List<SelectListItem> result = new List<SelectListItem>();
            var query = SqlHelper.GetRecords<AppointmentAvailabilityList>("spGetAvailabilityList", Parms);

            if (query != null && query.Count() > 0)
            {
                int count = 1;
                foreach (var item in query)
                {
                    if (item.StartDate != item.EndDate)
                    {
                        result.Add(new SelectListItem
                        {
                            Value = count.ToString(),
                            Text = item.StartDate + "-" + item.EndDate
                        });

                        count++;
                    }
                }
            }
            else
                result.Add(new SelectListItem { Value = "1", Text = "No Availability Found." });

            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetADAECDescription()
        {
            var query = @"SELECT ID AS Value, ADAECDescription As Text FROM dbo.tlkpADAOrEC WHERE ISNULL(Disabled, 0) = 0 Order BY DisplayOrder";
            var results = SqlHelper.ExecuteCommands<SelectListItem>(query);
            //= db.ADAOrEC_lkups.Where(x => x.Disabled == null).OrderBy(o => o.DisplayOrder).Select(s => new SelectListItem { Value = s.ID.ToString(), Text = s.ADAECDescription }).ToList();
            return Json(results, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetPOCOfficeLocationByPerson([DataSourceRequest] DataSourceRequest request, int StaffId, DateTime StartDate, DateTime EndDate)
        {
            List<ApptPOCOffice> locations = new List<ApptPOCOffice>();
            if (StartDate == EndDate)
                EndDate = StartDate.AddHours(24);

            var query = string.Format(@"select distinct t1.ComplexID AS LocationId, t4.ComplexDesc AS OfficeName, t4.CountyID, t5.Name AS CountyName from dbo.Appointment t1 
INNER JOIN dbo.AppointmentTrace t2 on t1.AppointmentTraceID= t2.AppointmentTraceID 
Inner Join AppointmentWithStaff t3 ON t1.AppointmentID = t3.AppointmentID 
INNER JOIN dbo.tlkpLocation t4 ON t1.ComplexId = t4.ComplexID
INNER JOIN dbo.tlkpCounty t5 ON t4.CountyID = t5.CountyID
WHERE t1.ActionStatus <> 10 and startdate >= '{0}' AND EndDate <= '{1}' AND StaffID = {2} AND ISNULl(t5.Disabled,0)=0", 
          StartDate, EndDate, StaffId);
            var results = SqlHelper.ExecuteCommands<ApptPOCOffice>(query);

            if (results == null || results.FirstOrDefault() == null )
                results = new List<ApptPOCOffice> { new ApptPOCOffice
                {
                    CountyId = 0,
                    CountyName = "No County",
                    LocationId = 0,
                    OfficeName = "NA"
                }};

            return Json(results.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetEventTypes()
        {
            List<ApptEventType> eventStatus = null;
            var query = @"SELECT ID, EvtTShortDescr, ShowCDCRNum FROM dbo.tlkpAppointmentType WHERE ISNULl(Disabled, 0)=0 ORDER BY EvtTShortDescr";
            eventStatus = SqlHelper.ExecuteCommands<ApptEventType>(query);
            return Json(eventStatus, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetEventStatus()
        {
            List<SelectListItem> eventStatus = null;
            var query = @"SELECT ID AS Value, ApptShortDescr AS Text FROM dbo.tlkpAppointmentStatus WHERE ISNULl(Disabled, 0)=0 ORDER BY ApptShortDescr";
            eventStatus = SqlHelper.ExecuteCommands<SelectListItem>(query);
            return Json(eventStatus, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetSelectedStaffs(int AppointmentId, int StaffId)
        {
            var selectedStaffs = new List<ActivePATSUser>();
            var query = string.Format(@"IF EXISTS(SELECT 1 FROM dbo.AppointmentWithStaff WHERE AppointmentID = {0}) 
                 BEGIN
                 SELECT StaffID AS StaffId, (SELECT Name From dbo.fn_GetAsstUserName(StaffID))StaffName, {1} AS IsCurrentUser FROM dbo.AppointmentWithStaff WHERE AppointmentID = {0} 
                 END 
                 ELSE BEGIN
                 IF {2} > 0 SELECT UserID AS StaffId, (SELECT Name From dbo.fn_GetAsstUserName(UserID))StaffName, {1} AS IsCurrentUser FROM dbo.[User] WhERE UserID = {2} END", AppointmentId, (CurrentUser.UserID == StaffId ? 1 : 0), StaffId);

            var results = SqlHelper.ExecuteCommands<ActivePATSUser>(query);
            if (results != null && results.Count() > 0)
                selectedStaffs = results;

            return Json(selectedStaffs, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetPOCOfficeStaff([DataSourceRequest] DataSourceRequest request, int LocationId, DateTime StartDate, DateTime EndDate)
        {
            var staffs = new List<ActivePATSUser>();
            if (LocationId > 0)
            {
                if (StartDate == EndDate)
                {
                    EndDate = StartDate.AddHours(24);
                }
                staffs = GetPatsStaff(StartDate, EndDate, LocationId, 0);
                if (staffs == null || staffs.FirstOrDefault() == null)
                {
                    staffs.Add(new ActivePATSUser
                    {
                        LocationId = 0,
                        ComplexId = 0,
                        StaffId = 0,
                        StaffName = "NA",
                        IsCurrentUser = false
                    });
                }
            }
            return Json(staffs.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetSelectedEpisodes(int AppointmentId)
        {
            List<ApptClient> selectedClients = new List<ApptClient>();

            if (AppointmentId > 0)
            {
                selectedClients = GetEpisodesBYID(null, AppointmentId);
            }

            return Json(selectedClients, JsonRequestBehavior.AllowGet);
        }
        public List<ApptClient> GetEpisodesBYID(int[] Values, int AppointmentID)
        {
            List<ApptClient> list = new List<ApptClient>();
            var Parms = new List<ParameterInfo> {
                new ParameterInfo { ParameterName="SearchStr", ParameterValue=null },
                new ParameterInfo { ParameterName="EpisodeIDs", ParameterValue=null },
                new ParameterInfo { ParameterName="AppointmentID", ParameterValue=AppointmentID }
            };
            return SqlHelper.GetRecords<ApptClient>("spGetApptClientList", Parms); 
        }
        public JsonResult GetAllOffices(string text)
        {
            var query = @"SELECT DISTINCT t1.ComplexID, t1.ComplexDesc As OfficeName,t1.CountyId, t2.Name AS CountyName 
                            FROM dbo.tlkpLocation t1 INNER JOIN tlkpCounty t2 ON t1.CountyId = t2.CountyID 
                           WHERE ISNULL(t1.Disabled, 0)=0 ORDER BY ComplexDesc";
            var results = SqlHelper.ExecuteCommands<ApptPOCOffice>(query);

            if (!string.IsNullOrEmpty(text))
                results = results.Where(x => x.OfficeName.ToUpper().Contains(text.ToUpper())).ToList();
            return Json(results, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetApptStaffs(string text)
        {
            var list = GetPatsStaff(null, null, null, -1).OrderBy(o => o.StaffName).ToList();
            if (!string.IsNullOrEmpty(text))
                list = list.Where(x => x.StaffName.ToUpper().Contains(text.ToUpper())).ToList();
            return Json(list, JsonRequestBehavior.AllowGet);
        }
        public FileResult PrintStaffAppts(int StaffID, string StartDT)
        {
            DateTime SDT = Convert.ToDateTime(StartDT);
            DateTime EDT = SDT.AddHours(24);
            List<AppointmentViewModel> events = GetAllAppts(StaffID, 0, 0, 0, SDT.Date, EDT.Date);
            List<ApptActivityInfo> infoList = new List<ApptActivityInfo>();
            if (events.Count() > 0)
            {
                foreach (var item in events)
                {
                    ApptActivityInfo info = new ApptActivityInfo();
                    if (item.SelectedClients != null && item.SelectedClients.Count() > 0)
                    {
                        if (item.Eventstatus == "Canceled" || item.Eventstatus == "Excused")
                            continue;

                        foreach (var it in item.SelectedClients)
                        {
                            info.ClientName = it.ClientName;
                            info.Unit = it.Unit;
                            info.FollowupAppt = string.IsNullOrEmpty(it.FollowupAppt.Trim()) ? "" : it.FollowupAppt.Substring(0, 16);
                            info.StartTime = item.StartTime.ToString("hh:mm tt");
                            info.EndTime = item.EndTime.ToString("hh:mm tt");
                            info.CDCRNum = it.CDCRNumber;
                            info.Location = item.SelectedLocationDesc;
                            info.ApptType = item.TypeDesc;
                            info.ApptStatus = item.Eventstatus;
                            info.ContactPh = it.ContactPh;
                            infoList.Add(info);
                            info = new ApptActivityInfo();
                        }
                    }
                    else
                    {
                        info.ClientName = "";
                        info.Unit = "";
                        info.FollowupAppt = "";
                        info.StartTime = item.StartTime.ToString("hh:mm tt");
                        info.EndTime = item.EndTime.ToString("hh:mm tt");
                        info.CDCRNum = item.CDCRNum;
                        info.Location = item.SelectedLocationDesc;
                        info.ApptType = item.TypeDesc;
                        info.ApptStatus = item.Eventstatus;
                        info.ContactPh = "";
                        infoList.Add(info);
                    }
                }

            }

            ActivePATSUser user = GetPatsStaff(null,null,null, -1).Where(x=>x.StaffId == StaffID).FirstOrDefault();
            var title = string.Format("{0:ddd MM/dd/yyyy}   {1} - {2}", SDT, user.StaffName, "Case Worker");
            PrintPATSPDF ppdf = new PrintPATSPDF();
            Byte[] bytes = ppdf.GenerateAppointmentStream(CurrentUser.UserLFI(), title, infoList);
            return File(bytes, "pdf", "Appointment.pdf");
        }
        public FileResult PrintParoleeAppts(int EpisodeID, string StartDT)
        {
            DateTime SDT = Convert.ToDateTime(StartDT);
            DateTime EDT = SDT.AddHours(24);
            List<AppointmentViewModel> events = GetAllAppts(0, 0, EpisodeID, 0, SDT.Date, EDT.Date);
            List<ApptActivityInfo> infoList = new List<ApptActivityInfo>();
            if (events.Count() > 0)
            {
                foreach (var item in events)
                {
                    ApptActivityInfo info = new ApptActivityInfo();
                    ApptClient client = item.SelectedClients.Where(w => w.EpisodeID == EpisodeID).FirstOrDefault();
                    string status = "Pending";
                    switch (client == null ? 0 : client.ClientStatus)
                    {
                        case 1: status = "Absent"; break;
                        case 3: status = "Present"; break;
                        case 4: status = "Excused"; break;
                        case 5: status = "Canceled"; break;
                    }
                    info.StaffName = item.SelectedStaffNames;
                    info.Unit = client == null ? "" : client.Unit;
                    info.FollowupAppt = (client == null ? "" : client.FollowupAppt);
                    info.StartTime = item.StartTime.ToString("hh:mm tt");
                    info.EndTime = item.EndTime.ToString("hh:mm tt");
                    info.Location = item.SelectedLocationDesc;
                    info.ApptType = item.TypeDesc;
                    info.ApptStatus = status;
                    info.ContactPh = client.ContactPh;
                    infoList.Add(info);
                    info = new ApptActivityInfo();
                }
            }
            else
            {
                ApptActivityInfo info = new ApptActivityInfo
                {
                    StaffName = "",
                    Unit = "",
                    FollowupAppt = "",
                    StartTime = "",
                    EndTime = "",
                    Location = "",
                    ApptType = "",
                    ApptStatus = "",
                    ContactPh = ""
                };
                infoList.Add(info);
            }
            ApptClient clientinfo = events[0].SelectedClients.Where(w => w.EpisodeID == EpisodeID).FirstOrDefault();
            var title = string.Format("{0:ddd MM/dd/yyyy}  {1}#{2} {3}", SDT, "Parolee: ", clientinfo.CDCRNumber, clientinfo.ClientName);
            PrintPATSPDF ppdf = new PrintPATSPDF();
            Byte[] bytes = ppdf.GenerateParoleAppointmentStream(CurrentUser.UserLFI(), title, infoList);
            return File(bytes, "pdf", "ClientAppointment.pdf");
        }
        public ActionResult PrintNotice(string EventId)
        {
            string filePath = WebConfigurationManager.AppSettings["PMHSTemplateFileDir"];
            string TemplateFile = Path.Combine(filePath, "AppointmentNotice.pdf");
            var parms = new List<ParameterInfo> {
                 new ParameterInfo {ParameterName="AppointmentID", ParameterValue=EventId }
            };
            var notices = SqlHelper.GetRecords<Notice>("spGetApptNotice", parms);
            string filename = "Group";
            //creat notice pdf
            MemoryStream outputStream = new MemoryStream();
            try
            {
                using (iTextSharp.text.Document document = new iTextSharp.text.Document())
                {
                    using (PdfSmartCopy copy = new PdfSmartCopy(document, outputStream))
                    {
                        document.Open();
                        int counter = 0;

                        foreach (var values in notices)
                        {
                            ++counter;
                            Dictionary<string, string> dictionary = GetParameters(values, (int)ControllerID.Appointment);
                            PdfReader reader = new PdfReader(TemplateFile);
                            using (var ms = new MemoryStream())
                            {
                                using (PdfStamper pdfStamper = new PdfStamper(reader, ms))
                                {
                                    AcroFields acroFields = pdfStamper.AcroFields;
                                    foreach (var key in acroFields.Fields.Keys)
                                    {
                                        if (key.Contains("Text10"))
                                            continue;
                                        acroFields.SetField(key, dictionary[key]);
                                    }
                                    pdfStamper.FormFlattening = true;
                                }
                                reader = new PdfReader(ms.ToArray());
                                copy.AddPage(copy.GetImportedPage(reader, 1));
                            }
                        }

                        if (counter == 1)
                        {
                            filename = notices[0].CDCRNum + "_" + notices[0].ParoleName.Split(',')[0];
                        }
                    }
                }
            }
            catch (IOException ex)
            {
                //RedirectToAction("Error", "Home");
                return null;
            }
            // return File(outputStream.ToArray(), "pdf", "eventNotice.pdf");
            return File(outputStream.ToArray(), "pdf", filename + "_"  + "EventNotice.pdf");
        }
        private void DeleteAppointment(int AppointmentTraceId)
        {
            List<ParameterInfo> parameters = new List<ParameterInfo> {
                { new ParameterInfo() { ParameterName = "AppointmentTraceID", ParameterValue = AppointmentTraceId } } };

            var result = SqlHelper.ExecuteQuery("spDeleteAppointment", parameters);
        }
    }  
}