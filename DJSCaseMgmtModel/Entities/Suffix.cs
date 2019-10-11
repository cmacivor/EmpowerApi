using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgmtModel.Entities
{
    public class Suffix : EntityBase
    {
        [Required, StringLength(25)]
        public string Name { get; set; }
        
        [StringLength(50)]
        public string Description { get; set; }
        
        [Required]
        public bool Active { get; set; }
    }
}