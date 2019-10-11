using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using System.Configuration;
using DJSCaseMgtWeb.Models;
using System.Net.Http;
using System.Text;
using System.Web.Http;
using System.Net.Http.Headers;

namespace DJSCaseMgtWeb.Controllers
{
    public class HomeController : ApiController
    {

        [System.Web.Http.HttpGet]
        public HttpResponseMessage Settings(string angularModuleName = "DJSCaseMgtApp")
        {

            var settings = new SettingsDto
            {
                servicesURL = GetAppSetting<string>("servicesURL"),
                servicesAdultURL =GetAppSetting<string>("servicesAdultURL"),
                GISServiceURL = GetAppSetting<string>("GISServiceURL"),
                locationURL = GetAppSetting<string>("locationURL"),
                uploadServiceURL = GetAppSetting<string>("uploadServiceURL"),
                clientType = GetAppSetting<string>("clientType"),
                ViewerRole = GetAppSetting<string>("ViewerRole"),
                reportServerURL = GetAppSetting<string>("reportServerURL"),
                CWBreportServerURL = GetAppSetting<string>("CWBreportServerURL")
            };

            var serializerSettings = new JsonSerializerSettings
            {
                ContractResolver = new CamelCasePropertyNamesContractResolver()
            };
            var settingservicesAdultURL = JsonConvert.SerializeObject(settings.servicesAdultURL, Formatting.Indented, serializerSettings);
            var settingservicesURL = JsonConvert.SerializeObject(settings.servicesURL, Formatting.Indented, serializerSettings);
            var settingGISServiceURL = JsonConvert.SerializeObject(settings.GISServiceURL, Formatting.Indented, serializerSettings);
            var settingclientType = JsonConvert.SerializeObject(settings.clientType, Formatting.Indented, serializerSettings);
            var settinglocationURL = JsonConvert.SerializeObject(settings.locationURL, Formatting.Indented, serializerSettings);
            var settinguploadURL = JsonConvert.SerializeObject(settings.uploadServiceURL, Formatting.Indented, serializerSettings);
            var settingviewerRole= JsonConvert.SerializeObject(settings.ViewerRole, Formatting.Indented, serializerSettings);
            var settingreportServerURL = JsonConvert.SerializeObject(settings.reportServerURL, Formatting.Indented, serializerSettings);
            var settingCWBreportServerURL = JsonConvert.SerializeObject(settings.CWBreportServerURL, Formatting.Indented, serializerSettings);

            var settingsVm = new SettingsViewModel
            {
                servicesAdultURL = settingservicesAdultURL,
                servicesURL = settingservicesURL,
                GISServiceURL= settingGISServiceURL,
                clientType= settingclientType,
                locationURL= settinglocationURL,
                uploadServiceURL= settinguploadURL,
                AngularModuleName = angularModuleName,
                ViewerRole= settingviewerRole,
                reportServerURL= settingreportServerURL,
                CWBreportServerURL = settingCWBreportServerURL
            };
            string res = "(function () {angular.module('" + settingsVm.AngularModuleName + "')"+
                ".constant('servicesAdultURL'," + settingservicesAdultURL + ")" +
                ".constant('servicesURL'," + settingservicesURL + ")"+
                ".constant('GISServiceURL','" + settingGISServiceURL + "')"+
                 ".constant('clientType'," + settingclientType + ")" +
                ".constant('locationURL'," + settinglocationURL + ")" +
                  ".constant('ViewerRole'," + settingviewerRole + ")" +
                 ".constant('uploadServiceURL'," + settinguploadURL + ")" +
                 ".constant('reportServerURL'," + settingreportServerURL + ")" +
                 ".constant('CWBreportServerURL'," + settingCWBreportServerURL + ");" +
                "})();";


            HttpResponseMessage response = Request.CreateResponse(System.Net.HttpStatusCode.OK);
            response.Content = (new StringContent(res, Encoding.UTF8, "text/plain"));
            response.Content.Headers.ContentType = new MediaTypeHeaderValue("application/x-javascript");
            return response;
            //  Response.ContentType = "text/javascript";
            // return View(settingsVm);
        }

        protected static T GetAppSetting<T>(string key)
        {
            return (T)Convert.ChangeType(ConfigurationManager.AppSettings[key], typeof(T));
        }


       
        public class SettingsDto
        {
            public string servicesURL { get; set; }
            public string servicesAdultURL { get; set; }
            public string uploadServiceURL { get; set; }
            public string locationURL { get; set; }
            public string GISServiceURL { get; set; }
            public string clientType { get; set; }
            public object ViewerRole { get;  set; }
            public object reportServerURL { get; set; }
            public object CWBreportServerURL { get; set; }
        }
    }
}