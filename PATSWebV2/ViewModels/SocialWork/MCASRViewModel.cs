using IdentityManagement.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PATSWebV2.ViewModels.SocialWork
{
    public class MCASRViewModel
    {
        public int EpisodeID { get; set; }
        public List<ScaleQuestion> Scalequestions { get; set; }
        public bool CanEdit { get; set; }
        public MvcHtmlString NoEditAllowed { get; set; }
        public MCASRData MCASRData { get; set; }
        public MCASRViewModel() { }
    }
}