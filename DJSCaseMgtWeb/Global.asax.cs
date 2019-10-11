using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Optimization;

namespace DJSCaseMgtWeb
{
    public class WebApiApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            GlobalConfiguration.Configure(WebApiConfig.Register);

            AreaRegistration.RegisterAllAreas();
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }

        //protected void Application_EndRequest(object sender, EventArgs e)
        //{
        //    if (Response.StatusCode == 401)
        //    {
        //       // Response.StatusCode = 303;
        //        Response.Clear();
        //        Response.Redirect("~/Login.html");
        //        Response.End();
        //    }
        //}

    }
}