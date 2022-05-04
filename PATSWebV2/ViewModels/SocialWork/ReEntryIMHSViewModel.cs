using IdentityManagement.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PATSWebV2.ViewModels.SocialWork
{
    public enum APPOINTMENT_TYPE
    {
        ACUTE = 1,
        URGENT,
        INTERMEDIATE,
        ROUTINE,
        UNNECESSARY
    }
    public class OptionSelect
    {
        public string selectedOption { get; set; }
        public List<SelectListItem> OptionItem
        {
            get
            {
                return new List<SelectListItem>
                    {
                        new SelectListItem { Text = "YES", Value = "1" },
                        new SelectListItem { Text = "NO", Value = "2" }
                    };
            }
        }
    }
    public class ReEntryIMHSViewModel
    {
        public int EpisodeID { get; set; }
        public string ActivateTab { get; set; }
        public bool CanEdit { get; set; }
        public bool IsAdmin { get; set; }
        public MvcHtmlString NoEditAllowed { get; set; }
        public ReEntryIMHSData CaseReEntryIMHSSet { get; set; }
        public ReEntryIMHSViewModel() { }
        public ReEntryIMHSViewModel(ReEntryIMHSData reentry)
        {
            reentry.PrintUrl = "@Url.Action(\"PrintReEntry\", \"Clinical\", new { EpisodeId =" + EpisodeID.ToString() + ", CaseREIMHSID = " + reentry.CaseReEntryID.ToString() + "})";
            CaseReEntryIMHSSet = reentry;
        }
        private SelectList GetApptStatusSelectList()
        {
            Array values = Enum.GetValues(typeof(APPOINTMENT_TYPE));
            List<SelectListItem> items = new List<SelectListItem>(values.Length);

            foreach (var i in values)
            {
                items.Add(new SelectListItem
                {
                    Text = Enum.GetName(typeof(APPOINTMENT_TYPE), i),
                    Value = i.ToString()
                });
            }

            return new SelectList(items);
        }
        private string SetBoolValue(bool? selectOption)
        {
            if (selectOption == null)
                return string.Empty;
            else if (selectOption == true)
                return "1";
            else
                return "2";
        }
    }
}