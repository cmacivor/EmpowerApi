using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DJSCaseMgtViewModel.Views
{
    public class ClientProfileSearch
    {
        public int ID { get; set; }
        public string LastName { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string Suffix { get; set; }
        public string JTS { get; set; }
        public DateTime? DOB { get; set; }
    }
}