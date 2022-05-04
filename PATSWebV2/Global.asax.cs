using PATSWebV2.App_Start;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Http;
using System.Web.Helpers;

namespace PATSWebV2
{
    public class MvcApplication : System.Web.HttpApplication
    {
        internal MvcHtmlString NoEditAllowed
        {
            get { return MvcHtmlString.Create("<i><scan style='color:darkgoldenrod;font-size:x-small'>You do not have permission to edit.</scan></i>"); }
        }
        internal string LoginUserName
        {
            get { return ""; }
            set { this.LoginUserName = value; }
        }
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            WebApiConfig.Register(GlobalConfiguration.Configuration);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            Dapper.SqlMapper.AddTypeMap(typeof(string), System.Data.DbType.AnsiString);

            ValueProviderFactories.Factories.Add(new JsonValueProviderFactory());
            Application["NoEditAllowed"] = NoEditAllowed;

            AntiForgeryConfig.SuppressIdentityHeuristicChecks = true;
        }
        protected void Application_BeginRequest(Object sender, EventArgs e)
        {
            AntiForgeryConfig.SuppressIdentityHeuristicChecks = true;
            AntiForgeryConfig.RequireSsl = HttpContext.Current.Request.IsSecureConnection;

            HttpContext.Current.Response.Cache.SetExpires(DateTime.UtcNow.AddDays(-1));
            HttpContext.Current.Response.Cache.SetValidUntilExpires(true);
            HttpContext.Current.Response.Cache.SetRevalidation(HttpCacheRevalidation.AllCaches);
            HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
            HttpContext.Current.Response.Cache.SetNoStore();
        }
        protected void Application_EndRequest(Object sender, EventArgs e)
        {
            // Any AJAX request that ends in a redirect should get mapped to an unauthorized request
            // since it should only happen when the request is not authorized and gets automatically
            // redirected to the login page.
            var context = new HttpContextWrapper(Context);
            if (context.Request.IsAjaxRequest() && !context.Request.IsAuthenticated)
            {
                context.Response.Clear();
                Context.Response.StatusCode = 401;
                Response.RedirectToRoute("Logout");
            }

            //if (context.AllErrors != null && context.AllErrors.Length > 0)
            //{
            //    context.Response.Clear();
            //    context.Response.End();
            //    Response.RedirectToRoute("Logout");
            //}
            //if (context.Request.TimedOutToken.IsCancellationRequested )
            //{ 
            //    Response.RedirectToRoute("Logout");
            //}
        }
        private void Application_Error(object sender, EventArgs e)
        {
            Exception ex = Server.GetLastError();
            Response.Clear();
            Server.ClearError();
            //if (ex is HttpAntiForgeryException)
            //{
            //    Server.ClearError(); //make sure you log the exception first              
            //}
        }
    }
}
