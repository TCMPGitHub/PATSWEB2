using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using IdentityManagement.DAL;
using PATSWebV2.ViewModels.Client;
using PATSWebV2.ViewModels.DSM;
using PATSWebV2.DataAccess;
using IdentityManagement.Entities;
using System.IO;
using IdentityManagement.Data;
using Kendo.Mvc.UI;
using Kendo.Mvc.Extensions;
using PATSWebV2.ViewModels.SocialWork;
using System.Web.Script.Serialization;
using IdentityManagement.Entities.SocialWork;
using System.Text.RegularExpressions;
using PATSWebV2.ViewModels.Psychiatry;
using IdentityManagement.Entities.Psychiatry;
using PATSWebV2.ViewModels.Evaluation;
using PATSWebV2.ViewModels.LegalDocument;
using PATS.Models.HelperModels;
using System.Web.Configuration;
using iTextSharp.text.pdf;

namespace PATSWebV2.Controllers
{
    public enum ETHNIC_BACKGROUND
    {
        ASIAN = 1,
        AFRICAN_AMERICAN = 3,
        WHITE = 4,
        HISPANIC = 5,
        AMERICAN_INDIAN = 6,
        OTHER = 7
    }
    public enum GenderID
    {
        Female = 1,
        Male,
        Trans,
        Unknown = 99
    }
    public enum LEVELCARE
    {
        None = 1,   // or Not Specified
        EOP,
        CCCMS,
        MedNecessity
    }
    public enum MH_L_STATUS
    {
        MHNone = 1,      //Not Specified
        EOP,             //Enhanced Outpatient Program
        CCCMS,           //Correctional Clinical Case Management System
        MedNec,          //Medical Necessity
        REMOVED,
        EOPToCCCMS,
        CCCMSToEOP
    }
    public enum MHSTATUS
    {
        WNL = 1,
        ABNORMAL
    }
    public enum ATTENDANCE_MEMEBER
    {
        Clinical_Social_Worker = 1,
        Psychologist,
        Psychiatrist,
        Case_Manager,
        Parole_Agent,
        Parolee,
        Other
    }
    [RoutePrefix("Client")]
    [ValidateInput(false)]
    public class ClientController : PATSBassController
    {
        public bool CanEditClient
        {
            get { return (CurrentUser.IsPOCAdmin || CurrentUser.IsPOCPsychiatrist || CurrentUser.IsPOCPsychologist || CurrentUser.IsPOCSocialWorker || CurrentUser.IsPOCCaseManager); }
        }
        public bool CanEditSW
        {
            get { return (CurrentUser.IsPOCAdmin || CurrentUser.IsPOCPsychologist || CurrentUser.IsPOCSocialWorker || CurrentUser.IsPOCCaseManager); }
        }
        public bool CanEditPsychi
        {
            get { return (CurrentUser.IsPOCAdmin || CurrentUser.IsPOCPsychiatrist ); }
        }
        public bool CanEditDSM
        {
            get { return (CurrentUser.IsPOCAdmin || CurrentUser.IsPOCPsychologist); }
        }
        public MvcHtmlString NoEditAllowed
        {
            get { return HttpContext.Application["NoEditAllowed"] as MvcHtmlString; }
        }
        // GET: Client
        [Route("~/Client")]
        [HttpGet]
        //[ValidateAntiForgeryToken]
        public ActionResult Index(string CDCRNum)
        {
            ViewBag.ControllerID = ControllerID.Client;
            ViewBag.CurrentUser = (ApplicationUser)Session["CurrentUser"];
            return View();
        }
        public JsonResult GetAllSearchResults(string text)
        {  
            if (string.IsNullOrEmpty(text))
            {
                return Json("", JsonRequestBehavior.AllowGet);
            }
            List<ParameterInfo> parameters = new List<ParameterInfo> { new ParameterInfo() { ParameterName = "SearchString", ParameterValue = text } };
           
            var result = SqlHelper.GetRecords<SelectListItem>("spGetEpisodeDropDownList", parameters).ToList();
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetAllOffenderEpisodes(int? EpisodeID)
        {
            if (EpisodeID < 1)
            {
                return Json("", JsonRequestBehavior.AllowGet);
            }
           List<ParameterInfo> parameters = new List<ParameterInfo> { new ParameterInfo() { ParameterName = "EpisodeID", ParameterValue = EpisodeID } };
            
            var results = SqlHelper.GetRecords<SelectListItem>("spGetOffenderEpisodes", parameters).ToList();
            return Json(results, JsonRequestBehavior.AllowGet);
        }
        
        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        public ActionResult GetEditingPane(int? selectedSearchResult)
        {
            //check to see if the log in user can add new profile
            var canEnterNew = CurrentUser.IsPOCAdmin ? true : false;
            if (selectedSearchResult == null)
            {
                if (canEnterNew)
                {
                    selectedSearchResult = -1;

                    //var episode = new Episode();
                    //episode.Offender = new Offender();
                   // int EpisodeID, int PID, string CDCRNum, bool NewEpisode
                    return RedirectToAction("GetClientProfile", "Client", new { EpisodeID = -1, PID = 0, CDCRNum = string.Empty, NewEpisode = true });
                }
                else
                    return Content("");
            }

            return PartialView("_EditingPane", GetAllSummary(selectedSearchResult.Value));
        }
        [HttpPost]
        public ActionResult GetClientSummary(int? selectedSearchResult)
        {
            if (selectedSearchResult == null)
            {
                selectedSearchResult = 0;
            }

            List<string> objList = new List<string> { "PPSummary", "CaseAssignSmy" };
            List<ParameterInfo> parameters = new List<ParameterInfo> { new ParameterInfo() { ParameterName = "EpisodeID", ParameterValue = selectedSearchResult.Value } };
            var results = SqlHelper.GetMultiRecordsets<dynamic>("spGetEpisodeSummary", parameters, objList);
            
            ////var results = PATSClientController.GetClientSummary(selectedSearchResult.Value);
            return PartialView("_ClientSummary", new ClientSummaryViewModel
            {
                ClientSummary = (PPSummary)results[0],
                Staffs = results[1] == null ? (new List<CaseAssignSmy> { new CaseAssignSmy { DateEnrolled ="", Psychiatrist = "", Psychologist= "", SocialWorker = "", Id =0 } }) : ((List<CaseAssignSmy>)results[1]).ToList(),
                CanUploadFile = CurrentUser.IsPOCAdmin || CurrentUser.IsPOCPsychologist,
                CanAddMed = CurrentUser.IsPOCPsychiatrist
            });

        }
        private EditingPaneViewModel GetAllSummary(int EpisodeID)
        {      
            List<string> objList = new List<string> { "SummaryCollection", "CaseAssignSmy", "AppointmentSummary", "ParoleLocationID" };
            List<ParameterInfo> parameters = new List<ParameterInfo>{
                new ParameterInfo { ParameterName = "EpisodeID",ParameterValue = EpisodeID }};
            var results = SqlHelper.GetMultiRecordsets<dynamic>("spGetClientSummaryList", parameters, objList).ToList();
            //var results = PATSClientController.GetAllSummary(EpisodeID);
            List<SummaryCollection> list = results[0] as List<SummaryCollection>;
            return new EditingPaneViewModel
            {
                EpisodeID = EpisodeID,
                ApptListSmy = results[2] == null ? null : ((List<AppointmentSummary>)results[2]).ToList(),
                CaseIMHSDone = false,
                AllSmy = ((List<SummaryCollection>)results[0]).ToList(),
                CaseAssignSmy = results[1] == null ? null : ((List<CaseAssignSmy>)results[1]).ToList(),
                ShowPrescription = PatsConstants.ShowPrescription
            };
        }
        #region Client Profile
        public PartialViewResult GetEditingPaneBack(int episodeID)
        {
            if (episodeID == 0)
            {
                string val = Convert.ToString(Request.Params["editepisodeid"]);
            }
            return PartialView("_EditingPane", GetAllSummary(episodeID));
        }
        [Route]
        public ActionResult GetClientProfileIndex(int EpisodeID, string ActiveTabIn, bool NewClient, bool FromCMRequested)
        {
            ModelState.Clear();
           
            return PartialView("_ClientProfileIndex", new ClientViewModel { EpisodeID = EpisodeID, ActiveTab = ActiveTabIn, NewEpisode = NewClient, CanDoASAM = CurrentUser.IsPOCAdmin || CurrentUser.IsPOCPsychologist, FromCM = FromCMRequested, EditingEnabled = true, CanEditAddress = true, CanEditHCB = true });
        }
        public ActionResult GetClientProfile(int EpisodeID, int PID, string CDCRNum, bool NewEpisode)
        {
            List<ClientProfile> selectEpisode = new List<ClientProfile>();
            List<ParameterInfo> parameters = new List<ParameterInfo>();
            parameters.Add(new ParameterInfo() { ParameterName = "EpisodeID", ParameterValue = EpisodeID });
            parameters.Add(new ParameterInfo() { ParameterName = "PID", ParameterValue = PID });
            parameters.Add(new ParameterInfo() { ParameterName = "CDCRNum", ParameterValue = CDCRNum });

            //get object list
            List<string> objlist = new List<string>();
            objlist.Add("ClientProfile");
            objlist.Add("Complex");
            objlist.Add("Ethnicity");
            objlist.Add("Gender");
            objlist.Add("SignificantOtherStatus");
            objlist.Add("CaseClosureReason");
            objlist.Add("CaseReferralSource");
            objlist.Add("ParoleMentalHealthLevelOfService");
            var results = SqlHelper.GetMultiRecordsets<object>("spGetEpisodeProfile", parameters, objlist);
            ClientProfile profile = (ClientProfile)results[0];

            return PartialView("_ClientProfileEditor", new ClientEditViewModel
            {
                AllCountys = ((List<Complex>)results[1]).ToList(),
                AllCaseClosureReasons = ((List<CaseClosureReason>)results[5]).OrderBy(o => o.CaseClosureReasonDescShort).ToList(),
                AllCaseReferrals = ((List<CaseReferralSource>)results[6]).OrderBy(o => o.CaseReferralSourceDesc).ToList(),
                AllEthnicities = ((List<Ethnicity>)results[2]).OrderBy(o => o.EthnicityDesc).ToList(),
                AllGenders = ((List<Gender>)results[3]).OrderBy(o => o.Name).ToList(),
                AllParoleMentalHealthLOfS = ((List<ParoleMentalHealthLevelOfService>)results[7]).OrderBy(o => o.ParoleMentalHealthLevelOfServiceDescShort).ToList(),
                AllSignOtherStatuses = ((List<SignificantOtherStatus>)results[4]).OrderBy(o => o.SignificantOtherStatusDesc).ToList(),
                EditingEnabled = true, // episode.HasEditPermission(CurrentUser),
                Profile = profile,
                //ActiveTab = "clientprofile",
                NewProfile = NewEpisode,
                IsLOCAdmin = (CurrentUser.IsLOCBHRAdmin.HasValue && CurrentUser.IsLOCBHRAdmin.Value == true) ? true : false,
                CanDoASAM = CurrentUser.IsPOCPsychologist || CurrentUser.IsPOCAdmin
            });
        }
        public ActionResult MatchesRead([DataSourceRequest] DataSourceRequest request, string PID, string CDCRNum)
        {
           var parms = new List<ParameterInfo> {
                new ParameterInfo { ParameterName="EpisodeID", ParameterValue=0 },
                new ParameterInfo { ParameterName="PID", ParameterValue=PID},
                new ParameterInfo { ParameterName="CDCRNum", ParameterValue=CDCRNum },
                new ParameterInfo { ParameterName="Matches", ParameterValue=true } };
            var results = SqlHelper.GetRecords<MatchClient>("spGetEpisodeProfile", parms);
            
            return Json(results.Where(x => x.EpisodeId > 0).ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public bool ValidCDCRNumber(string CDCRNum)
        {
            var query = string.Format("SELECT COUNT(*) FROM Episode WHERE CDCRNum='{0}'", CDCRNum);
            var result = SqlHelper.ExecuteQueryWithReturnValue(query);
            return result == 0;
        }
        public ActionResult ResetCaseStatus(int EpisodeID, string ChangeDate, string CloseReason, int CaseType)
        {
            var CaseBankedDate = "null";
            var CaseClosureDate = "null";
            var CaseClosureReasonCode = "null";
            var IntakeDate = "null";
            if (CaseType == 3 && (!string.IsNullOrEmpty(ChangeDate) && ChangeDate != "__/__/____"))
            {
                CaseBankedDate = "'" + ChangeDate + "'";
            }
            else if (CaseType == 2 && (!string.IsNullOrEmpty(ChangeDate) && ChangeDate != "__/__/____"))
            {
                CaseClosureDate = "'" + ChangeDate + "'";
                CaseClosureReasonCode = string.IsNullOrEmpty(CloseReason) ? "null" : "'" + CloseReason + "'";
            }
            else if (CaseType == 1 && (!string.IsNullOrEmpty(ChangeDate) && ChangeDate != "__/__/____"))
            {
                IntakeDate = "'" + ChangeDate + "'";
                CaseClosureDate = "null";
                CaseClosureReasonCode = "null";
            }
            var query = string.Format(@"DECLARE @EpisodeID int = {0}
DECLARE @ClientEpisodeID int =(SELECT ISNULL(ClientEpisodeID, 0) FROM dbo.EpisodeTrace WHERE EpisodeID = @EpisodeID) 
DECLARE @ActionStatus int = 0
IF @ClientEpisodeID = 0
BEGIN
  SET @ActionStatus =  1 
  INSERT INTO [dbo].[ClientEpisode]([EpisodeID],[IntakeDate],[CaseBankedDate],[CaseClosureDate],
             [CaseClosureReasonCode],[DateAction],[ActionBy],[ActionStatus])
     VALUES(@EpisodeID,{1},{2},{3},{4},GetDate(),{5},@ActionStatus)
	UPDATE dbo.EPisodeTrace SET ClientEpisodeID =  @@IDENTITY WHERE EpisodeID  = @EpisodeID 
END
ELSE
BEGIN
 SET @ActionStatus = 2
 DECLARE @CaseType int = {6}
 IF @CaseType =1
 UPDATE dbo.ClientEpisode SET IntakeDate = {1}, CaseBankedDate=null, CaseClosureDate=null,CaseClosureReasonCode=null, ActionStatus = @ActionStatus, 
                              ActionBy ={5} WHERE ClientEpisodeID  = @ClientEpisodeID
 ELSE IF @CaseType =2 
  UPDATE dbo.ClientEpisode SET CaseClosureDate={3},CaseClosureReasonCode={4}, CaseBankedDate=null,
  ActionStatus = @ActionStatus, ActionBy ={5} WHERE ClientEpisodeID  = @ClientEpisodeID
 ELSE IF @CaseType =3 
  UPDATE dbo.ClientEpisode SET CaseBankedDate={2},CaseClosureDate=null,CaseClosureReasonCode=null, ActionStatus = @ActionStatus, ActionBy ={5} WHERE ClientEpisodeID  = @ClientEpisodeID
END", EpisodeID, IntakeDate, CaseBankedDate, CaseClosureDate, CaseClosureReasonCode, CurrentUser.UserID, CaseType);
            var result = SqlHelper.ExecuteCommand(query);
            return RedirectToAction("GetClientProfile", new { EpisodeID = EpisodeID, PID = 0, CDCRNum = string.Empty, NewEpisode = false });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult SaveClientProfile(ClientEditViewModel submission)
        {
            if (ModelState.IsValid)
            {
                var InclusionCriteriaMet = "null";
                if (submission.Profile.InclusionCriteriaMetYes)
                    InclusionCriteriaMet = "1";
                else if(submission.Profile.InclusionCriteriaMetNo)
                    InclusionCriteriaMet = "0";

                var IsConvictedStalking = "null";
                if (submission.Profile.IsConvictedOfStalking.HasValue && submission.Profile.IsConvictedOfStalking.Value == true)
                    IsConvictedStalking = "1";
                else if (submission.Profile.IsConvictedOfStalking.HasValue && submission.Profile.IsConvictedOfStalking.Value == false)
                    IsConvictedStalking = "0";

                var query = string.Format(@"DECLARE @OffenderID int=0
	IF EXISTS(SELECT 1 FROM Offender WHERE PID={0})
	   SET @OffenderID =(SELECT OffenderID FROM Offender WHERE PID={0})
DECLARE @EpisodeID int = 0 IF EXISTS(SELECT 1 FROM dbo.Episode WHERE CDCRNum={1})  SET @EpisodeID =(SELECT EpisodeID FROM dbo.Episode WHERE CDCRNum={1})
DECLARE @Location nvarchar(50)= (CASE WHEN {2} IS null THEN '' ELSE (SELECT ISNULl(LocationDesc, '') FROM dbo.tlkpLocation WHERE LocationID={2}) END)
DECLARE @CountyID int = (CASE WHEN {13} > 0 THEN (SELECT TOP 1 CountyID FROM dbo.tlkpLocation WHERE ComplexID = {13} ) ELSE null END)
IF @OffenderID > 0
  UPDATE dbo.Offender SET FirstName ={3},LastName ={4},GenderID={5},PC290 ={6},PC457 ={7},USVet ={8},DOB={9}, SSN={10}, MiddleName={11} WHERE OffenderID=@OffenderID 
ELSE 
 BEGIN 
    INSERT INTO Offender(FirstName, LastName,GenderID,PC290, PC457,USVet, DOB,SSN, MiddleName, 
	            InitialDate,DevDisabled,PhysDisabled,PID) 
		 VALUES({3},{4},{5},{6},{7},{8},{9},{10},{11},GetDate(), 0,0,{0}) 
	SET @OffenderID = @@IDENTITY 
 END  
 IF @EpisodeID > 0
  BEGIN     
	Update Episode SET Lifer={12},ParoleUnit=@Location,ReleaseCountyID=@CountyID, ParoleLocationID = {2},ReleaseDate={14},ParoleAgent={15} 
	WHERE EpisodeID =@EpisodeID 
  END
 ELSE 
   BEGIN 
	  INSERT INTO dbo.Episode(OffenderID,InitialDate,SuggestionDate,CDCRNum,SomsUploadId, Lifer,ParoleUnit,ReleaseCountyID,ReleaseDate,ParoleAgent, ParoleLocationID) 
	       VALUES (@OffenderID, GetDate(), GetDate(),{1}, -2, {12},@Location,@CountyID,{14},{15},{2}) 
	  SET @EpisodeID=@@IDENTITY 
      UPDATE dbo.EpisodeTrace SET IsLastOne = null WHERE EpisodeID in (SELECT EpisodeID FROM Episode WHERE OffenderID = @OffenderID) 
	  INSERT INTO dbo.EpisodeTrace(EpisodeID, DateAction, IsLastOne) 
	        VALUES (@EpisodeID, GetDate(), 1) 
   END 
   DECLARE @ClientEpisodeID int = (select ISNULL(ClientEpisodeID, 0) FROM [dbo].[EpisodeTrace] WHERE EpisodeID = @EpisodeID)           
   IF @ClientEpisodeID > 0 BEGIN
     IF NOT EXISTS(SELECT * FROM [dbo].[ClientEpisode] WHERE ClientEpisodeID = @ClientEpisodeID AND ISNULL(CaseClosureDate, '')=ISNULL({16}, '')
                   AND ISNULL(IsConvictedOfStalking, -1)=ISNULl({29}, -1) AND ISNULL(Alias, '') =ISNULL({17}, '') AND ISNULL(CaseClosureReasonCode, '') = ISNULL({18}, '') 
                   AND ISNULL(CaseReferralSourceCode, '')=ISNULL({19}, '') AND ISNULL(InTakeDate, '') =ISNULL({20}, '') AND ISNULL(CaseBankedDate,'') = ISNULL({21}, '') 
                   AND ISNULL(ISMIPEnrolledDate,'') = ISNULL({22}, '') AND ISNULL(ISMIPReferredDate, '') = ISNULL({23},'') AND ISNULL(ISMIPClosedDate, '') = ISNULL({24}, '') 
                   AND ISNULL(CMProgramStartDate, '') = ISNULL({25}, '') AND ISNULL(CMProgramClosedDate, '') = ISNULL({26}, '') AND ISNULL(MATProgramStartDate, '') = ISNULL({27}, '') 
	               AND ISNULL(MATProgramClosedDate, '') = ISNULL({28}, '') AND ISNULL(InclusionCriteriaMet, 0)=ISNULL({29}, 0) AND ISNULL(CMRPEStartDate, '') =ISNULL({30}, '') 
                   AND ISNULL(CMRPEClosedDate, '') = ISNULL({31}, '') AND ISNULL(ParoleMentalHealthLevelOfServiceID, 0) =ISNULL({32}, 0) AND ISNULL(ParoleDisChargeDate, '')=ISNULL({33}, '')
	               AND ISNULL(SignificantOtherStatusCode, '') =ISNULL({34}, '') AND ISNULL(ASAMComments, '')=ISNULL({35}, '') AND ISNULL(ASAMDate, '')=ISNULL({36}, '') 
                   AND ISNULL(EthnicityId, 0) = ISNULL({37}, 0) AND ISNULL(PlaceOfBirth, '')= ISNULL({38}, '') AND ISNULL(InclusionCriteriaMet, 0) = ISNULL({39}, 0)) 
         BEGIN
     INSERT INTO [dbo].[ClientEpisode]([EpisodeID],[Alias],[IntakeDate],[CaseBankedDate],[CaseReferralSourceCode]
           ,[SignificantOtherStatusCode],[IsConvictedOfStalking],[ParoleMentalHealthLevelOfServiceID]
           ,[ReleaseCaseTypeCode],[ParoleDischargeDate],[ControllingDischargeDate],[DischargeReviewDate]
           ,[CaseClosureDate],[CSRAScore],[CompasCriminogenicNeeds],[AdditionalInformation],[CaseClosureReasonCode]
           ,[EthnicityID],[PlaceOfBirth],[DateAction],[ActionBy],[ISMIPReferredDate],[ISMIPEnrolledDate]
           ,[ISMIPClosedDate],[CMProgramStartDate],[CMProgramClosedDate],[MATProgramStartDate],[MATProgramClosedDate]
           ,[CMRPEStartDate],[CMRPEClosedDate],[ASAMDate],[InclusionCriteriaMet],[ASAMComments],[ActionStatus])
	 SELECT @EpisodeID,{17},{20},{21},{19},{34},{29},{32},[ReleaseCaseTypeCode],{33},[ControllingDischargeDate],
            [DischargeReviewDate],{16},[CSRAScore],[CompasCriminogenicNeeds],[AdditionalInformation],{18},{37}, {38},
            GetDate(),{40},{23},{22},{24},{25},{26},{27},{28},{30},{31},{36},{39},{35}, 2
	  FROM [dbo].[ClientEpisode]
	 WHERE ClientEpisodeID  = @ClientEpisodeID
      Update dbo.EpisodeTrace SET ClientepisodeID = @@IDENTITY WHERE EpisodeID = @EpisodeID END END
     ELSE BEGIN
      INSERT INTO [dbo].[ClientEpisode]([EpisodeID],[Alias],[IntakeDate],[CaseBankedDate],[CaseReferralSourceCode],[ParoleDischargeDate]
           ,[SignificantOtherStatusCode],[IsConvictedOfStalking],[ParoleMentalHealthLevelOfServiceID],[CaseClosureDate]
           ,[CaseClosureReasonCode],[EthnicityID],[PlaceOfBirth],[DateAction],[ActionBy],[ISMIPReferredDate],[ISMIPEnrolledDate]
           ,[ISMIPClosedDate],[CMProgramStartDate],[CMProgramClosedDate],[MATProgramStartDate],[MATProgramClosedDate]
           ,[CMRPEStartDate],[CMRPEClosedDate],[ASAMDate],[InclusionCriteriaMet],[ASAMComments],[ActionStatus])
	 SELECT @EpisodeID,{17},{20},{21},{19},{33},{34},{29},{32},{16},{18},{37}, {38},
            GetDate(),{40},{23},{22},{24},{25},{26},{27},{28},{30},{31},{36},{39},{35}, 2
      Update dbo.EpisodeTrace SET ClientepisodeID = @@IDENTITY WHERE EpisodeID = @EpisodeID END
     IF {32} <> 5
      BEGIN
          UPDATE [dbo].[ClinicalPMHS] SET PMHSDischargeType = -1, PMHSChangeDate = null WHERE ID = (Select PMHSID From EpisodeTrace WHere EpisodeID  = @EpisodeID) 
      END    
      SELECT @EpisodeID",
   submission.Profile.PID, "'" + submission.Profile.CDCRNumber + "'",
   submission.Profile.SelectedLocationId.HasValue ?  submission.Profile.SelectedLocationId.Value.ToString() : "null", 
   "'" + RemoveUnprintableChars(submission.Profile.FirstName) + "'", 
   "'" + RemoveUnprintableChars(submission.Profile.LastName) + "'", 
   submission.Profile.GenderID, (submission.Profile.PC290 == false ? 0 : 1),
   (submission.Profile.PC457 == false ? 0 : 1), (submission.Profile.USVet == false ? 0 : 1),
   (submission.Profile.DOB == (DateTime?)null ? "null" : "'" + submission.Profile.DOB + "'"),
   (string.IsNullOrEmpty(submission.Profile.SSN) ? @"'999-99-9999'" : "'" + submission.Profile.SSN + "'"),
   (string.IsNullOrEmpty(submission.Profile.MidName)? "null" : "'" + RemoveUnprintableChars(submission.Profile.MidName) + "'"),
   (submission.Profile.Lifer == false ? 0 : 1), 
   ((submission.Profile.ComplexId == (int?)null || submission.Profile.ComplexId == 0) ? 0 : submission.Profile.ComplexId),
   (submission.Profile.ReleaseDate == (DateTime?)null ? "null" : "'" + submission.Profile.ReleaseDate + "'"),
   (string.IsNullOrEmpty(submission.Profile.ParoleAgent) ? "null" : "'" + RemoveUnprintableChars(submission.Profile.ParoleAgent) + "'"),
   (submission.Profile.CaseClosureDate.HasValue ? "'" + submission.Profile.CaseClosureDate.Value.ToShortDateString() + "'" : "null"),
   (string.IsNullOrEmpty(submission.Profile.Alias) ? "null" : "'" + RemoveUnprintableChars(submission.Profile.Alias) + "'"),   
   ((string.IsNullOrEmpty(submission.Profile.CaseClosureReasonID) || submission.Profile.CaseClosureReasonID == "-1") ? "null" : "'" + submission.Profile.CaseClosureReasonID + "'"),
   (string.IsNullOrEmpty(submission.Profile.CaseReferral) ? "null" : "'" + submission.Profile.CaseReferral + "'"),
   (submission.Profile.InTakeDate.HasValue ? "'" + submission.Profile.InTakeDate.Value.ToShortDateString() + "'" : "null"),
   (submission.Profile.CaseBankedDate.HasValue ? "'" + submission.Profile.CaseBankedDate.Value.ToShortDateString() + "'" : "null"),
   (submission.Profile.ISMIPEnrolledDate.HasValue ? "'" + submission.Profile.ISMIPEnrolledDate.Value.ToShortDateString() + "'" : "null"),
   (submission.Profile.ISMIPReferredDate.HasValue ? "'" + submission.Profile.ISMIPReferredDate.Value.ToShortDateString() + "'" : "null"),
   (submission.Profile.ISMIPClosedDate.HasValue ? "'" + submission.Profile.ISMIPClosedDate.Value.ToShortDateString() + "'" : "null"),
   (submission.Profile.CMProgramStartDate.HasValue ? "'" + submission.Profile.CMProgramStartDate.Value.ToShortDateString() + "'" : "null"),
   (submission.Profile.CMProgramClosedDate.HasValue ? "'" + submission.Profile.CMProgramClosedDate.Value.ToShortDateString() + "'" : "null"),
   (submission.Profile.MATProgramStartDate.HasValue ? "'" + submission.Profile.MATProgramStartDate.Value.ToShortDateString() + "'" : "null"),
   (submission.Profile.MATProgramClosedDate.HasValue ? "'" + submission.Profile.MATProgramClosedDate.Value.ToShortDateString() + "'" : "null"),
   IsConvictedStalking,
   (submission.Profile.CMRPEStartDate.HasValue ? "'" + submission.Profile.CMRPEStartDate.Value.ToShortDateString() + "'" : "null"),
   (submission.Profile.CMRPEClosedDate.HasValue ? "'" + submission.Profile.CMRPEClosedDate.Value.ToShortDateString() + "'" : "null"),
   ((submission.Profile.MHLevelOfService.HasValue && submission.Profile.MHLevelOfService.Value > 0) ? submission.Profile.MHLevelOfService.Value.ToString() : "null"),
   (submission.Profile.ParoleDisChargeDate.HasValue ? "'" + submission.Profile.ParoleDisChargeDate.Value.ToShortDateString() + "'" : "null"),
   (!string.IsNullOrEmpty(submission.Profile.SignificantOtherStatus) ? "'" + submission.Profile.SignificantOtherStatus + "'" : "null"),
   (!string.IsNullOrEmpty(submission.Profile.ASAMComments) ? "'" + RemoveUnprintableChars(submission.Profile.ASAMComments) + "'" : "null"),
   (submission.Profile.ASAMDate.HasValue ? "'" + submission.Profile.ASAMDate.Value.ToShortDateString() + "'" : "null"),
   (submission.Profile.EthnicityId.HasValue ? submission.Profile.EthnicityId.Value.ToString() : "null"),
   (!string.IsNullOrEmpty(submission.Profile.POB) ? "'" + RemoveUnprintableChars(submission.Profile.POB) + "'" : "null"),
   InclusionCriteriaMet, CurrentUser.UserID);
               
                int epdId = SqlHelper.ExecuteCommands<int>(query).FirstOrDefault();
                if (epdId < 0)
                {
                    ModelState.AddModelError("Profile.CDCRNumber", "CDCR Number already assigned.");
                    Response.StatusCode = 409;
                    Response.StatusDescription = "Validation error";
                    return null;
                }

               
                return RedirectToAction("GetClientProfileIndex", new
                {
                    EpisodeId = epdId,
                    ActiveTabIn = "clientprofile",
                    NewClient = false,
                    FromCMRequested = false
                });
            }
            return PartialView("_ClientProfileEditor", submission);
        }
        [HttpGet]
        public ActionResult GetMatchCases()
        {
            return PartialView("_ClientMatchProfileList", new ClientMatchViewModel());
        }
        public JsonResult GetLocationList(int? ComplexID)
        {
            var resultlist = SqlHelper.ExecuteCommands<Location>(
                "SELECT LocationID, LocationDesc FROM tlkpLocation WHERE ComplexID= " + ComplexID.Value.ToString()).OrderBy(o => o.LocationDesc);

            return Json(resultlist, JsonRequestBehavior.AllowGet);
        }
        #region Address
        public PartialViewResult GetAddress(int EpisodeID, bool FromCMRequested)
        {
            return PartialView("_Address", new AddressEditorViewModel
            {
                EpisodeId = EpisodeID,
                CanEditAddress = true,
                FromCM = FromCMRequested
            });
        }
        public ActionResult AddressRead([DataSourceRequest] DataSourceRequest request, int EpisodeID)
        {
            if (EpisodeID == -1)
                return null;

            List<Address> addrs = GetLatestAddress(EpisodeID, 0);
            return Json(addrs.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }
        public ActionResult AddressCreate([DataSourceRequest] DataSourceRequest request, Address address)
        {
            if (address != null && ModelState.IsValid)
            {
                address.ActionStatus = "1";
                SaveAddress(address);
            }
            List<Address> addrs = GetLatestAddress(address.EpisodeID, 0);
            return Json(addrs.ToDataSourceResult(request, ModelState), JsonRequestBehavior.AllowGet);
        }
        public ActionResult AddressUpdate([DataSourceRequest] DataSourceRequest request, Address address)
        {
            if (address != null && ModelState.IsValid)
            {
                address.ActionStatus = "2";
                SaveAddress(address);
            }
            List<Address> addrs = GetLatestAddress(address.EpisodeID, 0);
            return Json(addrs.ToDataSourceResult(request, ModelState), JsonRequestBehavior.AllowGet);
        }
        public ActionResult AddressDestroy([DataSourceRequest] DataSourceRequest request, [Bind(Prefix = "models")]IEnumerable<Address> address)
        {
            if (ModelState.IsValid)
            {
                var addr = address.FirstOrDefault();
                RemoveAddress(addr.ID, addr.AddressTypeID, addr.EpisodeID);
                //address = GetLatestAddress(addr.EpisodeID, 0);
                return Json(address.ToDataSourceResult(request, ModelState), JsonRequestBehavior.AllowGet);
            }

            return Json(new[] { address }.ToDataSourceResult(request, ModelState), JsonRequestBehavior.AllowGet);
        }
        public ActionResult HierarchyBinding_Address([DataSourceRequest] DataSourceRequest request, int EpisodeID, int AddressTypeID)
        {
            List<Address> addressList = GetLatestAddress(EpisodeID, AddressTypeID);
            return Json(addressList.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }
        private int SaveAddress(Address address)
        {
            int actionstatus = address.ActionStatus == "1" ? (int)ACTION_STATUS.New : (int)ACTION_STATUS.Update;
            //create new/modify a address
            var commText = string.Format(@"INSERT INTO dbo.Address (ActionModel,ActionBy,ActionStatus,DateAction,EpisodeID,AddressDetails,
                                                     AddressTypeID,State,EffectiveDate,FacilityName,FaxNumber,Inactive,
                                                     StreetAddress,PrimaryNumber,SecondaryNumber,City,ZIPCode,LivingSituationID)
                  VALUES ('ClientProf',{0},{1},GetDate(),{2},{3},{4},{5},{6},{7},{8},{9},{10},{11},{12},{13},{14},{15})
                 IF {4} = 1 UPDATE dbo.EpisodeTrace SET AddressID=@@IDENTITY WHERE EpisodeID  ={2} ", 
                 CurrentUser.UserID, actionstatus, address.EpisodeID,
                 (string.IsNullOrEmpty(address.AddressDetails) ? "null" :"'" + RemoveUnprintableChars(address.AddressDetails) + "'"), 
                 address.AddressTypeID,("'" + address.State + "'"),("'" + address.EffectiveDate + "'"),
                 (string.IsNullOrEmpty(address.FacilityName)? "null" : "'" + RemoveUnprintableChars(address.FacilityName) + "'"),
                 (string.IsNullOrEmpty(address.FaxNumber) ? "null" : "'" + address.FaxNumber + "'"), (address.Inactive == true ? 1 : 0),
                 (string.IsNullOrEmpty(address.StreetAddress) ? "null" : "'" + RemoveUnprintableChars(address.StreetAddress) + "'"),
                 (string.IsNullOrEmpty(address.PrimaryNumber) ? "null" : "'" + address.PrimaryNumber + "'"),
                 (string.IsNullOrEmpty(address.SecondaryNumber) ? "null" : "'" + address.SecondaryNumber + "'"),
                 (string.IsNullOrEmpty(address.City) ? "null" : "'" + address.City + "'"), 
                 (string.IsNullOrEmpty(address.ZIPCode) ? "null" : "'" + address.ZIPCode + "'"),
                 (!address.AddressLivingSituationID.HasValue || address.AddressLivingSituationID == -1) ? "null" : address.AddressLivingSituationID.ToString());
            return SqlHelper.ExecuteCommand(commText);
        }
        private int RemoveAddress(int addrId, int AddressTypeID, int EpisodeID)
        {
            if (addrId > 0)
            {
                string commText = string.Format(@"Update dbo.Address SET ActionStatus = 10 WHERE ID = {0}", addrId);
                if (AddressTypeID == 1) {
                    commText = commText + string.Format(@" DECLARE @ID int = (SELECT TOP 1 ID FROM dbo.Address WHERE EpisodeID = {0} AND ID <> {1} AND AddressTypeID = 1 ORDER BY ID DESC)
                         Update EpisodeTrace Set AddressID = ISNULL(@ID, null) WHERE EpisodeID = {0}",
                        EpisodeID, addrId);
                }
                    
                return SqlHelper.ExecuteCommand(commText);
            }
            return 0;
        }
        private List<Address> GetLatestAddress(int EpisodeID, int AddressTypeID)
        {
            List<Address> addressList = new List<Address>();
            List<ParameterInfo> parameters = new List<ParameterInfo> { 
               { new ParameterInfo { ParameterName = "EpisodeID",ParameterValue = EpisodeID } },
               { new ParameterInfo { ParameterName = "AddressTypeID",ParameterValue = AddressTypeID } }
            };
            addressList = SqlHelper.GetRecords<Address>("spGetEpisodeAddress", parameters).ToList();
              
            return addressList;
        }
        public JsonResult GetAddressTypeList()
        {
            var commText = "SELECT AddressTypeID, AddressTypeDesc FROM dbo.tlkpAddressType WHERE ISNULL(Disabled, 0) <> 1";
            var resultlist = SqlHelper.ExecuteCommands<AddressType>(commText);
            return Json(resultlist, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetAddressLivingSituationList()
        {
            var commText = "SELECT AddressLivingSituationID, LivingSituationDesc FROM dbo.tlkpAddressLivingSituation WHERE ISNULL(Disabled, 0) <> 1";
            var resultlist = SqlHelper.ExecuteCommands<AddressLivingSituation>(commText);
            return Json(resultlist, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetStateList()
        {
            var commText = "SELECT State FROM dbo.tlkpState";
            var resultlist = SqlHelper.ExecuteCommands<StateEntity>(commText);
            return Json(resultlist, JsonRequestBehavior.AllowGet);
        }
        #endregion Address
        #region Alert
        public PartialViewResult GetAlerts(int EpisodeID)
        {
            List<ParameterInfo> parms = new List<ParameterInfo> {
                new ParameterInfo { ParameterName= "EpisodeID", ParameterValue =EpisodeID },
                new ParameterInfo {  ParameterName= "AlertTypeID", ParameterValue = 1 } };
            var resultlist = SqlHelper.GetRecords<ClientNote>("spGetEpisodeAlert", parms);
            return PartialView("_AlertEditor", new ClientAlertViewModel
            {
                  Alert = resultlist.FirstOrDefault(),
                  ActiveTab = "",
                  EditingEnabled = true
            });
        }
        public ActionResult SaveClientAlert(ClientAlertViewModel submission)
        {
            if (ModelState.IsValid)
            {
                var commText = string.Format(@"INSERT INTO dbo.ClientNote(EpisodeID, NoteType, NoteField, NoteOrComments, EntryDate, EntryID, ActionStatus) 
                   VALUES({0},{1},{2},{3},GetDate(),{4},{5})  UPDATE dbo.EpisodeTrace SET ClientNoteID=@@IDENTITY WHERE EpisodeID ={0}",
                 submission.Alert.EpisodeID,submission.Alert.NoteType,
                 (string.IsNullOrEmpty(submission.Alert.NoteField) ? "null" : "'" + submission.Alert.NoteField + "'" ),  
                 (string.IsNullOrEmpty(submission.Alert.NoteOrComments) ? "null" : "'" + RemoveUnprintableChars(submission.Alert.NoteOrComments) + "'"),
                 CurrentUser.UserID, (submission.Alert.ActionStatus == 0 ? 1 : 2));
                var success = SqlHelper.ExecuteCommand(commText);

                return RedirectToAction("GetClientProfileIndex", new
                {
                    EpisodeId = submission.Alert.EpisodeID,
                    ActiveTabIn = "clientalerts",
                    NewClient = false,
                    FromCMRequested = false
                });
            }
            return PartialView("_AlertEdit", submission);
        }
        #endregion Alert
        #region Health Benefit
        public ActionResult GetClientHealthCareBenefits(int EpisodeID)
        {
            return PartialView("_ClientHealthCareEditor", new ClientHealthBenefitViewModel
            {
                EpisodeId = EpisodeID,
                CanEditHCB = true
            });
        }
        public ActionResult HCBenefitRead([DataSourceRequest] DataSourceRequest request, int EpisodeID)
        {
            if (EpisodeID == -1) return null;

            List<HealthBenefit> hcbenefit = GetLatestHCBenefit(EpisodeID, 0);
            return Json(hcbenefit.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }
        public ActionResult HCBenefitDestroy([DataSourceRequest] DataSourceRequest request, [Bind(Prefix = "models")]IEnumerable<HealthBenefit> hcbenefit)
        {
            if (ModelState.IsValid && hcbenefit != null)
            {
                var data = hcbenefit.FirstOrDefault();
                var commText = string.Format("UPDATE dbo.ClientHealthCareBenefit SET ActionStatus = 10, ActionBy={0}, DateAction = GetDate() WHERE EpisodeID = {1} AND BenefitTypeID={2}", CurrentUser.UserID,
                    data.EpisodeId, data.BenefitTypeID);
                var success = SqlHelper.ExecuteCommand(commText);
            }

            return Json(new[] { hcbenefit }.ToDataSourceResult(request, ModelState), JsonRequestBehavior.AllowGet);
        }       
        public ActionResult HCBenefitCreate([DataSourceRequest] DataSourceRequest request, HealthBenefit hcbenefit)
        {
            if (hcbenefit != null && ModelState.IsValid)
            {
                SaveHCBenefit(hcbenefit);
            }
            return Json(new[] { hcbenefit }.ToDataSourceResult(request, ModelState), JsonRequestBehavior.AllowGet);
        }
        public ActionResult HCBenefitUpdate([DataSourceRequest] DataSourceRequest request, HealthBenefit hcbenefit)
        {
            if (hcbenefit != null && ModelState.IsValid)
            {
                SaveHCBenefit(hcbenefit);
            }
            return Json(new[] { hcbenefit }.ToDataSourceResult(request, ModelState), JsonRequestBehavior.AllowGet);
        }
        public ActionResult HierarchyBinding_HCBenefit([DataSourceRequest] DataSourceRequest request, int EpisodeID, int BenefitTypeID)
        {
            List<HealthBenefit> hcbenefitList = GetLatestHCBenefit(EpisodeID, BenefitTypeID);
            return Json(hcbenefitList.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }
        private void SaveHCBenefit(HealthBenefit hcbenefit)
        {
            var commText = string.Format(@"INSERT INTO dbo.ClientHealthCareBenefit(EpisodeID, BenefitTypeID, AppliedOrRefusedOnDate,
                           PhoneInterviewDate, OutcomeID, OutcomeDate, BICNum,AppliedOrRefused, IssuedOnDate, ArchivedOnDate, NoteOrComment, 
                           ActionStatus, ActionBy, DateAction) VALUES({0}, {1},{2},{3},{4},{5},{6},{7},{8},{9},{10},{11},{12}, GetDate())",
                  hcbenefit.EpisodeId,(hcbenefit.BenefitTypeID.HasValue ? hcbenefit.BenefitTypeID.ToString() : "null"),
                  (hcbenefit.AppliedOrRefusedOnDate.HasValue ? ("'" + hcbenefit.AppliedOrRefusedOnDate + "'") : "null"),
                  (hcbenefit.PhoneInterviewDate.HasValue ? ("'" + hcbenefit.PhoneInterviewDate + "'") : "null"),
                  (hcbenefit.OutcomeID.HasValue ? hcbenefit.OutcomeID.ToString() : "null"),
                  (hcbenefit.OutcomeDate.HasValue ? ("'" + hcbenefit.OutcomeDate + "'") : "null"),
                  (string.IsNullOrEmpty(hcbenefit.BICNum) ? "null" : "'" + hcbenefit.BICNum + "'"),
                  (hcbenefit.AppliedOrRefused ? 1 : 0),
                  (hcbenefit.IssuedOnDate.HasValue ? ("'" + hcbenefit.IssuedOnDate + "'") : "null"),
                  (hcbenefit.ArchivedOnDate.HasValue ? ("'" + hcbenefit.ArchivedOnDate + "'") : "null"),
                  (string.IsNullOrEmpty(hcbenefit.NoteorComment) ? "null" : "'" + RemoveUnprintableChars(hcbenefit.NoteorComment) + "'"),
                  (hcbenefit.ID > 1 ? 2 : 1),CurrentUser.UserID);
                  
            var success = SqlHelper.ExecuteCommand(commText);
        }
        private List<HealthBenefit> GetLatestHCBenefit(int EpisodeID, int BenefitTypeID)
        {
            List<ParameterInfo> parameters = new List<ParameterInfo> { 
                { new ParameterInfo() { ParameterName = "EpisodeID", ParameterValue = EpisodeID } },
                { new ParameterInfo() { ParameterName = "BenefitTypeID", ParameterValue = BenefitTypeID } } };

            var result = SqlHelper.GetRecords<HealthBenefit>("spGetEpisodeHealthBenefit", parameters).ToList();
           
            return result.OrderBy(o => o.BenefitTypeID).ThenByDescending(t => t.ID).ToList();
        }
        public JsonResult GetBenefitTypeList()
        {
            var resultlist = SqlHelper.ExecuteCommands<BenefitType>("SELECT ApplicationTypeID AS BenefitTypeID, Name FROM dbo.tlkpApplicationType WHERE ISNULl(Disabled, 0) <> 1").OrderBy(o => o.Name);
            return Json(resultlist, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetOutcomeList()
        {
            var resultlist = SqlHelper.ExecuteCommands<OutcomeType>("SELECT ApplicationOutcomeID AS OutcomeID, Name FROM dbo.tlkpApplicationOutcome").OrderBy(o => o.Name);
            return Json(resultlist, JsonRequestBehavior.AllowGet);
        }

        #endregion Health Benefit
        #region Case Note
        public ActionResult GetCaseNotes(int EpisodeId, string ActionModel)
        {
            var edit = false;
            var viewName = "_AllNote";
            if (ActionModel == "Clinic" || ActionModel == "PSY")
            {
                viewName = "_ClinicalNote";
                if (ActionModel == "PSY")
                {
                    edit = this.CanEditPsychi;
                }
                else
                {
                    edit = this.CanEditClient;
                }
            }
            
            return PartialView(viewName, new CaseNoteViewModel
            {
                EpisodeId = EpisodeId,
                CanEdit= edit,
                NoEditAllowed = (edit ? MvcHtmlString.Create("") : this.NoEditAllowed),
                ActionModel = ActionModel,
            });
        }
        public JsonResult GetCaseNoteTypeList()
        {
            var resultlist = SqlHelper.ExecuteCommands<CaseNoteType>("SELECT CaseNoteTypeId, Name FROM dbo.tlkpCaseNoteType WHERE ISNULl(Disabled, 0) <> 1").OrderBy(o => o.CaseNoteTypeId);
            return Json(resultlist, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetCaseContactMethodList()
        {
            var resultlist = SqlHelper.ExecuteCommands<CaseContactMethod>("SELECT CaseContactMethodID, ContactMethod FROM dbo.tlkpCaseContactMethod WHERE ISNULl(Disabled, 0) <> 1").OrderBy(o => o.CaseContactMethodID);
            return Json(resultlist, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public JsonResult CaseNoteCreate([DataSourceRequest] DataSourceRequest request, [Bind(Prefix = "models")]IEnumerable<CaseNoteData> cmnotes, int EpisodeId, string ActionModel)
        {
            if (cmnotes != null && ModelState.IsValid)
            {
                var noteTemp = cmnotes.FirstOrDefault();
                if (noteTemp.CaseNoteTypeId == 0)
                    ModelState.AddModelError("", "Note Type is requested.");
                else
                {
                    SaveCaseNote(noteTemp, EpisodeId, (int)ACTION_STATUS.New, ActionModel);
                }
            }
            return Json(cmnotes.ToDataSourceResult(request, ModelState), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult CaseNoteUpdate([DataSourceRequest] DataSourceRequest request, [Bind(Prefix = "models")]IEnumerable<CaseNoteData> cmnotes, int EpisodeId, string ActionModel)
        {
            if (cmnotes != null && ModelState.IsValid)
            {
                var noteTemp = cmnotes.FirstOrDefault();
                SaveCaseNote(noteTemp, EpisodeId, (int)ACTION_STATUS.Update, ActionModel);
            }
            return Json(cmnotes.ToDataSourceResult(request, ModelState), JsonRequestBehavior.AllowGet);
        }

        public ActionResult CaseNoteDestroy([DataSourceRequest] DataSourceRequest request, [Bind(Prefix = "models")]IEnumerable<CaseNoteData> cmnotes)
        {
            if (ModelState.IsValid && cmnotes != null)
            {
                var data = cmnotes.FirstOrDefault();
                var commText = string.Format("UPDATE dbo.CaseNote SET ActionStatus = 10, ActionBy={0}, DateAction = GetDate() WHERE Id = {1}", CurrentUser.UserID, data.Id);
                var success = SqlHelper.ExecuteCommand(commText);
            }

            return Json(new[] { cmnotes }.ToDataSourceResult(request, ModelState), JsonRequestBehavior.AllowGet);
        }
        public ActionResult CaseNoteRead([DataSourceRequest] DataSourceRequest request, int EpisodeId, string ActionModel)
        {
            List<CaseNoteData> casenotes = GetCaseNoteListData<CaseNoteData>(EpisodeId, 0);
            if (ActionModel == "Clinic" || ActionModel == "PSY")
                casenotes = casenotes.Where(x => x.ActionModel == ActionModel).ToList();

            return Json(casenotes.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        private void SaveCaseNote(CaseNoteData Note, int EpisodeId, int Status, string ActionModel)
        {
            if (ModelState.IsValid)
            {
                var commText = string.Format(@"INSERT INTO dbo.CaseNote(CaseNoteId, EpisodeId, CaseNoteTypeId,
                    CaseContactMethodID, Note, ActionStatus, ActionBy, DateAction, ActionModel) VALUES ({0},{1},{2},{3},{4},{5},{6}, GetDate(),{7}) 
                    DECLARE @newID int = @@IDENTITY 
                   IF {0} = 0 
                       BEGIN 
                         Update dbo.CaseNote Set CaseNoteID =@newID Where ID = @newID 
                         INSERT INTO dbo.CaseNoteTrace(CaseNoteId, NoteID) VALUES(@newID, @newID) 
                      END
                   ELSE 
                      UPDATE dbo.CaseNoteTrace SET NoteID = @newID WHERE CaseNoteId={0} ", 
                      Note.CaseNoteId, EpisodeId, Note.CaseNoteTypeId,Note.CaseContactMethodID,
                      "'" + RemoveUnprintableChars(Note.Note) + "'", Status, CurrentUser.UserID, "'" + ActionModel + "'");
                var success = SqlHelper.ExecuteCommand(commText);
            }
        }
                            
        
        public ActionResult HierarchyBinding_Note([DataSourceRequest] DataSourceRequest request, int CaseNoteId)
        {
            List<CaseNoteHistory> casenotes = GetCaseNoteListData<CaseNoteHistory>(0,CaseNoteId);
            return Json(casenotes.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }
        private List<T> GetCaseNoteListData<T>(int EpisodeID, int CaseNoteId)
        {
            //List<CaseNoteData> notes = new List<CaseNoteData>();
            List<ParameterInfo> parameters = new List<ParameterInfo> {
                { new ParameterInfo() { ParameterName = "EpisodeID", ParameterValue = EpisodeID } },
                { new ParameterInfo() { ParameterName = "CaseNoteID", ParameterValue = CaseNoteId } } };
           
           return SqlHelper.GetRecords<T>("spGetEpisodeCaseNote", parameters).ToList();
        }
        #endregion Case Note
        #region File Upload
        public PartialViewResult GetFileUpload(int EpisodeID)
        {
            var list = new SelectList(new[] {
                 new SelectListItem{ Text = "1", Value = "1"},
                 new SelectListItem{ Text = "2", Value = "2"},
                 new SelectListItem{ Text = "All", Value = "All"}
            });

            return PartialView("_ClientFileUpload", new ClientEditViewModel() {
                EpisodeId = EpisodeID, PageSize = list, EditingEnabled= this.CanEditClient
            });
        }
        public ActionResult FilesRead([DataSourceRequest] DataSourceRequest request, int EpisodeId)
        {
            List<UploadedFiles> uploadFiles = new List<UploadedFiles>();
            var query = string.Format("SELECT t1.ID, t1.FileName, (t1.FileSize/1024) AS FileSize, t1.DateAction AS UploadDate," +
                   " (t2.LastName + ', ' + t2.FirstName + ' ' + ISNULl(MiddleName,''))UploadBy FROM dbo.ClientUploadFile t1" + 
                   " INNER JOIN dbo.[User] t2 ON t1.ActionBy = t2.UserID WHERE EpisodeID = {0}", EpisodeId);
            uploadFiles = SqlHelper.ExecuteCommands<UploadedFiles>(query);
          
            return Json(uploadFiles.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult FilesDestroy([DataSourceRequest] DataSourceRequest request, UploadedFiles file)
        {
            if (file != null)
            {
                var query = string.Format("Update dbo.ClientUploadFile SET ActionStatus = 10 WHERE" +
                   " ID = {0}", file.ID);
                var success = SqlHelper.ExecuteCommand(query);
            }

            return Json(new[] { file }.ToDataSourceResult(request, ModelState));
        }

        public ActionResult SaveUploadFile(IEnumerable<HttpPostedFileBase> files, int EpisodeId)
        {
            if (files != null)
            {
                foreach (var file in files)
                {
                    //copy file to server
                    if (files != null)
                    {
                        // only use in the file name.
                        var fileName = Path.GetFileNameWithoutExtension(file.FileName) + DateTime.Now.ToString("MMddyyyyhhmm") + ".pdf";
                        var physicalPath = Path.Combine(Server.MapPath("~/PATSDoc"), fileName);
                        // The files are not actually saved in this demo
                        file.SaveAs(physicalPath);
                        var query = string.Format("INSERT INTO dbo.ClientUploadFile(EpisodeId, ActionBy, ActionStatus, DateAction, FileTypeId,FileName, FileSize) Values({0},{1},1,GetDate(),1,{2},{3})",
                       EpisodeId, CurrentUser.UserID, fileName, System.IO.File.ReadAllBytes(physicalPath).Length);
                        var success = SqlHelper.ExecuteCommand(query);
                    }
                }
            }
            // Return an empty string to signify success
            return Content("");
        }

        public ActionResult Download(int id)
        {
            var query = string.Format("SELECT ID, FileName, FileSize, DateAction, ActionBy FROM dbo.ClientUploadFile WHERE ID = {0}", id);
            var file = SqlHelper.ExecuteCommands<UploadedFiles>(query).FirstOrDefault();
            var fileName = Path.GetFileName(file.FileName);
            var physicalPath = Path.Combine(Server.MapPath("~/PATSDoc"), fileName);
            byte[] data = file.FileData;
            // TODO: Verify file existed
            if (System.IO.File.Exists(physicalPath))
            {
                // System.IO.File.Delete(physicalPath);
                data = System.IO.File.ReadAllBytes(physicalPath);
            }
            else
            {
                System.IO.File.WriteAllBytes(physicalPath, file.FileData);
                file.FileData = null;
                var query1 = string.Format("Update dbo.ClientUploadFile SET FileDate = null WHERE" +
                   " ID = {0}", file.ID);
                var success = SqlHelper.ExecuteCommand(query);
            }
            return File(data.ToArray(), "application/octet-stream", file.FileName);
        }
        #endregion File Upload
        #endregion Client Profile
        #region Social work
        public ActionResult GetSocialWork(int EpisodeID, string ActiveTabIn)
        {
            //make sure the case management object always carry episode id and programphase
            bool hasIDTT = false;
            var query = string.Format("SELECT COUNT(*) FROM dbo.ClinicalIDTT WHERE EpisodeID  = {0} AND ActionStatus <> 10", EpisodeID);
            var tt = SqlHelper.ExecuteCommands<int>(query).FirstOrDefault();
            if(tt > 0)
                hasIDTT = true;
            
            return PartialView("_SocialWork", new SocialWorkViewModel
            {
                ActiveTabIn = ActiveTabIn,
                EpisodeId = EpisodeID,
                CanEdit = CanEditSW,
                NoEditAllowed = CanEditSW ? MvcHtmlString.Create("") : this.NoEditAllowed,
                HasIDTT = hasIDTT,
                ModelAction = "Clinic"
            });
        }

        #region Case Reentry
        public ActionResult GetReEntryIMHS(int EpisodeId, int CaseReEntryIMHSID)
        {
            var reentry = GetReEntryIMHSData(EpisodeId, CaseReEntryIMHSID);
            return PartialView("_ReEntryIMHS", new ReEntryIMHSViewModel(reentry) {
                   CanEdit = this.CanEditClient,
                   NoEditAllowed = (this.CanEditClient ? MvcHtmlString.Create("") : this.NoEditAllowed),
                   EpisodeID = EpisodeId,
                   IsAdmin = CurrentUser.IsPOCAdmin
            });
        }
        private ReEntryIMHSData GetReEntryIMHSData(int EpisodeID, int caseReEntryIMHSID)
        {
            List<ParameterInfo> parms = new List<ParameterInfo> {
                { new ParameterInfo {  ParameterName= "EpisodeID", ParameterValue = EpisodeID } },
                { new ParameterInfo {  ParameterName= "CaseReEntryIMHSID", ParameterValue = caseReEntryIMHSID }} };
            ReEntryIMHSData reentry = new ReEntryIMHSData();
            reentry = SqlHelper.GetRecord<ReEntryIMHSData>("[dbo].[spGetEpisodeReEntryIMHS]", parms);
            
            return reentry;
        }
        public JsonResult GetRIMHSDateList(int EpisodeID)
        {
            var query = string.Format("DECLARE @EpisodeID int = {0} " +
                 "DECLARE @ID int = ISNULl((SELECT ReEntryIMHSID FROM EPisodeTrace WHERE EpisodeID = @EpisodeID), 0)" +
                 "IF @ID = 0" +
                 " SELECT 0 AS CaseRIMHSID, (CONVERT(NVARCHAR(15), GetDate(), 110) + '*') AS CaseReEntryDate " +
                 "ELSE " +
                   " SELECT id as CaseRIMHSID, (CONVERT(NVARCHAR(15), DateAction, 110) + " +
                   " (CASE WHEN id = @ID THEN '*' ELSE '' END)) as CaseReEntryDate " +
                   " From CaseReEntryIMHS Where EpisodeID = @EpisodeID ORDER BY DateAction DESC", EpisodeID);
            var dates = SqlHelper.ExecuteCommands<CaseReEntryDates>(query);
            return Json(dates, JsonRequestBehavior.AllowGet);
            
        }
        [HttpPost]
        public ActionResult SaveReEntryIMHS(ReEntryIMHSViewModel caseReEntryIMHSView)
        {
            if (ModelState.IsValid)
            {
                //Guid caseReentryGUID = Guid.NewGuid();
                //get the value of new level of care
                int? levelcare = (int?)null;

                var status = caseReEntryIMHSView.CaseReEntryIMHSSet.CaseReEntryID > 0 ? 2 : 1;
                
                if (caseReEntryIMHSView.CaseReEntryIMHSSet.NewLevelCareCCCMS == true)
                    levelcare = (int)LEVELCARE.CCCMS;
                if (caseReEntryIMHSView.CaseReEntryIMHSSet.NewLevelCareEOP == true)
                    levelcare = (int)LEVELCARE.EOP;
                if (caseReEntryIMHSView.CaseReEntryIMHSSet.NewLevelCareMedNecessity == true)
                    levelcare = (int)LEVELCARE.MedNecessity;

                //get the value of current level of care
                int? desccare = (int?)null;
                if (caseReEntryIMHSView.CaseReEntryIMHSSet.CurrentDESCCCCMS == true)
                    desccare = (int)LEVELCARE.CCCMS;
                if (caseReEntryIMHSView.CaseReEntryIMHSSet.CurrentDESCEOP == true)
                    desccare = (int)LEVELCARE.EOP;
                if (caseReEntryIMHSView.CaseReEntryIMHSSet.CurrentDESCNone == true)
                    desccare = (int)LEVELCARE.None;

                //get the value of mh status
                int? mhstatus = (int?)null;
                if (caseReEntryIMHSView.CaseReEntryIMHSSet.MHStatusWNL == true)
                    mhstatus = (int)MHSTATUS.WNL;
                if (caseReEntryIMHSView.CaseReEntryIMHSSet.MHStatusABWNL == true)
                    mhstatus = (int)MHSTATUS.ABNORMAL;

                var ccb = GetBoolValue(caseReEntryIMHSView.CaseReEntryIMHSSet.CommunicationBarrierYes,
                    caseReEntryIMHSView.CaseReEntryIMHSSet.CommunicationBarrierNo);

                var bnws = GetBoolValue(caseReEntryIMHSView.CaseReEntryIMHSSet.BadNewsWorriesStressYes,
                       caseReEntryIMHSView.CaseReEntryIMHSSet.BadNewsWorriesStressNo);

                var hv = GetBoolValue(caseReEntryIMHSView.CaseReEntryIMHSSet.HearingVoiceYes,
                    caseReEntryIMHSView.CaseReEntryIMHSSet.HearingVoiceNo);

                var stnt = GetBoolValue(caseReEntryIMHSView.CaseReEntryIMHSSet.SeeingThingsNotThereYes, caseReEntryIMHSView.CaseReEntryIMHSSet.SeeingThingsNotThereNo);

                var tpm = GetBoolValue(caseReEntryIMHSView.CaseReEntryIMHSSet.TakingPsychotropicMedYes,
                    caseReEntryIMHSView.CaseReEntryIMHSSet.TakingPsychotropicMedNo);

                var dsm = GetBoolValue(caseReEntryIMHSView.CaseReEntryIMHSSet.DoSupplyMedYes,
                    caseReEntryIMHSView.CaseReEntryIMHSSet.DoSupplyMedNo);

                var bmr = GetBoolValue(caseReEntryIMHSView.CaseReEntryIMHSSet.BridgeMedsRequestedYes,
                   caseReEntryIMHSView.CaseReEntryIMHSSet.BridgeMedsRequestedNo);

                var thcs = GetBoolValue(caseReEntryIMHSView.CaseReEntryIMHSSet.ThoughtsHurtingOrCommittimgSuicideYes,
                    caseReEntryIMHSView.CaseReEntryIMHSSet.ThoughtsHurtingOrCommittimgSuicideNo);

                var thse = GetBoolValue(caseReEntryIMHSView.CaseReEntryIMHSSet.ThoughtsHurtingSomeElseYes,
                    caseReEntryIMHSView.CaseReEntryIMHSSet.ThoughtsHurtingSomeElseNo);

                var tmmi = GetBoolValue(caseReEntryIMHSView.CaseReEntryIMHSSet.TakeMedicationForMedicalIssuesYes,
                    caseReEntryIMHSView.CaseReEntryIMHSSet.TakeMedicationForMedicalIssuesNo);

                var fa = GetBoolValue(caseReEntryIMHSView.CaseReEntryIMHSSet.FollowupAppointmentYes,
                    caseReEntryIMHSView.CaseReEntryIMHSSet.FollowupAppointmentNo);

                var atm = GetBoolValue(caseReEntryIMHSView.CaseReEntryIMHSSet.AllergiesToMedicationYes, caseReEntryIMHSView.CaseReEntryIMHSSet.AllergiesToMedicationNo);

                var dap = GetBoolValue(caseReEntryIMHSView.CaseReEntryIMHSSet.DrugOrAlcoholProblemYes,
                    caseReEntryIMHSView.CaseReEntryIMHSSet.DrugOrAlcoholProblemNo);

                var mhcc = GetBoolValue(caseReEntryIMHSView.CaseReEntryIMHSSet.MHChronoCompletedYes,
                    caseReEntryIMHSView.CaseReEntryIMHSSet.MHChronoCompletedNo);

                var UrgentCurrentlyPreScribedMed = GetBoolValue(caseReEntryIMHSView.CaseReEntryIMHSSet.UrgentCurrentlyPreScribedMedYes,
                    caseReEntryIMHSView.CaseReEntryIMHSSet.UrgentCurrentlyPreScribedMedNo);

                var InterMediateCurrentlyPreScribedMed = GetBoolValue(caseReEntryIMHSView.CaseReEntryIMHSSet.InterMediateCurrentlyPreScribedMedYes,
                   caseReEntryIMHSView.CaseReEntryIMHSSet.InterMediateCurrentlyPreScribedMedNo);

                var RoutineCurrentlyPreScribedMed = GetBoolValue(caseReEntryIMHSView.CaseReEntryIMHSSet.RoutineCurrentlyPreScribedMedYes,
                   caseReEntryIMHSView.CaseReEntryIMHSSet.RoutineCurrentlyPreScribedMedNo);

                var InterMediateHasMed = GetBoolValue(caseReEntryIMHSView.CaseReEntryIMHSSet.InterMediateHasMedYes, caseReEntryIMHSView.CaseReEntryIMHSSet.InterMediateHasMedNo);

                var RoutineHasMed = GetBoolValue(caseReEntryIMHSView.CaseReEntryIMHSSet.RoutineHasMedYes,
                    caseReEntryIMHSView.CaseReEntryIMHSSet.RoutineHasMedNo);

                var RoutineBridgeMedRequested = GetBoolValue(caseReEntryIMHSView.CaseReEntryIMHSSet.RoutineBridgeMedRequestedYes, caseReEntryIMHSView.CaseReEntryIMHSSet.RoutineBridgeMedRequestedNo);

                var UrgentHasMed = GetBoolValue(caseReEntryIMHSView.CaseReEntryIMHSSet.UrgentHasMedYes,
                    caseReEntryIMHSView.CaseReEntryIMHSSet.UrgentHasMedNo);

                var imbmr = GetBoolValue(caseReEntryIMHSView.CaseReEntryIMHSSet.InterMediateBridgeMedRequestedYes,
                    caseReEntryIMHSView.CaseReEntryIMHSSet.InterMediateBridgeMedRequestedNo);

                var UrgentBridgeMedRequested = GetBoolValue(caseReEntryIMHSView.CaseReEntryIMHSSet.UrgentBridgeMedRequestedYes,
                   caseReEntryIMHSView.CaseReEntryIMHSSet.UrgentBridgeMedRequestedNo);

                var HistoryMHTreatment = GetBoolValue(caseReEntryIMHSView.CaseReEntryIMHSSet.HisMHTreatmentYes, caseReEntryIMHSView.CaseReEntryIMHSSet.HisMHTreatmentNo);

                var UnApptNecessary = caseReEntryIMHSView.CaseReEntryIMHSSet.UnApptNecessary == true ? true : (bool?)null;

                var query = string.Format(@"INSERT INTO [dbo].[CaseReEntryIMHS]([EpisodeID],[Observasion],[CommunicationBarrier],[CommunicationBarrierNote]
           ,[BadNewsWorriesStress],[BadNewsWorriesStressNote],[HearingVoice],[HearingVoice_Note],[SeeingThingsNotThere],[SeeingThingsNotThereNote]
           ,[TakingPsychotropicMed],[TakingPsychotropicMedNote],[DoSupplyMed],[MedicationNumber],[LastTimeMedTakenDate]
           ,[BridgeMedsRequested],[ThoughtsHurtingOrCommittimgSuicide],[ThoughtsHurtingOrCommittimgSuicide_Note],[ThoughtsHurtingSomeElse]
           ,[ThoughtsHurtingSomeElse_Note],[ThoughtsHurtingWho],[TakeMedicationForMedicalIssues],[TakeMedicationForMedicalIssues_Note]
           ,[FollowupAppointment],[FollowupAppointmentNote],[AllergiesToMedication],[AllergiesToMedicationNote],[DrugOrAlcoholProblem]
           ,[DrugOrAlcoholProblemNote],[AcuteRemandedTo],[UrgentNextAppointmentNote],[IntermediateNextAppointmentNote]
           ,[RoutineNextAppointmentNote],[MHChronoCompleted],[NewLevelCare],[ScreeningNote],[ActionStatus],[ActionBy],[DateAction]
           ,[UrgentCurrentlyPreScribedMed],[UrgentHasMed],[UrgentBridgeMedRequested],[InterMediateCurrentlyPreScribedMed]
           ,[InterMediateHasMed],[InterMediateBridgeMedRequested],[RoutineCurrentlyPreScribedMed],[RoutineHasMed]
           ,[RoutineBridgeMedRequested],[HistoryMHTreatment],[UnApptNecessary],[MHStatue])
     VALUES
           ({0},{1},{2},{3},{4},{5},{6},{7},{8},{9},{10},{11},{12},{13},{14},{15},{16},{17},{18},{19},{20},{21},{22},{23},{24},{25},{26},{27},
            {28},{29},{30},{31},{32},{33},{34},{35},{36},{37},GetDate(),{38},{39},{40},{41},{42},{43},{44},{45},{46},{47},{48},{49})
      UPDATE dbo.EpisodeTrace Set ReEntryIMHSID = @@IDENTITY WHERE EpisodeID={0}
      DECLARE @CLEID int = (SELECT ISNULL(ClientEpisodeID,0) FROM dbo.EpisodeTrace WHERE EpisodeID ={0})
      IF @CLEID > 0 
           UPDATE dbo.ClientEpisode Set ParoleMentalHealthLevelOfServiceID = {50} WHERE EpisodeID={0}
      ELSE
      BEGIN
          INSERT INTO dbo.ClientEpisode(EpisodeID, ParoleMentalHealthLevelOfServiceID, ActionStatus, ActionBy, DateAction) VALUES({0},{50}, 1, {37}, GetDate()) 
          UPDATE dbo.EpisodeTrace Set ClientEpisodeID = @@IDENTITY WHERE EpisodeID={0}
       END",
          caseReEntryIMHSView.EpisodeID,
           (!string.IsNullOrEmpty(caseReEntryIMHSView.CaseReEntryIMHSSet.Observasion) ? "'" + RemoveUnprintableChars(caseReEntryIMHSView.CaseReEntryIMHSSet.Observasion) + "'" : "null"),
           (ccb != (bool?)null ? (ccb == true ? "1" : "0") : "null"),
           (!string.IsNullOrEmpty(caseReEntryIMHSView.CaseReEntryIMHSSet.CommunicationBarrierNote) ? "'" + RemoveUnprintableChars(caseReEntryIMHSView.CaseReEntryIMHSSet.CommunicationBarrierNote) + "'" : "null"),
           (bnws != (bool?)null ? (bnws == true ? "1" : "0") : "null"),
           (!string.IsNullOrEmpty(caseReEntryIMHSView.CaseReEntryIMHSSet.BadNewsWorriesStressNote) ? "'" + RemoveUnprintableChars(caseReEntryIMHSView.CaseReEntryIMHSSet.BadNewsWorriesStressNote) + "'" : "null"),
           (hv != (bool?)null ? (hv == true ? "1" : "0") : "null"),
           (!string.IsNullOrEmpty(caseReEntryIMHSView.CaseReEntryIMHSSet.HearingVoice_Note) ? "'" + RemoveUnprintableChars(caseReEntryIMHSView.CaseReEntryIMHSSet.HearingVoice_Note) + "'" : "null"),
           (stnt != (bool?)null ? (stnt == true ? "1" : "0") : "null"),
           (!string.IsNullOrEmpty(caseReEntryIMHSView.CaseReEntryIMHSSet.SeeingThingsNotThereNote) ? "'" + RemoveUnprintableChars(caseReEntryIMHSView.CaseReEntryIMHSSet.SeeingThingsNotThereNote) + "'" : "null"),
           (tpm != (bool?)null ? (tpm == true ? "1" : "0") : "null"),
           (!string.IsNullOrEmpty(caseReEntryIMHSView.CaseReEntryIMHSSet.TakingPsychotropicMedNote) ? "'" + RemoveUnprintableChars(caseReEntryIMHSView.CaseReEntryIMHSSet.TakingPsychotropicMedNote) + "'" : "null"),
           (dsm != (bool?)null ? (dsm == true ? "1" : "0") : "null"), (caseReEntryIMHSView.CaseReEntryIMHSSet.MedicationNumber != (int?)null ? caseReEntryIMHSView.CaseReEntryIMHSSet.MedicationNumber.ToString() : "null"),
           (caseReEntryIMHSView.CaseReEntryIMHSSet.LastTimeMedTakenDate.HasValue ? "'" + caseReEntryIMHSView.CaseReEntryIMHSSet.LastTimeMedTakenDate.Value.ToShortDateString() + "'" : "null"),
           (bmr != (bool?)null ? (bmr == true ? "1" : "0") : "null"), (thcs != (bool?)null ? (thcs == true ? "1" : "0") : "null"),
           (!string.IsNullOrEmpty(caseReEntryIMHSView.CaseReEntryIMHSSet.ThoughtsHurtingOrCommittimgSuicide_Note) ? "'" + RemoveUnprintableChars(caseReEntryIMHSView.CaseReEntryIMHSSet.ThoughtsHurtingOrCommittimgSuicide_Note) + "'" : "null"),
           (thse != (bool?)null ? (thse == true ? "1" : "0") : "null"),
           (!string.IsNullOrEmpty(caseReEntryIMHSView.CaseReEntryIMHSSet.ThoughtsHurtingSomeElse_Note) ? "'" + RemoveUnprintableChars(caseReEntryIMHSView.CaseReEntryIMHSSet.ThoughtsHurtingSomeElse_Note) + "'" : "null"),
           (!string.IsNullOrEmpty(caseReEntryIMHSView.CaseReEntryIMHSSet.ThoughtsHurtingWho) ? "'" + RemoveUnprintableChars(caseReEntryIMHSView.CaseReEntryIMHSSet.ThoughtsHurtingWho) + "'" : "null"),
           (tmmi != (bool?)null ? (tmmi == true ? "1" : "0") : "null"),
           (!string.IsNullOrEmpty(caseReEntryIMHSView.CaseReEntryIMHSSet.TakeMedicationForMedicalIssues_Note) ? "'" + RemoveUnprintableChars(caseReEntryIMHSView.CaseReEntryIMHSSet.TakeMedicationForMedicalIssues_Note) + "'" : "null"),
           (fa != (bool?)null ? (fa == true ? "1" : "0") : "null"),
           (!string.IsNullOrEmpty(caseReEntryIMHSView.CaseReEntryIMHSSet.FollowupAppointmentNote) ? "'" + RemoveUnprintableChars(caseReEntryIMHSView.CaseReEntryIMHSSet.FollowupAppointmentNote) + "'" : "null"),
           (atm != (bool?)null ? (atm == true ? "1" : "0") : "null"),
           (!string.IsNullOrEmpty(caseReEntryIMHSView.CaseReEntryIMHSSet.AllergiesToMedicationNote) ? "'" + RemoveUnprintableChars(caseReEntryIMHSView.CaseReEntryIMHSSet.AllergiesToMedicationNote) + "'" : "null"),
           (dap != (bool?)null ? (dap == true ? "1" : "0") : "null"),
           (!string.IsNullOrEmpty(caseReEntryIMHSView.CaseReEntryIMHSSet.DrugOrAlcoholProblemNote) ? "'" + RemoveUnprintableChars(caseReEntryIMHSView.CaseReEntryIMHSSet.DrugOrAlcoholProblemNote) + "'" : "null"),
           (!string.IsNullOrEmpty(caseReEntryIMHSView.CaseReEntryIMHSSet.AcuteRemandedTo) ? "'" + RemoveUnprintableChars(caseReEntryIMHSView.CaseReEntryIMHSSet.AcuteRemandedTo) + "'" : "null"),
           (!string.IsNullOrEmpty(caseReEntryIMHSView.CaseReEntryIMHSSet.UrgentNextAppointmentNote) ? "'" + RemoveUnprintableChars(caseReEntryIMHSView.CaseReEntryIMHSSet.UrgentNextAppointmentNote) + "'" : "null"),
           (!string.IsNullOrEmpty(caseReEntryIMHSView.CaseReEntryIMHSSet.IntermediateNextAppointmentNote) ? "'" + RemoveUnprintableChars(caseReEntryIMHSView.CaseReEntryIMHSSet.IntermediateNextAppointmentNote) + "'" : "null"),
           (!string.IsNullOrEmpty(caseReEntryIMHSView.CaseReEntryIMHSSet.RoutineNextAppointmentNote) ? "'" + RemoveUnprintableChars(caseReEntryIMHSView.CaseReEntryIMHSSet.RoutineNextAppointmentNote) + "'" : "null"),
           (mhcc != (bool?)null ? (mhcc == true ? "1" : "0") : "null"), (levelcare != (int?)null ? levelcare.ToString() : "null"),
           (!string.IsNullOrEmpty(caseReEntryIMHSView.CaseReEntryIMHSSet.ScreeningNote) ? "'" + RemoveUnprintableChars(caseReEntryIMHSView.CaseReEntryIMHSSet.ScreeningNote) + "'" : "null"),
           status, CurrentUser.UserID, 
           (UrgentCurrentlyPreScribedMed != (bool?)null ? (UrgentCurrentlyPreScribedMed == true ? "1" : "0") : "null"),
           (UrgentHasMed != (bool?)null ? (UrgentHasMed == true ? "1" : "0") : "null"),
           (UrgentBridgeMedRequested != (bool?)null ? (UrgentBridgeMedRequested == true ? "1" : "0") : "null"),
           (InterMediateCurrentlyPreScribedMed != (bool?)null ? (InterMediateCurrentlyPreScribedMed == true ? "1" : "0") : "null"),
           (InterMediateHasMed != (bool?)null ? (InterMediateHasMed == true ? "1" : "0") : "null"),
           (imbmr != (bool?)null ? (imbmr == true ? "1" : "0") : "null"),
           (RoutineCurrentlyPreScribedMed != (bool?)null ? (RoutineCurrentlyPreScribedMed == true ? "1" : "0") : "null"),          
           (RoutineHasMed != (bool?)null ? (RoutineHasMed == true ? "1" : "0") : "null"),
           (RoutineBridgeMedRequested != (bool?)null ? (RoutineBridgeMedRequested == true ? "1" : "0") : "null"),           
           (HistoryMHTreatment != (bool?)null ? (HistoryMHTreatment == true ? "1" : "0") : "null"),
           (UnApptNecessary != (bool?)null ? (UnApptNecessary == true ? "1" : "0") : "null"), 
           (mhstatus == (int?)null ? "null" : mhstatus.ToString()), (desccare == (int?)null ? "null" : desccare.ToString()));

                var result = SqlHelper.ExecuteCommand(query);
                return RedirectToAction("GetSocialWork", new
                {
                    EpisodeID = caseReEntryIMHSView.EpisodeID,
                    ActiveTabIn = "ReEntry"
                });
            }
            return null;
        }
        #endregion Case Reentry
        #region IRP
        public ActionResult GetIRP(int EpisodeId, int IRPID)
        {
            return PartialView("_IRP", new IRPViewModel
            {
                EpisodeID = EpisodeId,
                IRPSetList = GetIRPListData(EpisodeId, IRPID),
                ActionUserName = CurrentUser.UserLFI(),
                CanEdit = this.CanEditClient,
                NoEditAllowed = (this.CanEditClient ? MvcHtmlString.Create("") : this.NoEditAllowed)
            });
        }
        private List<IRPSet> GetIRPListData(int EpisodeID, int IRPID)
        {
            List<IRPSet> list = new List<IRPSet>();
            List<ParameterInfo> parms = new List<ParameterInfo> {
                { new ParameterInfo {  ParameterName= "EpisodeID", ParameterValue = EpisodeID } },
                { new ParameterInfo {  ParameterName= "IRPID", ParameterValue = IRPID }} };
            return SqlHelper.GetRecords<IRPSet>("spGetEpisodeIRP", parms);
        }
        public JsonResult GetIRPDateList(int EpisodeID)
        {
            var query = string.Format("DECLARE @EpisodeID int = {0} " +
                "DECLARE @ID int = (SELECT ISNULl(IRPID, 0) FROM EpisodeTrace WHERE EpisodeID = @EpisodeID) " +
                "IF @ID = 0 " +
                "SELECT 0 AS IRPID, (CONVERT(NVARCHAR(15), GetDate(), 110) + '*') AS IRPDate " +
                "ELSE " +
                  " SELECT id as IRPID, (CONVERT(NVARCHAR(15), DateAction, 110) + " +
                  " (CASE WHEN id = @ID THEN '*' ELSE '' END)) as IRPDate " +
                  " From dbo.CaseIRP Where EpisodeID = @EpisodeID AND NeedId = 1 AND ActionStatus <> 10 ORDER BY DateAction DESC", EpisodeID);
            var dates = SqlHelper.ExecuteCommands<IRPDates>(query);
            return Json(dates, JsonRequestBehavior.AllowGet);
        }
        public ActionResult SaveClinicalIRP(IRPViewModel casrIrp)
        {
            if (ModelState.IsValid)
            {
                var newid = SaveIRP(casrIrp.IRPSetList, casrIrp.EpisodeID);
                return RedirectToAction("GetSocialWork", new
                {
                    EpisodeID = casrIrp.EpisodeID,
                    ActiveTabIn = "IRP"
                });
            }
            return null; // ErrorsJson(ModelStateErrors());
        }
        private int SaveIRP(List<IRPSet> caseIRPs, int EpisodeId)
        {
            if (caseIRPs == null || caseIRPs.Count() == 0)
                return 0;

            //var currentDateTime = DateTime.Now;
            var query = string.Format("DECLARE @EpisodeID int = {0} DECLARE @IsNew int = 0 DECLARE @IRpDate DateTime = GetDate() " +
                "DECLARE @ID int = (SELECT ISNULl(IRPID,0) FROM dbo.EpisodeTrace WHERE EpisodeID = @EpisodeID) IF @ID = 0  SET @IsNew = 1 ELSE SET @IsNew = 2", EpisodeId);
            foreach (var item in caseIRPs)
            {
                var NeedStatus = (int?)null;
                if (item.NeedStatus1.HasValue && item.NeedStatus1.Value == true)
                    NeedStatus = 1;
                else if (item.NeedStatus2.HasValue && item.NeedStatus2.Value == true)
                    NeedStatus = 2;
                else if (item.NeedStatus3.HasValue && item.NeedStatus3.Value == true)
                    NeedStatus = 3;
                else if (item.NeedStatus4.HasValue && item.NeedStatus4.Value == true)
                    NeedStatus = 4;

                var LongTermStatus = (int?)null;
                if (item.LongTermStatusMet.HasValue && item.LongTermStatusMet.Value == true)
                    LongTermStatus = 1;
                else if (item.LongTermStatusNoMet.HasValue && item.LongTermStatusNoMet.Value == true)
                    LongTermStatus = 0;

                var queryIRP = string.Format(@" INSERT INTO [dbo].[CaseIRP]([EpisodeID],[NeedId],[NeedStatus],[DescriptionCurrentNeed],[Note],[ShortTermGoal],[LongTermGoal],[LongTermStatus],[LongTermStatusDate],[PlanedIntervention],[ActionStatus],[ActionBy],[DateAction]) VALUES (@EpisodeID,{0},(CASE WHEN {1} = 0 THEN null ELSE {1} END),{2},{3},{4},{5},(CASE WHEN {6} = -1 THEN null ELSE {6} END),{7},{8},@IsNew,{9},@IRpDate) ", item.NeedId, (NeedStatus == (int?)null ? 0 : NeedStatus), 
                  (string.IsNullOrEmpty(item.DescriptionCurrentNeed) ? "null" : "'" + RemoveUnprintableChars(item.DescriptionCurrentNeed) + "'"), 
                  (string.IsNullOrEmpty(item.Note) ? "null" : "'" + RemoveUnprintableChars(item.Note) + "'"),
                  (string.IsNullOrEmpty(item.ShortTermGoal) ? "null" : "'" + RemoveUnprintableChars(item.ShortTermGoal) + "'"),
                  (string.IsNullOrEmpty(item.LongTermGoal) ? "null" : "'" + RemoveUnprintableChars(item.LongTermGoal) + "'"),(LongTermStatus == (int?)null ? -1 : LongTermStatus), 
                  (item.LongTermStatusDate != (DateTime?)null ? "'" +  item.LongTermStatusDate + "'" : "null"), (string.IsNullOrEmpty(item.PlanedIntervention) ? "null" : "'" + RemoveUnprintableChars(item.PlanedIntervention) + "'"), CurrentUser.UserID);
                if (item.NeedId ==1)
                {
                    queryIRP = queryIRP + " SET @ID=@@IDENTITY ";
                }
                query = query + queryIRP;
                
            }
            query = query + " UPDATE dbo.EpisodeTrace SET IRPID=@ID WHERE EpisodeID=@EpisodeID SELECT @ID ";
            return SqlHelper.ExecuteCommands<int>(query).SingleOrDefault();
        }
        #endregion IRP
        #region MCASR
        public ActionResult GetMCASR(int EpisodeId, int MCASRID)
        {
            return PartialView("_MCASR", GetMCASRData(EpisodeId, MCASRID));
        }
        private MCASRViewModel GetMCASRData(int EpisodeID, int MCASRID)
        {
            var parms = new List<ParameterInfo> {
                new ParameterInfo { ParameterName = "EpisodeID", ParameterValue= EpisodeID },
                new ParameterInfo { ParameterName = "MCASRID", ParameterValue= MCASRID }
            };
            List<string> objlist = new List<string>();
            objlist.Add("MCASRData");
            objlist.Add("ScaleQuestion");
            var results = SqlHelper.GetMultiRecordsets<object>("spGetEpisodeMCASR", parms, objlist);
            MCASRData mcasrSet = (MCASRData)results[0];
            List<ScaleQuestion> mcasrQlist = ((List<ScaleQuestion>)results[1]).ToList();
            if (mcasrQlist != null && mcasrQlist.Count() > 0)
            {
                foreach (var item in mcasrQlist)
                {
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    item.PossibleAnswer = serializer.Deserialize<List<Anwser>>(item.Answers);
                    item.PossibleAnswer.Add(new Anwser { Answer = "Do not know", AnwserId = 0, QuestionAnwserId = 0 });
                }
            }
          
            return new MCASRViewModel
            {
                EpisodeID = EpisodeID,
                CanEdit = this.CanEditClient,
                NoEditAllowed = (this.CanEditClient ? MvcHtmlString.Create("") : this.NoEditAllowed),
                MCASRData = mcasrSet,
                Scalequestions = mcasrQlist
            };
        }
        public JsonResult GetMCASRDateList(int EpisodeID)
        {
            var query = string.Format("DECLARE @EpisodeID int = {0} " +
                "DECLARE @ID int = (SELECT ISNULl(MCASRID, 0)MCASRID FROM EpisodeTrace WHERE EpisodeID = @EpisodeID) " +
                "IF @ID = 0" +
                " SELECT 0 AS MCASRID, (CONVERT(NVARCHAR(15), GetDate(), 110) + '*') AS CaseMCASRDate " +
                "ELSE " +
                  " SELECT id as MCASRID, (CONVERT(NVARCHAR(15), DateAction, 110) + " +
                  " (CASE WHEN id = @ID THEN '*' ELSE '' END)) as CaseMCASRDate " +
                  " From dbo.CaseMCASR Where EpisodeID = @EpisodeID AND ActionStatus <> 10 ORDER BY DateAction DESC", EpisodeID);
             var dates = SqlHelper.ExecuteCommands<MCASRDates>(query);
             return Json(dates, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult SaveMCASR(MCASRViewModel view)
        {
            //TODO: Save data
            if (ModelState.IsValid)
            {
                var query = string.Format("DECLARE @Status int = 1 DECLARE @ID int = (SELECT ISNULL(MCASRID,0)MCASRID FROM dbo.EpisodeTrace WHERE EpisodeID = {0}) IF @ID > 0  SET @Status = 2 " +
                     "INSERT INTO[dbo].[CaseMCASR]([EpisodeID],[Section1Score],[Section2Score]" +
                        ",[Section3Score],[Section4Score],[Question1Anwser],[Question2Anwser]" +
                        ",[Question3Anwser],[Question4Anwser],[Question5Anwser],[Question6Anwser]" +
                        ",[Question7Anwser],[Question8Anwser],[Question9Anwser],[Question10Anwser]" +
                        ",[Question11Anwser],[Question12Anwser],[Question13Anwser],[Question14Anwser]" +
                        ",[Question15Anwser],[Question16Anwser],[Question17Anwser],[ActionStatus]" +
                        ",[ActionBy],[DateAction]) OUTPUT INSERTED.[Id] VALUES({0}, {1}, {2}, {3}, {4},{5},{6}, {7}, {8}," +
                        "{9}, {10}, {11},{12},{13},{14},{15},{16},{17},{18},{19},{20},{21},@Status,{22},GetDate()) UPDATE dbo.EpisodeTrace SET MCASRID = @@IDENTITY WHERE EpisodeID={0} ",
                        view.EpisodeID, view.MCASRData.Section1Score, view.MCASRData.Section2Score,
                        view.MCASRData.Section3Score, view.MCASRData.Section4Score,
                        view.Scalequestions[0].SelectedAnwser == null ? 0 : Convert.ToInt32(view.Scalequestions[0].SelectedAnwser),
                        view.Scalequestions[1].SelectedAnwser == null ? 0 : Convert.ToInt32(view.Scalequestions[1].SelectedAnwser),
                        view.Scalequestions[2].SelectedAnwser == null ? 0 : Convert.ToInt32(view.Scalequestions[2].SelectedAnwser),
                        view.Scalequestions[3].SelectedAnwser == null ? 0 : Convert.ToInt32(view.Scalequestions[3].SelectedAnwser),
                        view.Scalequestions[4].SelectedAnwser == null ? 0 : Convert.ToInt32(view.Scalequestions[4].SelectedAnwser),
                        view.Scalequestions[5].SelectedAnwser == null ? 0 : Convert.ToInt32(view.Scalequestions[5].SelectedAnwser),
                        view.Scalequestions[6].SelectedAnwser == null ? 0 : Convert.ToInt32(view.Scalequestions[6].SelectedAnwser),
                        view.Scalequestions[7].SelectedAnwser == null ? 0 : Convert.ToInt32(view.Scalequestions[7].SelectedAnwser),
                        view.Scalequestions[8].SelectedAnwser == null ? 0 : Convert.ToInt32(view.Scalequestions[8].SelectedAnwser),
                        view.Scalequestions[9].SelectedAnwser == null ? 0 : Convert.ToInt32(view.Scalequestions[9].SelectedAnwser),
                        view.Scalequestions[10].SelectedAnwser == null ? 0 : Convert.ToInt32(view.Scalequestions[10].SelectedAnwser),
                        view.Scalequestions[11].SelectedAnwser == null ? 0 : Convert.ToInt32(view.Scalequestions[11].SelectedAnwser),
                        view.Scalequestions[12].SelectedAnwser == null ? 0 : Convert.ToInt32(view.Scalequestions[12].SelectedAnwser),
                        view.Scalequestions[13].SelectedAnwser == null ? 0 : Convert.ToInt32(view.Scalequestions[13].SelectedAnwser),
                        view.Scalequestions[14].SelectedAnwser == null ? 0 : Convert.ToInt32(view.Scalequestions[14].SelectedAnwser),
                        view.Scalequestions[15].SelectedAnwser == null ? 0 : Convert.ToInt32(view.Scalequestions[15].SelectedAnwser),
                        view.Scalequestions[16].SelectedAnwser == null ? 0 : Convert.ToInt32(view.Scalequestions[16].SelectedAnwser),
                        CurrentUser.UserID);
                        
                var newID = SqlHelper.ExecuteCommand(query);
                //UpdateEpisodeTrace(view.EpisodeID, "MCASRID", newID);
               
                return RedirectToAction("GetSocialWork", new
                {
                    EpisodeID = view.EpisodeID,
                    ActiveTabIn = "Multnomah"
                });

            }

            return null;
        }

        #endregion MCASR
        #region Need Assessment
        public ActionResult GetNeedsAssessmentSet(int EpisodeId, int AssessmentId)
        {
            return PartialView("_NeedsAssessment", GetNeedsAssessmentSetData(EpisodeId, AssessmentId));
        }
        private AssessmentViewModel GetNeedsAssessmentSetData(int EpisodeID, int AssessmentID)
        {
            List<string> objlist = new List<string>();
            objlist.Add("NeedsAssessment");
            objlist.Add("IRP");
            List<ParameterInfo> parms = new List<ParameterInfo> {
                { new ParameterInfo {  ParameterName= "EpisodeID", ParameterValue = EpisodeID } },
                { new ParameterInfo {  ParameterName= "AssessmentID", ParameterValue = AssessmentID }} };
            var results = SqlHelper.GetMultiRecordsets<object>("spGetEpisodeNeedsAssessment", parms, objlist);
            return new AssessmentViewModel { EpisodeID = EpisodeID,
                NeedsAssessmentSet = (NeedsAssessmentData)results[0],
                CanEdit = this.CanEditClient, ActionUserName = CurrentUser.UserName,
                IRPSetList = ((List<IRPSet>)results[1]),
                NoEditAllowed = (this.CanEditClient ? MvcHtmlString.Create("") : this.NoEditAllowed) };
        }
        public JsonResult GetNeedsAssessmentDateList(int EpisodeID)
        {
            var query = string.Format("DECLARE @EpisodeID int = {0} " +
                "DECLARE @ID int = (SELECT ISNULl(NeedsAssessmentID, 0)AssessmentID FROM EpisodeTrace WHERE EpisodeID = @EpisodeID) " +
                "IF @ID = 0" +
                " SELECT 0 AS AssessmentID, (CONVERT(NVARCHAR(15), GetDate(), 110) + '*') AS AssessmentDate " +
                "ELSE " +
                  " SELECT id as AssessmentID, (CONVERT(NVARCHAR(15), DateAction, 110) + " +
                  " (CASE WHEN id = @ID THEN '*' ELSE '' END)) as AssessmentDate " +
                  " From dbo.CaseNeedsAssessment Where EpisodeID = @EpisodeID AND ActionStatus <> 10 ORDER BY DateAction DESC", EpisodeID);
            var dates = SqlHelper.ExecuteCommands<NeedsAssessmentDates>(query);
            return Json(dates, JsonRequestBehavior.AllowGet);
        }
        public ActionResult SaveNeedAssessment(AssessmentViewModel Assessment)
        {
            if (ModelState.IsValid)
            {
                var isNewIRP = Assessment.NeedsAssessmentSet.IRPID.HasValue ? false : true;
                bool needSaveIrp = false;
                List<IRPSet> currtIrpset = Assessment.IRPSetList;
                List<IRPSet> preIrpset = new List<IRPSet>();
                if (!isNewIRP)
                {
                    preIrpset = GetIRPListData(Assessment.EpisodeID, (int)Assessment.NeedsAssessmentSet.IRPID);
                    for(int item = 0; item < 15; item++)
                    {
                        if (currtIrpset[item].NeedStatus1 != preIrpset[item].NeedStatus1) { needSaveIrp = true; break; }
                        if (currtIrpset[item].NeedStatus2 != preIrpset[item].NeedStatus2) { needSaveIrp = true; break; }
                        if (currtIrpset[item].NeedStatus3 != preIrpset[item].NeedStatus3) { needSaveIrp = true; break; }
                        if (currtIrpset[item].NeedStatus4 != preIrpset[item].NeedStatus4) { needSaveIrp = true; break; }
                        if (currtIrpset[item].DescriptionCurrentNeed != preIrpset[item].DescriptionCurrentNeed) { needSaveIrp = true; break; }
                    }

                }
                int newIrpID = (int)Assessment.NeedsAssessmentSet.IRPID;
                if (isNewIRP || needSaveIrp)
                {
                    newIrpID = SaveIRP(currtIrpset, Assessment.EpisodeID);
                }
             
                //save needs assessment
                var ipn = (bool?)null;
                if (Assessment.NeedsAssessmentSet.InterpreterNeededYes.HasValue && Assessment.NeedsAssessmentSet.InterpreterNeededYes == true)
                    ipn = true;
                else if (Assessment.NeedsAssessmentSet.InterpreterNeededNo.HasValue && Assessment.NeedsAssessmentSet.InterpreterNeededNo == true)
                    ipn = false;

                var serviceneeds = (int?)null;
                if (Assessment.NeedsAssessmentSet.ServiceHighNeeds.HasValue && Assessment.NeedsAssessmentSet.ServiceHighNeeds == true)
                    serviceneeds = 1;
                else if (Assessment.NeedsAssessmentSet.ServiceModNeeds.HasValue && Assessment.NeedsAssessmentSet.ServiceModNeeds == true)
                    serviceneeds = 2;
                else if (Assessment.NeedsAssessmentSet.ServiceLowNeeds.HasValue && Assessment.NeedsAssessmentSet.ServiceLowNeeds == true)
                    serviceneeds = 3;
                var querytitle = string.Format(@"DECLARE @EpisodeID int = {0} INSERT INTO dbo.CaseNeedsAssessment(EpisodeID,MCASRScore,IRPID", Assessment.EpisodeID);
                var queryvalue = string.Format("Values(@EpisodeID,{0},{1}",  Assessment.NeedsAssessmentSet.MCASRScore,newIrpID);
                if (!string.IsNullOrEmpty(Assessment.NeedsAssessmentSet.AdditionalInformation))
                {
                    querytitle += ",AdditionalInformation";
                    queryvalue = queryvalue + ",'" + RemoveUnprintableChars(Assessment.NeedsAssessmentSet.AdditionalInformation) + "'";
                }
                if (!string.IsNullOrEmpty(Assessment.NeedsAssessmentSet.AssessmentLauguage))
                {
                    querytitle += ",AssessmentLauguage";
                    queryvalue = queryvalue + ",'" + RemoveUnprintableChars(Assessment.NeedsAssessmentSet.AssessmentLauguage) + "'";
                }
                if(ipn != (bool?)null)
                {
                    querytitle += ",InterpreterNeeded";
                    queryvalue = queryvalue + "," + (ipn == true ? 1 : 0 );
                }
                if (serviceneeds != (int?)null) {
                    querytitle += ",ServiceNeeds";
                    queryvalue = queryvalue + "," + serviceneeds;
                }
                querytitle += ",ActionStatus,ActionBy,DateAction) ";
                queryvalue = queryvalue + string.Format(",{0},{1},GetDate()) ", (Assessment.NeedsAssessmentSet.AssessmentId > 0 ? 2 : 1), CurrentUser.UserID);
                var query = querytitle + queryvalue + " UPDATE dbo.EpisodeTrace SET NeedsAssessmentID=@@IDENTITY WHERE EpisodeID=@EpisodeID ";
                //save case assessment
                int newID = SqlHelper.ExecuteCommand(query);        
              
                return RedirectToAction("GetSocialWork", new
                {
                    EpisodeId = Assessment.EpisodeID,
                    ActiveTabIn = "Assessment"
                });
            }
            return null;
        }
        #endregion Need Assessment
        #region IDTT
        public ActionResult GetClinicalIDTT(int EpisodeId, int IDTTId)
        {
            List<ParameterInfo> parms = new List<ParameterInfo> {
                { new ParameterInfo {  ParameterName= "EpisodeID", ParameterValue = EpisodeId } },
                { new ParameterInfo {  ParameterName= "IDTTID", ParameterValue = IDTTId }} };
            List<string> objlist = new List<string>();
            objlist.Add("ClinicalIDTTData");
            objlist.Add("FinalRecommendations");
            var results = SqlHelper.GetMultiRecordsets<object>("spGetEpisodeIDTT", parms, objlist);
            var idtt = (ClinicalIDTTData)results[0];
            var decisionlist = (List<FinalRecommendations>)results[1];
            MultiSelectList frList = new SelectList(decisionlist, "Id", "FinalRecommendation", "Selected");

            //get all selected attendance
            var types = from ATTENDANCE_MEMEBER s in Enum.GetValues(typeof(ATTENDANCE_MEMEBER)) select new SelectListItem { Value = ((int)s).ToString(), Text = s.ToString().Replace("_", " "), Selected = false };
            var list = types.ToList();

            if (!string.IsNullOrEmpty(idtt.MemeberAttendance))
            {
                string[] data = idtt.MemeberAttendance.Split(',');
                list.ForEach(x => x.Selected = data.Contains(x.Value));
            }
            MultiSelectList satype = new SelectList(list, "Value", "Text", "Selected");

            return PartialView("_ClinicalIDTT", new ClinicalIDTTViewModel
            {
                ClinicalIDTTSet = idtt,
                EpisodeId = EpisodeId,
                CanEdit = this.CanEditSW,
                NoEditAllowed = (this.CanEditSW ? MvcHtmlString.Create("") : this.NoEditAllowed),
                FinalIDTTDecision = frList,
                SAssignmentType = satype
            });
        }
        public JsonResult GetClinicalIDTTDateList(int EpisodeID)
        {
            var query = string.Format(@"DECLARE @EpisodeID int = {0} 
                DECLARE @ID int = (SELECT ISNULl(IDTTID, 0)IDTTID FROM EpisodeTrace WHERE EpisodeID = @EpisodeID) IF @ID = 0 SELECT 0 AS IDTTID, (CONVERT(NVARCHAR(15), GetDate(), 110) + '*') AS IDTTDate 
                  ELSE  SELECT id as IDTTID, (CONVERT(NVARCHAR(15), IDTTDate, 110) + (CASE WHEN id = @ID THEN '*' ELSE '' END)) as IDTTDate FROM (SELECT ID, IDTTDate, ROW_NUMBER() OVER (PARTITION BY IDTTDate ORDER BY ID DESC) AS RowNum FROM dbo.ClinicalIDTT WHERE EpisodeID = @EpisodeID AND ActionStatus <> 10) d WHERE d.RowNum = 1 ORDER BY ID DESC", EpisodeID);
            var dates = SqlHelper.ExecuteCommands<IDTTDates>(query);
            return Json(dates, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult SaveClinicalIDTT(ClinicalIDTTViewModel clinicalIDTT)
        {
            //remove the two types known error
            if (ModelState.ContainsKey("SAssignmentType"))
            {
                ModelState["SAssignmentType"].Errors.Clear();
            }

            if (ModelState.ContainsKey("FinalIDTTDecision"))
            {
                ModelState["FinalIDTTDecision"].Errors.Clear();
            }

            if (ModelState.IsValid)
            {
                var queryTitle = "INSERT INTO dbo.ClinicalIDTT(EpisodeID";
                var queryValue = string.Format(" Values({0}", clinicalIDTT.ClinicalIDTTSet.EpisodeId);
                if (clinicalIDTT.ClinicalIDTTSet.IDTTDate != (DateTime?)null)
                {
                    queryTitle += ",IDTTDate";
                    queryValue = queryValue + ",'" + clinicalIDTT.ClinicalIDTTSet.IDTTDate + "'";
                }
                if (!string.IsNullOrEmpty(clinicalIDTT.ClinicalIDTTSet.MemeberAttendance))
                {
                    queryTitle += ",MemeberAttendance";
                    queryValue = queryValue + ",'" + clinicalIDTT.ClinicalIDTTSet.MemeberAttendance + "'";
                }
                if (!string.IsNullOrEmpty(clinicalIDTT.ClinicalIDTTSet.OtherMemeberAttendance))
                {
                    queryTitle += ",OtherMemeberAttendance";
                    queryValue = queryValue + ",'" + RemoveUnprintableChars(clinicalIDTT.ClinicalIDTTSet.OtherMemeberAttendance) + "'";
                }
                if (!string.IsNullOrEmpty(clinicalIDTT.ClinicalIDTTSet.RecommandationForStatus))
                {
                    queryTitle += ",RecommandationForStatus";
                    queryValue = queryValue + ",'" + RemoveUnprintableChars(clinicalIDTT.ClinicalIDTTSet.RecommandationForStatus) + "'";
                }
                if (clinicalIDTT.ClinicalIDTTSet.IDTTDecision != (int?)null)
                {
                    queryTitle += ",IDTTDecision";
                    queryValue = queryValue + "," + clinicalIDTT.ClinicalIDTTSet.IDTTDecision;
                }
                queryTitle += ",ActionBy,ActionStatus,DateAction) ";
                queryValue = queryValue + string.Format(",{0},{1},GetDate()) " +
                        " Update EpisodeTrace SET IDTTID = @@IDENTITY WHERE EpisodeID = {2} ", 
                        CurrentUser.UserID, (clinicalIDTT.ClinicalIDTTSet.Id > 0 ? 2 : 1), clinicalIDTT.ClinicalIDTTSet.EpisodeId);

                var query = queryTitle + queryValue;
                int? idttd = clinicalIDTT.ClinicalIDTTSet.IDTTDecision;
                if (idttd.HasValue)
                {
                    switch (clinicalIDTT.ClinicalIDTTSet.IDTTDecision.Value)
                    {
                        case 1: case 7: idttd = (int)MH_L_STATUS.EOP; break;
                        case 2: case 6: idttd = (int)MH_L_STATUS.CCCMS; break;
                        case 4: idttd = (int)MH_L_STATUS.MHNone; break;
                        case 5: idttd = (int)MH_L_STATUS.MedNec; break;
                    }

                    if (idttd.HasValue && idttd > 0)
                    {
                        var q = string.Format("DECLARE @PMHLS int DECLARE @ClientEpisodeID int " +
                              " SELECT TOP 1 @ClientEpisodeID = ISNULl(ClientEpisodeID, 0), @PMHLS = ISNULl " +
                              "(ParoleMentalHealthLevelOfServiceID, 0) FROM CLientEpisode WHERE EpisodeID={0} " +
                              "ORDER BY ClientEpisodeID DESC IF @PMHLS <> {1}  BEGIN IF @ClientEpisodeID > 0 " +
                              "Insert INTO ClientEpisode(EpisodeID,[Alias],[IntakeDate],[CaseBankedDate]" +
                              ",[CaseReferralSourceCode],[SignificantOtherStatusCode]" +
                              ",[IsConvictedOfStalking],[ParoleMentalHealthLevelOfServiceID]" +
                              ",[ReleaseCaseTypeCode],[ParoleDischargeDate],[ControllingDischargeDate]" +
                              ",[DischargeReviewDate],[CaseClosureDate],[CSRAScore]" +
                              ",[CompasCriminogenicNeeds],[AdditionalInformation],[CaseClosureReasonCode]" +
                              ",[EthnicityID],[PlaceOfBirth],[DateAction],[ActionBy],[ISMIPReferredDate]" +
                              ",[ISMIPEnrolledDate],[ISMIPClosedDate],[CMProgramStartDate]" +
                              ",[CMProgramClosedDate],[MATProgramStartDate],[MATProgramClosedDate]" +
                              ",[CMRPEStartDate],[CMRPEClosedDate],[ASAMDate],[InclusionCriteriaMet]" +
                              ",[ASAMComments],[ActionStatus])" +
                              " SELECT {0},[Alias],[IntakeDate],[CaseBankedDate]" +
                              ",[CaseReferralSourceCode],[SignificantOtherStatusCode]" +
                              ",[IsConvictedOfStalking],[ParoleMentalHealthLevelOfServiceID]" +
                              ",[ReleaseCaseTypeCode],[ParoleDischargeDate],[ControllingDischargeDate]" +
                              ",[DischargeReviewDate],[CaseClosureDate],[CSRAScore]" +
                              ",[CompasCriminogenicNeeds],[AdditionalInformation],[CaseClosureReasonCode]" +
                              ",[EthnicityID],[PlaceOfBirth], GetDate(), {2}, [ISMIPReferredDate]" +
                              ",[ISMIPEnrolledDate],[ISMIPClosedDate],[CMProgramStartDate]" +
                              ",[CMProgramClosedDate],[MATProgramStartDate],[MATProgramClosedDate]" +
                              ",[CMRPEStartDate],[CMRPEClosedDate],[ASAMDate],[InclusionCriteriaMet]" +
                              ",[ASAMComments],2 FROM [dbo].[ClientEpisode] Where ClientEpisodeID = @ClientEpisodeID " +
                              "ELSE  INSERT INTO [dbo].[ClientEpisode](EpisodeID,[ParoleMentalHealthLevelOfServiceID]," +
                              "ActionBY, ActionStatus, DateAction) Values({0}, {1}, {2}, 1, GetDate()) " +
                              " Update EpisodeTrace SET ClientEpisodeID = @@IDENTITY WHERE EpisodeID = {0} END ", clinicalIDTT.ClinicalIDTTSet.EpisodeId, idttd, CurrentUser.UserID);
                        query = query + q;
                    }
                }
                var success = SqlHelper.ExecuteCommand(query);
                
                return RedirectToAction("GetSocialWork", new
                {
                    EpisodeId = clinicalIDTT.ClinicalIDTTSet.EpisodeId,
                    ActiveTabIn = "IDTT"
                });
            }
            return null;
        }
        #endregion IDTT
        #region PMHSProfile
        public ActionResult GetPMHProfile(int EpisodeID)
        {
            return PartialView("_PMHSProfile", new PMHProfileViewModel
            {
                EpisodeId = EpisodeID,
                PMHProfileSet = GetPMHProfileData(EpisodeID, true),
                CanEdit = this.CanEditSW,
                NoEditAllowed = (this.CanEditSW ? MvcHtmlString.Create("") : this.NoEditAllowed)
            });
        }
        private PMHProfileData GetPMHProfileData(int EpisodeId, bool NeedFacility)
        {
            var Parms = new List<ParameterInfo>{
                  new ParameterInfo { ParameterName = "EpisodeID", ParameterValue = EpisodeId }, 
                  new ParameterInfo { ParameterName = "NeedFacility", ParameterValue = NeedFacility } };
            return  SqlHelper.GetRecords<PMHProfileData>("spGetEpisodePMHProfile", Parms).FirstOrDefault();
        }
        public ActionResult SavePMHProfile(PMHProfileViewModel viewmodel)
        {
            if (ModelState.IsValid)
            {
                var profileData = viewmodel.PMHProfileSet;
                var SignificantOtherStatusCode = "";
                var EthnicityID = 0;
                var CaseReferralSourceCode = "";
                //marital status
                if (profileData.Married)
                    SignificantOtherStatusCode = "M";
                else if (profileData.Single)
                    SignificantOtherStatusCode = "N";
                else if (profileData.Separated)
                    SignificantOtherStatusCode = "S";
                else if (profileData.Divorced)
                    SignificantOtherStatusCode = "D";
                else if (profileData.Cohabitating)
                    SignificantOtherStatusCode = "O";
                else if (profileData.DomesticPartner)
                    SignificantOtherStatusCode = "P";
                else if (profileData.Widowed)
                    SignificantOtherStatusCode = "W";

                if (profileData.Asian)
                    EthnicityID = (int)ETHNIC_BACKGROUND.ASIAN;
                else if (profileData.White)
                    EthnicityID = (int)ETHNIC_BACKGROUND.WHITE;
                else if (profileData.AfricanAmerican)
                    EthnicityID = (int)ETHNIC_BACKGROUND.AFRICAN_AMERICAN;
                else if (profileData.AmericanIndian)
                    EthnicityID = (int)ETHNIC_BACKGROUND.AMERICAN_INDIAN;
                else if (profileData.Hispanic)
                    EthnicityID = (int)ETHNIC_BACKGROUND.HISPANIC;
                else if (profileData.Other)
                    EthnicityID = (int)ETHNIC_BACKGROUND.OTHER;
                else
                    EthnicityID = 0;

               if (profileData.Prison)
                    CaseReferralSourceCode = "I";
                else if (profileData.CountyJail)
                    CaseReferralSourceCode = "J";
                else if (profileData.CourtWalkover)
                    CaseReferralSourceCode = "W";
                else if (profileData.ReleaseTypeNone)
                    CaseReferralSourceCode = null;

              

                string ddp = string.Empty;
                if (profileData.NCF)
                    ddp = "NCF";
                else if (profileData.NDD)
                    ddp = "NDD";
                else if (profileData.DD0)
                    ddp = "DD0";
                else if (profileData.DD1)
                    ddp = "DD1";
                else if (profileData.DD2)
                    ddp = "DD2";
                else if (profileData.DD3)
                    ddp = "DD3";
                else if (profileData.DDPNone)
                    ddp = "NON";

                var query = string.Format(@"DECLARE @ClientEpisodeID int = (SELECT ISNULl(ClientEpisodeID, 0) FROM EpisodeTrace WHERE EpisodeID = {0})
                IF @ClientEpisodeID > 0 
                BEGIN   
                  IF NOT EXISTS(SELECT [SignificantOtherStatusCode],[CSRAScore],[EthnicityID],[DischargeReviewDate],[CONTROLLINGDISCHARGEDATE],[COMPASCRIMINOGENICNEEDS],[AdditionalInformation],[CaseReferralSourceCode]
                              FROM dbo.ClientEpisode WHERE EpisodeID={0} AND ClientEpisodeID=@ClientEpisodeID AND ISNULL([SignificantOtherStatusCode],'')=ISNULL({1},'') AND ISNULL([CSRAScore],0)=ISNULL({2},0) AND 
                                 ISNULL([EthnicityID],0)={3} AND ISNULL([DischargeReviewDate],'')=ISNULL({4},'') AND ISNULL([CONTROLLINGDISCHARGEDATE],'')=ISNULL({5},'') AND 
                                 ISNULl([COMPASCRIMINOGENICNEEDS],'')=ISNULL({6},'') AND ISNULl([AdditionalInformation],'')=ISNULL({7},'') AND ISNULL([CaseReferralSourceCode],'')=ISNULL({8},''))
                   BEGIN
                     INSERT INTO dbo.ClientEpisode([EpisodeID],[Alias],[IntakeDate],[CaseBankedDate],[ParoleMentalHealthLevelOfServiceID],
                      [IsConvictedOfStalking],[ReleaseCaseTypeCode],[ParoleDischargeDate],[CaseClosureDate],[CaseClosureReasonCode],[SignificantOtherStatusCode],
                      [PlaceOfBirth],[CSRAScore],[EthnicityID],[ISMIPReferredDate],[ISMIPEnrolledDate],[ISMIPClosedDate],[CMProgramStartDate],[CMProgramClosedDate],
                      [MATProgramStartDate],[MATProgramClosedDate],[CMRPEStartDate],[CMRPEClosedDate],[ASAMDate],[InclusionCriteriaMet],[ASAMComments],[DischargeReviewDate],
                      [CONTROLLINGDISCHARGEDATE],[COMPASCRIMINOGENICNEEDS],[AdditionalInformation],[CaseReferralSourceCode],[ActionBy],[DateAction],[ActionStatus])
                     SELECT {0},[Alias],[IntakeDate],[CaseBankedDate],[ParoleMentalHealthLevelOfServiceID],[IsConvictedOfStalking],[ReleaseCaseTypeCode],
                      [ParoleDischargeDate],[CaseClosureDate],[CaseClosureReasonCode],{1},[PlaceOfBirth],{2},{3},
                      [ISMIPReferredDate],[ISMIPEnrolledDate],[ISMIPClosedDate],[CMProgramStartDate],[CMProgramClosedDate],[MATProgramStartDate],
                      [MATProgramClosedDate],[CMRPEStartDate],[CMRPEClosedDate],[ASAMDate],[InclusionCriteriaMet],[ASAMComments],{4},{5},{6},{7},{8},{9},GetDate(),2 
                      FROM dbo.ClientEpisode WHERE EpisodeID ={0} AND ClientEpisodeID=@ClientEpisodeID
                     UPDATE EpisodeTrace SET ClientEpisodeID = @@IDENTITY WHERE EpisodeID = {0} 
                  END
                 END
                 ELSE
                 BEGIN
                     INSERT INTO dbo.ClientEpisode([EpisodeID],[SignificantOtherStatusCode],[CSRAScore],[EthnicityID],[DischargeReviewDate],[CONTROLLINGDISCHARGEDATE],
                      [COMPASCRIMINOGENICNEEDS],[AdditionalInformation],[CaseReferralSourceCode],[ActionBy],[DateAction],[ActionStatus])
                     SELECT {0},{1},{2},{3},{4},{5},{6},{7},{8},{9},GetDate(),1
                     UPDATE EpisodeTrace SET ClientEpisodeID = @@IDENTITY WHERE EpisodeID = {0} 
                 END
                 IF NOT EXISTS(SELECT e.OffenderID, o.DOB, o.SSN, o.DDP, e.ReleaseDate, e.CustodyFacilityID FROM Episode e INNER JOIN Offender o ON e.OffenderID = o.OffenderID 
                                WHERE EpisodeID ={0} AND ISNULL(DOB, '')=ISNULL({10}, '') AND ISNULL(DDP,'')=ISNULL({11}, '') AND ISNULL(SSN, '')=ISNULL({12},'') 
                                      AND ISNULl(ReleaseDate, '')=ISNULL({13},'') AND ISNULL(CustodyFacilityID,0)=ISNULl({14},0)) 
                 BEGIN 
                 DECLARE @OffenderID int = (SELECT OffenderID FROM Episode WHERE EpisodeID = {0})
                 UPDATE Offender SET SSN ={12},DOB ={10}, DDP ={11} WHERE OffenderID = @OffenderID
                 UPDATE Episode SET ReleaseDate ={13}, CustodyFacilityID ={14} WHERE EpisodeID={0} END", 
                      viewmodel.EpisodeId, (!string.IsNullOrEmpty(SignificantOtherStatusCode) ? "'" + SignificantOtherStatusCode.ToString() + "'" : "null"),
                      (!string.IsNullOrEmpty(profileData.CSRASCORE) ? profileData.CSRASCORE : "null"),(EthnicityID > 0 ? EthnicityID.ToString() : "null"),
                      (profileData.DISCHARGEREVIEWDATE != (DateTime?)null ? "'" + profileData.DISCHARGEREVIEWDATE + "'" : "null"),
                      (profileData.CONTROLLINGDISCHARGEDATE != (DateTime?)null ? "'" + profileData.CONTROLLINGDISCHARGEDATE + "'" : "null"),
                      (!string.IsNullOrEmpty(profileData.COMPASCRIMINOGENICNEEDS) ? "'" + RemoveUnprintableChars(profileData.COMPASCRIMINOGENICNEEDS) + "'" : "null"),
                      (!string.IsNullOrEmpty(profileData.ADDITIONALINFORMATION) ? "'" + RemoveUnprintableChars(profileData.ADDITIONALINFORMATION) + "'" : "null"),
                      (!string.IsNullOrEmpty(CaseReferralSourceCode) ? "'" + CaseReferralSourceCode + "'" : "null"), CurrentUser.UserID.ToString(),
                      (profileData.DOB != (DateTime?)null ? "'" + profileData.DOB  + "'" : "null"), (!string.IsNullOrEmpty(ddp) ? "'" + ddp + "'" : "null"),
                      (!string.IsNullOrEmpty(profileData.SOCIALSECURITYNUMBER) ? "'" + profileData.SOCIALSECURITYNUMBER + "'" : "null"),
                      (profileData.RECENTRELEASEDATE != (DateTime?)null ? "'" + profileData.RECENTRELEASEDATE.ToString() + "'" : "null"),
                      (profileData.FacilityID == 0 ? "null" : profileData.FacilityID.ToString()));
                                             
                var succes = SqlHelper.ExecuteCommand(query);

                return RedirectToAction("GetSocialWork", new
                {
                    EpisodeId = viewmodel.EpisodeId,
                    ActiveTabIn = "PMHSProfile"
                });
            }

            return null;
        }
        public JsonResult GetFacilityList()
        {
            var query = "SELECT FacilityID, Abbr, Name FROM dbo.tlkpFacility WHERE ISNULL(Disabled, 0) = 0";
            var results = SqlHelper.ExecuteCommands<Facilities>(query);
            return Json(results, JsonRequestBehavior.AllowGet);
        }
        #endregion PMHSProfile
        #region PMHS
        public ActionResult GetClinicalPMHSPC(int EpisodeId)
        {
            var Parms = new List<ParameterInfo>
            {
                new ParameterInfo { ParameterName = "EpisodeID", ParameterValue= EpisodeId },
                new ParameterInfo { ParameterName = "PMHSID", ParameterValue= 0 }
            };
            var result = SqlHelper.GetRecords<ClinicalPMHSData>("spGetEpisodeClinicalPMHS", Parms).FirstOrDefault();
           
            result.IsRenew = false;
            result.ClinicianName = CurrentUser.UserLFI();

            return PartialView("_ClinicalPMHSPC", new ClinicalPMHSViewModel
            {
                ClinicalPMHSSet = result,
                CanEdit = this.CanEditSW && result.PMHSDischargeType < 0,
                EpisodeID = EpisodeId,
                IsAdmin = CurrentUser.IsPOCAdmin,
                NoEditAllowed = (this.CanEditSW ? MvcHtmlString.Create("") : this.NoEditAllowed)
            });
        }
        public ActionResult SaveClinicalPMHPC(ClinicalPMHSViewModel viewModel)
        {
            if (ModelState.IsValid)
            {
                //get InclusionPMHS
                int? InclusionPMHSoption = (int?)null;
                if (viewModel.ClinicalPMHSSet.InclusionInPMHSCurrent == true)
                    InclusionPMHSoption = 3;
                else if (viewModel.ClinicalPMHSSet.InclusionInPMHSMeet == true)
                    InclusionPMHSoption = 2;
                else if (viewModel.ClinicalPMHSSet.InclusionInPMHSNoMeet == true)
                    InclusionPMHSoption = 1;

                // get countinue Mental Health Designation
                int? cmhd = (int?)null;
                if (viewModel.ClinicalPMHSSet.ForConstituteToEOP)
                    cmhd = (int)MH_L_STATUS.CCCMSToEOP;
                else if (viewModel.ClinicalPMHSSet.ForConstituteToCCCMS)
                    cmhd = (int)MH_L_STATUS.EOPToCCCMS;
                else if (viewModel.ClinicalPMHSSet.ForCCCMS)
                    cmhd = (int)MH_L_STATUS.CCCMS;
                else if (viewModel.ClinicalPMHSSet.ForEOP)
                    cmhd = (int)MH_L_STATUS.EOP;
                

                //get prescribed value
                bool? prescribing = (bool?)null;
                if (viewModel.ClinicalPMHSSet.PsychottropicPrescribedYes == true)
                    prescribing = true;
                else if (viewModel.ClinicalPMHSSet.PsychottropicPrescribedNo == true)
                    prescribing = false;

                var status = 1;
                if (!viewModel.ClinicalPMHSSet.IsRenew)
                {
                    status = 2;
                }

                var query = string.Format(
                    @"DECLARE @ClientEpisodeID int = (SELECT ClientEpisodeID FROM EpisodeTrace WHERE EpisodeID = {0})
              INSERT INTO [dbo].[ClinicalPMHS]([EpisodeID] ,[InclusionInPMHS],[MentalDisorder],[RefForWelfare]
                         ,[RefToContratedService],[TeamLeaderName],[SupervisorName],[TeamLeaderSigDate]
                         ,[SupervisorSigDate],[RefToContratedServiceNote],[RefForResourcePlan],[RefForResourcePlanNote]
                         ,[RefForDischarge],[Other],[OtherNote],[LGAFScore],[PsychottropicPrescribed]
                         ,[PMHSDischargeType],[BehavioralAlerts],[PMHSChangeNote],[PMHSChangeDate]
                         ,[PMHSDischargeNote],[PMHSDischargeDate],[ActionBy],[ActionStatus],[DateAction],[ClinicianName],[MHDesignation])
                     VALUES ({0},{1},{2},{3},{4},{5},{6},{7},{8},{9}, {10},{11},{12},{13},{14},{15},{16},{17},{18},{19},{20},{21},{22},{23},{24},
                             GetDate(),{25},{26})
                 UPDATE EpisodeTrace SET PMHSID = @@IDENTITY WHERE EpisodeID = {0}",
                viewModel.EpisodeID, (InclusionPMHSoption == (int?)null ? "null" : InclusionPMHSoption.ToString()),
                    (viewModel.ClinicalPMHSSet.MentalDisorder == true ? "1" : "null"), 
                    (viewModel.ClinicalPMHSSet.RefForWelfare == true ? "1" : "null"),
                    (viewModel.ClinicalPMHSSet.RefToContratedService == true ? "1" : "null"),
                    (!string.IsNullOrEmpty(viewModel.ClinicalPMHSSet.TeamLeaderName) ? "'" + viewModel.ClinicalPMHSSet.TeamLeaderName + "'" : "null"),
                    (!string.IsNullOrEmpty(viewModel.ClinicalPMHSSet.SupervisorName) ? "'" + viewModel.ClinicalPMHSSet.SupervisorName + "'" : "null"),
                    (viewModel.ClinicalPMHSSet.TeamLeaderSigDate != (DateTime?)null ? "'" + viewModel.ClinicalPMHSSet.TeamLeaderSigDate + "'" : "null"),
                    (viewModel.ClinicalPMHSSet.SupervisorSigDate != (DateTime?)null ? "'" + viewModel.ClinicalPMHSSet.SupervisorSigDate + "'" : "null"),
                    (!string.IsNullOrEmpty(viewModel.ClinicalPMHSSet.RefToContratedServiceNote) ? "'" + RemoveUnprintableChars(viewModel.ClinicalPMHSSet.RefToContratedServiceNote) + "'" : "null"),
                    (viewModel.ClinicalPMHSSet.RefForResourcePlan == true ? "1" : "null"), 
                    (!string.IsNullOrEmpty(viewModel.ClinicalPMHSSet.RefForResourcePlanNote) ? "'" + RemoveUnprintableChars(viewModel.ClinicalPMHSSet.RefForResourcePlanNote) + "'" : "null"),
                    (viewModel.ClinicalPMHSSet.RefForDischarge == true ? "1" : "null"), 
                    (viewModel.ClinicalPMHSSet.Other == true ? "1" : "null"),
                    (!string.IsNullOrEmpty(viewModel.ClinicalPMHSSet.OtherNote) ? "'" + RemoveUnprintableChars(viewModel.ClinicalPMHSSet.OtherNote) + "'" : "null"),
                    (viewModel.ClinicalPMHSSet.LGAFScore == (int?)null ? "null" : viewModel.ClinicalPMHSSet.LGAFScore.ToString()), 
                    (prescribing == (bool?)null ? "null" : (prescribing == true ? "1" : "0")),
                    (viewModel.ClinicalPMHSSet.PMHSDischargeType == (int?)null ? "null" : viewModel.ClinicalPMHSSet.PMHSDischargeType.ToString()),
                    (!string.IsNullOrEmpty(viewModel.ClinicalPMHSSet.BehavioralAlerts) ? "'" + RemoveUnprintableChars(viewModel.ClinicalPMHSSet.BehavioralAlerts) + "'" : "null"),
                    (!string.IsNullOrEmpty(viewModel.ClinicalPMHSSet.PMHSChangeNote) ? "'" + RemoveUnprintableChars(viewModel.ClinicalPMHSSet.PMHSChangeNote) + "'" : "null"),
                    (viewModel.ClinicalPMHSSet.PMHSChangeDate != (DateTime?)null ? "'" + viewModel.ClinicalPMHSSet.PMHSChangeDate + "'" : "null"),
                    (!string.IsNullOrEmpty(viewModel.ClinicalPMHSSet.PMHSDischargeNote) ? "'" + RemoveUnprintableChars(viewModel.ClinicalPMHSSet.PMHSDischargeNote) + "'" : "null"),
                    (viewModel.ClinicalPMHSSet.PMHSDischargeDate != (DateTime?)null ? "'" + viewModel.ClinicalPMHSSet.PMHSDischargeDate + "'" : "null"),
                    CurrentUser.UserID, status,
                    (!string.IsNullOrEmpty(viewModel.ClinicalPMHSSet.ClinicianName) ? "'" + viewModel.ClinicalPMHSSet.ClinicianName + "'" : "null"), 
                    (cmhd ==(int?)null ? "null" : cmhd.ToString() ));
     
                var success = SqlHelper.ExecuteCommand(query);

                return RedirectToAction("GetSocialWork", new
                {
                    EpisodeId = viewModel.EpisodeID,
                    ActiveTabIn = "PMHSPC"
                });
            }

            return null;
        }
        public ActionResult GetClinicalPMHSR(int EpisodeId)
        {
            var Parms = new List<ParameterInfo>
            {
                new ParameterInfo { ParameterName = "EpisodeID", ParameterValue= EpisodeId },
                new ParameterInfo { ParameterName = "PMHSID", ParameterValue= 0 }
            };
            var result = SqlHelper.GetRecords<ClinicalPMHSData>("spGetEpisodeClinicalPMHS", Parms).FirstOrDefault();
           
            bool editable = result.Id == 0 ? false : true;
            var message = result.Id == 0 ? "Must complete CDCR 128-PMH1 form to continue." : "";
            result.IsRenew = false;
            result.ClinicianName = CurrentUser.UserLFI();

            return PartialView("_ClinicalPMHSR", new ClinicalPMHSViewModel
            {
                ClinicalPMHSSet = result,
                CanEdit = this.CanEditSW && editable,
                //CanEdit = this.CanEditSW,
                IsAdmin = CurrentUser.IsPOCAdmin,
                NoEditAllowed = (this.CanEditSW ? MvcHtmlString.Create("") : this.NoEditAllowed),
                EpisodeID = EpisodeId,
                InfoMessage = message
            });
        }
        public ActionResult SaveClinicalPMHR(ClinicalPMHSViewModel viewModel)
        {
            if (ModelState.IsValid)
            {
                //get DischargeType
                int? dischargeType = null;
                if (viewModel.ClinicalPMHSSet.PMHSDischargeA == true)
                    dischargeType = 1;
                else if (viewModel.ClinicalPMHSSet.PMHSDischargeB == true)
                    dischargeType = 2;
                else if (viewModel.ClinicalPMHSSet.PMHSDischargeC == true)
                    dischargeType = 3;
                else if (viewModel.ClinicalPMHSSet.PMHSDischargeD == true)
                    dischargeType = 4;

                // get discharge date
                string dischargeDate = "";
                if (dischargeType == 1)
                    dischargeDate = viewModel.ClinicalPMHSSet.PMHSDischargeDateA.HasValue ? viewModel.ClinicalPMHSSet.PMHSDischargeDateA.ToString() : DateTime.Now.ToString();
                else if (dischargeType == 2)
                    dischargeDate = viewModel.ClinicalPMHSSet.PMHSDischargeDateB.HasValue ? viewModel.ClinicalPMHSSet.PMHSDischargeDateB.ToString() : DateTime.Now.ToString();

                var query = string.Format(@"
                        DECLARE @EpisodeID int = {0} 
                        DECLARE @PMHSID int = (SELECT PMHSID FROM EpisodeTrace WHERE EpisodeID  = @EpisodeID)
                        DECLARE @DischargeType int = {1}
                        INSERT INTO[dbo].[ClinicalPMHS]
                           ([EpisodeID],[InclusionInPMHS],[MentalDisorder],[RefForWelfare],[RefToContratedService]
                           ,[TeamLeaderSigDate],[SupervisorSigDate],[RefToContratedServiceNote]
                           ,[RefForResourcePlan],[RefForResourcePlanNote],[RefForDischarge]
                           ,[Other],[OtherNote],[LGAFScore],[PsychottropicPrescribed],[BehavioralAlerts],[PMHSChangeNote]
                           ,[PMHSChangeDate],[PMHSDischargeNote],[PMHSDischargeType],[PMHSDischargeDate],[ClinicianName]
                           ,[ActionBy],[ActionStatus],[DateAction])
                        SELECT [EpisodeID],[InclusionInPMHS],[MentalDisorder],[RefForWelfare],[RefToContratedService]
                           ,[TeamLeaderSigDate],[SupervisorSigDate],[RefToContratedServiceNote]
                           ,[RefForResourcePlan],[RefForResourcePlanNote],[RefForDischarge]
                           ,[Other],[OtherNote],[LGAFScore],[PsychottropicPrescribed],[BehavioralAlerts],[PMHSChangeNote]
                           ,[PMHSChangeDate],{5},{1},{2},'{3}',{4},2,GetDate()
                         FROM [dbo].[ClinicalPMHS]
                        WHERE Id = @PMHSID
                        IF @DischargeType IS NOT NULL
                           UPDATE ClientEpisode SET ParoleMentalHealthLevelOfServiceID = 5 WHERE ClientEpisodeID = (SELECT ClientEpisodeID FROM EpisodeTrace WHERE EpisodeID = {0})
                        ELSE
                           UPDATE ClientEpisode SET ParoleMentalHealthLevelOfServiceID = null WHERE ClientEpisodeID = (SELECT ClientEpisodeID FROM EpisodeTrace WHERE EpisodeID = {0})
                        UPDATE EpisodeTrace SET PMHSID = @@IDENTITY WHERE EpisodeID  = {0}",
                      viewModel.EpisodeID, (dischargeType == (int?)null ? "null" : dischargeType.ToString()), (string.IsNullOrEmpty(dischargeDate) ? "null" : "'" + dischargeDate + "'"),
                      (string.IsNullOrEmpty(viewModel.ClinicalPMHSSet.ClinicianName) ? CurrentUser.UserLFI() : viewModel.ClinicalPMHSSet.ClinicianName), CurrentUser.UserID,
                      (string.IsNullOrEmpty(viewModel.ClinicalPMHSSet.PMHSDischargeNote) ? "'" + null + "'": "'" + RemoveUnprintableChars(viewModel.ClinicalPMHSSet.PMHSDischargeNote) + "'"));
             
                var success = SqlHelper.ExecuteCommand(query);

                return RedirectToAction("GetSocialWork", new
                {
                    EpisodeId = viewModel.EpisodeID,
                    ActiveTabIn = "PMHSR"
                });
            }

            return null;
        }
        #endregion PMHS
        #region DSM5
        public ActionResult GetClinicalDSM5(int EpisodeID, int DSM5ID)
        {
            var data = GetDSM5ListData(EpisodeID, DSM5ID);
            data.NoEditAllowed = (data.CanEdit ? MvcHtmlString.Create("") : this.NoEditAllowed);
            return PartialView("_ClinicalDSM5", data);
        }
        private DSM5ViewModel GetDSM5ListData(int EpisodeID, int DSM5ID)
        {
            JavaScriptSerializer jss = new JavaScriptSerializer();
            List<ParameterInfo> parms = new List<ParameterInfo> {
                { new ParameterInfo {  ParameterName= "EpisodeID", ParameterValue = EpisodeID } },
                { new ParameterInfo {  ParameterName= "CurrentUserID", ParameterValue = CurrentUser.UserID } },
                { new ParameterInfo {  ParameterName= "DSM5ID", ParameterValue = DSM5ID }} };
            var data = SqlHelper.GetRecords<DSM5ViewModel>("spGetEpisodeDSM5", parms).FirstOrDefault();
            data.EpisodeDSM5 = jss.Deserialize<List<DSM5>>(data.DSM5Json);
            return data;
        }
        public JsonResult GetDSM5DateList(int EpisodeID)
        {
            var query = string.Format(@"DECLARE @EpisodeID int = {0}
                DECLARE @ID int = ISNULL((SELECT DSM5ID FROM EPisodeTrace WHERE EpisodeID = @EpisodeID), 0) 
                IF @ID = 0 
                   SELECT 0 AS DSM5ID, (CONVERT(NVARCHAR(15), GetDate(), 110) + '*') AS DSM5Date
                ELSE
                  SELECT DSM5ID, (CONVERT(NVARCHAR(15), DateAction, 110) + (CASE WHEN DSM5ID = @ID THEN '*' ELSE '' END)) as DSM5Date
                    FROM 
                   (SELECT DSM5ID, DateAction, ActionBy, ROW_NUMBER() OVER(PARTITION BY Cast(DateAction AS Date), ActionBy ORDER BY DSM5ID DESC) AS RowNum
                      FROM dbo.ClinicalDSM5 Where EpisodeID = @EpisodeID AND ActionStatus <> 10) T WHERE T.RowNum = 1 ", EpisodeID);
            var dates = SqlHelper.ExecuteCommands<DSM5Dates>(query);
            return Json(dates.OrderByDescending(d=>d.DSM5ID), JsonRequestBehavior.AllowGet);
        }
        public ActionResult SaveClinicalDSM5(DSM5ViewModel DSM5)
        {
            if (ModelState.IsValid)
            {
                JavaScriptSerializer jss = new JavaScriptSerializer();
                string jasonstring = RemoveUnprintableChars(jss.Serialize(DSM5.EpisodeDSM5));
                
        //var newid = SaveDSM5(casrIrp.IRPSetList, casrIrp.EpisodeID);
        var query = string.Format(@"DECLARE @status int = (CASE (SELECT ISNULL(DSM5ID, 0) FROM dbo.EpisodeTrace WHERE EpisodeID = {0}) WHEN 0 THEN 1 ELSE 2 END)
            INSERT INTO dbo.ClinicalDSM5(EpisodeID, DSM5Json, ActionStatus, ActionBy, DateAction) VALUES({0}, '{1}', @status, {2}, GetDate())
            UPDATE dbo.EpisodeTrace SET DSM5ID = @@IDENTITY WHERE EpisodeID  = {0}",
                DSM5.EpisodeID, jasonstring, CurrentUser.UserID);
                SqlHelper.ExecuteCommand(query);
                return RedirectToAction("GetSocialWork", new
                {
                    EpisodeID = DSM5.EpisodeID,
                    ActiveTabIn = "DSM5"
                });
            }
            return null; // ErrorsJson(ModelStateErrors());
        }
        
        #endregion DSM5
        #endregion Social work
        #region DSM
        public ActionResult GetDsm(int EpisodeId, string ActiveTabIn = "")
        {
            return PartialView("_DSM", new DsmViewModel
            {
                EpisodeId = EpisodeId,
                ActiveTabIn = ActiveTabIn
            });
        }
        public ActionResult GetDsmDiagnosis(int EpisodeId, int DsmId)
        {
           var query = string.Format(@"DECLARE @EpisodeID int ={0}
DECLARE @EvaluationID int =(SELECT ISNULl(EvaluationID,0) FROM dbo.EpisodeTrace WHERE EpisodeID = @EpisodeID) 
IF @EvaluationID = 0
   SELECT '' AS EvaluationNote
ELSE 
BEGIN
  DECLARE @DateAction DateTime = (SELECT DateAction FROM dbo.EpisodeEvaluation WHERE EpisodeID=@EpisodeID AND ID=@EvaluationID )
  IF @DateAction IS NULL
     SELECT '' AS EvaluationNote
  ELSE
    SELECT EvaluationNote FROM dbo.EpisodeEvaluation WHERE EvaluationItemId = 12 AND DateAction =@DateAction
END", EpisodeId);
            var result = SqlHelper.ExecuteCommands<string>(query).Single();
            
            return PartialView("_DSMDiagnosis", new DsmViewModel
            {
                CanEdit = this.CanEditDSM,
                NoEditAllowed = (this.CanEditDSM ? MvcHtmlString.Create("") : this.NoEditAllowed),
                EpisodeId = EpisodeId,
                DsmId = DsmId,
                DiagnosticImpression = result
            });
        }
        public JsonResult GetDSMDateList(int EpisodeId)
        {
            var query = string.Format(@"DECLARE @EpisodeID int = {0} 
                 DECLARE @ID int = (SELECT ISNULL(DSMID,0) FROM EpisodeTrace WHERE EpisodeID = @EpisodeID) 
                 IF @ID = 0
                  SELECT 0 AS DsmId, (FORMAT(GetDate(),'MM-dd-yyyy') + '*')DsmDate 
                 ELSE 
                    SELECT Id as DsmId, (FORMAT(DateAction,'MM-dd-yyyy') + 
                          (CASE WHEN Id = @ID THEN '*' ELSE '' END))DsmDate
                      FROM dbo.DSM Where EpisodeID = @EpisodeID AND ActionStatus <> 10 ORDER BY Id DESC", EpisodeId);

            var dates = SqlHelper.ExecuteCommands<DsmDates>(query);
            return Json(dates, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetDSMSearchList(string text)
        {
            var query = @"SELECT t1.ICDCode + '_' + (CASE WHEN t1.DSMDesc like '%No corresponding DSM-5%' THEN t1.ICDDesc ELSE t1.DSMDesc END) AS Dsm, t1.MasterDXId FROM  dbo.tlkpICD_DX_Codes t1 LEFT OUTER JOIN dbo.tlkpDsmQAMap t2 ON t1.MasterDXId = t2.MasterDXId";
            var result = SqlHelper.ExecuteCommands<ICDCodeList>(query).Distinct().OrderBy(o=>o.Dsm);
           
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetDSMTypeSearchList(int? MasterDXId)
        {
            var query = string.Format(@"SELECT t2.Question AS DsmType, t1.DsmQuestionId AS DsmTypeId FROM  dbo.tlkpDsmQAMap t1 LEFT OUTER JOIN dbo.tlkpDsmQuestion t2 ON t1.DsmQuestionId = t2.Id WHERE ISNULl(t2.Disaled, 0) = 0 AND t1.MasterDXId={0}", MasterDXId);
            var result = SqlHelper.ExecuteCommands<DsmQuestionList>(query);
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetDSMTypeSpecifierSearchList(int? Id)
        {
            var query = string.Format(@"SELECT SubQuestion AS DsmSpecifier, Id AS DsmSpecifierId FROM  dbo.tlkpDsmSubQuestion WHERE ISNULl(Disaled, 0) = 0 AND QuestionId={0}", Id);
            var result = SqlHelper.ExecuteCommands<DsmSubQuestionList>(query);
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult DSMHisRead([DataSourceRequest] DataSourceRequest request, int EpisodeId)
        {
            //List<DsmData> assignments = new List<DsmData>();
            var query = string.Format(@"SELECT l1.Id, l1.DsmId, l1.MasterDXId, 
           FORMAT(l1.DateAction, 'MM-dd-yyyy hh:mm tt')DateDsmDate,l3.IcdCode,l3.DsmDesc,  
	       l1.Note AS Comments, l5.Question AS DsmType,l6.SubQuestion AS DsmSpecifier,  
           (SELECT Name FROM dbo.fn_GetAsstUserName(l1.ActionBy))ClinicalName,
           (CASE l1.ActionStatus WHEN 10 THEN 'Deleted' WHEN 1 THEN '' END)ActionStatus,
           l1.DsmTypeId,ISNULl(l1.DsmSpecifierId, 0)DsmSpecifierId          
      FROM dbo.DsmDiagnosis l1 INNER JOIN dbo.Dsm l2 ON l1.DsmId =l2.Id
	  INNER Join dbo.tlkpICD_DX_Codes l3 ON l1.MasterDXId = l3.MasterDXId 
      INNER JOIN dbo.[User] l4 on l1.ActionBy = l4.UserID
      LEFT OUTER JOIN dbo.tlkpDsmQuestion l5 on l1.DsmTypeId = l5.Id 
      LEFT OUTER JOIN dbo.tlkpDsmSubQuestion l6 on l1.DsmSpecifierId = l6.Id
     WHERE l2.EpisodeID={0} order by l1.Id DESC", EpisodeId);
            var results = SqlHelper.ExecuteCommands<DsmData>(query);
            return Json(results.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }
        //DSM Diagnosis Read
        public ActionResult DSMDiagnosisRead([DataSourceRequest] DataSourceRequest request, int EpisodeId, int DsmId)
        {
            List<DsmData> dsms = new List<DsmData>();
            var dsm = GetDiagnosisList(EpisodeId, DsmId);
            if (dsm.FirstOrDefault() != null )
               dsms = dsm;
            return Json(dsms.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public JsonResult DSMDiagnosisCreate([DataSourceRequest] DataSourceRequest request, [Bind(Prefix = "models")]IEnumerable<DsmData> dsms, int EpisodeId, int DsmId)
        {
            List<DsmData> Diagnosis = new List<DsmData>();
            if (dsms != null && ModelState.IsValid)
            {
                var dsmTemp = dsms.FirstOrDefault();
                SaveNewDsmData(dsmTemp, EpisodeId, DsmId);
                //Diagnosis = GetDiagnosisList(EpisodeId, 0);
            }
            return Json(Diagnosis.ToDataSourceResult(request, ModelState), JsonRequestBehavior.AllowGet);
        }

        private void SaveNewDsmData(DsmData dsmTemp, int episodeId, int dsmId)
        {
            var query = string.Format(@"DECLARE @EpisodeID int = {0}
                          DECLARE @ActionStatus int = 1 DECLARE @dsmId int = {1}
                          DECLARE @newDsmDate DateTime = FORMAT(GetDate(), 'MM-dd-yyyy')   
 IF NOT EXISTS(SELECT * FROM dbo.Dsm WHERE @newDsmDate = DsmDate AND ActionStatus <> 10 AND EpisodeID = @EpisodeID)
 BEGIN
   INSERT INTO dbo.DSM(EpisodeId, DsmDate, ActionStatus, ActionBy, DateAction)
        VALUES (@EpisodeID,@newDsmDate, @ActionStatus,{2}, GetDate())
   SET @dsmId = @@IDENTITY
   Update dbo.EpisodeTrace SET DsmID =@dsmId WHERE EpisodeID = @EpisodeID
 END
 ELSE SET @ActionStatus = 2
 IF @dsmId = 0 SET @dsmId = (SELECT DSMID FROM dbo.EpisodeTrace WHERE EpisodeID  = @EpisodeID)
 INSERT INTO dbo.DsmDiagnosis(DsmId, MasterDXId", episodeId, dsmId, CurrentUser.UserID);
            var quervalue = " VALUES ( @dsmId," + dsmTemp.MasterDXId;
            if (dsmTemp.DsmTypeId != (int?)null)
            {
                query = query + ",DsmTypeId";
                quervalue = quervalue + "," + dsmTemp.DsmTypeId;
            }
            if (dsmTemp.DsmSpecifierId != (int?)null)
            {
                query = query + ",DsmSpecifierId";
                quervalue = quervalue + "," + dsmTemp.DsmSpecifierId;
            }
            if (!string.IsNullOrEmpty(dsmTemp.Comments))
            {
                query = query + ",Note";
                quervalue = quervalue + ",'" + RemoveUnprintableChars(dsmTemp.Comments) + "'";
            }
            query = query + ",ActionStatus, ActionBy, DateAction)";
            quervalue = quervalue + ",@ActionStatus," + CurrentUser.UserID + ",GetDate())";
            query = query + quervalue;
            var result = SqlHelper.ExecuteCommand(query);
        }

        public ActionResult GetDsmHis(int EpisodeId)
        {
            return PartialView("_DSMHis", new DsmViewModel
            {
                EpisodeId = EpisodeId,
            });
        }
       
        public ActionResult DSMDiagnosisDestroy([DataSourceRequest] DataSourceRequest request, [Bind(Prefix = "models")]IEnumerable<DsmData> dsms, int EpisodeID)
        {
            if (ModelState.IsValid && dsms != null)
            {
                var dsm = dsms.FirstOrDefault();
                var query = string.Format(@"UPDATE dbo.DsmDiagnosis SET ActionStatus = 10 Where ID= {0}
                     DECLARE @count int = (SELECT COUNT(*) FROM dbo.DsmDiagnosis WHERE ActionStatus <> 10 AND DsmId = {1})  
                      IF @count = 0 BEGIN 
                      Update dbo.Dsm SET ActionStatus = 10 WHERE ActionStatus <> 10 AND Id={1} 
                      DECLARE @id int = (SELECT TOP 1 ISNULl(ID, 0) FROM dbo.Dsm WHERE ActionStatus <> 10 AND EpisodeID = {2} ORDER BY ID DESC)
                      IF @id = 0
                          Update dbo.EpisodeTrace SET DSMID = null WHERE EpisodeID={2} 
                      ELSE Update dbo.EpisodeTrace SET DSMID = @id WHERE EpisodeID={2}  END "
                 , dsm.Id, dsm.DsmId, EpisodeID);
                var result = SqlHelper.ExecuteCommand(query);
                dsms = GetDiagnosisList(EpisodeID, 0);
            }

            return Json(new[] { dsms }.ToDataSourceResult(request, ModelState), JsonRequestBehavior.AllowGet);
        }

        //[HttpPost]
        public ActionResult DeleteDsmDiagnosis(int EpisodeId, int DsmId)
        {
            if (ModelState.IsValid)
            {
                var query = string.Format(@"UPDATE dbo.DsmDiagnosis SET ActionStatus = 10 Where DsmId= {0}
                      Update dbo.Dsm SET ActionStatus = 10 WHERE ActionStatus <> 10 AND Id={0} 
                      DECLARE @id int = (SELECT TOP 1 ISNULl(ID, 0) FROM dbo.Dsm WHERE ActionStatus <> 10 AND EpisodeID = {1} ORDER BY ID DESC)
                      IF @id = 0
                          Update dbo.EpisodeTrace SET DSMID = null WHERE EpisodeID={1} 
                      ELSE Update dbo.EpisodeTrace SET DSMID = @id WHERE EpisodeID={1} "
                 , DsmId, EpisodeId);
                var result = SqlHelper.ExecuteCommand(query);
            }

            return RedirectToAction("GetDsmDiagnosis", new { EpisodeId = EpisodeId, DsmId = DsmId });
        }
        private List<DsmData> GetDiagnosisList(int EpisodeId, int DsmId)
        {
           var Parms = new List<ParameterInfo> {
                 new ParameterInfo { ParameterName= "EpisodeID", ParameterValue= EpisodeId },
                 new ParameterInfo { ParameterName= "DSMID", ParameterValue= DsmId } };
            return SqlHelper.GetRecords<DsmData>("spGetEpisodeDSM", Parms);      
            
        }
        #endregion DSM
        #region Psychiatry
        public ActionResult GetPsychiatry(int EpisodeId, string ActiveTabIn = "")
        {
            bool canedit = (CurrentUser.IsPOCAdmin || CurrentUser.IsPOCPsychiatrist);
             return PartialView("_Psychiatry", new PsychiatryMMAViewModel
            {
                EpisodeId = EpisodeId,
                CanEdit = this.CanEditPsychi,
                NoEditAllowed = this.CanEditPsychi ? MvcHtmlString.Create("") : this.NoEditAllowed,
                ActiveTabIn = "mma"
            });
        }
        public ActionResult GetMMA(int EpisodeId, int SelectedMMAID)
        {
            var mma = GetMMAData(EpisodeId, SelectedMMAID);

            return PartialView("_MMA", new PsychiatryMMAViewModel
            {
                EpisodeId = EpisodeId,
                CanEdit = this.CanEditPsychi,
                NoEditAllowed = this.CanEditPsychi ? MvcHtmlString.Create("") : this.NoEditAllowed,
                SelectedMMAID = mma.MMAID,
                PsyAsmt = mma
            });
        }
        [HttpPost]
        public ActionResult SaveMMA(PsychiatryMMAViewModel vmodel)
        {
            if (ModelState.IsValid) {

                var HeadTraumaHistory = "null";
                if (vmodel.PsyAsmt.HISTORYHEADTRAUMAYES)
                    HeadTraumaHistory = "1";
                else if (vmodel.PsyAsmt.HISTORYHEADTRAUMADENIED)
                    HeadTraumaHistory = "0";

                var StrokeHistory = "null";
                if (vmodel.PsyAsmt.HISTORYSTROKEYES)
                    StrokeHistory = "1";
                else if (vmodel.PsyAsmt.HISTORYSTROKEDENIED)
                    StrokeHistory = "0";

                var LossConsciousnessHistory = "null";
                if (vmodel.PsyAsmt.HISTORYLOSSCONSCIOUSNESSYES)
                    LossConsciousnessHistory = "1";
                else if (vmodel.PsyAsmt.HISTORYLOSSCONSCIOUSNESSDENIED)
                    LossConsciousnessHistory = "0";

                var SpinalCordInjuries = "null";
                if (vmodel.PsyAsmt.SPINALCORDINJURIESYES)
                    SpinalCordInjuries = "1";
                else if (vmodel.PsyAsmt.SPINALCORDINJURIESDENIED)
                    SpinalCordInjuries = "0";

                var SkeletalFracturesOrBrakes = "null";
                if (vmodel.PsyAsmt.SKELETALFRACTURESBRAKESYES)
                    SkeletalFracturesOrBrakes = "1";
                else if (vmodel.PsyAsmt.SKELETALFRACTURESBRAKESDENIED)
                    SkeletalFracturesOrBrakes = "0";

                var MVA = "null";
                if (vmodel.PsyAsmt.MVAYES)
                    MVA = "1";
                else if (vmodel.PsyAsmt.MVADENIED)
                    MVA = "0";

                var GunshotWounds = "null";
                if (vmodel.PsyAsmt.GUNSHOTWOUNDSYES)
                     GunshotWounds = "1";
                else if (vmodel.PsyAsmt.GUNSHOTWOUNDSDENIED)
                    GunshotWounds = "0";

                var SeizuresHistory = "null";
                if (vmodel.PsyAsmt.HISTORYOFSEIZURESYES)
                    SeizuresHistory = "1";
                else if (vmodel.PsyAsmt.HISTORYOFSEIZURESDENIED)
                    SeizuresHistory = "0";

                var MigraineHAHistory = "null";
                if (vmodel.PsyAsmt.HISTORYMIGRAINEHAYES)
                    MigraineHAHistory = "1";
                else if (vmodel.PsyAsmt.HISTORYMIGRAINEHADENIED)
                    MigraineHAHistory = "0";

                var HeartDisease = "null";
                if (vmodel.PsyAsmt.HEARTDISEASEYES)
                    HeartDisease = "1";
                else if (vmodel.PsyAsmt.HEARTDISEASEDENIED)
                    HeartDisease = "0";

                var Asthma = "null";
                if (vmodel.PsyAsmt.ASTHMAYES)
                    Asthma = "1";
                else if (vmodel.PsyAsmt.ASTHMADENIED)
                    Asthma = "0";

                var COPD = "null";
                if (vmodel.PsyAsmt.COPDYES)
                    COPD = "1";
                else if (vmodel.PsyAsmt.COPDDENIED)
                    COPD = "0";

                var Diabetes = "null";
                if (vmodel.PsyAsmt.DIABETESYES)
                    Diabetes = "1";
                else if (vmodel.PsyAsmt.DIABETESDENIED)
                    Diabetes = "0";

                var Hyperlipidemia = "null";
                if (vmodel.PsyAsmt.HYPERLIPIDEMIAYES)
                    Hyperlipidemia = "1";
                else if (vmodel.PsyAsmt.HYPERLIPIDEMIADENIED)
                    Hyperlipidemia = "0";

                var Hypertension = "null";
                if (vmodel.PsyAsmt.HYPERTENSIONYES)
                    Hypertension = "1";
                else if (vmodel.PsyAsmt.HYPERTENSIONDENIED)
                    Hypertension = "0";

                var Hepatitis = "null";
                if (vmodel.PsyAsmt.HEPATITISYES)
                    Hepatitis = "1";
                else if (vmodel.PsyAsmt.HEPATITISDENIED)
                    Hepatitis = "0";

                var VDOrHIV = "null";
                if (vmodel.PsyAsmt.VDHIVYES)
                    VDOrHIV = "1";
                else if (vmodel.PsyAsmt.VDHIVDENIED)
                    VDOrHIV = "0";

                var Anemia = "null";
                if (vmodel.PsyAsmt.ANEMIAYES)
                    Anemia = "1";
                else if (vmodel.PsyAsmt.ANEMIADENIED)
                    Anemia = "0";

                var ThyroidAbnormalities = "null";
                if (vmodel.PsyAsmt.THYROIDABNORMALITIESYES)
                    ThyroidAbnormalities = "1";
                else if (vmodel.PsyAsmt.THYROIDABNORMALITIESDENIED)
                    ThyroidAbnormalities = "0";

                var Glaucoma = "null";
                if (vmodel.PsyAsmt.GLAUCOMAYES)
                    Glaucoma = "1";
                else if (vmodel.PsyAsmt.GLAUCOMADENIED)
                    Glaucoma = "0";

                var AbnormalLabResults = "null";
                if (vmodel.PsyAsmt.ABNORMALLABRESULTSYES)
                    AbnormalLabResults = "1";
                else if (vmodel.PsyAsmt.ABNORMALLABRESULTSDENIED)
                    AbnormalLabResults = "0";

                var AbnormalEKG = "null";
                if (vmodel.PsyAsmt.ABNORMALEKGYES)
                    AbnormalEKG = "1";
                else if (vmodel.PsyAsmt.ABNORMALEKGDENIED)
                    AbnormalEKG = "0";

                var CurrPregnancy = "null";
                if (vmodel.PsyAsmt.CURRENTPREGNANCYYES)
                    CurrPregnancy = "1";
                else if (vmodel.PsyAsmt.CURRENTPREGNANCYDENIED)
                    CurrPregnancy = "0";

                var PriapismHistory = "null";
                if (vmodel.PsyAsmt.HISTORYPRIAPISMYES)
                    PriapismHistory = "1";
                else if (vmodel.PsyAsmt.HISTORYPRIAPISMDENIED)
                    PriapismHistory = "0";

                var OtherChronicMediIll = "null";
                if (vmodel.PsyAsmt.OTHERCHRONICMEDICALILLNESSYES)
                    OtherChronicMediIll = "1";
                else if (vmodel.PsyAsmt.OTHERCHRONICMEDICALILLNESSDENIED)
                    OtherChronicMediIll = "0";

                var IdentifyLearnDisablity = "null";
                if (vmodel.PsyAsmt.IDENTIFIEDLEARNINGDISABILITY)
                    IdentifyLearnDisablity = "1";

                var IntellectualImpairment = "null";
                if (vmodel.PsyAsmt.INTELLECTUALIMPAIRMENTDENIED)
                    IntellectualImpairment = "1";

                var Appearance = "null";
                if (vmodel.PsyAsmt.APPEARANCEDISHEVELED)
                    Appearance = "1";
                else if (vmodel.PsyAsmt.APPEARANCEGROOMED)
                    Appearance = "2";
                else if (vmodel.PsyAsmt.APPEARANCENOURISHED)
                    Appearance = "3";
                else if (vmodel.PsyAsmt.APPEARANCEOBESE)
                    Appearance = "4";

                var PsychomotorActivity = "null";
                if (vmodel.PsyAsmt.PSYCHOMOTORACTIVITYWNL)
                    PsychomotorActivity = "1";
                else if (vmodel.PsyAsmt.PSYCHOMOTORACTIVITYABNORMAL)
                    PsychomotorActivity = "2";

                var AbnormalInvoluntaryMovement = "null";
                if (vmodel.PsyAsmt.ABNORMALINVOLUNTARYMOVEMENTPRESENT)
                    AbnormalInvoluntaryMovement = "1";
                else if (vmodel.PsyAsmt.ABNORMALINVOLUNTARYMOVEMENTABSENT)
                    AbnormalInvoluntaryMovement = "2";

                var ChildhoodMemo = "null";
                if (vmodel.PsyAsmt.CHILDHOODMEMORIESPRESENT)
                    ChildhoodMemo = "1";
                else if (vmodel.PsyAsmt.CHILDHOODMEMORIESABSENT)
                    ChildhoodMemo = "2";

                var AdultMemPrevTraumatic = "null";
                if (vmodel.PsyAsmt.ADULTMEMORIESPREVTRAUMATICEVENTPRESENT)
                    AdultMemPrevTraumatic = "1";
                else if (vmodel.PsyAsmt.ADULTMEMORIESPREVTRAUMATICEVENTABSENT)
                    AdultMemPrevTraumatic = "2";

                var RptIntentPsyReactTrauMemo = "null";
                if (vmodel.PsyAsmt.RPTINTENSEPSYREACTTRAUMEMOPRESENT)
                    RptIntentPsyReactTrauMemo = "1";
                else if (vmodel.PsyAsmt.RPTINTENSEPSYREACTTRAUMEMOABSENT)
                    RptIntentPsyReactTrauMemo = "2";

                var RptAvoidSAWTrauMemo = "null";
                if (vmodel.PsyAsmt.RPTAVOIDSTIMULIPRESENT)
                    RptAvoidSAWTrauMemo = "1";
                else if (vmodel.PsyAsmt.RPTAVOIDSTIMULIABSENT)
                    RptAvoidSAWTrauMemo = "2";

                var RptFlashTrauMemo = "null";
                if (vmodel.PsyAsmt.RPTFLASHBACKSTRAUMATICMEMPRESENT)
                    RptFlashTrauMemo = "1";
                else if (vmodel.PsyAsmt.RPTFLASHBACKSTRAUMATICMEMABSENT)
                    RptFlashTrauMemo = "2";

                var RptRecurrDistressNMTrau = "null";
                if (vmodel.PsyAsmt.RPTRECURRDISTRESSNMTRAUPRESENT)
                    RptRecurrDistressNMTrau = "1";
                else if (vmodel.PsyAsmt.RPTRECURRDISTRESSNMTRAUABSENT)
                    RptRecurrDistressNMTrau = "2";

                var ObsessionsCompulsions = "null";
                if (vmodel.PsyAsmt.OBSESSIONSCOMPULSIONSYES)
                    ObsessionsCompulsions = "1";
                else if (vmodel.PsyAsmt.OTHERCHRONICMEDICALILLNESSDENIED)
                    ObsessionsCompulsions = "0";

                var AppearsRespInternStimulus = "null";
                if (vmodel.PsyAsmt.APPEARSRESPONDINTERNALSTIMULUSYES)
                    AppearsRespInternStimulus = "1";
                else if (vmodel.PsyAsmt.APPEARSRESPONDINTERNALSTIMULUSNO)
                    AppearsRespInternStimulus = "0";

                var Anhedonia = "null";
                if (vmodel.PsyAsmt.ANHEDONIAPRESENT)
                    Anhedonia = "1";
                else if (vmodel.PsyAsmt.ANHEDONIAABSENT)
                    Anhedonia = "2";

                var SLArticulation = "null";
                if (vmodel.PsyAsmt.ARTICULATIONNORMAL)
                    SLArticulation = "1";
                else if (vmodel.PsyAsmt.ARTICULATIONABNORMAL)
                    SLArticulation = "0";

                var SLRate = "null";
                if (vmodel.PsyAsmt.RATENORMAL)
                    SLRate = "1";
                else if (vmodel.PsyAsmt.RATEPRESSURED)
                    SLRate = "0";

                var SLRhythm = "null";
                if (vmodel.PsyAsmt.RHYTHMNORMAL)
                    SLRhythm = "1";
                else if (vmodel.PsyAsmt.RHYTHMPRESSURED)
                    SLRhythm = "0";

                var Sleep = "null";
                if (vmodel.PsyAsmt.SLEEPINSOMINA)
                    Sleep = "1";
                else if (vmodel.PsyAsmt.SLEEPINTERRUPED)
                    Sleep = "2";
                else if (vmodel.PsyAsmt.SLEEPNORMAL)
                    Sleep = "3";

                var Irritability = "null";
                if (vmodel.PsyAsmt.IRRITABILITYPRESENT)
                    Irritability = "1";
                else if (vmodel.PsyAsmt.IRRITABILITYABSENT)
                    Irritability = "2";

                var RangeAffect = "null";
                if (vmodel.PsyAsmt.RANGEAFFECTFULL)
                    RangeAffect = "1";
                else if (vmodel.PsyAsmt.RANGEAFFECTCONSTRICTED)
                    RangeAffect = "2";
                else if (vmodel.PsyAsmt.RANGEAFFECTFLAT)
                    RangeAffect = "3";

                var AppropriateContentSpeech = "null";
                if (vmodel.PsyAsmt.APPROPRIATECONTENTSPEECHYES)
                    AppropriateContentSpeech = "1";
                else if (vmodel.PsyAsmt.APPROPRIATECONTENTSPEECHNO)
                    AppropriateContentSpeech = "0";

                var MoodCongruent = "null";
                if (vmodel.PsyAsmt.MOODCONGRUENTYES)
                    MoodCongruent = "1";
                else if (vmodel.PsyAsmt.MOODCONGRUENTNO)
                    MoodCongruent = "0";

                var HomicidalIdeationPlanOrUntent = "null";
                if (vmodel.PsyAsmt.HOMICIDALIDEATIONPLANUNTENTPRESENT)
                    HomicidalIdeationPlanOrUntent = "1";
                else if (vmodel.PsyAsmt.HOMICIDALIDEATIONPLANUNTENTABSENT)
                    HomicidalIdeationPlanOrUntent = "2";

                var SuicidalIdeation = "null";
                if (vmodel.PsyAsmt.SUICIDALIDEATIONPRESENT)
                    SuicidalIdeation = "1";
                else if (vmodel.PsyAsmt.SUICIDALIDEATIONABSENT)
                    SuicidalIdeation = "2";

                var SuicidalPlan = "null";
                if (vmodel.PsyAsmt.SUICIDALPLANPRESENT)
                    SuicidalPlan = "1";
                else if (vmodel.PsyAsmt.SUICIDALPLANABSENT)
                    SuicidalPlan = "2";

                var SuicidalIntent = "null";
                if (vmodel.PsyAsmt.SUICIDALINTENTPRESENT)
                    SuicidalIntent = "1";
                else if (vmodel.PsyAsmt.SUICIDALINTENTABSENT)
                    SuicidalIntent = "2";

                var VisualHallucinations = "null";
                if (vmodel.PsyAsmt.VISUALHALLUCINATIONSPRESENT)
                    VisualHallucinations = "1";
                else if (vmodel.PsyAsmt.VISUALHALLUCINATIONSABSENT)
                    VisualHallucinations = "2";

                var AuditoryHallucinations = "null";
                if (vmodel.PsyAsmt.AUDITORYHALLUCINATIONSPRESENT)
                    AuditoryHallucinations = "1";
                else if (vmodel.PsyAsmt.AUDITORYHALLUCINATIONSABSENT)
                    AuditoryHallucinations = "2";

                var Insight = "null";
                if (vmodel.PsyAsmt.INSIGHTGOOD)
                    Insight = "1";
                else if (vmodel.PsyAsmt.INSIGHTPOOR)
                    Insight = "2";

                var ThoughtProcesses = "null";
                if (vmodel.PsyAsmt.THOUGHTPROCESSESLAGD)
                    ThoughtProcesses = "1";
                else if (vmodel.PsyAsmt.THOUGHTPROCESSESDISORGANIZED)
                    ThoughtProcesses = "2";
                else if (vmodel.PsyAsmt.THOUGHTPROCESSESCIRCUMSTANTIAL)
                    ThoughtProcesses = "3";
                else if (vmodel.PsyAsmt.THOUGHTPROCESSESTANGENTIAL)
                    ThoughtProcesses = "4";

                var RacingThoughts = "null";
                if (vmodel.PsyAsmt.RACINGTHOUGHTSPRESENT)
                    RacingThoughts = "1";
                else if (vmodel.PsyAsmt.RACINGTHOUGHTSABSENT)
                    RacingThoughts = "2";

                var GuardSuspicious = "null";
                if (vmodel.PsyAsmt.GUARDEDSUSPICIOUSYES)
                    GuardSuspicious = "1";
                else if (vmodel.PsyAsmt.GUARDEDSUSPICIOUSNO)
                    GuardSuspicious = "0";

                var HyperVigilant = "null";
                if (vmodel.PsyAsmt.HYPERVIGILANTYES)
                    HyperVigilant = "1";
                else if (vmodel.PsyAsmt.HYPERVIGILANTNO)
                    HyperVigilant = "0";

                var Preoccupation = "null";
                if (vmodel.PsyAsmt.PREOCCUPATIONSYES)
                    Preoccupation = "1";
                else if (vmodel.PsyAsmt.PREOCCUPATIONSDENIED)
                    Preoccupation = "0";

                var ExaggPsySymptoms = "null";
                if (vmodel.PsyAsmt.APPEARSEXAGGERATEPSYSYMPTOMSYES)
                    ExaggPsySymptoms = "1";
                else if (vmodel.PsyAsmt.APPEARSEXAGGERATEPSYSYMPTOMSNO)
                    ExaggPsySymptoms = "0";

                var medSym = string.Format("{0},{1},{2},{3},{4},{5},{6},{7},{8},{9},{10},{11},{12},{13},{14},{15},{16},{17},{18},{19},{20},{21},",
                   vmodel.PsyAsmt.MEDICATIONTARGETSYMPTOMS1 ? "1" : "",
                   vmodel.PsyAsmt.MEDICATIONTARGETSYMPTOMS2 ? "2" : "",
                   vmodel.PsyAsmt.MEDICATIONTARGETSYMPTOMS3 ? "3" : "",
                   vmodel.PsyAsmt.MEDICATIONTARGETSYMPTOMS4 ? "4" : "",
                   vmodel.PsyAsmt.MEDICATIONTARGETSYMPTOMS5 ? "5" : "",
                   vmodel.PsyAsmt.MEDICATIONTARGETSYMPTOMS6 ? "6" : "",
                   vmodel.PsyAsmt.MEDICATIONTARGETSYMPTOMS7 ? "7" : "",
                   vmodel.PsyAsmt.MEDICATIONTARGETSYMPTOMS8 ? "8" : "",
                   vmodel.PsyAsmt.MEDICATIONTARGETSYMPTOMS9 ? "9" : "",
                   vmodel.PsyAsmt.MEDICATIONTARGETSYMPTOMS10 ? "10" : "",
                   vmodel.PsyAsmt.MEDICATIONTARGETSYMPTOMS11 ? "11" : "",
                   vmodel.PsyAsmt.MEDICATIONTARGETSYMPTOMS12 ? "12" : "",
                   vmodel.PsyAsmt.MEDICATIONTARGETSYMPTOMS13 ? "13" : "",
                   vmodel.PsyAsmt.MEDICATIONTARGETSYMPTOMS14 ? "14" : "",
                   vmodel.PsyAsmt.MEDICATIONTARGETSYMPTOMS15 ? "15" : "",
                   vmodel.PsyAsmt.MEDICATIONTARGETSYMPTOMS16 ? "16" : "",
                   vmodel.PsyAsmt.MEDICATIONTARGETSYMPTOMS17 ? "17" : "",
                   vmodel.PsyAsmt.MEDICATIONTARGETSYMPTOMS18 ? "18" : "",
                   vmodel.PsyAsmt.MEDICATIONTARGETSYMPTOMS19 ? "19" : "",
                   vmodel.PsyAsmt.MEDICATIONTARGETSYMPTOMS20 ? "20" : "",
                   vmodel.PsyAsmt.MEDICATIONTARGETSYMPTOMS21 ? "21" : "",
                   vmodel.PsyAsmt.MEDICATIONTARGETSYMPTOMS22 ? "22" : "");

                var func = string.Format("{0},{1},{2},{3},{4},{5},{6},{7},{8},{9},{10},{11},",
                   vmodel.PsyAsmt.FUNCIMPAIRMENT1 ? "1" : "", vmodel.PsyAsmt.FUNCIMPAIRMENT2 ? "2" : "", vmodel.PsyAsmt.FUNCIMPAIRMENT3 ? "3" : "", vmodel.PsyAsmt.FUNCIMPAIRMENT4 ? "4" : "",
                   vmodel.PsyAsmt.FUNCIMPAIRMENT5 ? "5" : "", vmodel.PsyAsmt.FUNCIMPAIRMENT6 ? "6" : "",
                   vmodel.PsyAsmt.FUNCIMPAIRMENT7 ? "7" : "", vmodel.PsyAsmt.FUNCIMPAIRMENT8 ? "8" : "",
                   vmodel.PsyAsmt.FUNCIMPAIRMENT9 ? "9" : "", vmodel.PsyAsmt.FUNCIMPAIRMENT10 ? "10" : "",
                   vmodel.PsyAsmt.FUNCIMPAIRMENT11 ? "11" : "", vmodel.PsyAsmt.FUNCIMPAIRMENT12 ? "12" : "");

                var recmd = string.Format("{0},{1},{2},{3},", vmodel.PsyAsmt.RECOMMENDATIONS1 ? "1" : "", vmodel.PsyAsmt.RECOMMENDATIONS2 ? "2" : "", vmodel.PsyAsmt.RECOMMENDATIONS3 ? "3" : "", vmodel.PsyAsmt.RECOMMENDATIONS4 ? "4" : "");

                var labs = string.Format("{0},{1},{2},{3},{4},",
                   vmodel.PsyAsmt.LABSREQUESTEDCBC ? "1" : "", vmodel.PsyAsmt.LABSREQUESTEDCHEM ? "2" : "", vmodel.PsyAsmt.LABSREQUESTEDA1C ? "3" : "", vmodel.PsyAsmt.LABSREQUESTEDSTUDY ? "4" : "",
                   vmodel.PsyAsmt.LABSREQUESTEDOTHER ? "5" : "");

                var RTC = "null";
                if (vmodel.PsyAsmt.RTC1MONTH)
                    RTC = "1";
                else if (vmodel.PsyAsmt.RTC2MONTH)
                    RTC = "2";
                else if (vmodel.PsyAsmt.RTC3MONTH)
                    RTC = "3";
                else if (vmodel.PsyAsmt.RTCWEEKS)
                    RTC = "4";

                var discussed = string.Format("{0},{1},{2},{3},",
                   vmodel.PsyAsmt.DISCUSSEDPLAN ? "1" : "", vmodel.PsyAsmt.DISCUSSEDSIDE ? "2" : "", vmodel.PsyAsmt.DISCUSSEDFOLLOW ? "3" : "", vmodel.PsyAsmt.DISCUSSEDDIET ? "4" : "");

                var SexPreferenceGender = "null";
                if (vmodel.PsyAsmt.SEXPREFERENCEFEMALE)
                    SexPreferenceGender = "1";
                else if (vmodel.PsyAsmt.SEXPREFERENCEMALE)
                    SexPreferenceGender = "2";

    var query = string.Format(@"INSERT INTO [dbo].[PsychiatryASMT]([EpisodeId],[Weight]
           ,[ChiefComplaint],[DiscontinuedMedications],[MedicationChanges]
           ,[MedicationSideEffects],[PrevPsyAdmission],[PrevSuicideAttempts]
           ,[YearOutpatientPsyCare],[PrevDrugDependence],[CurrDrugDependence]
           ,[YearDrugUse],[LastDrugUseDate],[MedicationAllergies],[Hospitalizations]
           ,[Surgeries],[HeadTraumaHistory],[HeadTraumaHistoryNote],[StrokeHistory]
           ,[StrokeHistoryNote],[LossConsciousnessHistory],[LossConsciousnessHistoryNote]
           ,[SpinalCordInjuries],[SpinalCordInjuriesNote],[SkeletalFracturesOrBrakes]
           ,[SkeletalFracturesOrBrakesNote],[MVA],[MVANote],[GunshotWounds]
           ,[GunshotWoundsNote],[SeizuresHistory],[SeizuresHistoryNote]
           ,[MigraineHAHistory],[MigraineHAHistoryNote],[HeartDisease]
           ,[HeartDiseaseNote],[Asthma],[AsthmaNote],[COPD],[COPDNote]
           ,[Diabetes],[DiabetesNote],[Hyperlipidemia],[HyperlipidemiaNote]
           ,[Hypertension],[HypertensionNote],[Hepatitis],[HepatitisNote]
           ,[VDOrHIV],[VDOrHIVNote],[Anemia],[AnemiaNote],[ThyroidAbnormalities]
           ,[ThyroidAbnormalitiesNote],[Glaucoma],[GlaucomaNote],[AbnormalLabResults]
           ,[AbnormalLabResultsNote],[AbnormalEKG],[AbnormalEKGNote],[CurrPregnancy]
           ,[CurrPregnancyNote],[PriapismHistory],[PriapismHistoryNote]
           ,[OtherChronicMediIll],[OtherChronicMediIllNote],[PregnanciesNum]
           ,[DeliveryNum],[CurrHousing],[SupportiveRelationships],[CurrEmployment]
           ,[LastEmployed],[HighestGradeCompleted],[IdentifyLearnDisablity]
           ,[IdentifyLearnDisablityNote],[IntellectualImpairment],[IntellectualImpairmentNote]
           ,[IncarcerationHistory],[Appearance],[PsychomotorActivity]
           ,[AbnormalInvoluntaryMovement],[Distractibility],[Impulsivity]
           ,[Concentration],[MemoRegistration],[AnxietyLevel],[ChildhoodMemo]
           ,[AdultMemPrevTraumatic],[RptIntentPsyReactTrauMemo],[RptAvoidSAWTrauMemo]
           ,[RptFlashTrauMemo],[RptRecurrDistressNMTrau],[ObsessionsCompulsions]
           ,[AppearsRespInternStimulus],[Anhedonia],[SLArticulation],[SLRate]
           ,[SLRhythm],[Mood],[Euphoria],[Demeanor],[Sleep],[PridTimeEnergizedSleep]
           ,[Appetite],[EnergyLevel],[Libido],[Irritability],[RangeAffect]
           ,[AppropriateContentSpeech],[MoodCongruent],[HomicidalIdeationPlanOrUntent]
           ,[SuicidalIdeation],[SuicidalPlan],[SuicidalIntent],[VisualHallucinations]
           ,[AuditoryHallucinations],[Insight],[InternalStimulus],[ThoughtProcesses]
           ,[RacingThoughts],[Delusions],[GuardSuspicious],[HyperVigilant]
           ,[Preoccupation],[Judgement],[ExaggPsySymptoms],[MedTargetSymptoms]
           ,[FuncImpairment],[Recommendations],[LabsRequested]
           ,[LabsRequestedOtherNote],[RTC],[RTCWeeks],[Discussed],[ActionBy]
           ,[ActionStatus],[SexPreferenceGender],[SexPreferenceNote]
           ,[CurrentMedications],[PreviousPsychiatricMedications],[PsychiatristId],[ASMTDate],[DateAction])
    VALUES ({0},{1},{2},{3},{4},{5},{6},{7},{8},{9},{10},{11},{12},{13},{14},{15},{16},{17},{18},{19},
            {20},{21},{22},{23},{24},{25},{26},{27},{28},{29},{30},{31},{32},{33},{34},{35},{36},{37},{38},{39},
            {40},{41},{42},{43},{44},{45},{46},{47},{48},{49},{50},{51},{52},{53},{54},{55},{56},{57},{58},{59},
            {60},{61},{62},{63},{64},{65},{66},{67},{68},{69},{70},{71},{72},{73},{74},{75},{76},{77},{78},{79},
            {80},{81},{82},{83},{84},{85},{86},{87},{88},{89},{90},{91},{92},{93},{94},{95},{96},{97},{98},{99},
            {100},{101},{102},{103},{104},{105},{106},{107},{108},{109},{110},{111},{112},{113},{114},{115},{116},{117},{118},{119},
            {120},{121},{122},{123},{124},{125},{126},{127},{128},{129},{130},{131},{132},{133},{134},{135},{136},{137},{138},{139},
            {140},GetDate(),GetDate()) 
         UPDATE dbo.EpisodeTrace SET ASMTID =@@IDENTITY WHERE EpisodeID={0}",
        vmodel.EpisodeId, (string.IsNullOrEmpty(vmodel.PsyAsmt.WEIGHT) ? "null" : vmodel.PsyAsmt.WEIGHT), 
        (string.IsNullOrEmpty(vmodel.PsyAsmt.CHIEFCOMPLAINT) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.CHIEFCOMPLAINT) + "'"),
        (string.IsNullOrEmpty(vmodel.PsyAsmt.DISCONTINUEDMEDICATIONS) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.DISCONTINUEDMEDICATIONS) + "'"),
        (string.IsNullOrEmpty(vmodel.PsyAsmt.MEDICATIONCHANGES) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.MEDICATIONCHANGES) + "'"),
        (string.IsNullOrEmpty(vmodel.PsyAsmt.MEDICATIONSIDEEFFECTS) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.MEDICATIONSIDEEFFECTS) + "'"),
        (string.IsNullOrEmpty(vmodel.PsyAsmt.PREVPSYCHIATRICADMISSIONS) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.PREVPSYCHIATRICADMISSIONS) + "'"),
        (string.IsNullOrEmpty(vmodel.PsyAsmt.PREVSUICIDEATTEMPTS) ? "null" : vmodel.PsyAsmt.PREVSUICIDEATTEMPTS),
        (string.IsNullOrEmpty(vmodel.PsyAsmt.OUTPATIENTPSYCHIATRICCAREYEARS) ? "null" : vmodel.PsyAsmt.OUTPATIENTPSYCHIATRICCAREYEARS),
        (string.IsNullOrEmpty(vmodel.PsyAsmt.PREVDRUGDEPENDENCE) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.PREVDRUGDEPENDENCE) + "'"),
        (string.IsNullOrEmpty(vmodel.PsyAsmt.CURRENTDRUGDEPENDENCE) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.CURRENTDRUGDEPENDENCE) + "'"),
        (string.IsNullOrEmpty(vmodel.PsyAsmt.YEARSOFDRUGUSE) ? "null" : vmodel.PsyAsmt.YEARSOFDRUGUSE),
        (vmodel.PsyAsmt.DATEOFLASTDRUGUSE ==(DateTime?)null ? "null" : "'" + vmodel.PsyAsmt.DATEOFLASTDRUGUSE.Value.ToShortDateString() + "'"),
        (string.IsNullOrEmpty(vmodel.PsyAsmt.MEDICATIONALLERGIES) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.MEDICATIONALLERGIES) + "'"),
        (string.IsNullOrEmpty(vmodel.PsyAsmt.HOSPITALIZATIONS) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.HOSPITALIZATIONS) + "'"),
        (string.IsNullOrEmpty(vmodel.PsyAsmt.SURGERIES) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.SURGERIES) + "'"), HeadTraumaHistory,
        (string.IsNullOrEmpty(vmodel.PsyAsmt.HISTORYHEADTRAUMANOTE) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.HISTORYHEADTRAUMANOTE) + "'"),
        StrokeHistory, (string.IsNullOrEmpty(vmodel.PsyAsmt.HISTORYSTROKENOTE) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.HISTORYSTROKENOTE) + "'"),
        LossConsciousnessHistory, 
        (string.IsNullOrEmpty(vmodel.PsyAsmt.HISTORYLOSSCONSCIOUSNESSNOTE) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.HISTORYLOSSCONSCIOUSNESSNOTE) + "'"),
        SpinalCordInjuries, 
        (string.IsNullOrEmpty(vmodel.PsyAsmt.SPINALCORDINJURIESNOTE) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.SPINALCORDINJURIESNOTE) + "'"),
        SkeletalFracturesOrBrakes,
        (string.IsNullOrEmpty(vmodel.PsyAsmt.SKELETALFRACTURESBRAKESNOTE) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.SKELETALFRACTURESBRAKESNOTE) + "'"),
        MVA, (string.IsNullOrEmpty(vmodel.PsyAsmt.MVANOTE) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.MVANOTE) + "'"), GunshotWounds,
        (string.IsNullOrEmpty(vmodel.PsyAsmt.GUNSHOTWOUNDSNOTE) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.GUNSHOTWOUNDSNOTE) + "'"), SeizuresHistory,
        (string.IsNullOrEmpty(vmodel.PsyAsmt.HISTORYOFSEIZURESNOTE) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.HISTORYOFSEIZURESNOTE) + "'"), 
        MigraineHAHistory,
        (string.IsNullOrEmpty(vmodel.PsyAsmt.HISTORYMIGRAINEHANOTE) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.HISTORYMIGRAINEHANOTE) + "'"), HeartDisease,
        (string.IsNullOrEmpty(vmodel.PsyAsmt.HEARTDISEASENOTE) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.HEARTDISEASENOTE) + "'"), Asthma,
        (string.IsNullOrEmpty(vmodel.PsyAsmt.ASTHMANOTE) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.ASTHMANOTE) + "'"), COPD,
        (string.IsNullOrEmpty(vmodel.PsyAsmt.COPDNOTE) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.COPDNOTE) + "'"), Diabetes,
        (string.IsNullOrEmpty(vmodel.PsyAsmt.DIABETESNOTE) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.DIABETESNOTE) + "'"), Hyperlipidemia,
        (string.IsNullOrEmpty(vmodel.PsyAsmt.HYPERLIPIDEMIANOTE) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.HYPERLIPIDEMIANOTE) + "'"), Hypertension,
        (string.IsNullOrEmpty(vmodel.PsyAsmt.HYPERTENSIONNOTE) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.HYPERTENSIONNOTE) + "'"), Hepatitis,
        (string.IsNullOrEmpty(vmodel.PsyAsmt.HEPATITISNOTE) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.HEPATITISNOTE) + "'"), VDOrHIV,
        (string.IsNullOrEmpty(vmodel.PsyAsmt.VDHIVNOTE) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.VDHIVNOTE) + "'"), Anemia,
        (string.IsNullOrEmpty(vmodel.PsyAsmt.ANEMIANOTE) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.ANEMIANOTE) + "'"), ThyroidAbnormalities,
        (string.IsNullOrEmpty(vmodel.PsyAsmt.THYROIDABNORMALITIESNOTE) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.THYROIDABNORMALITIESNOTE) + "'"),
        Glaucoma,(string.IsNullOrEmpty(vmodel.PsyAsmt.GLAUCOMANOTE) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.GLAUCOMANOTE) + "'"), AbnormalLabResults,
        (string.IsNullOrEmpty(vmodel.PsyAsmt.ABNORMALLABRESULTSNOTE) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.ABNORMALLABRESULTSNOTE) + "'"), AbnormalEKG,
        (string.IsNullOrEmpty(vmodel.PsyAsmt.ABNORMALEKGNOTE) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.ABNORMALEKGNOTE) + "'"), CurrPregnancy,
        (string.IsNullOrEmpty(vmodel.PsyAsmt.CURRENTPREGNANCYNOTE) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.CURRENTPREGNANCYNOTE) + "'"), PriapismHistory,
        (string.IsNullOrEmpty(vmodel.PsyAsmt.HISTORYPRIAPISMNOTE) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.HISTORYPRIAPISMNOTE) + "'"), OtherChronicMediIll,
        (string.IsNullOrEmpty(vmodel.PsyAsmt.OTHERCHRONICMEDICALILLNESSNOTE) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.OTHERCHRONICMEDICALILLNESSNOTE) + "'"),(vmodel.PsyAsmt.NUMBERPREGNANCIES == 0 ? "null" : vmodel.PsyAsmt.NUMBERPREGNANCIES.ToString()),
        (vmodel.PsyAsmt.NUMBERDELIVERIES == 0 ? "null" : vmodel.PsyAsmt.NUMBERDELIVERIES.ToString()),
        (string.IsNullOrEmpty(vmodel.PsyAsmt.CURRENTHOUSING) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.CURRENTHOUSING) + "'"),
        (string.IsNullOrEmpty(vmodel.PsyAsmt.SUPPORTIVERELATIONSHIPS) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.SUPPORTIVERELATIONSHIPS) + "'"),
        (string.IsNullOrEmpty(vmodel.PsyAsmt.CURRENTEMPLOYMENT) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.CURRENTEMPLOYMENT) + "'"),
        (string.IsNullOrEmpty(vmodel.PsyAsmt.LASTEMPLOYED) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.LASTEMPLOYED) + "'"),
        (string.IsNullOrEmpty(vmodel.PsyAsmt.HIGHESTGRADECOMPLETED) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.HIGHESTGRADECOMPLETED) + "'"), IdentifyLearnDisablity,
        (string.IsNullOrEmpty(vmodel.PsyAsmt.IDENTIFIEDLEARNINGDISABILITYNOTE) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.IDENTIFIEDLEARNINGDISABILITYNOTE) + "'"),
        IntellectualImpairment,(string.IsNullOrEmpty(vmodel.PsyAsmt.INTELLECTUALIMPAIRMENT) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.INTELLECTUALIMPAIRMENT) + "'"),
        (string.IsNullOrEmpty(vmodel.PsyAsmt.HISOTRYINCARCERATION) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.HISOTRYINCARCERATION) + "'"), Appearance,
        PsychomotorActivity, AbnormalInvoluntaryMovement,
        (string.IsNullOrEmpty(vmodel.PsyAsmt.DISTRACTIBILITY) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.DISTRACTIBILITY) + "'"),
        (string.IsNullOrEmpty(vmodel.PsyAsmt.IMPULSIVITY) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.IMPULSIVITY) + "'"),
        (string.IsNullOrEmpty(vmodel.PsyAsmt.CONCENTRATION) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.CONCENTRATION) + "'"),
        (string.IsNullOrEmpty(vmodel.PsyAsmt.MEMORYREGISTRATION) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.MEMORYREGISTRATION) + "'"),
        (string.IsNullOrEmpty(vmodel.PsyAsmt.ANXIETYLEVEL) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.ANXIETYLEVEL) + "'"), ChildhoodMemo, 
        AdultMemPrevTraumatic, RptIntentPsyReactTrauMemo, RptAvoidSAWTrauMemo, RptFlashTrauMemo, RptRecurrDistressNMTrau,
        ObsessionsCompulsions, AppearsRespInternStimulus, Anhedonia, SLArticulation, SLRate, SLRhythm,
        (string.IsNullOrEmpty(vmodel.PsyAsmt.MOOD) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.MOOD) + "'"),
        (string.IsNullOrEmpty(vmodel.PsyAsmt.EUPHORIA) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.EUPHORIA) + "'"),
        (string.IsNullOrEmpty(vmodel.PsyAsmt.DEMEANOR) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.DEMEANOR) + "'"), Sleep,
        (string.IsNullOrEmpty(vmodel.PsyAsmt.PERIODSTIMETOOENERGIZEDTOSLEEP) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.PERIODSTIMETOOENERGIZEDTOSLEEP) + "'"),(string.IsNullOrEmpty(vmodel.PsyAsmt.APPETITE) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.APPETITE) + "'"),
        (string.IsNullOrEmpty(vmodel.PsyAsmt.ENERGYLEVEL) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.ENERGYLEVEL) + "'"),
        (string.IsNullOrEmpty(vmodel.PsyAsmt.LIBIDO) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.LIBIDO) + "'"), Irritability, RangeAffect,
        AppropriateContentSpeech, MoodCongruent, HomicidalIdeationPlanOrUntent, SuicidalIdeation, SuicidalPlan, SuicidalIntent,
        VisualHallucinations, AuditoryHallucinations, Insight,"null", ThoughtProcesses, RacingThoughts,
        (string.IsNullOrEmpty(vmodel.PsyAsmt.DELUSIONS) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.DELUSIONS) + "'"), GuardSuspicious, HyperVigilant,
        Preoccupation, (string.IsNullOrEmpty(vmodel.PsyAsmt.JUDGEMENT) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.JUDGEMENT) + "'"), ExaggPsySymptoms,
        "'" + medSym + "'", "'" + func + "'", "'" + recmd + "'", "'" + labs + "'",
        (string.IsNullOrEmpty(vmodel.PsyAsmt.LABSREQUESTEDOTHERNOTE) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.LABSREQUESTEDOTHERNOTE) + "'"), RTC,
        (vmodel.PsyAsmt.RTCAMOUNTWEEKS > 0 ? vmodel.PsyAsmt.RTCAMOUNTWEEKS.ToString() : "null"),"'" + discussed + "'",
        CurrentUser.UserID.ToString(), (vmodel.PsyAsmt.MMAID > 0 ? "2" : "1"), SexPreferenceGender,
        (string.IsNullOrEmpty(vmodel.PsyAsmt.SEXPREFERENCENOTE) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.SEXPREFERENCENOTE) + "'"),
        (string.IsNullOrEmpty(vmodel.PsyAsmt.CURRENTMEDICATIONS) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.CURRENTMEDICATIONS) + "'"),
        (string.IsNullOrEmpty(vmodel.PsyAsmt.PREVIOUSPSYCHIATRICMEDICATIONS) ? "null" : "'" + RemoveUnprintableChars(vmodel.PsyAsmt.PREVIOUSPSYCHIATRICMEDICATIONS) + "'"), CurrentUser.UserID.ToString());
                SaveQueryToFile(query);
                var result = SqlHelper.ExecuteCommand(query);
                
               return RedirectToAction("GetPsychiatry", new
                { EpisodeId = vmodel.EpisodeId, ActiveTab = "mma" });
            }
            return null;
        }
        private void SaveQueryToFile(string  query)
        {
            string logDir = WebConfigurationManager.AppSettings["ErrorLogDir"].ToString();
            if (string.IsNullOrEmpty(logDir))
                logDir = "Production";
            string logSubDir = WebConfigurationManager.AppSettings["Environment"].ToString();
            string logPath = Path.Combine(logDir, logSubDir);
            string mmafile = logPath + "\\PATSMMAQuery" + DateTime.Today.ToString("MMMddyyyy") + ".txt";
            if (!System.IO.File.Exists(mmafile))
            {
                System.IO.File.Create(mmafile).Close();
            }
            using (StreamWriter writer = System.IO.File.AppendText(mmafile))
            {
                writer.WriteLine("=========================================");
                string line = DateTime.Now.ToString("MM/dd/yyyy hh:mm ") + query;
                writer.WriteLine(line);
                writer.WriteLine("=========================================");
                writer.WriteLine();
                writer.Close();
            }
            return;
        }
        public MMA GetMMAData(int EpisodeId, int SelectedMMAID)
        {
            MMA epmma = new MMA();
            var parms = new List<ParameterInfo> {
                new ParameterInfo { ParameterName="EpisodeID", ParameterValue=EpisodeId },
                new ParameterInfo { ParameterName="SelectedMMAID", ParameterValue=SelectedMMAID } };
            return SqlHelper.GetRecord<MMA>("spGetEpisodeMMA", parms);
        }
        public JsonResult GetMMADateList(int EpisodeID)
        {
            var query = string.Format(@"DECLARE @EpisodeID int = {0} 
                 DECLARE @ID int = (SELECT ISNULL(ASMTID,0) FROM EpisodeTrace WHERE EpisodeID = @EpisodeID) 
                 IF @ID = 0
                  SELECT 0 AS MMAID, (FORMAT(GetDate(),'MM-dd-yyyy') + '*')MMADate
                 ELSE 
                    SELECT Id as MMAID, (FORMAT(DateAction,'MM-dd-yyyy') + 
                          (CASE WHEN Id = @ID THEN '*' ELSE '' END))MMADate
                      FROM dbo.PsychiatryASMT Where EpisodeID = @EpisodeID AND ActionStatus <> 10 ORDER BY DateAction DESC", EpisodeID);

            var dates = SqlHelper.ExecuteCommands<MMADates>(query);
            return Json(dates, JsonRequestBehavior.AllowGet);
        }
        #endregion Psychiatry
        #region Evaluation
        public ActionResult GetInitialEval(int EpisodeId, string ActiveTabIn = "")
        {
            return PartialView("_Evaluation", new EvaluationViewModel
            {
                EpisodeId = EpisodeId,
                CanEdit = this.CanEditClient,
                SelectedStaffId = CurrentUser.UserID.ToString(),
                ActiveTabIn = ActiveTabIn,   
            });
        }
        public ActionResult GetEvaluationHis(int EpisodeId)
        {
            return PartialView("_EvaluationHis", new EvaluationViewModel
            {
                EpisodeId = EpisodeId,
            });
        }
        public ActionResult EvaluationHisRead([DataSourceRequest] DataSourceRequest request, int EpisodeId)
        {
            List<EvaluationData> evlHis = GetEvaluationItemList(EpisodeId, -1);
            return Json(evlHis.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetEvaluationItems(int EpisodeId, int EvaluationID)
        {       
            var dataSet = GetEvaluationItemList(EpisodeId, EvaluationID);
            var firstEvl = dataSet.FirstOrDefault();
            string selectedPsychiatrist = firstEvl.EvaluatedBy > 0 ?  firstEvl.EvaluatedBy.ToString() : CurrentUser.UserID.ToString();
            DateTime selectedEvaluationdate = firstEvl.EvaluationDate == null ? DateTime.Now : firstEvl.EvaluationDate;
            return PartialView("_EvaluationEditor", new EvaluationViewModel
            {
                CanEdit = this.CanEditClient,
                EpisodeId = EpisodeId,
                LoginStaffId = CurrentUser.UserID,
                EvaluationID = EvaluationID,
                SelectedEvaluationDate = selectedEvaluationdate,
                SelectedStaffId = selectedPsychiatrist,
                Evaluations = dataSet
            });
        }
        public JsonResult GetAllEvaluationStaffs()
        {
            var list = GetPatsStaff(null, null, null, -1).OrderBy(o => o.StaffName);
            return Json(list, JsonRequestBehavior.AllowGet);
        }
        public List<EvaluationData> GetEvaluationItemList(int EpisodeID, int EvaluationID)
        {
            var parms = new List<ParameterInfo> {
                new ParameterInfo { ParameterName= "EpisodeID" , ParameterValue = EpisodeID },
                new ParameterInfo { ParameterName= "EvaluationID" , ParameterValue = EvaluationID } };
            var results = SqlHelper.GetRecords<EvaluationData>("spGetEpisodeEvaluation", parms);
            
            return results;
        }
        public JsonResult GetEvlDateList(int EpisodeId)
        {
            var query = string.Format(@"DECLARE @EpisodeID int = {0} 
                 DECLARE @ID int = (SELECT ISNULL(EvaluationID,0) FROM EpisodeTrace WHERE EpisodeID = @EpisodeID) 
                 DECLARE @MaxDate DateTime = (Select Max(DateAction) FROM EpisodeEvaluation Where EpisodeID = @EpisodeID Group By EpisodeID)
                 IF @ID = 0
                  SELECT 0 AS EvaluationID, (FORMAT(GetDate(),'MM-dd-yyyy') + '*')EvaluationDate 
                 ELSE 
                    SELECT Id as EvaluationID, (FORMAT(DateAction,'MM-dd-yyyy') + 
                          (CASE WHEN DateAction = @MaxDate THEN '*' ELSE '' END))EvaluationDate
                      FROM dbo.EpisodeEvaluation Where EpisodeID = @EpisodeID AND ActionStatus <> 10 AND EvaluationItemId = 1 ORDER BY DateAction DESC", EpisodeId);

            var dates = SqlHelper.ExecuteCommands<EvaluationDates>(query);
            return Json(dates, JsonRequestBehavior.AllowGet);
        }
        public ActionResult SaveEvaluation(EvaluationViewModel evaluation)
        {
           
           if (ModelState.IsValid)
            {
                var inital = evaluation.Evaluations[0].IsInitial ? 1 : 0;
                var guid = (inital == 0 ? evaluation.Evaluations[0].EvaluationGUID : Guid.NewGuid().ToString());
                var userid = evaluation.SelectedStaffId;
                var query = string.Format(@" DECLARE @EpisodeID int = {0} DECLARE @evlID int = 0  DECLARE @evlDate DateTime = GetDate() DECLARE @status int = 1 
                                             DECLARE @initial bit = {1} IF (SELECT ISNULL(EvaluationID, 0) FROM EpisodeTrace WHERE EpisodeID = @EpisodeID) > 0 
                                               BEGIN IF @initial = 1  SET @status = 3 ELSE SET @status = 2 END ",evaluation.EpisodeId, inital);

                foreach (var item in evaluation.Evaluations)
                {
                    var query1 = string.Format(@" INSERT INTO [dbo].[EpisodeEvaluation]([EpisodeEvaluationGUID],[EpisodeID],[EvaluationItemId],[EvaluationNote],
                                               [EvaluatedBy],[ActionStatus],[ActionBy],[DateAction]) VALUES ({4},@EpisodeID, {0},{1},{2},@status,{3}, @evlDate) ",
                     item.EvaluationItemID, string.IsNullOrEmpty(item.EvaluationItemNote) ? "null" : "'" + RemoveUnprintableChars(item.EvaluationItemNote) + "'",
                     (string.IsNullOrEmpty(userid) ?  CurrentUser.UserID.ToString() : userid), CurrentUser.UserID, "'" + guid + "'");
                    query = query + query1;
                    if (item.EvaluationItemID == 1)
                    {
                        query = query + " SET @evlID = @@IDENTITY ";
                    }
                }
                query = query + " UPDATE EpisodeTrace SET EvaluationID= @evlID WHERE EpisodeID = @EpisodeID ";
                var result = SqlHelper.ExecuteCommand(query);
                SaveQueryToFile(query);
                return RedirectToAction("GetInitialEval", new
                {
                    EpisodeId = evaluation.EpisodeId,
                    ActiveTabIn = "evaluationmain"
                });
            }
            return null;
        }
        #endregion Evaluation
        #region Legal Doc
        public ActionResult GetLegalDocument(int EpisodeId, string ActiveTabIn = "")
        {
            return PartialView("_LegalDocument", new LegalDocumentViewModel
            {
                EpisodeId = EpisodeId,
                CanEdit = this.CanEditClient,
                ActiveTabIn = "legaldocChecklist"
            });
        }
        public ActionResult LegalDocRelease_Destroy([DataSourceRequest] DataSourceRequest request, int EpisodeId, int DocId)
        {
            DeleteLegalDocument(EpisodeId, DocId);
            List<LegalDocumentData> docs = GetLegalDocumentList(EpisodeId, -1);
            return Json(docs.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }
        public ActionResult LegalDocRelease_read([DataSourceRequest] DataSourceRequest request, int EpisodeId)
        {
            List<LegalDocumentData> docs = GetLegalDocumentList(EpisodeId, -1);
            if (docs.Count() == 1 && docs[0].Id == 0) docs = new List<LegalDocumentData>();
            return Json(docs.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        private List<LegalDocumentData>GetLegalDocumentList(int EpisodeId, int DocId)
        {
            var Parms = new List<ParameterInfo> {
                new ParameterInfo { ParameterName="EpisodeID", ParameterValue=EpisodeId },
                new ParameterInfo { ParameterName="DocID", ParameterValue=DocId }
            };          
            return SqlHelper.GetRecords<LegalDocumentData>("spGetEpisodeLegalDoc", Parms);
        }            
        public LegalDocumentData GetSelectedData(int EpisodeID, int DocId)
        {
             return GetLegalDocumentList(EpisodeID, DocId).FirstOrDefault();
        }
        public ActionResult GetLegalDocumentCheckList(int EpisodeId, int DocId)
        {
            var legalDocumentDataSet = GetLegalDocumentList(EpisodeId, DocId);
            LegalDocumentData docData = null;
            if (DocId > 0) {
                docData = legalDocumentDataSet.Where(x => x.Id == DocId).FirstOrDefault();
            }
            else
                docData = legalDocumentDataSet.Where(x=>x.IsLastOne == true).FirstOrDefault();
           
            return PartialView("_LegalDocumentCheckList", new LegalDocumentViewModel { CanEdit = this.CanEditClient, EpisodeId = EpisodeId, legDoc = docData });
        }
        public void DeleteLegalDocument(int EpisodeId, int DocId)
        {
            if (DocId > 0)
            {
                var query = string.Format(@"DECLARE @LastOne int = (SELECT ISNULL(LegalDocID, 0) FROM EpisodeTrace WHERE EpisodeID = {0}) 
                      UpDate dbo.LegalDocument SET ActionStatus = 10, DateAction = GetDate() Where Id ={1}
                      IF @LastOne = {1} 
                       BEGIN 
                         DECLARE @id int =(SELECT TOP 1 Id FROM dbo.LegalDocument WHERE EpisodeID = {0} AND ActionStatus <> 10 ORDER BY Id DESC) 
                         Update dbo.EpisodeTrace SET LegalDocID = @id WHERE EpisodeID = {0}  
                       END", EpisodeId, DocId);
                var result = SqlHelper.ExecuteCommand(query);
            }
             return;
        }
        public ActionResult SaveLegalDocument(LegalDocumentViewModel lgDocument)
        {
            if (ModelState.IsValid)
            {
                var query = string.Format(@" DECLARE @EpisodeID int = {0} DECLARE @status int = 1 IF (SELECT ISNULl(LegalDocID, 0) FROM dbo.EpisodeTrace Where EpisodeID ={0}) > 0 SET @status = 2 INSERT INTO dbo.LegalDocument ([EpisodeId],[ReleaseInformationsNote],[ReleaseTo],[ReleaseFrom],[OtherDdesc]
           ,[DateReleaseInfoExpiration],[DateNoticePrivacyPractice],[DateInformedConcentForTreatment],[DateOther]
           ,[ActionBy],[ActionStatus],[DateAction]) VALUES({0},{1},{2},{3},{4},{5},{6},{7},{8},{9},@status,GetDate()) Update dbo.EpisodeTrace SET LegalDocID = @@IDENTITY WHERE EpisodeID = @EpisodeID ", lgDocument.EpisodeId, 
           (string.IsNullOrEmpty(lgDocument.legDoc.ReleaseInformationsNote) ? "null" : "'" + RemoveUnprintableChars(lgDocument.legDoc.ReleaseInformationsNote) + "'"),
           (string.IsNullOrEmpty(lgDocument.legDoc.ReleaseTo) ? "null": "'" + RemoveUnprintableChars(lgDocument.legDoc.ReleaseTo) + "'"),
           (string.IsNullOrEmpty(lgDocument.legDoc.ReleaseFrom) ? "null" : "'" + RemoveUnprintableChars(lgDocument.legDoc.ReleaseFrom) + "'"),
           (string.IsNullOrEmpty(lgDocument.legDoc.OtherDdesc) ? "null" : "'" + RemoveUnprintableChars(lgDocument.legDoc.OtherDdesc) + "'"),
           (lgDocument.legDoc.DateReleaseInfoExpiration == (DateTime?)null ? "null" : "'" + lgDocument.legDoc.DateReleaseInfoExpiration + "'"),
           (lgDocument.legDoc.DateNoticePrivacyPractice == (DateTime?)null ? "null" : "'" + lgDocument.legDoc.DateNoticePrivacyPractice + "'"),
           (lgDocument.legDoc.DateInformedConcentForTreatment == (DateTime?)null ? "null" : "'" + lgDocument.legDoc.DateInformedConcentForTreatment + "'"),
           (lgDocument.legDoc.DateOther == (DateTime?)null ? "null" : "'" + lgDocument.legDoc.DateOther + "'"), CurrentUser.UserID);

                var result = SqlHelper.ExecuteCommand(query);

                return RedirectToAction("GetLegalDocument", new
                {
                    EpisodeId = lgDocument.EpisodeId,
                    ActionTabIn = "legaldocChecklist"
                });
            }
            else
            //lgDocument.data.Failed = true;

            return PartialView("_LegalDocumentCheckList", ModelState);
        }
        #endregion Legal Doc
        #region print
        private RptClientInfo GetReportClientInfo(int EpisodeID)
        {
            var queryheader = string.Format(@"DECLARE @EpisodeID int = {0} SELECT t1.CDCRNum, (SELECT Name FROM dbo.fn_GetClientName(@EpisodeID))PAROLEENAME, 
 t1.ParoleUnit,  (CASE WHEN ISNULl(t1.ReleaseCountyID, 0)= 0 THEN '' ELSE ISNULL(t3.Region, '') END)ParoleRegion,t1.ParoleAgent, t1.ReleaseDate,t2.PC290, 
t2.DOB, t2.GenderID, (SELECT dbo.fnGetMHStatusDesc((SELECT ClientEpisodeID FROM EpisodeTrace WHERE EpisodeID = @EpisodeID), @EpisodeID))MhStatus,
FORMAT(GetDate(), 'MM/dd/yyyy')PrintDate FROM dbo.Episode t1 INNER JOIN Offender t2 on t1.OffenderID = t2.OffenderID 
LEFT OUTER JOIN dbo.tlkpCounty t3 ON t1.ReleaseCountyID = t3.CountyID WHERE EpisodeID = @EpisodeID", EpisodeID);
            return SqlHelper.ExecuteCommands<RptClientInfo>(queryheader).FirstOrDefault();
        }
        public ActionResult PrintCaseNote(int EpisodeId, int CaseNoteId)
        {
            //get login user name 
            string loginUser = "";
            if (CurrentUser == null)
                loginUser = HttpContext.Application["LoginUserName"].ToString();
            else
                loginUser = CurrentUser.UserLFI();

            string psychiatristName = string.Empty;

            //CaseNoteInfo cmNote = new CaseNoteInfo();
            var query = string.Format(@"DECLARE @EpisodeID int = {0} DECLARE @NoteID int = {1} SELECT t2.id, t2.CaseNoteId, t3.CDCRNum, 
                   (SELECT Name FROM dbo.fn_GetClientName(t2.EpisodeID))ClientName, Format(t2.DateAction, 'MM/dd/yyyy')NoteDate, 
                   (SELECT dbo.fnGetCaseNoteTypeDesc(t2.CaseNoteTypeID))NoteType, (SELECT dbo.fnGetCaseContactMethodDesc(t2.CaseContactMethodID))ContactMethod, 
                   (SELECT Name FROM dbo.fn_GetAsstUserName(t2.ActionBy))EnteredBy,t2.Note, (SELECT dbo.fnGetCaseNoteTypeDesc(ISNULL(t4.CaseWorkerTypeId, 0)))CaseWorkerType 
                 FROM dbo.CaseNoteTrace t1 INNER JOIN dbo.CaseNote t2 ON t1.NoteId = t2.ID INNER JOIN dbo.Episode t3 on t2.EpisodeID = t3.EpisodeID 
                 INNER JOIN dbo.[User] t4 on t2.ActionBy = t4.UserID WHERE t2.EpisodeID = @EpisodeID AND t2.ID = @NoteID", EpisodeId, CaseNoteId);

            var cmNote = SqlHelper.ExecuteCommands<CaseNoteInfo>(query).FirstOrDefault();
            
            if (!string.IsNullOrEmpty(cmNote.Note))
            {
                var charReplacements = new Dictionary<string, string> {
                        { "&lt;", "<" },{ "&gt;", ">" }
                    };
                var str = string.Join("|", charReplacements.Keys.Select(k => k.ToString()).ToArray());
                cmNote.Note = Regex.Replace(cmNote.Note, string.Join("|", charReplacements.Keys
                   .Select(k => k.ToString()).ToArray()), m => charReplacements[m.Value]);
            }

            if (string.IsNullOrEmpty(cmNote.EnteredBy))
            {
                cmNote.EnteredBy = loginUser;
            }
            PrintPATSPDF ppdf = new PrintPATSPDF();
            Byte[] bytes = ppdf.GenerateCaseNoteStream(loginUser, cmNote);

            //Response.AppendHeader("Content-Disposition", "inline; filename=CaseNote.pdf");
            return File(bytes, "pdf", "CaseNote.pdf");
        }
        public ActionResult PrintIRP(int EpisodeId, int IRPID)
        {
            MemoryStream outputStream = new MemoryStream();
            try
            {
                string filePath = WebConfigurationManager.AppSettings["PMHSTemplateFileDir"];
                string TemplateFile = Path.Combine(filePath, "CDCR2276CASEIRP.pdf");
                PdfReader reader = new PdfReader(TemplateFile);

                var queryheader = GetReportClientInfo(EpisodeId);

                Dictionary<string, string> dictionary = new Dictionary<string, string>();
                dictionary.Add("PAROLEENAME", queryheader.PAROLEENAME);
                dictionary.Add("ParoleUnit", queryheader.ParoleUnit);
                dictionary.Add("CDCRNum", queryheader.CDCRNum);
                dictionary.Add("ParoleRegion", queryheader.ParoleRegion == "S" ? "Southern" : "Northern");
                dictionary.Add("ParoleAgent", queryheader.ParoleAgent);                
                dictionary.Add("PrintDate", "Printed at: " + queryheader.PrintDate);

                //get data from IRP
                var query = GetIRPListData(EpisodeId, IRPID);

                if (query != null && query.Count() > 0)
                {
                    dictionary.Add("CLINICALCASEMANAGERCCMASSIGNED", query[0].ActionName);
                    dictionary.Add("DATEPREPARED", query[0].DateAction.ToString("MM/dd/yyyy"));
                    dictionary.Add("InitialPlan", query[0].ActionStatus == 1 ? "Yes" : "");
                    dictionary.Add("UpdatePlan", query[0].ActionStatus == 2 ? "Yes" : "");

                    foreach (var item in query.ToList())
                    {
                        //var q1 = query.Where(x => x.NeedId == 1).FirstOrDefault();
                        dictionary.Add("Need" + item.NeedId.ToString(), item.DescriptionCurrentNeed);
                        dictionary.Add("SHORTTERM" + item.NeedId.ToString(), item.ShortTermGoal);
                        dictionary.Add("LONGTERM" + item.NeedId.ToString(), item.LongTermGoal);
                        dictionary.Add("PLANNEDINTERVENTION" + item.NeedId.ToString(), item.PlanedIntervention);
                        dictionary.Add("Met" + item.NeedId.ToString(), item.LongTermStatusMet.HasValue && item.LongTermStatusMet.Value == true ? "Yes" : "");
                        dictionary.Add("NotMet" + item.NeedId.ToString(), item.LongTermStatusNoMet.HasValue && item.LongTermStatusNoMet.Value == true ? "Yes" : "");
                        dictionary.Add("DATEMET" + item.NeedId.ToString(), item.LongTermStatusDate.HasValue ? item.LongTermStatusDate.Value.ToString("MM/dd/yyyy") : "");
                    }
                }

                outputStream = CreatePDFString(reader, dictionary, '\0');
            }
            catch (IOException ex)
            {
            }
            //Response.AppendHeader("Content-Disposition", "inline; filename=ClientCaseIrp.pdf");
            return File(outputStream.ToArray(), "pdf", "ClientCaseIrp.pdf");
        }
        //DSM-5 Self-Rated Level 1 Cross-Cutting Symptom Measure--Adult
        public ActionResult PrintDSM5(int EpisodeId, int DSM5ID)
        {
            var header = GetReportClientInfo(EpisodeId);
            Dictionary<string, string> dictionary = new Dictionary<string, string>();
            dictionary.Add("Name", header.PAROLEENAME);
            dictionary.Add("Age",  header.DOB.HasValue ? GetAge(header.DOB.Value).ToString() : "");
            dictionary.Add("Sex", header.GenderID.ToString() );
            dictionary.Add("Date", header.ReleaseDate.HasValue  ? header.ReleaseDate.Value.ToString("MM/dd/yyyy") : "");
            dictionary.Add("PrintDate", DateTime.Now.ToString("MM/dd/yyyy"));

            var DSM5List = GetDSM5ListData(EpisodeId, DSM5ID).EpisodeDSM5;

            dictionary.Add("LoginUser", CurrentUser.UserLFI());

            PrintPATSPDF ppdf1 = new PrintPATSPDF();
            Byte[] bytes = ppdf1.GenerateDSM5Stream(CurrentUser.UserLFI(), dictionary, DSM5List);
            return File(bytes, "pdf", "EpisodeDSM5.pdf");
        }
        
        public ActionResult PrintPMH1(int EpisodeId)
        {
            string filePath = WebConfigurationManager.AppSettings["PMHSTemplateFileDir"];
            string TemplateFile = Path.Combine(filePath, "CDCR128PMH1Revised.pdf");

            // open the reader
            MemoryStream outputStream = new MemoryStream();
            try
            {
                PdfReader reader = new PdfReader(TemplateFile);

                var queryheader = GetReportClientInfo(EpisodeId);
                var region = (queryheader.ParoleRegion == "" ? "" : (queryheader.ParoleRegion == "S" ? "Southern" : "Northern"));
                Dictionary<string, string> dictionary = new Dictionary<string, string>();
                dictionary.Add("ParoleeName", queryheader.PAROLEENAME);
                dictionary.Add("ParoleUnit", queryheader.ParoleUnit);
                dictionary.Add("CDC", queryheader.CDCRNum);
                dictionary.Add("ParoleRegion", region);
                dictionary.Add("ReferralDate", queryheader.PrintDate);
                dictionary.Add("MHId", queryheader.MhStatus);
                var Parms = new List<ParameterInfo>
            {
                new ParameterInfo { ParameterName = "EpisodeID", ParameterValue= EpisodeId },
                new ParameterInfo { ParameterName = "PMHSID", ParameterValue= 0 }
            };
                var val = SqlHelper.GetRecords<ClinicalPMHSData>("spGetEpisodeClinicalPMHS", Parms).FirstOrDefault();

      //          SELECT[Id],[EpisodeID],[InclusionInPMHS],[MentalDisorder],[RefForWelfare]
      //,[RefToContratedService],[TeamLeaderName],[SupervisorName]
      //,[TeamLeaderSigDate],[SupervisorSigDate],[RefToContratedServiceNote]
      //,[RefForResourcePlan],[RefForResourcePlanNote],[RefForDischarge]
      //,[Other] ,[OtherNote],[LGAFScore],[PsychottropicPrescribed]
      //,[PMHSDischargeType],[BehavioralAlerts],[LTDFNLE]
      //,[PMHSChangeNote],[PMHSChangeDate],[PMHSDischargeNote]
      //,[PMHSDischargeDate],[ActionBy],[ActionStatus],[DateAction],[ClinicianName]
      //  FROM[dbo].[ClinicalPMHS]
      //  WHERE EpisodeID = { 0 }

                //var val = db.ClinicalPMHSs.Where(x => x.EpisodeID == EpisodeId).OrderByDescending(o => o.Id).FirstOrDefault();
                if (val != null)
                {
                    //clinicianName = db.Users.Find(val.ActionBy).LastFirstMI;
                    var values2 = new
                    {
                        ClinicianName = string.IsNullOrEmpty(val.ClinicianName) ? CurrentUser.UserLFI() : val.ClinicianName,
                        BehavioralAlerts = val.BehavioralAlerts,
                        ForMedicalNecessity = (val.ForMedicalNecessity ? "On" : ""),
                        InclusionInPMHSNotMeet = (val.InclusionInPMHSNoMeet ? "On" : ""),
                        InclusionInPMHSMeets = (val.InclusionInPMHSMeet ? "On" : ""),
                        InclusionInPMHSCurrent = (val.InclusionInPMHSCurrent ? "On" : ""),
                        MentalHealthDesignationCCCMS = (val.ForCCCMS ? "On" : ""),
                        MentalHealthDesignationCCCMS1 = (val.ForConstituteToCCCMS  ? "On" : ""),
                        MentalHealthDesignationEOP = (val.ForEOP ? "On" : ""),
                        MentalHealthDesignationEOP1 = (val.ForConstituteToEOP ? "On" : ""),
                        Score = (val.LGAFScore.HasValue ? val.LGAFScore.Value.ToString() : ""),
                        MentalDisorder = (val.MentalDisorder ? "On" : ""),
                        Other = (val.Other ? "On" : ""),
                        OtherNote = val.OtherNote,
                        PMHSChangeNote = val.PMHSChangeNote,
                        Yes = (val.PsychottropicPrescribedYes ? "On" : ""),
                        No = (val.PsychottropicPrescribedNo ? "On" : ""),
                        RefForResourcePlan = (val.RefForResourcePlan ? "On" : ""),
                        RefForResourcePlanNote = val.RefForResourcePlanNote,
                        RefForWelfare = (val.RefForWelfare ? "On" : ""),
                        RefForDischarge = (val.RefForDischarge ? "On" : ""),
                        RefToContratedService = (val.RefToContratedService ? "On" : ""),
                        RefToContratedServiceNote = val.RefToContratedServiceNote,
                        SupervisorName = val.SupervisorName,
                        TeamLeaderName = val.TeamLeaderName,
                        DateAction = val.DateAction.ToString("MM/dd/yyyy")
                    };
                    GetParameters(values2, (int)ControllerID.Client).ToList().ForEach(x => dictionary.Add(x.Key, x.Value));
                }
                else
                {
                    var values3 = new
                    {
                        ClinicianName = CurrentUser.UserLFI(),
                        BehavioralAlerts = "",
                        ForMedicalNecessity = "",
                        InclusionInPMHSNotMeet = "",
                        InclusionInPMHSMeets = "",
                        InclusionInPMHSCurrent = "",
                        MentalHealthDesignationCCCMS = "",
                        MentalHealthDesignationCCCMS1 = "",
                        MentalHealthDesignationEOP = "",
                        MentalHealthDesignationEOP1 = "",
                        Score = "",
                        MentalDisorder = "",
                        Other = "",
                        OtherNote = "",
                        PMHSChangeNote = "",
                        Yes = "",
                        No = "",
                        RefForResourcePlan = "",
                        RefForResourcePlanNote = "",
                        RefForWelfare = "",
                        RefForDischarge = "",
                        RefToContratedService = "",
                        RefToContratedServiceNote = "",
                        SupervisorName = "",
                        TeamLeaderName = "",
                        DateAction=""
                    };
                    GetParameters(values3, (int)ControllerID.Client).ToList().ForEach(x => dictionary.Add(x.Key, x.Value));
                }
                outputStream = CreatePDFString(reader, dictionary, '\0');
            }
            catch (IOException ex)
            {
                //RedirectToAction("Error", "Home");
                return null;
            }
            //Response.AppendHeader("Content-Disposition", "inline; filename=PrintPMH1.pdf");
            return File(outputStream.ToArray(), "pdf", "PrintPMH1.pdf");
        }
        public ActionResult PrintPMH2(int EpisodeId)
        {
            string filePath = WebConfigurationManager.AppSettings["PMHSTemplateFileDir"];
            string TemplateFile = Path.Combine(filePath, "CDCR128PMH2Revised.pdf");


            // open the reader
            MemoryStream outputStream = new MemoryStream();
            try
            {
                PdfReader reader = new PdfReader(TemplateFile);

                var queryheader = GetReportClientInfo(EpisodeId);
                var region = (queryheader.ParoleRegion == "" ? "" : (queryheader.ParoleRegion == "S" ? "Southern" : "Northern"));
                Dictionary<string, string> dictionary = new Dictionary<string, string>();
                dictionary.Add("ParoleeName", queryheader.PAROLEENAME);
                dictionary.Add("ParoleUnit", queryheader.ParoleUnit);
                dictionary.Add("CDC", queryheader.CDCRNum);
                dictionary.Add("ParoleRegion", region);
                //dictionary.Add("ParoleAgent", queryheader.ParoleAgent);
                //dictionary.Add("ReferralDate", queryheader.PrintDate);
                //dictionary.Add("MHId", queryheader.MhStatus);
                //get data from episode
                //var values = db.Episodes.Where(x => x.EpisodeID == EpisodeId).Select(s => new {
                //    ParoleeName = s.Offender.LastName + ", " + s.Offender.FirstName + " " + s.Offender.MiddleName ?? " ",
                //    ParoleUnit = s.ParoleUnit,
                //    CDC = s.CDCRNum,
                //    ParoleRegion = (string)(s.ReleaseCounty.Region == "S" ? "Southern" : "Northern"),
                //    //ReferralDate = s.ReferralDate
                //}).FirstOrDefault();

                //Dictionary<string, string> dictionary = GetParameters(values, (int)ControllerID.SocialWork);

                var Parms = new List<ParameterInfo>
                {
                   new ParameterInfo { ParameterName = "EpisodeID", ParameterValue= EpisodeId },
                   new ParameterInfo { ParameterName = "PMHSID", ParameterValue= 0 }
                };
                var query = SqlHelper.GetRecords<ClinicalPMHSData>("spGetEpisodeClinicalPMHS", Parms).FirstOrDefault();
                //string clinicianName = string.Empty;
                //var query1 = db.ClinicalPMHSs.Where(x => x.EpisodeID == EpisodeId).OrderByDescending(o => o.DateAction).FirstOrDefault();
                if (query != null)
                {
                    var id = query.Id;
                    //clinicianName = db.Users.Find(query1.ActionBy).LastFirstMI;  //get clinician name 
                    var values2 = new
                        //db.ClinicalPMHSs.Where(x => x.EpisodeID == EpisodeId && x.Id == id).Select(query => new
                    {
                        ClinicianName = string.IsNullOrEmpty(query.ClinicianName) ? CurrentUser.UserLFI() : query.ClinicianName,
                        PMHSDischargeA = (query.PMHSDischargeA ? "On" : ""),
                        PMHSDischargeB = (query.PMHSDischargeB ? "On" : ""),
                        PMHSDischargeC = (query.PMHSDischargeC ? "On" : ""),
                        PMHSDischargeD = (query.PMHSDischargeD ? "On" : ""),
                        PMHSDischargeDateAM = ((query.PMHSDischargeType.HasValue && query.PMHSDischargeType.Value == 1) ? query.PMHSDischargeDate.Value.Month.ToString().PadLeft(2, '0') : ""),
                        PMHSDischargeDateAD = ((query.PMHSDischargeType.HasValue && query.PMHSDischargeType.Value == 1) ?  query.PMHSDischargeDate.Value.Day.ToString().PadLeft(2, '0') : "" ),
                        PMHSDischargeDateAY = ((query.PMHSDischargeType.HasValue && query.PMHSDischargeType.Value == 1) ? query.PMHSDischargeDate.Value.Year.ToString() : ""),
                        PMHSDischargeDateBM = ((query.PMHSDischargeType.HasValue && query.PMHSDischargeType.Value == 2) ?  query.PMHSDischargeDate.Value.Month.ToString().PadLeft(2,'0') : ""),
                        PMHSDischargeDateBD = ((query.PMHSDischargeType.HasValue && query.PMHSDischargeType.Value == 2) ? query.PMHSDischargeDate.Value.Day.ToString().PadLeft(2, '0') : ""),
                        PMHSDischargeDateBY = ((query.PMHSDischargeType.HasValue && query.PMHSDischargeType.Value == 2) ? query.PMHSDischargeDate.Value.Year.ToString() : ""),
                        PMHSDischargeNote = query.PMHSDischargeNote,
                        TeamLeaderName = query.TeamLeaderName,
                        SupervisorName = query.SupervisorName,
                        DateAction = query.DateAction
                    };

                    GetParameters(values2, (int)ControllerID.Client).ToList().ForEach(x => dictionary.Add(x.Key, x.Value));
                }
                else
                {
                    var values3 = new
                    {
                        PMHSDischargeA = "",
                        PMHSDischargeB = "",
                        PMHSDischargeC = "",
                        PMHSDischargeD = "",
                        PMHSDischargeDateAM = "",
                        PMHSDischargeDateAD = "",
                        PMHSDischargeDateAY = "",
                        PMHSDischargeDateBM = "",
                        PMHSDischargeDateBD = "",
                        PMHSDischargeDateBY = "",
                        PMHSDischargeNote = "",
                        TeamLeaderName = "",
                        SupervisorName = "",
                        ClinicianName = CurrentUser.UserLFI(),
                    };
                    GetParameters(values3, (int)ControllerID.Client).ToList().ForEach(x => dictionary.Add(x.Key, x.Value));
                }

                outputStream = CreatePDFString(reader, dictionary, '\0');
            }
            catch (IOException ex)
            {
                //RedirectToAction("Error", "Home");
                return null;
            }
            //Response.AppendHeader("Content-Disposition", "inline; filename=PrintPMH2.pdf");
            return File(outputStream.ToArray(), "pdf", "PrintPMH2.pdf");
        }
        public ActionResult PrintClinicalIDTT(int EpisodeId, int IDTTId)
        {
            string filePath = WebConfigurationManager.AppSettings["PMHSTemplateFileDir"];
            string TemplateFile = Path.Combine(filePath, "ClinicalIDTT.pdf");

            // open the reader
            MemoryStream outputStream = new MemoryStream();
            try
            {
                PdfReader reader = new PdfReader(TemplateFile);
                var header = GetReportClientInfo(EpisodeId);

                Dictionary<string, string> dictionary = new Dictionary<string, string>();
                //get data from episode
                dictionary.Add("PAROLEENAME", header.PAROLEENAME);
                dictionary.Add("PAROLEUNIT", header.ParoleUnit);
                dictionary.Add("CDCRNUMBER", header.CDCRNum);
                dictionary.Add("REGION", (header.ParoleRegion=="" ? "" : header.ParoleRegion));
                dictionary.Add("PrintDate", "Printed at: " + header.PrintDate);
                //get idtt set
                List<ParameterInfo> parms = new List<ParameterInfo> {
                { new ParameterInfo {  ParameterName= "EpisodeID", ParameterValue = EpisodeId } },
                { new ParameterInfo {  ParameterName= "IDTTID", ParameterValue = IDTTId }} };
                List<string> objlist = new List<string>();
                objlist.Add("ClinicalIDTTData");
                objlist.Add("FinalRecommendations");
                var results = SqlHelper.GetMultiRecordsets<object>("spGetEpisodeIDTT", parms, objlist);
                var query = (ClinicalIDTTData)results[0];

                dictionary.Add("CLINICIANNAMEPRINT", query.ActionByName);
                dictionary.Add("DATE", query.IDTTDate.HasValue ? query.IDTTDate.Value.ToShortDateString() : "");
                dictionary.Add("IDTTDecision", query.IDTTDecision.HasValue ? query.IDTTDecision.Value.ToString() : "");
                var attendences = (string.IsNullOrEmpty(query.MemeberAttendance) ? "" : query.MemeberAttendance).Split(',');
                dictionary.Add("ClinicalSW", Array.IndexOf(attendences, "1") >= 0 ? "Yes" : "");
                dictionary.Add("Psychologist", Array.IndexOf(attendences, "2") >= 0 ? "Yes" : "");
                dictionary.Add("Psychiatrist", Array.IndexOf(attendences, "3") >= 0 ? "Yes" : "");
                dictionary.Add("CaseManager", Array.IndexOf(attendences, "4") >= 0 ? "Yes" : "");
                dictionary.Add("ParoleAgent", Array.IndexOf(attendences, "5") >= 0 ? "Yes" : "");
                dictionary.Add("Parolee", Array.IndexOf(attendences, "6") >= 0 ? "Yes" : "");
                dictionary.Add("Other", Array.IndexOf(attendences, "7") >= 0 ? "Yes" : "");
                dictionary.Add("OtherAttendance", string.IsNullOrEmpty(query.OtherMemeberAttendance) ? "" : query.OtherMemeberAttendance);
                dictionary.Add("CURRENTSTATUSANDRECOMMENDATION", string.IsNullOrEmpty(query.RecommandationForStatus) ? "" : query.RecommandationForStatus);

                outputStream = CreatePDFString(reader, dictionary, '\0');
            }
            catch (IOException ex)
            {
                //RedirectToAction("Error", "Home");
                return null;
            }
            //Response.AppendHeader("Content-Disposition", "inline; filename=ClinicIDTT.pdf");
            return File(outputStream.ToArray(), "pdf", "ClinicIDTT.pdf");
        }
        public ActionResult PrintReEntry(int EpisodeId, int CaseREIMHSID)
        {
            MemoryStream outputStream = new MemoryStream();
            try
            {
                string filePath = WebConfigurationManager.AppSettings["PMHSTemplateFileDir"];
                string TemplateFile = Path.Combine(filePath, "CDCR2277CaseReEntryInitiMHS.pdf");
                PdfReader reader = new PdfReader(TemplateFile);
                var header = GetReportClientInfo(EpisodeId);
                
                Dictionary<string, string> dictionary = new Dictionary<string, string>();
                dictionary.Add("ParoleeName", header.PAROLEENAME);
                dictionary.Add("ParoleUnit", header.ParoleUnit);
                dictionary.Add("CDCNUMBER", header.CDCRNum);
                dictionary.Add("Region", (header.ParoleRegion == "" ? "" : (header.ParoleRegion == "S" ? "Southern" : "Northern")));
                dictionary.Add("AOR", header.ParoleAgent);
                dictionary.Add("ReleaseDate", header.ReleaseDate.HasValue ? header.ReleaseDate.ToString() : "");
                dictionary.Add("PC290", header.PC290 ? "Yes" : "No");
                dictionary.Add("MentalStatus", header.MhStatus == "" ? "None" : header.MhStatus);
                dictionary.Add("PrintDate", "Printed at: " + header.PrintDate);
               
                //get data from EpisodeEvaluations
                var query = GetReEntryIMHSData(EpisodeId, CaseREIMHSID);

                if (query != null)
                {
                    var currentStatus = "";
                    if (query.CurrentDESCCCCMS) currentStatus = "CCCMS";
                    if (query.CurrentDESCEOP) currentStatus = "EOP";
                    if (query.CurrentDESCNone) currentStatus = "None";

                    var HisMHTreatment = "No";
                    if (query.HisMHTreatmentYes) HisMHTreatment = "Yes";


                    var CommunicationBarrier = "No";
                    if (query.CommunicationBarrierYes) CommunicationBarrier = "Yes";

                    var BadNewsWorriesStress = "No";
                    if (query.BadNewsWorriesStressYes) BadNewsWorriesStress = "Yes";

                    var HearingVoice = "No";
                    if (query.HearingVoiceYes) HearingVoice = "Yes";

                    var SeeingThingsNotThere = "No";
                    if (query.SeeingThingsNotThereYes) SeeingThingsNotThere = "Yes";

                    var TakingPsychotropicMed = "No";
                    if (query.TakingPsychotropicMedYes) TakingPsychotropicMed = "Yes";

                    var DoSupplyMed = "No";
                    if (query.DoSupplyMedYes) DoSupplyMed = "Yes";

                    var BridgeMedsRequested = "No";
                    if (query.BridgeMedsRequestedYes) BridgeMedsRequested = "Yes";

                    var TakeMedicationForMedicalIssues = "No";
                    if (query.TakeMedicationForMedicalIssuesYes) TakeMedicationForMedicalIssues = "Yes";

                    var ThoughtsHurtingSomeElse = "No";
                    if (query.ThoughtsHurtingSomeElseYes) ThoughtsHurtingSomeElse = "Yes";

                    var ThoughtsHurtingOrCommittimgSuicide = "No";
                    if (query.ThoughtsHurtingOrCommittimgSuicideYes) ThoughtsHurtingOrCommittimgSuicide = "Yes";

                    var FollowupAppointment = "No";
                    if (query.FollowupAppointmentYes) FollowupAppointment = "Yes";

                    var AllergiesToMedication = "No";
                    if (query.AllergiesToMedicationYes) AllergiesToMedication = "Yes";

                    var DrugOrAlcoholProblem = "No";
                    if (query.DrugOrAlcoholProblemYes) DrugOrAlcoholProblem = "Yes";

                    var MHChronoCompleted = "No";
                    if (query.MHChronoCompletedYes) MHChronoCompleted = "Yes";

                    var UrgentCurrentlyPreScribedMed = "No";
                    if (query.UrgentCurrentlyPreScribedMedYes) UrgentCurrentlyPreScribedMed = "Yes";

                    var newStatus = "";
                    if (query.NewLevelCareCCCMS) newStatus = "CCCMS";
                    if (query.NewLevelCareEOP) newStatus = "EOP";
                    if (query.NewLevelCareMedNecessity) newStatus = "Medical Necessity";

                    var UrgentHasMed = "No";
                    if (query.UrgentHasMedYes) UrgentHasMed = "Yes";

                    var UrgentBridgeMedRequested = "No";
                    if (query.UrgentBridgeMedRequestedYes) UrgentBridgeMedRequested = "Yes";

                    var InterMediateCurrentlyPreScribedMed = "No";
                    if (query.InterMediateCurrentlyPreScribedMedYes) InterMediateCurrentlyPreScribedMed = "Yes";

                    var InterMediateHasMed = "No";
                    if (query.InterMediateHasMedYes) InterMediateHasMed = "Yes";

                    var InterMediateBridgeMedRequested = "No";
                    if (query.InterMediateBridgeMedRequestedYes) InterMediateBridgeMedRequested = "Yes";

                    var RoutineCurrentlyPreScribedMed = "No";
                    if (query.RoutineCurrentlyPreScribedMedYes) RoutineCurrentlyPreScribedMed = "Yes";

                    var RoutineHasMed = "No";
                    if (query.RoutineHasMedYes) RoutineHasMed = "Yes";

                    var RoutineBridgeMedRequested = "No";
                    if (query.RoutineBridgeMedRequestedYes) RoutineBridgeMedRequested = "Yes";

                    dictionary.Add("CCMAssigned", query.CMAssigneTo);
                    dictionary.Add("Date", query.CaseReEntryDate.Value.ToString("MM/dd/yyyy"));
                    dictionary.Add("OBSERVATION", query.Observasion);
                    dictionary.Add("MHTreatmentHistory", HisMHTreatment);
                    dictionary.Add("CurrMHDECS", currentStatus);
                    dictionary.Add("CommunicationBarrier", CommunicationBarrier);
                    dictionary.Add("CommunicationBarrierNote", query.CommunicationBarrierNote);
                    dictionary.Add("BadNewsWorriesStress", BadNewsWorriesStress);
                    dictionary.Add("BadNewsWorriesStressNote", query.BadNewsWorriesStressNote);
                    dictionary.Add("HearingVoice", HearingVoice);
                    dictionary.Add("HearingVoiceNote", query.HearingVoice_Note);
                    dictionary.Add("SeeingThingsNotThere", SeeingThingsNotThere);
                    dictionary.Add("SeeingThingsNotThereNote", query.SeeingThingsNotThereNote);
                    dictionary.Add("TakingPsychotropicMed", TakingPsychotropicMed);
                    dictionary.Add("TakingPsychotropicMedNote", query.TakingPsychotropicMedNote);
                    dictionary.Add("DoSupplyMed", DoSupplyMed);
                    dictionary.Add("LastTimeMedTakenDate", query.LastTimeMedTakenDate.HasValue ? query.LastTimeMedTakenDate.Value.ToShortDateString() : "");
                    dictionary.Add("MedicationNumber", query.MedicationNumber.HasValue ? query.MedicationNumber.Value.ToString() : "");
                    dictionary.Add("BridgeMedsRequested", BridgeMedsRequested);
                    dictionary.Add("ThoughtsHurtingOrCommittimgSuicide", ThoughtsHurtingOrCommittimgSuicide);
                    dictionary.Add("ThoughtsHurtingOrCommittimgSuicide_Note", query.ThoughtsHurtingOrCommittimgSuicide_Note);
                    dictionary.Add("ThoughtsHurtingSomeElse", ThoughtsHurtingSomeElse);
                    dictionary.Add("ThoughtsHurtingSomeElse_Note", query.ThoughtsHurtingSomeElse_Note);
                    dictionary.Add("ThoughtsHurtingWho", query.ThoughtsHurtingWho);
                    dictionary.Add("TakeMedicationForMedicalIssues", TakeMedicationForMedicalIssues);
                    dictionary.Add("TakeMedicationForMedicalIssues_Note", query.TakeMedicationForMedicalIssues_Note);
                    dictionary.Add("FollowupAppointment", FollowupAppointment);
                    dictionary.Add("FollowupAppointmentNote", query.FollowupAppointmentNote);
                    dictionary.Add("AllergiesToMedication", AllergiesToMedication);
                    dictionary.Add("AllergiesToMedicationNote", query.AllergiesToMedicationNote);
                    dictionary.Add("DrugOrAlcoholProblem", DrugOrAlcoholProblem);
                    dictionary.Add("DrugOrAlcoholProblemNote", query.DrugOrAlcoholProblemNote);
                    dictionary.Add("AcuteRemandedTo", query.AcuteRemandedTo);
                    dictionary.Add("UrgentNextAppointmentNote", query.UrgentNextAppointmentNote);
                    dictionary.Add("IntermediateNextAppointmentNote", query.IntermediateNextAppointmentNote);
                    dictionary.Add("RoutineNextAppointmentNote", query.RoutineNextAppointmentNote);
                    dictionary.Add("ChkUnNecessary", query.UnApptNecessary == true ? "Yes" : "No");
                    dictionary.Add("MHChronoCompleted", MHChronoCompleted);
                    dictionary.Add("NewLevelCare", newStatus);
                    //========================================= page 2====//
                    dictionary.Add("UrgentCurrentlyPreScribedMed", UrgentCurrentlyPreScribedMed);
                    dictionary.Add("UrgentHasMed", UrgentHasMed);
                    dictionary.Add("UrgentBridgeMedRequested", UrgentBridgeMedRequested);
                    dictionary.Add("InterMediateCurrentlyPreScribedMed", InterMediateCurrentlyPreScribedMed);
                    dictionary.Add("InterMediateHasMed", InterMediateHasMed);
                    dictionary.Add("InterMediateBridgeMedRequested", InterMediateBridgeMedRequested);
                    dictionary.Add("RoutineCurrentlyPreScribedMed", RoutineCurrentlyPreScribedMed);
                    dictionary.Add("RoutineHasMed", RoutineHasMed);
                    dictionary.Add("RoutineBridgeMedRequested", RoutineBridgeMedRequested);
                }

                outputStream = CreatePDFString(reader, dictionary, '\0');
            }
            catch (IOException ex)
            {
            }
            //Response.AppendHeader("Content-Disposition", "inline; filename=ClientCaseREIMHS.pdf");
            return File(outputStream.ToArray(), "pdf", "ClientCaseREIMHS.pdf");
        }
        public ActionResult PrintProfile(int EpisodeId)
        {
            MemoryStream outputStream = new MemoryStream();
            try
            {
                string filePath = WebConfigurationManager.AppSettings["PMHSTemplateFileDir"];
                string TemplateFile = Path.Combine(filePath, "CDCR2287ProfileRevised.pdf");
                PdfReader reader = new PdfReader(TemplateFile);
                PMHProfileData profileData = GetPMHProfileData(EpisodeId, false);
                Dictionary<string, string> dictionary = GetParameters(profileData, (int)ControllerID.Client);

                outputStream = CreatePDFString(reader, dictionary, '\0');
            }
            catch (IOException ex)
            {
            }
            //Response.AppendHeader("Content-Disposition", "inline; filename=PrintProfile.pdf");
            return File(outputStream.ToArray(), "pdf", "PrintProfile.pdf");
        }
        public ActionResult PrintMCASR(int EpisodeId, int MCASRID)
        {
            MemoryStream outputStream = new MemoryStream();
            try
            {
                string filePath = WebConfigurationManager.AppSettings["PMHSTemplateFileDir"];
                string TemplateFile = Path.Combine(filePath, "CDCR2288MCASR.pdf");
                PdfReader reader = new PdfReader(TemplateFile);
                var header = GetReportClientInfo(EpisodeId);
                //get data from Episode
                Dictionary<string, string> dictionary = new Dictionary<string, string>();

                dictionary.Add("PAROLEENAME", header.PAROLEENAME);
                dictionary.Add("PAROLEUNIT", header.ParoleUnit);
                dictionary.Add("CDCNUMBER", header.CDCRNum);
                dictionary.Add("REGION", header.ParoleRegion);
                dictionary.Add("PAROLEEAGENT", header.ParoleAgent);
                dictionary.Add("PrintDate", "Printed at: " + header.PrintDate);

                //get data from case IRP
                var query = string.Format(@"DECLARE @EpisodeID int = {0}
DECLARE @MCASRID int = {1}
DECLARE @ID int = 0

if @MCASRID > 0 SET @ID = @MCASRID
ELSE
  SET  @ID =(SELECT ISNULl(MCASRID,0) FROM dbo.EpisodeTrace WHERE EpisodeID =@EpisodeID)

SELECT t1.[Id],t1.[EpisodeID],[Section1Score],[Section2Score],[Section3Score],[Section4Score]
      ,[Question1Anwser],[Question2Anwser],[Question3Anwser],[Question4Anwser],[Question5Anwser]
      ,[Question6Anwser],[Question7Anwser],[Question8Anwser],[Question9Anwser],[Question10Anwser]
      ,[Question11Anwser],[Question12Anwser],[Question13Anwser],[Question14Anwser]
      ,[Question15Anwser],[Question16Anwser],[Question17Anwser],[ActionStatus]
      ,(SELECT Name FROM dbo.fn_GetAsstUserName(t1.ActionBy))[ActionUserName],FORMAT(t1.[DateAction], 'MM/dd/yyyy')ASSESSMENTDATE
  FROM [dbo].[CaseMCASR] t1 INNER JOIN [dbo].EpisodeTrace t2 on t1.EpisodeID= t2.EpisodeID WHERE t1.EpisodeID=@EpisodeID and t1.Id = @ID", EpisodeId, MCASRID);
                var mcasr = SqlHelper.ExecuteCommands<CaseMCASR>(query).FirstOrDefault();
                
                //total score
                var total = (mcasr.Section1Score.HasValue ? mcasr.Section1Score.Value : 0) +
                            (mcasr.Section2Score.HasValue ? mcasr.Section2Score.Value : 0) +
                            (mcasr.Section3Score.HasValue ? mcasr.Section3Score.Value : 0) +
                            (mcasr.Section4Score.HasValue ? mcasr.Section4Score.Value : 0);

                dictionary.Add("SummedSection1", (mcasr.Section1Score.HasValue ? mcasr.Section1Score.Value.ToString() : ""));
                dictionary.Add("SummedSection2", (mcasr.Section2Score.HasValue ? mcasr.Section2Score.Value.ToString() : ""));
                dictionary.Add("SummedSection3", (mcasr.Section3Score.HasValue ? mcasr.Section3Score.Value.ToString() : ""));
                dictionary.Add("SummedSection4", (mcasr.Section4Score.HasValue ? mcasr.Section4Score.Value.ToString() : ""));
                dictionary.Add("TOTALSCORE", (total > 0 ? total.ToString() : ""));

                //questions
                dictionary.Add("PhysicalHealth", (mcasr.Question1Anwser.HasValue ? "1" + mcasr.Question1Anwser.Value.ToString() : ""));
                dictionary.Add("IntellectualFunctioning", (mcasr.Question2Anwser.HasValue ? "2" + mcasr.Question2Anwser.Value.ToString() : ""));
                dictionary.Add("ThoughtProcesses", (mcasr.Question3Anwser.HasValue ? "3" + mcasr.Question3Anwser.Value.ToString() : ""));
                dictionary.Add("MoodAbnormality", (mcasr.Question4Anwser.HasValue ? "4" + mcasr.Question4Anwser.Value.ToString() : ""));
                dictionary.Add("ResponseStressAnxiety", (mcasr.Question5Anwser.HasValue ? "5" + mcasr.Question5Anwser.Value.ToString() : ""));
                dictionary.Add("AdjustmentLiving", (mcasr.Question6Anwser.HasValue ? "6" + mcasr.Question6Anwser.Value.ToString() : ""));
                dictionary.Add("IndependenceDailyLife", (mcasr.Question7Anwser.HasValue ? "7" + mcasr.Question7Anwser.Value.ToString() : ""));
                dictionary.Add("AcceptanceIllness", (mcasr.Question8Anwser.HasValue ? "8" + mcasr.Question8Anwser.Value.ToString() : ""));
                dictionary.Add("SocialAcceptability", (mcasr.Question9Anwser.HasValue ? "9" + mcasr.Question9Anwser.Value.ToString() : ""));
                dictionary.Add("SocialInterest", (mcasr.Question10Anwser.HasValue ? "10" + mcasr.Question10Anwser.Value.ToString() : ""));
                dictionary.Add("SocialEffectiveness", (mcasr.Question11Anwser.HasValue ? "11" + mcasr.Question11Anwser.Value.ToString() : ""));
                dictionary.Add("SocialNetwork", (mcasr.Question12Anwser.HasValue ? "12" + mcasr.Question12Anwser.Value.ToString() : ""));
                dictionary.Add("MeaningfulActivity", (mcasr.Question13Anwser.HasValue ? "13" + mcasr.Question13Anwser.Value.ToString() : ""));
                dictionary.Add("MedicationCompliance", (mcasr.Question14Anwser.HasValue ? "14" + mcasr.Question14Anwser.Value.ToString() : ""));
                dictionary.Add("CooperationTreatmentProviders", (mcasr.Question15Anwser.HasValue ? "15" + mcasr.Question15Anwser.Value.ToString() : ""));
                dictionary.Add("AlcoholDrugAbuse", (mcasr.Question16Anwser.HasValue ? "16" + mcasr.Question16Anwser.Value.ToString() : ""));
                dictionary.Add("ImpulseControl", (mcasr.Question17Anwser.HasValue ? "17" + mcasr.Question17Anwser.Value.ToString() : ""));

                dictionary.Add("CLINICALCASEMANAGERCCMASSIGNED", mcasr.ActionUserName );
                dictionary.Add("CLINICIANPRINTEDNAME", mcasr.ActionUserName);
                dictionary.Add("ASSESSMENTDATE", mcasr.ASSESSMENTDATE.ToShortDateString());

                outputStream = CreatePDFString(reader, dictionary, '\0');
            }
            catch (IOException ex)
            {
            }
            //Response.AppendHeader("Content-Disposition", "inline; filename=ClientCaseMCASR.pdf");
            return File(outputStream.ToArray(), "pdf", "ClientCaseMCASR.pdf");
        }
        public ActionResult PrintNeedsAssessment(int EpisodeId, int AssessmentId)
        {
            MemoryStream outputStream = new MemoryStream();
            try
            {
                string filePath = WebConfigurationManager.AppSettings["PMHSTemplateFileDir"];
                string TemplateFile = Path.Combine(filePath, "CDCR2286CaseNeedsAssessment.pdf");
                PdfReader reader = new PdfReader(TemplateFile);
                var header = GetReportClientInfo(EpisodeId);
                //get data from Episode
                Dictionary<string, string> dictionary = new Dictionary<string, string>();

                dictionary.Add("PAROLEENAME", header.PAROLEENAME);
                dictionary.Add("PAROLEUNIT", header.ParoleUnit);
                dictionary.Add("CDCRNum", header.CDCRNum);
                dictionary.Add("REGION", header.ParoleRegion);
                dictionary.Add("PAROLEEAGENT", header.ParoleAgent);
                dictionary.Add("PrintDate", "Printed at: " + header.PrintDate);
                //get data from Episode
                

                //Dictionary<string, string> dictionary = GetParameters(parole, (int)ControllerID.SocialWork);

                var query = GetNeedsAssessmentSetData(EpisodeId, AssessmentId);

                if (query != null)
                {
                    var irplist = query.IRPSetList;
                    foreach (var item in irplist)
                    {
                        switch (item.NeedId)
                        {
                            case 1:
                                dictionary.Add("FOOD", item.NeedStatus.HasValue ? GetNeedStatusString(item.NeedStatus.Value) : "");
                                break;
                            case 2:
                                dictionary.Add("CLOTHING", item.NeedStatus.HasValue ? GetNeedStatusString(item.NeedStatus.Value) : "");
                                break;
                            case 3:
                                dictionary.Add("SHELTER", item.NeedStatus.HasValue ? GetNeedStatusString(item.NeedStatus.Value) : "");
                                break;
                            case 4:
                                dictionary.Add("MEDMANAGEMENT", item.NeedStatus.HasValue ? GetNeedStatusString(item.NeedStatus.Value) : "");
                                break;
                            case 5:
                                dictionary.Add("HEALTHBENEFITS", item.NeedStatus.HasValue ? GetNeedStatusString(item.NeedStatus.Value) : "");
                                break;
                            case 6:
                                dictionary.Add("MED/DENTSERVICES", item.NeedStatus.HasValue ? GetNeedStatusString(item.NeedStatus.Value) : "");
                                break;
                            case 7:
                                dictionary.Add("MENTALHEALTHSERVICES", item.NeedStatus.HasValue ? GetNeedStatusString(item.NeedStatus.Value) : "");
                                break;
                            case 8:
                                dictionary.Add("SUBSTANCEABUSESERVICES", item.NeedStatus.HasValue ? GetNeedStatusString(item.NeedStatus.Value) : "");
                                break;
                            case 9:
                                dictionary.Add("INCOME", item.NeedStatus.HasValue ? GetNeedStatusString(item.NeedStatus.Value) : "");
                                break;
                            case 10:
                                dictionary.Add("IDENTIFICATIONCARD", item.NeedStatus.HasValue ? GetNeedStatusString(item.NeedStatus.Value) : "");
                                break;
                            case 11:
                                dictionary.Add("LIFESKILLS", item.NeedStatus.HasValue ? GetNeedStatusString(item.NeedStatus.Value) : "");
                                break;
                            case 12:
                                dictionary.Add("PRODUCTIVEACTIVITIES", item.NeedStatus.HasValue ? GetNeedStatusString(item.NeedStatus.Value) : "");
                                break;
                            case 13:
                                dictionary.Add("PROSOCIALSUPPORTSYSTEMS", item.NeedStatus.HasValue ? GetNeedStatusString(item.NeedStatus.Value) : "");
                                break;
                            case 14:
                                dictionary.Add("ACADEMICVOVATIONALPROGRAMS", item.NeedStatus.HasValue ? GetNeedStatusString(item.NeedStatus.Value) : "");
                                break;
                            case 15:
                                dictionary.Add("CR/DSP", item.NeedStatus.HasValue ? GetNeedStatusString(item.NeedStatus.Value) : "");
                                break;
                        }
                        dictionary.Add("NEED" + item.NeedId.ToString(), item.DescriptionCurrentNeed);
                    }
                }

                //get data from case nees assessment
                var serviceneeds = "";
                if (query.NeedsAssessmentSet.ServiceHighNeeds.HasValue && query.NeedsAssessmentSet.ServiceHighNeeds.Value == true) serviceneeds = "HIGH";
                if (query.NeedsAssessmentSet.ServiceModNeeds.HasValue && query.NeedsAssessmentSet.ServiceModNeeds.Value == true) serviceneeds = "MODERATE";
                if (query.NeedsAssessmentSet.ServiceLowNeeds.HasValue && query.NeedsAssessmentSet.ServiceLowNeeds.Value == true) serviceneeds = "LOW";

                var InterpreterNeeded = "";
                if (query.NeedsAssessmentSet.InterpreterNeededYes == true) InterpreterNeeded = "Yes";
                if (query.NeedsAssessmentSet.InterpreterNeededNo == false) InterpreterNeeded = "No";

                dictionary.Add("CLINICALCASEMANAGERCCMASSIGNED", query.NeedsAssessmentSet.ActionName);
                dictionary.Add("ASSESSMENTDATE", query.NeedsAssessmentSet.AssessmentDate.Value.ToString("MM/dd/yyyy"));
                dictionary.Add("AdditionalInfo", query.NeedsAssessmentSet.AdditionalInformation);
                dictionary.Add("CMServiceNeedsScale", serviceneeds);
                dictionary.Add("TOTALSCORE", query.NeedsAssessmentSet.MCASRScore == 0 ? "" : query.NeedsAssessmentSet.MCASRScore.ToString());
                dictionary.Add("InterpreterNeeded", InterpreterNeeded);
                dictionary.Add("InterpreterLanguage", query.NeedsAssessmentSet.AssessmentLauguage);

                outputStream = CreatePDFString(reader, dictionary, '\0');
            }
            catch (IOException ex)
            {
            }
            //Response.AppendHeader("Content-Disposition", "inline; filename=ClientCaseNeedsAssessment.pdf");
            return File(outputStream.ToArray(), "pdf", "ClientCaseNeedsAssessment.pdf");
        }
        public ActionResult PrintAMST(int EpisodeId, int SelectASMTID)
        {
            //get data from episode
            var header = GetReportClientInfo(EpisodeId);
            var amst = GetMMAData(EpisodeId, SelectASMTID);
            if (amst != null)
            {
                amst.CDCR = header.CDCRNum;
                amst.DOB = header.DOB.HasValue ? header.DOB.Value.ToString("MM/dd/yyyy") : "";
                amst.PAROLEOFFICE = header.ParoleUnit;
                amst.PAROLEENAME = header.PAROLEENAME;
                amst.WEIGHT = string.IsNullOrEmpty(amst.WEIGHT) ? "" : amst.WEIGHT + " lbs";
                amst.PrintDate = DateTime.Now;
            }

            PrintPATSPDF ppdf = new PrintPATSPDF();
            Byte[] bytes = ppdf.GenerateMMAStream(CurrentUser.UserLFI(), amst);
            //Response.AppendHeader("Content-Disposition", "inline; filename=MMA.pdf");
            return File(bytes, "pdf", "MMA.pdf");
        }
        public ActionResult PrintEval(int EpisodeId, int EvaluationID)
        {
            var header = GetReportClientInfo(EpisodeId);
            Dictionary<string, string> dictionary = new Dictionary<string, string>();
            dictionary.Add("ParoleName", header.PAROLEENAME);
            dictionary.Add("ParoleUnit", header.ParoleUnit);
            dictionary.Add("CDCRNumber", header.CDCRNum);
            dictionary.Add("ParoleRegion", (header.ParoleRegion == "" ? "" : (header.ParoleRegion == "S" ? "Southern" : "Northern")));
            dictionary.Add("ParoleAgent", header.ParoleAgent);
            dictionary.Add("PrintDate", DateTime.Now.ToString("MM/dd/yyyy"));

            var query = GetEvaluationItemList(EpisodeId, EvaluationID);

            if (query != null && query.Count() > 0)
            {
                dictionary.Add("EvaluatedBy", query[0].EvaluatedName);

                var EvaluationDate = query[0].EvaluationDate.ToString("MM/dd/yyyy");
                dictionary.Add("EvaluationDate", EvaluationDate);
               
                foreach (var item in query.ToList())
                {
                    dictionary.Add(item.EvaluationItemDesc.Replace(" ", ""), item.EvaluationItemNote);
                }
            }

            dictionary.Add("EvaluationDataItemGUID", query[0].EvaluationGUID);
            dictionary.Add("LoginUser", CurrentUser.UserLFI());

            PrintPATSPDF ppdf1 = new PrintPATSPDF();
            Byte[] bytes = ppdf1.GenerateEvaluationStream(CurrentUser.UserLFI(), dictionary);
            //Response.AppendHeader("Content-Disposition", "inline; filename=EpisodeEvaluation.pdf");
            return File(bytes, "pdf", "EpisodeEvaluation.pdf");
        }
        private string GetNeedStatusString(int value)
        {
            switch (value)
            {
                case 1:
                    return "NO";
                case 2:
                    return "LOW";
                case 3:
                    return "MODERATE";
                case 4:
                    return "HIGH/URGENT";
                default:
                    return "";
            }
        }
        #endregion print
        public int GetAge(DateTime birthDate)
        {
            DateTime now = DateTime.Now;
            int age = DateTime.Now.Year - birthDate.Year;
            
            if (now.Month < birthDate.Month || (now.Month == birthDate.Month && now.Day < birthDate.Day))
                age--;

            return age;
        }
    }
}