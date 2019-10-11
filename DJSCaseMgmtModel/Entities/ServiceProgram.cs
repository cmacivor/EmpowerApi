using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgmtModel.Entities
{
    public class ServiceProgram : SystemBase
    {
        [Required, StringLength(100)]
        public string Name { get; set; }
        
        public int? ServiceProviderID { get; set; }
        public virtual ServiceProvider ServiceProvider { get; set; }

        [Required]
        public bool Active { get; set; }
    }
}