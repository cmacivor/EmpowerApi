using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgmtModel.Entities
{
    public class Application : SystemBase
    {
        [Required, StringLength(200)]
        public string Name { get; set; }
        [Required]
        public bool Active { get; set; }

        #region Set Relationships/Constraints
        public 
            
            System System { get; set; }
        public virtual IEnumerable<LoginProfile> LoginProfile { get; set; }
        #endregion
    }
}