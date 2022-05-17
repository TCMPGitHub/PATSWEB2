using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IdentityManagement.Entities
{
    public class DMS5Data
    {
        public int DMS5ID { get; set; }
        public int EpisodeID { get; set; }
        public string DMS5Json { get; set; }
        public int ActionStatus { get; set; }
        public int ActionBy { get; set; }
        public DateTime DateAction { get; set; }
    }

    public class DMS5Dates
    {
        public int DMS5ID { get; set; }
        public string DMS5Date { get; set; }
    }
}


