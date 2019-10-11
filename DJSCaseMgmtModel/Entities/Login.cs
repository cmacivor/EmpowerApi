using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgmtModel.Entities
{
    public class Login : EntityBase
    {
        [Required]
        public string FirstName { get; set; }
        [Required]
        public string LastName { get; set; }
        public string MiddleName { get; set; }
        public string Email { get; set; }
        public int? JobTitleID { get; set; }
        public string Department { get; set; }
        public string Agency { get; set; }
        public string PhoneNumber { get; set; }
        public string FaxNumber { get; set; }
        public string OfficeLocation { get; set; }
        [Required]
        public bool Active { get; set; }
        //public string Access { get; set; }

        #region Set Relationships/Constraints
        public virtual JobTitle JobTitle { get; set; }
        public virtual IEnumerable<LoginProfile> LoginProfile { get; set; }
        #endregion
    }
}