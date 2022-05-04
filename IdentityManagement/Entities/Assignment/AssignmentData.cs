using System;

namespace IdentityManagement.Entities.Assignment
{
    public class StaffAssignmentData
    {
        public int Id { get; set; }
        public int EpisodeId { get; set; }
        public string ClientName { get; set; }
        public string CDCRNum { get; set; }
        public int? ParoleLocationID { get; set; }
        public int? ComplexID { get; set; }
        public string ComplexDesc { get; set; }
        public string LocationDesc { get; set; }
        public DateTime? DateAction { get; set; }
        public DateTime? CaseBankedDate { get; set; }
        public int? ActionBy { get; set; }
        public int? ActionStatus { get; set; }
        public int? SocialWorkerUserId { get; set; }
        public int? CaseManagerUserId { get; set; }
        public int? PsychiatristUserId { get; set; }
        public int? PsychologistUserId { get; set; }
        public string SocialWorker { get; set; }       
        public string Psychiatrist { get; set; }
        public string Psychologist { get; set; }
        public string CaseManager { get; set; }
        public string ParoleAgentName { get; set; }
        public string MHStatus { get; set; }
        public string CaseStatus { get; set; }
    }
    public class AssignmentHistoryData
    {
        public int ID { get; set; }
        public int EpisodeId { get; set; }
        public DateTime AssignmentDate { get; set; }
        public string SocialWorkerName { get; set; }
        public string ParoleAgentName { get; set; }
        public string PsychologistName { get; set; }
        public string PsychiatristName { get; set; }
        //public string CaseManagerName { get; set; }
        public string AssignedBy { get; set; }
    }
    public class ComplexList
    {
        public int ComplexID { get; set; }
        public string ComplexDesc { get; set; }
    }
}
