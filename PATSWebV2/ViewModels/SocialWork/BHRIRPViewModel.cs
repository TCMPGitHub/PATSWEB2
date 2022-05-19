using IdentityManagement.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PATSWebV2.ViewModels.SocialWork
{
    public class BHRIRPViewModel
    {
        public int EpisodeID { get; set; }
        public string ActionUserName { get; set; }
        public List<IRPSet> IRPSetList { get; set; }
        public bool CanEdit { get; set; }
        public MvcHtmlString NoEditAllowed { get; set; }
        //public string IDTTDecision { get; set; }
        //public bool IsLastIRPSet { get; set; }
        public BHRIRPViewModel() { }
    }

}