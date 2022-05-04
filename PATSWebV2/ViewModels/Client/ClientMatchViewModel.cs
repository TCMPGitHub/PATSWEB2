using IdentityManagement.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PATSWebV2.ViewModels.Client
{
    public class ClientMatchViewModel
    {
        public List<MatchClient> Matches { get; set; }
        public string ActiveTab { get; set; }

        public ClientMatchViewModel() { }
    }
}