using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PATSWebV2.ViewModels.Client
{
    public class AddressEditorViewModel 
    {
        public int EpisodeId { get; set; }
        public bool FromCM { get; set; }
        public bool CanEditAddress { get; set; }
        public AddressEditorViewModel() { }
    }

}