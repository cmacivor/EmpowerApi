using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgmtModel.Entities
{
    public class School : EntityBase
    {
        [Required, StringLength(50)]
        public string Name { get; set; }
        
        [StringLength(25)]
        public string Phone { get; set; }
        
        [StringLength(50)]
        public string Principal { get; set; }
        
        [StringLength(255)]
        public string Address { get; set; }
        
        [StringLength(50)]
        public string Zip { get; set; }
        
        [StringLength(25)]
        public string Fax { get; set; }
        
        public string EducationLevel { get; set; }
        
        public string SchoolCode { get; set; }
        
        [Required]
        public bool Active { get; set; }

    }
}