using IdentityManagement.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PATSWebV2.ViewModels.Client
{
    public class ClientEditViewModel
    {
        public int EpisodeId { get; set; }
        public ClientProfile Profile { get; set; }
        public bool EditingEnabled { get; set; }
        public bool CanDoASAM { get; set; }
        public bool NewProfile { get; set; }
        public bool IsLOCAdmin { get; set; }
        public List<Complex> AllCountys { get; set; }
        public List<Gender> AllGenders { get; set; }
        public List<Ethnicity> AllEthnicities { get; set; }
        public List<SignificantOtherStatus> AllSignOtherStatuses { get; set; }
        public List<CaseClosureReason> AllCaseClosureReasons { get; set; }
        public List<CaseReferralSource> AllCaseReferrals { get; set; }
        public List<ParoleMentalHealthLevelOfService> AllParoleMentalHealthLOfS { get; set; }
        public SelectList PageSize { get; internal set; }

        public ClientEditViewModel() { }
    }
    public class ClientHealthBenefitViewModel
    {
        public List<HealthBenefit> HealthBenefitList { get; set; }
        public int EpisodeId { get; set; }
        public bool CanEditHCB { get; set; }
        public string ErrorMessage { get; set; }
    }
}