using System;
using System.ComponentModel.DataAnnotations;

namespace IdentityManagement.Entities
{
    public class CaseNoteData
    {
        public int Id { get; set; }
        public int CaseNoteId { get; set; }
        [Range(1, int.MaxValue, ErrorMessage = "Note type is required")]
        public int CaseNoteTypeId { get; set; }
        public bool UpdateExpired { get; set; }  //24 hours
        public string CaseNoteType { get; set; }
        [Range(1, int.MaxValue, ErrorMessage = "Contact method is required")]
        public int CaseContactMethodID { get; set; }
        public string CaseContactMethod { get; set; }
        [Required(ErrorMessage = "Note is required")]
        public string Note { get; set; }
        public DateTime DateAction { get; set; }
        public string ActionByName { get; set; }
        public string ActionModel { get; set; }
        //public bool HasHistory { get; set; }
    }
    public class CaseNoteHistory
    {
        public int Id { get; set; }
        public int CaseNoteId { get; set; }
        public DateTime DateAction { get; set; }
        public string HisNote { get; set; }
        public string CaseContactMethod { get; set; }
        public string CaseNoteType { get; set; }
        public string ActionByName { get; set; }
        public string ActionStatus { get; set; }
        public string ActionModel { get; set; }

    }
    public class CaseNoteInfo
    {
        public string CDCRNum { get; set; }
        public string ClientName { get; set; }
        public string NoteDate { get; set; }
        public string NoteType { get; set; }
        public string ContactMethod { get; set; }
        public string EnteredBy { get; set; }
        public string Note { get; set; }
        public string CaseWorkerType { get; set; }
    }
    public class CaseNoteType
    {
        public int CaseNoteTypeId { get; set; }
        public string Name { get; set; }
    }
    public class CaseContactMethod
    {
        public int CaseContactMethodID { get; set; }
        public string ContactMethod { get; set; }
    }
}
