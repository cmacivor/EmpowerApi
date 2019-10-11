using System;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DJSCaseMgtService.Utility
{
    public class Constant
    {
        public static string DatabaseConnection =
            ConfigurationManager.ConnectionStrings["DJSCaseMgtContext"].ConnectionString;

        public static int SystemID =
            Int32.Parse(ConfigurationManager.AppSettings["SystemID"]);
    }
}
