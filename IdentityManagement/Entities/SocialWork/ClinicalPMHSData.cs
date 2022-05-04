using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IdentityManagement.Entities
{
    public class OptionSelection
    {
        public bool SelectedOption { get; set; }
        public List<System.Web.UI.WebControls.ListItem> OptionItem
        {
            get
            {
                return new List<System.Web.UI.WebControls.ListItem>
                    {
                        new System.Web.UI.WebControls.ListItem { Text = " ", Value = "1" },  // Not Meet/CCCMS/discharge1
                        new System.Web.UI.WebControls.ListItem { Text = " ", Value = "2" },   //Met/EOP/discharge2
                        new System.Web.UI.WebControls.ListItem { Text = " ", Value = "3" },  //In PMHS/discharge3
                        new System.Web.UI.WebControls.ListItem { Text = " ", Value = "4" }   //In PMHS/discharge4
                    };
            }
        }
    }
    public class ClinicalPMHSData
    {
        //PMHS Inclusion status 1: Not meet, 2: meet but note in, 3: Current in
        //public OptionSelection InclusionInPMHSNoMeet { get; set; }
        //public OptionSelection InclusionInPMHSMeet { get; set; }
        //public OptionSelection InclusionInPMHSCurrent { get; set; }
        public int Id { get; set; }
        public bool InclusionInPMHSNoMeet { get; set; }
        public bool InclusionInPMHSMeet { get; set; }
        public bool InclusionInPMHSCurrent { get; set; }
        public bool MentalDisorder { get; set; }
        public bool ForMedicalNecessity { get; set; }
        public bool ForEOP { get; set; }
        public bool ForConstituteToEOP { get; set; }
        public bool ForCCCMS { get; set; }
        public bool ForConstituteToCCCMS { get; set; }
        public bool IsRenew { get; set; }
        public bool RefForWelfare { get; set; }
        public bool RefToContratedService { get; set; }
        public string RefToContratedServiceNote { get; set; }
        public bool RefForResourcePlan { get; set; }
        public string RefForResourcePlanNote { get; set; }
        public bool RefForDischarge { get; set; }
        public bool Other { get; set; }
        public string OtherNote { get; set; }
        public int? LGAFScore { get; set; }
        //public OptionSelection PsychottropicPrescribedYes { get; set; }
        //public OptionSelection PsychottropicPrescribedNo { get; set; }
        public bool PsychottropicPrescribedYes { get; set; }
        public bool PsychottropicPrescribedNo { get; set; }
        public string BehavioralAlerts { get; set; }
        public DateTime? PMHSChangeDate { get; set; } // PMHS Change Note ( additional Information)
        public string PMHSChangeNote { get; set; }
        public string PMHSDischargeNote { get; set; }  // PMHS Discharge Note ( additional Information
        public DateTime? PMHSDischargeDate { get; set; }
        public string ClinicianName { get; set; }
        public string TeamLeaderName { get; set; }
        public string SupervisorName { get; set; }
        public DateTime? TeamLeaderSigDate { get; set; }
        public DateTime? SupervisorSigDate { get; set; }
        //public string LTDFNLE { get; set; }
        public bool PMHSDischargeA { get; set; }
        public bool PMHSDischargeB { get; set; }
        public bool PMHSDischargeC { get; set; }
        public bool PMHSDischargeD { get; set; }
        public int? PMHSDischargeType { get; set; }
        public DateTime? PMHSDischargeDateA { get; set; }
        public DateTime? PMHSDischargeDateB { get; set; }
        public DateTime DateAction { get; set; }
    }
}
