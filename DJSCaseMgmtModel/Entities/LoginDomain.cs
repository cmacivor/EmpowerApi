using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgmtModel.Entities
{
    public class LoginDomain : EntityBase
    {
        [Required, StringLength(20)]
        public string Name { get; set; }
        [Required]
        public bool Active { get; set; }

        #region Set Relationships/Constraints
        public virtual IEnumerable<LoginProfile> LoginProfile { get; set; }
        #endregion
    }
}