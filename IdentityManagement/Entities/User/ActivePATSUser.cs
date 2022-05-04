using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IdentityManagement.Entities
{
    public class ActivePATSUser
    {
        public int StaffId { get; set; }
        public string StaffName { get; set; }
        public string StaffType { get; set; }
        public int StaffTypeId { get; set; }
        public int LocationId { get; set; }
        public int ComplexId { get; set; }
        public bool IsCurrentUser { get; set; }

    }
}
