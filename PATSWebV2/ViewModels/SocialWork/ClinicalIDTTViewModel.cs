using IdentityManagement.Entities.SocialWork;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PATSWebV2.ViewModels.SocialWork
{
    public class ClinicalIDTTViewModel
    {
        public ClinicalIDTTData ClinicalIDTTSet { get; set; }
        public IEnumerable<SelectListItem> FinalIDTTDecision { get; set; }
        public IEnumerable<SelectListItem> SAssignmentType { get; set; }
        public int EpisodeId { get; set; }
        public bool CanEdit { get; set; }
        public MvcHtmlString NoEditAllowed { get; set; }
        public ClinicalIDTTViewModel() { }
    }
}