
using DJSCaseMgtService.Models;
using DJSCaseMgtService.oAuth;
using Newtonsoft.Json;
using System.Data.Entity;
using System.Reflection;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

namespace DJSCaseMgtService
{
    public class WebApiApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {

      
            GlobalConfiguration.Configure(WebApiConfig.Register);

            Database.SetInitializer<DJSCaseMgtContext>(null);
            //Database.SetInitializer<AuthContext>(null);
          


        }
    }
}
