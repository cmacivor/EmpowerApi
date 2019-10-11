using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgmtModel.Entities
{
    public class Staff : EntityBase
    {

       
        public string Agency { get; set; }

        public string LastName { get; set; }

        public string FirstName { get; set; }

        public string NetLogin { get; set; }

        public string Password { get; set; }

        public int? JobTitleID { get; set; }
        public virtual JobTitle JobTitle { get; set; }

        public string Phone { get; set; }

        public string Fax { get; set; }

        public string EMail { get; set; }

        public string Department { get; set; }

        public string OfficeLocation { get; set; }

        public string NetworkConnection { get; set; }

        public string AccessLevelReq { get; set; }

        public string SQLRole { get; set; }

        public DateTime? HireDate { get; set; }

        public DateTime? TerminationDate { get; set; }

        public string RestrictLevel { get; set; }

        public string Supervisor { get; set; }

        [Required]
        public bool Active { get; set;}

        public int SystemID { get; set; }

        //public virtual ICollection<Enrollment> counselorstaff { get; set; }
       // public virtual ICollection<Enrollment> sourcestaff { get; set; }

    }
}