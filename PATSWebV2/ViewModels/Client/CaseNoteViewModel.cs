using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PATSWebV2.ViewModels.Client
{
    public class CaseNoteViewModel
    {

        //public List<CaseNoteData> CaseNotes { get; set; }
        //public  List<CaseNoteHistory> CaseNoteDetails { get; set; }
        public int EpisodeId { get; set; }
        public bool CanEdit { get; set; }
        public string ActionModel { get; set; }
        public MvcHtmlString NoEditAllowed { get; set; }
        public CaseNoteViewModel() { }

    }
}