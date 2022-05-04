using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PATSWebV2.ViewModels.Client
{
    public class ClientViewModel
    {
        public int EpisodeID { get; set; }
        public string ActiveTab { get; set; }
        public bool NewEpisode { get; set; }
        public bool CanDoASAM { get; set; }
        public bool FromCM { get; set; }  // from case management
        public bool CanEditAddress { get; set; }
        public bool CanEditHCB { get; set; }
        public bool EditingEnabled { get; set; }


        public ClientViewModel() { }
    }
}