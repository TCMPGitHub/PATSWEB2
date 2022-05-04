using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;

namespace IdentityManagement.Entities
{
    public class Anwser
    {
        public int AnwserId { get; set; }
        public int QuestionAnwserId { get; set; }
        public string Answer { get; set; }
    }
    public class ScaleQuestion
    {
        public int SectionId { get; set; }
        public int QuestionId { get; set; }
        public string Question { get; set; }
        public string QuestionDescription { get; set; }
        public string SelectedAnwser { get; set; }
        public string Answers { get; set; }
        public List<Anwser> PossibleAnswer { get; set; }
    }

    public class MCASRData
    {
        public int MCASRID { get; set; }
        public int? Section1Score { get; set; }
        public int? Section4Score { get; set; }
        public int? Section2Score { get; set; }
        public int? Section3Score { get; set; }
        public int TotalScore { get; set; }
        public string ActionUserName { get; set; }
        public bool IsLastMCASRSet { get; set; }
        public string IDTTDecision { get; set; }
    }
    public class MCASRDates
    {
        public int MCASRID { get; set; }
        public string CaseMCASRDate { get; set; }
        
    }
    public class CaseMCASR
    {
        public int Id { get; set; }
        public int EpisodeID { get; set; }
        public int? Section1Score { get; set; }
        public int? Section2Score { get; set; }
        public int? Section3Score { get; set; }
        public int? Section4Score { get; set; }
        public int? Question1Anwser { get; set; }
        public int? Question2Anwser { get; set; }
        public int? Question3Anwser { get; set; }
        public int? Question4Anwser { get; set; }
        public int? Question5Anwser { get; set; }
        public int? Question6Anwser { get; set; }
        public int? Question7Anwser { get; set; }
        public int? Question8Anwser { get; set; }
        public int? Question9Anwser { get; set; }
        public int? Question10Anwser { get; set; }
        public int? Question11Anwser { get; set; }
        public int? Question12Anwser { get; set; }
        public int? Question13Anwser { get; set; }
        public int? Question14Anwser { get; set; }
        public int? Question15Anwser { get; set; }
        public int? Question16Anwser { get; set; }
        public int? Question17Anwser { get; set; }
        public int ActionStatus { get; set; }
        public string ActionUserName { get; set; }
        public DateTime ASSESSMENTDATE { get; set; }
    }
}
