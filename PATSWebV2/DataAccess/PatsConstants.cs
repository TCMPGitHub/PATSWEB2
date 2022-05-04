//using PATS.Models.ViewModels.PATS;
using System;
using System.Reflection;
using System.Web.Configuration;

namespace PATSWebV2.DataAccess
{
    public static class PatsConstants
    {
        public static string Environment
        {
            get
            {
                return (WebConfigurationManager.AppSettings["Environment"] == "Development" ? WebConfigurationManager.AppSettings["Environment"] : "");
            }
        }

        public static bool ShowPrescription
        {
            get
            {
                return WebConfigurationManager.AppSettings["ShowPrescriptionTab"] == "true";
            }
        }
        public static string LoginTitle
        {
            get
            {
                return " - " + WebConfigurationManager.AppSettings["SiteName"] + " (" + WebConfigurationManager.AppSettings["Environment"] + ")";
            }
        }
        public static string BkgColor
        {
            get
            {
                if (WebConfigurationManager.AppSettings["Environment"] == "Development")
                    return "red";
                else
                    return "white";
            }
        }
        public class FooterInfo
        {
            public string Version { get; set; }
            public string AppName { get; set; }
            public string CopyRight { get; set; }
        }

        public static bool ShowEnvironment
        {
            get
            {
                return WebConfigurationManager.AppSettings["ShowEnvironment"] == "true";
            }
        }

        public static string SiteName
        {
            get
            {
                return WebConfigurationManager.AppSettings["SiteName"];
            }
        }

        public static string PATSName
        {
            get
            {
                return WebConfigurationManager.AppSettings["PATSName"];
            }
        }

        public static string ActiveDirectory
        {
            get
            {
                return WebConfigurationManager.AppSettings["ActiveDirectory"];
            }
        }

        public static string ProductionAbout
        {
            get
            {
                var appCopyRight = ((AssemblyCopyrightAttribute)Attribute.GetCustomAttribute(Assembly.GetExecutingAssembly(), typeof(AssemblyCopyrightAttribute))).Copyright.ToString();
                var appName = ((AssemblyProductAttribute)Attribute.GetCustomAttribute(Assembly.GetExecutingAssembly(), typeof(AssemblyProductAttribute))).Product.ToString();
                var appVersion = ((AssemblyFileVersionAttribute)Attribute.GetCustomAttribute(Assembly.GetExecutingAssembly(), typeof(AssemblyFileVersionAttribute))).Version.ToString();
                return appName + "(" + appVersion + ") - " + appCopyRight;
            }
        }

        public static int EditOffenderSearchLimit
        {
            get
            {
                return Convert.ToInt32(WebConfigurationManager.AppSettings["EditOffenderSearchLimit"]);
            }
        }

        public const byte MaxLoginFailures = 5;
        public const string PlaceholderSSN = "999-99-9999";
        public const string PlaceholderHousing = "UNK UNK";
        public const int InactiveCutOffDays = 180;

    }
}