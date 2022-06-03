using System.Collections.Generic;
using System.Web.Mvc;

namespace PATSWebV2.ViewModels.SocialWork
{
    public class DSM5
    {
        public int DSM5ItemID { get; set; }
        public int GroupID { get; set; }
        public int ItemScore { get; set; }
        public string DSM5ItemDesc { get; set; }
    }
    public class DSM5ViewModel
    {      
        public int DSM5ID { get; set; }
        public int EpisodeID { get; set; }
        public bool CanEdit { get; set; }
        public bool IsLastDSM5Set { get; set; }
        public string DSM5Json { get; set; }
        public int ActionBy { get; set; }
        public string ActionName { get; set; }
        public MvcHtmlString NoEditAllowed { get; set; }
        public List<DSM5> EpisodeDSM5 { get; set; } 
    }
}