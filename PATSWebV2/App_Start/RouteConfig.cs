using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace PATSWebV2
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");
            routes.MapMvcAttributeRoutes();

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "PATSAccount", action = "Login", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "Logout",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "PATSAccount", action = "Logout", id = UrlParameter.Optional }
            );

            routes.MapRoute(
            name: "Client",
            url: "{controller}/{action}/{id}",
            defaults: new { controller = "Client", action = "Index", id = UrlParameter.Optional }
          );

           routes.MapRoute(
           name: "Assignments",
           url: "{controller}/{action}/{id}",
           defaults: new { controller = "Assignment", action = "AssignmentIndex", id = UrlParameter.Optional }
          );

          routes.MapRoute(
          name: "Appointments",
          url: "{controller}/{action}/{id}",
          defaults: new { controller = "Appointment", action = "ApptIndex", id = UrlParameter.Optional }
         );

            routes.MapRoute(
          name: "Reports",
          url: "{controller}/{action}/{id}",
          defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
         );
        }
    }
}
