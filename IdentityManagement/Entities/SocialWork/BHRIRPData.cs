using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IdentityManagement.Entities
{
    public class IdentifiedBarriersToIntervention
    {
        public int IBTIID { get; set; }
        public string IBTIValue { get; set; }
    }
    public class BarrierFrequency
    {
        public int BarrFreqID { get; set; }
        public string BarrFreqValue { get; set; }
    }
    public class BHRIRP
    {
        public int NeedId { get; set; }
        public string NeedName { get; set; }
        public int? NeedLevel { get; set; }
        public string STGoal { get; set; }
        public string PlanedSTIntervention { get; set; }
        public DateTime? STGoalMetDate { get; set; }
        public int? ReadingForCharge { get; set; }
        public string LTGoal { get; set; }
        public string PlanedLTIntervention { get; set; }
        public DateTime? LTGoalMetDate { get; set; }
        public int? IdentifiedBarriersToInterventionId { get; set; }
        public int? BarrierFrequency { get; set; }
    }
    public class BHRIRPData
    {
        public int IRPId { get; set; }
        public int EpisodeID { get; set; }
        public string BHRIRPJson { get; set; }
        public bool IsLastBIRPSet { get; set; }
        public int? CurrentPhaseStatus { get; set; }
        public string AdditionalRemarks { get; set; }
        public int ActionStatus { get; set; }
        public int ActionBy { get; set; }
        public string ActionName { get; set; }
        public DateTime DateAction { get; set; }
        public bool CanEditIRP { get; set; }
        public List<BHRIRP> IRPList { get; set; }
    }
    public class BHRIRPPDFData
    {
        public string NeedId { get; set; }
        public string NeedName { get; set; }
        public string NeedLevel { get; set; }
        public string STGoal { get; set; }
        public string PlanedSTIntervention { get; set; }
        public string STGoalMetDate { get; set; }
        public string ReadingForCharge { get; set; }
        public string LTGoal { get; set; }
        public string PlanedLTIntervention { get; set; }
        public string LTGoalMetDate { get; set; }
        public string IBTIDesc { get; set; }
        public string BarrFreq { get; set; }
    }

    public class BHRIRPDates
    {
        public int BHRIRPID { get; set; }
        public string BHRIRPDate { get; set; }
    }
}
