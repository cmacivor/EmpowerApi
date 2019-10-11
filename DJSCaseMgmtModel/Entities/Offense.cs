using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgmtModel.Entities
{
    public class Offense : EntityBase
    {
        [Required, StringLength(255)]
        public string Name { get; set; }
        
        public string DYFS { get; set; }
        
        public string VCCCode { get; set; }
        
        public string GeneralHeading { get; set; }
        
        public string Type { get; set; }
        
        public string Description { get; set; }
        
        public string Statute { get; set; }
        
        [Required]
        public bool Active { get; set; }

    }
}