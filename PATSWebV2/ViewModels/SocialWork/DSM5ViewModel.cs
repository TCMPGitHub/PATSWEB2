using System.Collections.Generic;
using System.Web.Mvc;

namespace PATSWebV2.ViewModels.SocialWork
{
    public class DMS5
    {
        public int DMS5ItemID { get; set; }
        public int GroupID { get; set; }
        public int ItemScore { get; set; }
        public string DMS5ItemDesc { get; set; }
    }
    public class DMS5ViewModel
    {      
        public int DMS5ID { get; set; }
        public int EpisodeID { get; set; }
        public bool CanEdit { get; set; }
        public bool IsLastDMS5Set { get; set; }
        public string DMS5Json { get; set; }
        public int ActionBy { get; set; }
        public string ActionName { get; set; }
        public MvcHtmlString NoEditAllowed { get; set; }
        public List<DMS5> EpisodeDMS5 { get; set; } 
    }
}