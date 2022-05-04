using IdentityManagement.Entities.Psychiatry;
using System.Web.Mvc;

namespace PATSWebV2.ViewModels.Psychiatry
{
    public class PsychiatryMMAViewModel
    {
        public int EpisodeId { get; set; }
        public bool IsLastAMST { get; set; }
        public int? SelectedMMAID { get; set; }
        public bool CanEdit { get; set; }
        public MvcHtmlString NoEditAllowed { get; set; }
        public MMA PsyAsmt { get; set; }
        public string ActiveTabIn { get; set; }
        //public List<ASMTDateList> DateList { get; set; }
    }
}