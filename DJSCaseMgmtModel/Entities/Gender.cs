using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgmtModel.Entities
{
    public class Gender : EntityBase
    {
        [Required, StringLength(10)]
        public string Name { get; set; }

        [StringLength(100)]
        public string Description { get; set; }

        [Required]
        public bool Active { get; set; }
        
    }
}