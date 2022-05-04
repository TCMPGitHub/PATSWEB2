using PATSWebV2.App_Start;
using Microsoft.AspNet.Identity;
using Microsoft.Owin;
using Microsoft.Owin.Security.Cookies;
using Owin;
using System.Web;

[assembly: OwinStartup(typeof(PATSWebV2.Startup), "ConfigureAuth")]
namespace PATSWebV2
{
    public class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }

        public void ConfigureAuth(IAppBuilder app)
        {
            app.CreatePerOwinContext<ApplicationUserManager>(ApplicationUserManager.Create);
            app.CreatePerOwinContext<ApplicationSignInManager>(ApplicationSignInManager.Create);
            app.UseCookieAuthentication(new CookieAuthenticationOptions
            {
                AuthenticationType = DefaultAuthenticationTypes.ApplicationCookie,
                //LoginPath = new PathString(VirtualPathUtility.ToAbsolute("~/PATSAccount/Login")),
                //LogoutPath = new PathString(VirtualPathUtility.ToAbsolute("~/PATSAccount/Logout")),
                LoginPath = new PathString(VirtualPathUtility.ToAbsolute("~/")),
                LogoutPath = new PathString(VirtualPathUtility.ToAbsolute("~/")),
                ExpireTimeSpan = System.TimeSpan.FromMinutes(120),
                SlidingExpiration = true
            });
        }
    }
}