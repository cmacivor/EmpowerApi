using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgmtModel.Entities
{
    public class LoginRole : EntityBase
    {
        [Required, StringLength(50)]
        public string Name { get; set; }
        [StringLength(500)]
        public string Description { get; set; }
        [Required]
        public bool Active { get; set; }

        #region Set Relationships/Constraints
        public virtual IEnumerable<LoginProfile> LoginProfile { get; set; }
        #endregion
    }
}