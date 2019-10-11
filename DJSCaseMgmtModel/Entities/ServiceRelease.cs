using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgmtModel.Entities
{
    public class ServiceRelease : SystemBase
    {
        [Required, StringLength(100)]
        public string Name { get; set; }
        
        public string Description { get; set; }
        
        public bool ExcludeFromEnrollmentCount { get; set; }
        
        [Required]
        public bool Active { get; set; }

    }
}