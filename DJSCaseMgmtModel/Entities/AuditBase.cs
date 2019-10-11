using System;
using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgmtModel.Entities
{

    public abstract class AuditBase
    {
        [Required]
        public DateTime CreatedDate { get; set; }
        
        [Required]
        public string  CreatedBy { get; set;}
        
        [Required]
        public DateTime UpdatedDate { get; set; }
        
        [Required]
        public string UpdatedBy { get; set; }
    }
}