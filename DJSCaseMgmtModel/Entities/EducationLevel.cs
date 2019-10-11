using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgmtModel.Entities
{
    public class EducationLevel : EntityBase
    {
        [Required, StringLength(35)]
        public string Name { get; set; }
        
        [StringLength(50)]
        public string Description { get; set; }
        
        [Required]
        public bool Active { get; set; }

    }
}