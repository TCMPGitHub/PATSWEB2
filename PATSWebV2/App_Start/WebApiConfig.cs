using System.Collections.Generic;
using System.Web.Http;
using Telerik.Reporting.Services.WebApi;

namespace PATSWebV2.App_Start
{
    class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {
            //config.Routes.MapHttpRoute("API Default", "api/{controller}/{id}",
            //    new { id = RouteParameter.Optional });
            config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );

            ReportsControllerConfiguration.RegisterRoutes(config);
        }
    }
}