using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IdentityManagement.Entities.SocialWork
{
    public class ClinicalIDTTData
    {
        public int Id { get; set; }
        public int EpisodeId { get; set; }
        public string MemeberAttendance { get; set; }
        public string OtherMemeberAttendance { get; set; }
        public DateTime? IDTTDate { get; set; }
        public int? IDTTDecision { get; set; }
        public string RecommandationForStatus { get; set; }
        public string ActionByName { get; set; }
        public bool IsLastIDTT { get; set; }
        public string FinalDecision { get; set; }
    }
    public class IDTTDates
    {
        public int IDTTID { get; set; }
        public string IDTTDate { get; set; }
    }

    public class FinalRecommendations
    {
        public int Id { get; set; }
        public string FinalRecommendation { get; set; }
        public bool Selected { get; set; }
    }
}
