using IdentityManagement.Data;
using IdentityManagement.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IdentityManagement.DAL
{
    public static class UserController
    {
        public static int NewUser(ApplicationUser objUser)
        {
            List<ParameterInfo> parameters = new List<ParameterInfo>();
            parameters.Add(new ParameterInfo() { ParameterName = "UserID", ParameterValue = objUser.UserID });
            parameters.Add(new ParameterInfo() { ParameterName = "UserName", ParameterValue = objUser.UserName });
            parameters.Add(new ParameterInfo() { ParameterName = "Email", ParameterValue = objUser.Email });
            parameters.Add(new ParameterInfo() { ParameterName = "Password", ParameterValue = objUser.Password });
            //parameters.Add(new ParameterInfo() { ParameterName = "Status", ParameterValue = objUser.Status });
            int success = SqlHelper.ExecuteQuery("NewUser", parameters);
            return success;
        }
        public static int DeleteUser(ApplicationUser objUser)
        {
            List<ParameterInfo> parameters = new List<ParameterInfo>();
            parameters.Add(new ParameterInfo() { ParameterName = "UserID", ParameterValue = objUser.UserID });
            int success = SqlHelper.ExecuteQuery("DeleteUser", parameters);
            return success;
        }

        public static ApplicationUser GetUser(int userId)
        {
            List<ParameterInfo> parameters = new List<ParameterInfo>();
            parameters.Add(new ParameterInfo() { ParameterName = "UserID",
                                                 ParameterValue = userId });
            ApplicationUser oUser = SqlHelper.GetRecord<ApplicationUser>("spGetUser", parameters);
            return oUser;
        }

        public static ApplicationUser GetUserByUsername(string userName)
        {
            List<ParameterInfo> parameters = new List<ParameterInfo>();
            parameters.Add(new ParameterInfo() { ParameterName = "Username", ParameterValue = userName });
            ApplicationUser oUser = SqlHelper.GetRecord<ApplicationUser>("spGetUserByUsername", parameters);
            return oUser;
        }
        
        public static int UpdateUser(ApplicationUser objUser)
        {
            List<ParameterInfo> parameters = new List<ParameterInfo>();
            parameters.Add(new ParameterInfo() { ParameterName = "Email", ParameterValue = objUser.Email });
            int success = SqlHelper.ExecuteQuery("UpdateUser", parameters);
            return success;
        }
        public static int UpdateLoginFailure(int UserID, int logins)
        {
            return SqlHelper.ExecuteCommand(string.Format("Update dbo.[User] Set LoginFailures ={0} Where UserID ={1}", logins, UserID));
        }

        public static int RecordPageLoad(int UserID, string Controller, string Action, string Method)
        {
            return SqlHelper.ExecuteCommand(
              string.Format("INSERT INTO dbo.PageLoad(UserID,Controller,Action,Method,DateTimeOffset) VALUES({0},'{1}','{2}','{3}',GetDate())", UserID, Controller, Action, Method));
        }
    }
}
