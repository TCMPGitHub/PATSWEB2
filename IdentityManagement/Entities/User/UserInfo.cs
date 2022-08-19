using IdentityManagement.Utilities;
using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IdentityManagement.Entities
{
    public class UserInfo : IUser<int>
    {

        public int UserID { get; set; }
        public string UserName { get; set; }
        public string LastName { get; set; }
        public string FirstName { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string PasswordHash { get; set; }
        public bool IsActive { get; set; }
        public bool IsPOCAdmin { get; set; }
        public bool IsPOCSocialWorker { get; set; }
        public bool IsPOCPsychologist { get; set; }
        public bool IsPOCPsychiatrist { get; set; }
        public bool IsPOCCaseManager { get; set; }
        public int CaseWorkerTypeId { get; set; }
        public int PrimaryLocationId { get; set; }
        public int LoginFailures { get; set; }
        public bool IsSysAdmin { get; set; }
        public bool? IsLOCBHRAdmin { get; set; }
        //public EnumUserStatus Status { get; set; }

        int IUser<int>.Id
        {
            get
            {
                return this.UserID;
            }
        }

        string IUser<int>.UserName
        {
            get
            {
                return this.UserName;
            }

            set
            {
                this.UserName = value;
            }
        }

        public string UserLFI()
        {
            return this.LastName + ", " + this.FirstName.Substring(0, 1) + ".";
        }
    }
}
    