using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using IdentityManagement.Entities.Appointment;
using IdentityManagement.Entities;

namespace PATSWebV2.ViewModels
{
    public enum Appointment_Status
    {
        Pending = 1,
        Complete,
        Due
    }

    public enum Appt_Client_Status
    {
        Absent = 1,
        Pending,
        Present,
        Excused
    }

   
   
    //public class AppointmentClientViewModel
    //{
    //    public int EpisodeId { get; set; }
    //    public int? ClientLocationId { get; set; }
    //    public bool CanEdit { get; set; }
    //    public int AppointmentDay { get; set; }
    //    public string ModelAction { get; set; }
    //    public int SelectTab { get; set; }
    //    public bool AutoPrint { get; set; }
    //    public int PrintAppointmentID { get; set; }
    //}

    public class AppointmentViewModel : AppointmentData, ISchedulerEvent
    {
        [Display(Name = "Action")]
        public int AppointmentId { get; set; }
        public int AppointmentTraceId { get; set; }
        public List<ApptClient> SelectedClients { get; set; }
        public List<SelectListItem> SelectedADAItems { get; set; }
        [Required(ErrorMessage = "Staff is required")]
        public List<ActivePATSUser> SelectedStaffs { get; set; }
        [Display(Name = "Client Name")]
        public string ClientName { get; set; }
        [Display(Name = "CDCR Number")]
        public string CDCRNum { get; set; }

        [Display(Name = "Staff")]
        public string SelectedStaffNames { get; set; }
        public string SelectedStaffIds { get; set; }
        public string SelectedADAIds { get; set; }
        [Display(Name = "Agent")]
        public string Agent { get; set; }
        public string ActiveTabIn { get; set; }
        [Display(Name = "POC Unit")]
        public string Unit { get; set; }
        [Display(Name = "Appt. Office")]
        [Required(ErrorMessage = "Location is required")]
        public int SelectedLocationId { get; set; }
        public string SelectedLocationDesc { get; set; }

        [Required(ErrorMessage = "Start Date is requested")]
        [Display(Name = "Start Date")]
        [DisplayFormat(DataFormatString = "{0:MM/dd/yyyy}")]
        public DateTime Start { get; set; }

        [Required(ErrorMessage = "Start time is requested")]
        [Display(Name = "Time")]
        [DisplayFormat(DataFormatString = "{0:h:mm tt}")]
        public DateTime StartTime { get; set; }

        [Required(ErrorMessage = "End date is requested")]
        [DisplayFormat(DataFormatString = "{0:MM/dd/yyyy}")]
        [Display(Name = "End Date")]
        public DateTime End { get; set; }

        [Required(ErrorMessage = "End time is requested")]
        [Display(Name = "Time")]
        [DisplayFormat(DataFormatString = "{0:h:mm tt}")]
        public DateTime EndTime { get; set; }

        [Required(ErrorMessage = "Appointment Type is required")]
        [Display(Name = "Type")]
        public int TypeID { get; set; }
        public string TypeDesc { get; set; }
        public string Title { get; set; }
        public string CellColor { get; set; }

        [Display(Name = "Status")]
        [Required(ErrorMessage = "Appointment Status is required")]
        public int StatusID { get; set; }
        public string Eventstatus { get; set; }
        [Display(Name = "Print Letter")]
        public string PrintUrl { get; set; }
        [Display(Name = "Purpose")]
        public string Description { get; set; }
        public IEnumerable<int> StaffIds { get; set; }
        public string textColor { get; set; }
        //[Display(Name = "Full Day")]
        public bool IsAllDay { get; set; }
        [Display(Name = "Completed")]
        public bool IsCompleted { get; set; }
        public string ProcessStatus { get; set; }
        public string StaffName { get; set; }
        public string StartTimezone { get { return null; } set { value = null; } }
        public string EndTimezone { get { return null; } set { value = null; } }
        public string RecurrenceRule { get; set; }
        public string RecurrenceException { get; set; }

        public List<ActivePATSUser> StaffList { get; set; }
    }
}