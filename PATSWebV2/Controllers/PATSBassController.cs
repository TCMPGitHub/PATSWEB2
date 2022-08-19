using IdentityManagement.Entities;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Mvc;
using System.Web.Routing;
using IdentityManagement.Utilities;
using IdentityManagement.Data;
using IdentityManagement.Entities.Assignment;
using System.Reflection.Emit;
using iTextSharp.text.pdf;
using System.Text.RegularExpressions;

namespace PATSWebV2.Controllers
{
    public enum ControllerID
    {
        Unknown, Client, Assignment, Appointment, Reports, Admin
    }

    public enum ACTION_STATUS
    {
        New = 1,
        Update,
        ReInitialize,
        Delete = 10
    }
    public abstract class PATSBassController : Controller
    {
        ApplicationUser _currentUser;
        // GET: PATS       
        public ApplicationUser CurrentUser
        {
            get { return _currentUser; }
            set { _currentUser = value; }
        }
        private string DoubleToSingleQuotes(string value)
        {
            if (string.IsNullOrEmpty(value))
                return string.Empty;
            return Regex.Replace(value, "\'", "\'\'");
        }
        public List<ActivePATSUser> GetPatsStaff(DateTime? StartDate, DateTime? EndDate, int? LocationID, int StaffID)
        {
            var parms = new List<ParameterInfo> {
                new ParameterInfo { ParameterName="CurrentUserID", ParameterValue= CurrentUser.UserID },
                new ParameterInfo { ParameterName="StartDate", ParameterValue= StartDate},
                new ParameterInfo { ParameterName="EndDate", ParameterValue= EndDate},
                new ParameterInfo { ParameterName="LocationID", ParameterValue= LocationID},
                new ParameterInfo { ParameterName="StaffID", ParameterValue= StaffID},
            };
            return SqlHelper.GetRecords<ActivePATSUser>("spGetApptStaffList", parms);
        }
        public List<ComplexList> GetComplexes()
        {
            var query = "SELECT -9999 AS ComplexID, 'All' AS ComplexDesc UNION SELECT DISTINCT ComplexID, ComplexDesc FROM dbo.tlkpLocation WHERE ISNULl(Disabled, 0)=0 Order BY ComplexDesc";
            return SqlHelper.ExecuteCommands<ComplexList>(query);
        }
        public MemoryStream CreatePDFString(PdfReader reader, Dictionary<string, string> dictionary, char endChar)
        {
            MemoryStream stream = new MemoryStream();
            using (PdfStamper pdfStamper = new PdfStamper(reader, stream, endChar))
            {
                AcroFields acroFields = pdfStamper.AcroFields;
                foreach (var key in acroFields.Fields.Keys)
                {
                    if (key.Contains("line"))
                        continue;
                    acroFields.SetField(key, dictionary[key], BaseFont.EMBEDDED);
                }

                pdfStamper.FormFlattening = true;
                pdfStamper.Close();
                reader.Close();
            }

            return stream;
        }
        public Dictionary<string, string> GetParameters(object data, int ControllId)
        {
            Dictionary<string, string> parameters = new Dictionary<string, string>();
            if (data != null)
            {
                foreach (System.Reflection.PropertyInfo property in data.GetType().GetProperties())
                {
                    string value = string.Empty;
                    if (property.PropertyType.FullName.Contains("DateTime"))
                    {
                        if (ControllId == (int)ControllerID.Appointment)
                        {
                            value = property.GetValue(data, null) == null ? "" : (Convert.ToDateTime(property.GetValue(data, null))).ToString("hh:mm AM/PM");
                        }
                        //else if (ControllId == (int)ControllerID.Prescription && property.Name == "PrintDate")
                        //{
                        //    value = property.GetValue(data, null) == null ? "" : (Convert.ToDateTime(property.GetValue(data, null))).ToLongDateString();
                        //}
                        else
                        {
                            value = property.GetValue(data, null) == null ? "" : (Convert.ToDateTime(property.GetValue(data, null))).ToString("MM/dd/yyyy");
                        }
                    }
                    else if (property.PropertyType.FullName.Contains("Boolean"))
                    {
                        if (property.GetValue(data, null) != null)
                        {
                            value = Convert.ToBoolean(property.GetValue(data, null)) == true ? "On" : "";
                        }
                    }
                    else
                    {
                        value = Convert.ToString(property.GetValue(data, null));
                    }

                    parameters.Add(property.Name, value);
                }
            }
            return parameters;
        }        
        public string RemoveUnprintableChars(string value)
        {
            if (string.IsNullOrEmpty(value))
                return string.Empty;
            value = DoubleToSingleQuotes(value);
            var regex = "/[^\t\n\r\x20-\x7E]/g";

            return Regex.Replace(value, regex, "");
        }      
        protected bool? GetBoolValue(bool? ObjYes, bool? objNo)
        {
            if (ObjYes.HasValue && ObjYes.Value == true)
            {
                return true;
            }
            else if (objNo.HasValue && objNo.Value == true)
                return false;
            else
                return (bool?)null;
        }
        protected override void Initialize(RequestContext requestContext)
        {
            base.Initialize(requestContext);

            if (requestContext.HttpContext.User.Identity.IsAuthenticated)
            {
                if((ApplicationUser)Session["Currentuser"] == null)
                {
                    try
                    {
                        List<ParameterInfo> parameters = new List<ParameterInfo>();
                        parameters.Add(new ParameterInfo() { ParameterName = "Username", ParameterValue = requestContext.HttpContext.User.Identity.Name });
                        Session["Currentuser"] = SqlHelper.GetRecord<ApplicationUser>("spGetUserByUsername", parameters);
                    }
                    catch ( Exception err){
                        throw err;
                    }
                }
                _currentUser = (ApplicationUser)Session["Currentuser"];
                ViewBag.CurrentUser = _currentUser;
                
                if (_currentUser != null && string.IsNullOrEmpty((string)HttpContext.Application["LoginUserName"]))
                    HttpContext.Application["LoginUserName"] = _currentUser.UserName;
            }
            else
                ViewBag.ControllerID = ControllerID.Unknown;
        }
        protected override void OnException(ExceptionContext filterContext)
        {
            Exception exception = filterContext.Exception;
            filterContext.ExceptionHandled = true;

            string logDir = WebConfigurationManager.AppSettings["ErrorLogDir"].ToString();
            if (string.IsNullOrEmpty(logDir))
                logDir = "Production";
            string logSubDir = WebConfigurationManager.AppSettings["Environment"].ToString();
            string logPath = Path.Combine(logDir, logSubDir);
            string logfile = logPath + "\\PATSV1Error" + DateTime.Today.ToString("MMMddyyyy") + ".txt";
            if (!System.IO.File.Exists(logfile))
            {
                System.IO.File.Create(logfile).Close();
            }
            using (StreamWriter writer = System.IO.File.AppendText(logfile))
            {
                string line = DateTime.Now.ToString("MM/dd/yyyy hh:mm ") + "        " + exception.Message;
                writer.WriteLine(line);
                writer.WriteLine("=========================================");
                writer.WriteLine();
                writer.Close();
            }

            // Output a nice error page
            if (filterContext.HttpContext.IsCustomErrorEnabled)
            {
                var result = this.View("Error", new HandleErrorInfo(exception, filterContext.RouteData.Values["controller"].ToString(), filterContext.RouteData.Values["action"].ToString()));
                filterContext.Result = result;
            }
            filterContext.HttpContext.Response.Clear();
        }

        public new void Dispose()
        {
            Session["Currentuser"] = null;
        }
    }
}