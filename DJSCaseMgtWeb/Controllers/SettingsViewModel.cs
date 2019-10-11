using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DJSCaseMgtWeb.Models
{
    public class SettingsViewModel
    {
        
        public string servicesAdultURL { get; set; }
        public string servicesURL { get; set; }
        public string uploadServiceURL { get; set; }
        public string locationURL { get; set; }
        public string GISServiceURL { get; set; }
        public string clientType { get; set; }
        public string AngularModuleName { get; set; }
        public string ViewerRole { get; internal set; }
        public string reportServerURL { get; set; }
        public string CWBreportServerURL { get; set; }
    }
}