using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgmtModel.Entities
{
    public class LoginProfile : SystemBase
    {
        [Required]
        public int ApplicationID { get; set; }
        [Required]
        public int LoginID { get; set; }
        [Required]
        public int LoginRoleID { get; set; }
        public int LoginDomainID { get; set; }
        public string AccountName { get; set; }
        public byte[] Password { get; set; }
        [Required]
        public bool Active { get; set; }

        #region Set Relationships/Constraints
        //public virtual System System { get; set; }
        public virtual Application Application { get; set; }
        public virtual Login Login { get; set; }
        public virtual LoginRole LoginRole { get; set; }
        public virtual LoginDomain LoginDomain { get; set; }
        public virtual IEnumerable<Placement> Referral { get; set; }
        public virtual IEnumerable<Enrollment> Enrollment { get; set; }
        #endregion

    }
}