using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IdentityManagement.Entities.Appointment
{
    public class ApptClient
    {
        public int EpisodeID { get; set; }
        public string CDCRNumber { get; set; }
        public string ClientName { get; set; }
        public int AppointmentId { get; set; }
        public string Agent { get; set; }
        public string Unit { get; set; }
        public string FollowupAppt { get; set; }
        public int? ReleaseLoc { get; set; }
        public int ClientStatus { get; set; }
        public string ContactPh { get; set; }
    }
    public class ApptStaff
    {
        public int StaffId { get; set; }
        public string StaffName { get; set; }
        public string StaffType { get; set; }
        public int StaffTypeId { get; set; }
        public int LocationId { get; set; }
        public int ComplexId { get; set; }
        public bool IsCurrentUser { get; set; }

    }
    public class ApptPOCOffice
    {
        public int LocationId { get; set; }
        public int CountyId { get; set; }
        public string OfficeName { get; set; }
        public string CountyName { get; set; }
        public int ComplexID { get; set; }
        public string ComplexDesc { get; set; }
    }
    public class ApptEventType
    {
        public int ID { get; set; }
        public string EvtTShortDescr { get; set; }
        public bool ShowCDCRNum { get; set; }
    }
    public class ApptHistory
    {
        public int AppointmentId { get; set; }
        public int AppointmentTraceID { get; set; }
        public DateTime Start { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public string ActionBy { get; set; }
        public DateTime DateAction { get; set; }
        public string EvtTShortDescr { get; set; }
        public string ApptShortDescr { get; set; }
        public string LocationDesc { get; set; }
        public string ApptClient { get; set; }
        public string ApptStaff { get; set; }
        public string ADAECs { get; set; }
    }
    public class AppointmentData
    {
        public int EpisodeId { get; set; }
        public int? ClientLocationId { get; set; }
        public bool CanEdit { get; set; }
        public int AppointmentDay { get; set; }
        public string ModelAction { get; set; }
        public int SelectTab { get; set; }
        public bool AutoPrint { get; set; }
        public int PrintAppointmentID { get; set; }
    }
    public class AppointmentList
    {
        public int AppointmentId { get; set; }
        public int AppointmentTraceID { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public int StatusID { get; set; }
        public int TypeID { get; set; }
        public bool IsCompleted { get; set; }
        public string ProcessStatus { get; set; }
        public bool IsAllDay { get; set; }
        public int LocationId { get; set; }
        public string EvtTCellColor { get; set; }
        public string EvtTShortDescr { get; set; }
        public string ApptShortDescr { get; set; }
        public string Note { get; set; }
        public string LocationDesc { get; set; }
        public string ApptClient { get; set; }
        public string ApptStaff { get; set; }
        public string ADAECs { get; set; }
        public int ClientLocationID { get; set; }
    }
    public class ApptActivityInfo
    {
        public string ClientName { get; set; }
        public string StaffName { get; set; }
        public string CDCRNum { get; set; }
        public string Unit { get; set; }
        public string Location { get; set; }
        public string StartTime { get; set; }
        public string EndTime { get; set; }
        public string FollowupAppt { get; set; }
        public string ApptType { get; set; }
        public string ApptStatus { get; set; }
        public string ContactPh { get; set; }
    }
    public class Notice
    {
        public string Location { get; set; }
        public string ParoleInfo { get; set; }
        public string ParoleName { get; set; }
        public string ApptDate { get; set; }
        public string ApptTime { get; set; }
        public string StaffType { get; set; }
        public string StaffName { get; set; }
        public string ApptPurpose { get; set; }
        public string ApptLocation { get; set; }
        public string ParoleAgent { get; set; }
        public string CDCRNum { get; set; }
        public string OtherAppts { get; set; }
    }
    public class AppointmentAvailabilityList
    {
        public string StartDate { get; set; }
        public string EndDate { get; set; }
    }

    public class ClientMinInfo
    {
        public DateTime StartDate { get; set; }
        public int ParoleLocationID { get; set; }
    }
}
