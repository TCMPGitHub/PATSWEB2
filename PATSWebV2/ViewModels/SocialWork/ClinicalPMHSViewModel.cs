using IdentityManagement.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PATSWebV2.ViewModels.SocialWork
{
    public class ClinicalPMHSViewModel
    {
        public int EpisodeID { get; set; }
        public string InfoMessage { get; set; }
        public ClinicalPMHSData ClinicalPMHSSet { get; set; }
        public bool CanEdit { get; set; }
        public bool IsAdmin { get; set; }
        public MvcHtmlString NoEditAllowed { get; set; }
        public ClinicalPMHSViewModel() { }
    }
}