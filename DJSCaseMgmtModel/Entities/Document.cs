using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgmtModel.Entities
{
    public class Document : SystemBase
    {        
        [Required, StringLength(100)]    
        public string Name { get; set; }

        [Required, StringLength(100)]
        public string FileName { get; set; }

        [StringLength(200)]
        public string Description { get; set; }
        
        [Required]
        public bool Active { get; set; }
    
    }
}