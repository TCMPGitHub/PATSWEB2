using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using IdentityManagement.Entities;

namespace PATSWebV2.ViewModels.Client
{
    public class ClientAlertViewModel
    {
        public ClientNote Alert { get; set; }
        public bool EditingEnabled { get; set; }
        public string ActiveTab { get; set; }
        public ClientAlertViewModel() { }
    }
}