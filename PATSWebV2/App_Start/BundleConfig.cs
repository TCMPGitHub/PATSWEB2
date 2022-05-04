using System.Web;
using System.Web.Optimization;

namespace PATSWebV2
{
    public class BundleConfig
    {
        // For more information on bundling, visit http://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.IgnoreList.Ignore("*.unobtrusive-ajax.min.js", OptimizationMode.WhenDisabled);

            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                           "~/Scripts/jquery-3.3.1.min.js",
                           "~/Scripts/jquery-migrate-3.3.0.min.js"));
            
            bundles.Add(new ScriptBundle("~/bundles/jqueryui").Include(
                                  "~/Scripts/jquery-ui-1.12.1.min.js"));

            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at http://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-2.8.3.js"));

            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                      "~/Scripts/respond.min.js"));
            bundles.Add(new ScriptBundle("~/bundles/kendo").Include(
                      "~/Scripts/kendo/2019.1.220/kendo.all.min.js",
                      "~/Scripts/kendo/2019.1.220/kendo.aspnetmvc.min.js",
                      "~/Scripts/kendo/2019.1.220/jszip.min.js",
                      "~/Scripts/kendo.modernizr.custom.js"));

            bundles.Add(new ScriptBundle("~/bundles/Report").Include(
                                 "~/ReportViewer/js/telerikReportViewer.kendo-13.0.19.222.min.js",
                                 "~/ReportViewer/js/telerikReportViewer-13.0.19.222.min.js",
                                 "~/Scripts/themeSwitcher.js"));

            bundles.Add(new ScriptBundle("~/bundles/PATS").Include(
                      "~/Scripts/PATS/pulltorefresh.min.js",
                      "~/Scripts/PATS/PATSShared.js"));

            bundles.Add(new StyleBundle("~/Content/css")            
                .Include("~/Content/Site.css", new CssRewriteUrlTransform())
                .Include("~/Content/themes/base/jquery-ui-min.css", new CssRewriteUrlTransform())
                .Include("~/Content/Styles/PATS/PATSStyle_0.css", new CssRewriteUrlTransform())
                .Include("~/Content/Styles/PATS/SortablePanelForPats.css", new CssRewriteUrlTransform())
                .Include("~/Content/Styles/kendo/2019.1.220/kendo.common.min.css", new CssRewriteUrlTransform())
                .Include("~/Content/Styles/kendo/2019.1.220/kendo.common.bootstrap.min.css", new CssRewriteUrlTransform())
                .Include("~/Content/Styles/kendo/2019.1.220/kendo.bootstrap.min.css", new CssRewriteUrlTransform()));
        }
    }
}
