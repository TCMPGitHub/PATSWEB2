using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IdentityManagement.Entities.SocialWork
{
    public class NeedsAssessmentData
    {
        public int AssessmentId { get; set; }
        public string AdditionalInformation { get; set; }
        public bool? ServiceHighNeeds { get; set; }
        public bool? ServiceModNeeds { get; set; }
        public bool? ServiceLowNeeds { get; set; }
        public bool? InterpreterNeededYes { get; set; }
        public bool? InterpreterNeededNo { get; set; }
        public string AssessmentLauguage { get; set; }
        public DateTime? AssessmentDate { get; set; }
        public int? IRPID { get; set; }
        public int MCASRScore { get; set; }
        public string ActionName { get; set; }
        public bool IsLastNeedsAssessmentSet { get; set; }
    }

    public class NeedsAssessmentDates{
        public int AssessmentID { get; set; }
        public string AssessmentDate { get; set; }
    }
}
