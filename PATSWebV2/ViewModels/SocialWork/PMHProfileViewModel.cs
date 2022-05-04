using System.Web.Mvc;
using IdentityManagement.Entities;
using System.Collections.Generic;

namespace PATSWebV2.ViewModels.SocialWork
{
    public class PMHProfileViewModel
    {
        public int EpisodeId { get; set; }
        public PMHProfileData PMHProfileSet { get; set; }
        public List<Facilities> Facilities { get; set; }
        public bool CanEdit { get; set; }
        public MvcHtmlString NoEditAllowed { get; set; }
        public PMHProfileViewModel() { }
    }
}