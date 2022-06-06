using IdentityManagement.Entities;
using System.Collections.Generic;
using System.Web.Mvc;

namespace PATSWebV2.ViewModels.SocialWork
{
    
    public class BHRIRPViewModel
    {
        public BHRIRPData IRP { get; set; }
        public List<IdentifiedBarriersToIntervention> IBTIList { get; set; }
        public List<BarrierFrequency> BarrFreqList { get; set; }
        
        public MvcHtmlString NoEditAllowed { get; set; }
        public BHRIRPViewModel() { }
    }

}