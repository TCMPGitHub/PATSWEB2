using IdentityManagement.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PATSWebV2.ViewModels.DSM
{
    public class DsmViewModel
    {
        public string DiagnosticImpression { get; set; }
        public int EpisodeId { get; set; }
        //public SelectList DmsdateList { get; set; }
        //public int SelectedDmsDateId { get; set; }  //dsm id
        public int DsmId { get; set; }
        public bool CanEdit { get; set; }
        public MvcHtmlString NoEditAllowed { get; set; }
        //public DsmData DsmD { get; set; }
        //public bool HasDsm { get; set; }
        //public DateTime? LastDsmDate { get; set; }
        //public string LastDsmDesc { get; set; }
        //public string DsmCode { get; set; }
        public string ActiveTabIn { get; set; }
        public DsmViewModel() { }
    }
}