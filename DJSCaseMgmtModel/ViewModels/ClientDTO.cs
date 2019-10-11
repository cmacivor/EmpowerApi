using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DJSCaseMgtModel.ViewModels
{
    public class ClientDTO
    {
        public int PersonID { get; set; }
        public string LastName { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string Suffix { get; set; }
        public string JTS { get; set; }
        public DateTime? DOB { get; set; }
        public int? RaceID { get; set; }
        public int? GenderID { get; set; }
        public string SSN { get; set; }
        public string DriversLicenseNumber { get; set; }
        public int ClientProfileID { get; set; }
        public int SystemID { get; set; }

    }
}