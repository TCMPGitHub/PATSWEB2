using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IdentityManagement.Entities
{
    public class UserRoleInfo
    {
        public string UserRoleID { get; set; }
        public string UserID { get; set; }
        public string RoleID { get; set; }
        public string RoleName { get; set; }
    }
}