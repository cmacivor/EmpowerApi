using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DJSCaseMgmtModel.ViewModels
{
    public class ClientSearchResults
    {
        public int ID { get; set; }
        public string LastName { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string Suffix { get; set; }
        public string JTS { get; set; }
        public string StateORVCIN { get; set; }
        public string SSN { get; set; }
        public DateTime? DOB { get; set; }
        public string Gender { get; set; }
    }
}