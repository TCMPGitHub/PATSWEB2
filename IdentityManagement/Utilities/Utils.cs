using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace IdentityManagement.Utilities
{
    public class Utils
    {
        public static String ConnectionString()
        {
            return System.Configuration.ConfigurationManager.ConnectionStrings["PATSWeb"].ConnectionString;
        }
        public static int ConnectTime()
        {
            return Convert.ToInt32(System.Configuration.ConfigurationManager.AppSettings["DBConnectionTimeOut"]);
        }
        public static bool IfUserAuthenticated()
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                return true;
            }
            return false;
        }

        public static bool IfUserInRole(string roleName)
        {
            if (IfUserAuthenticated())
            {
                if (HttpContext.Current.User.IsInRole(roleName))
                {
                    return true;
                }
            }
            return false;
        }

    }

}
