using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace PATSWebV2.ViewModels.Assignment
{
    public class PATSUser
    {
        [Key]
        [ScaffoldColumn(false)]
        public int PATSUserId { get; set; }
        public string PATSUserName { get; set; }
        public int CaseWorkerTypeId { get; set; }
        public int IsActive { get; set; }
    }

    
    //public class CaseManagerViewModel
    //{
    //    [Key]
    //    [ScaffoldColumn(false)]
    //    public int CaseManagerUserId { get; set; }
    //    public string CaseManagerName { get; set; }
    //}

    //public class SocialWorkerViewModel
    //{
    //    [Key]
    //    [ScaffoldColumn(false)]
    //    public int SocialWorkerUserId { get; set; }
    //    public string SocialWorkerName { get; set; }
    //}
    //public class PsychologistViewModel
    //{
    //    [Key]
    //    [ScaffoldColumn(false)]
    //    public int PsychologistUserId { get; set; }
    //    public string PsychologistName { get; set; }
    //}
    //public class PsychiatristViewModel
    //{
    //    [Key]
    //    [ScaffoldColumn(false)]
    //    public int PsychiatristUserId { get; set; }
    //    public string PsychiatristName { get; set; }
    //}
    public class AssignmentViewModel
    {
        public int Id { get; set; }
        public int EpisodeID { get; set; }
        public string ClientName { get; set; }
        public string CDCRNum { get; set; }
        public int? ParoleLocationID { get; set; }
        public int? ComplexID { get; set; }
        public string Location { get; set; }
        public DateTime? CaseBankedDate { get; set; }
        public string ParoleAgentName { get; set; }
        public string MHStatus { get; set; }
        public string CaseStatus { get; set; }

        public int? SocialWorkerUserId { get; set; }
        public int? PsychologistUserId { get; set; }
        public int? PsychiatristUserId { get; set; }
        //public int? CaseManagerUserId { get; set; }
        //public PATSUser CaseManager { get; set; }
        public PATSUser SocialWorker { get; set; }
        public PATSUser Psychologist { get; set; }
        public PATSUser Psychiatrist { get; set; }

        public bool CanEdit { get; set; }
        public int DefaultFilterUserID { get; set; }
        public int DefaulCaseWorkTypeId { get; set; }
        public string ActiveTabIn { get; set; }
    }
}