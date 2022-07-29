using IdentityManagement.Entities;
using IdentityManagement.Entities.SocialWork;
using System;
using System.Collections.Generic;
using System.Web.Mvc;

namespace PATSWebV2.ViewModels.SocialWork
{
    public class AssessmentViewModel
    {
        public int EpisodeID { get; set; }
        public string ActionUserName { get; set; }
        public List<IRPSet> IRPSetList { get; set; }
        public NeedsAssessmentData NeedsAssessmentSet { get; set; }
        public bool CanEdit { get; set; }
        public MvcHtmlString NoEditAllowed { get; set; }
        public string IDTTDecision { get; set; }
        public DateTime? AssessmentDate { get; set; }
        public AssessmentViewModel() { }
    }
}