using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgmtModel.Entities
{
    public class Relationship : EntityBase
    {
        [Required, StringLength(2)]
        public string Name { get; set; }
        
        [Required, StringLength(50)]
        public string Description { get; set; }
        
        [Required]
        public bool Active { get; set; }
    }
}