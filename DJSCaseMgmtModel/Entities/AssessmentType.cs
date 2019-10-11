using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgmtModel.Entities
{
    public class AssessmentType : SystemBase
    {
        [Required, StringLength(100)]
        public string Name { get; set; }
        
        [StringLength(200)]
        public string Description { get; set; }
        
        [Required]
        public bool Active { get; set; }

        

    }
}