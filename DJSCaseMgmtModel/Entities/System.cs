using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgmtModel.Entities
{
    public class System : EntityBase
    {
        [Required]
        public string Name { get; set; }
        
        [Required]
        public bool Active { get; set; }
       
    }
}