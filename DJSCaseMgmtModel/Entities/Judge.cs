using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgmtModel.Entities
{
    public class Judge : SystemBase
    {
        [Required, StringLength(50)]
        public string Name { get; set; }
        
        [StringLength(50)]
        public string Description { get; set; }
        
        [Required]
        public bool Active { get; set; }

    }
}