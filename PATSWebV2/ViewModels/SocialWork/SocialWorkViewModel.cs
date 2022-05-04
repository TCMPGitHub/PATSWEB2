using IdentityManagement.Entities.SocialWork;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PATSWebV2.ViewModels.SocialWork
{
    public class SocialWorkViewModel
    {
        public ClinicalIDTTData ClinicalIDTTSet { get; set; }
        public IEnumerable<SelectListItem> FinalIDTTDecision { get; set; }
        public IEnumerable<SelectListItem> SAssignmentType { get; set; }
        public int EpisodeId { get; set; }
        public string ActiveTabIn { get; set; }
        public string ModelAction { get; set; }
        public bool CanEdit { get; set; }
        public MvcHtmlString NoEditAllowed { get; set; }
        public bool HasIDTT { get; set; }
        public bool IsLastCLIDTTSet { get; set; }
        public SocialWorkViewModel() { }
    }
}