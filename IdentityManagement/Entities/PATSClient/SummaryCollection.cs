using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IdentityManagement.Entities
{
    public class SummaryCollection
    {
        [Key]
        public string ClientSmy { get; set; }
        public int Id { get; set; }
        public string DateType { get; set; }
        public string DateEnrolled { get; set; }
        public string smydesc { get; set; }
    }

    public class CaseAssignSmy
    {
        //public string ClientSmy { get; set; }
        public int Id { get; set; }

        public string DateEnrolled { get; set; }
        //public string CaseManager { get; set; }
        public string SocialWorker { get; set; }
        public string Psychologist { get; set; }
        public string Psychiatrist { get; set; }
    }

    public class AppointmentSummary
    {
        public int Id { get; set; }
        public DateTime StartDate { get; set; }
        public string Progress { get; set; }
        public string Clinician { get; set; }
        public string EventTypeDescr { get; set; }
        public string eventstatus { get; set; }
    }

    public class PPSummary
    {
        //public List<StaffAssignment> StaffAssignmentVM { get; set; }f
        //public ClientNote ClientNoteVM { get; set; }
        public string ClientNote { get; set; }
        public int EpisodeID { get; set; }
        public string LastFirstMI { get; set; }
        public string SSN { get; set; }
        public string CDCRNumber { get; set; }
        public string Gender { get; set; }
        public string ParoleUnit { get; set; }
        public int SelectedLocationId { get; set; }
        public string CalculatedAge { get; set; }
        public string DateOfBirth { get; set; }
        public string SomsOffenderID { get; set; }
        public string CountyText { get; set; }
        public string OfficeLocationText { get; set; }
        public bool Lifer { get; set; }
        public bool PC290 { get; set; }
        public string MHSINST { get; set; }
        public string MHSPOC { get; set; }
        public string Disabilities { get; set; }
        public string SearchString { get; set; }
        public string ParoleDischargeDate { get; set; }
        public string ReleaseDate { get; set; }
        public string Region { get; set; }
        public string EthnicityText { get; set; }
        public string CNEntryDate { get; set; }
        public string ParoleStatus { get; set; }
        public string CaseIntakeDate { get; set; }
        public string CaseClosureDate { get; set; }
        public string CaseBankedDate { get; set; }
        public bool ISMIPEnrolled { get; set; }
        public bool MATEnrolled { get; set; }
        public bool CMEnrolled { get; set; }
        public bool CMRPEEnrolled { get; set; }
        public bool Asam { get; set; }
        public string ParoleAgent { get; set; }
        public bool HasIDTT { get; set; }
    }
}
