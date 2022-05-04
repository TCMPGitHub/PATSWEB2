using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IdentityManagement.Entities
{
    public class EvaluationData
    {
        public int ID { get; set; }
        public string EvaluationGUID { get; set; }
        public int EvaluatedBy { get; set; }
        public string EvaluatedName { get; set; }
        public int EvaluationItemID { get; set; }
        public string EvaluationItemDesc { get; set; }
        public string EvaluationItemNote { get; set; }
        public string EvaluationStatus { get; set; }
        public DateTime EvaluationDate { get; set; }
        public bool IsLastEvlSet { get; set; }
        public bool IsInitial { get; set; }
    }
    //public class EvaluationHistory
    //{
    //    public int ID { get; set; }
    //    public int EpisodeId { get; set; }
    //    public DateTime EvaluationDate { get; set; }
    //    public Guid EvaluationGuid { get; set; }
    //    public string EvaluatedBy { get; set; }
    //    public int EvaluationItemID { get; set; }
    //    public int EvaluationItemOrder { get; set; }
    //    public string EvaluationItemDesc { get; set; }
    //    public string EvaluationNote { get; set; }
    //    public string EvaluationStatus { get; set; }
    //}

    public class EvaluationDates
    {
        public int EvaluationID { get; set; }
        public string EvaluationDate { get; set; }
    }
}

