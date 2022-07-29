using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IdentityManagement.Entities
{
    public class DSM5Data
    {
        public int DSM5ID { get; set; }
        public int EpisodeID { get; set; }
        public string DSM5Json { get; set; }
        public int ActionStatus { get; set; }
        public int ActionBy { get; set; }
        public DateTime DateAction { get; set; }
    }

    public class DSM5Dates
    {
        public int DSM5ID { get; set; }
        public string DSM5Date { get; set; }
    }
}


