using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PATSWebV2.ViewModels.Client
{
    
    public class PersonSearchViewModel
    {
        public string SearchString { get; set; }
        public bool RequestByOtherModel { get; set; }
        public int? SelectedSearchResult { get; set; }
        public int? SelectedParentResult { get; set; }
        public PersonSearchViewModel() { }
        public PersonSearchViewModel(string searchResult, bool requestByOtherModel)
        {
            this.SearchString = searchResult;
            this.RequestByOtherModel = requestByOtherModel;
        }
    }
}