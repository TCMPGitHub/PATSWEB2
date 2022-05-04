using IdentityManagement.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PATSWebV2.ViewModels.Client
{

    public class ClinicalSummary
    {
        public bool ClinicalReentryInitialed { get; set; }
        public string ClinicalReentryInitialedDate { get; set; }
        public bool ClinicalIDTTEnterred { get; set; }
        public string ClinicalIDTTEnterredDate { get; set; }
        public bool ClinicalNoteEnterred { get; set; }
        public string ClinicalNoteEnterredDate { get; set; }
        public bool ClinicalPMHEnterred { get; set; }
        public string ClinicalPMHEnterredLastDate { get; set; }
        public string IDTTDecision { get; set; }
    }
    public class ApptSummary
    {
        public int id { get; set; }
        public DateTime start_date { get; set; }
        public DateTime end_date { get; set; }
        public string Startdate { get; set; }
        public string Progress { get; set; }
        public string Clinician { get; set; }
        public string EventTypeDescr { get; set; }
        public string eventstatus { get; set; }
        public string LocationDesc { get; set; }
        public string NextApptURL { get; set; }
    }
    public class CasemanagementSummary
    {
        public bool CaseReentryInitialed { get; set; }
        public string CaseReentryInitialLastDate { get; set; }
        public bool CaseIrpEnterred { get; set; }
        public string CaseIrpEnterredLastDate { get; set; }
        public bool CaseNeedsAssessmented { get; set; }
        public string CaseNeedsAssessmentedLastDate { get; set; }
        public bool CaseIDTTEnterred { get; set; }
        public string CaseIDTTEnterredLastDate { get; set; }
        public bool CaseNoteEnterred { get; set; }
        public string CaseNoteEnterredLastDate { get; set; }
        public bool CaseMCASREnterred { get; set; }
        public string CaseMCASREnterredLastDate { get; set; }
        //public bool CasePMHEnterred { get; set; }
        //public string CasePMHEnterredLastDate { get; set; }
        public int? CaseMCASRScore { get; set; }
    }
    public class ClientAssignmentSummary
    {
        public bool ClientAssigned { get; set; }
        public string ClientLastAssignedDate { get; set; }
        public string CaseWorker { get; set; }
        public string psychia { get; set; }
        public string psychol { get; set; }
        public string SocialWorker { get; set; }
    }
    public class PrescriptionSummary
    {
        public bool HasPrescription { get; set; }
        public string PrescriptionDate { get; set; }
    }
    public class DSMSummary
    {
        public bool HasDsm { get; set; }
        public string Dsmdate { get; set; }
        public string DsmCode { get; set; }
        public string DsmDesc { get; set; }
    }
    public class ClientProfileSummary
    {
        public bool CaseEnrolled { get; set; }
        public string CaseEnrollee { get; set; }
        public bool ISMIPEnrolled { get; set; }
        public string ISMIPEnrollee { get; set; }
        public bool MATEnrolled { get; set; }
        public string MATEnrollee { get; set; }
        public bool CMEnrolled { get; set; }
        public string CMEnrollee { get; set; }
        public bool CMRPEEnrolled { get; set; }
        public string CMRPEEnrollee { get; set; }
        public bool MMA { get; set; }
        public string MMADate { get; set; }
    }
    public class LegalDocumentSummary
    {
        public bool NoticePrivacyPractice { get; set; }
        public bool InformedConcentForTreatment { get; set; }
        public bool ReleaseInformation { get; set; }
        public bool Other { get; set; }
        public string DateReleaseInfoExpiration { get; set; }
        public string DateNoticePrivacyPractice { get; set; }
        public string DateInformedConcentForTreatment { get; set; }
        public string DateOther { get; set; }
    }
    public class EvaluationSummary
    {
        public string EvaluationDate { get; set; }
        public string EvaluatedBy { get; set; }
    }
    public class EditingPaneViewModel
    {
        public int EpisodeID { get; set; }
        public bool CaseIMHSDone { get; set; }
        public List<SummaryCollection> AllSmy { get; set; }
        public List<AppointmentSummary> ApptListSmy { get; set; }
        public List<CaseAssignSmy> CaseAssignSmy { get; set; }
        public string BackgroundColor { get; set; }
        public string SummaryType { get; set; }
        public int ParoleLocationID { get; set; }
        public bool ShowPrescription { get; set; }
        //public CasemanagementSummary CMSmy { get; set; }
        //public ClientAssignmentSummary AssignedSmy { get; set; }
        //public ClientProfileSummary ClientSmy { get; set; }
        //public PrescriptionSummary RxSmy { get; set; }
        //public DSMSummary DSMSmy { get; set; }
        //public LegalDocumentSummary LegalDocSmy { get; set; }
        //public EvaluationSummary EvaSmy { get; set; }
    }

}
