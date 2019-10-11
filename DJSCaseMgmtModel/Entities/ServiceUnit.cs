using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgmtModel.Entities
{
    public class ServiceUnit : SystemBase
    {
        [Required]
        public int EnrollmentID { get; set; }
        public virtual Enrollment Enrollment { get; set; }

        [Required]
        public int Year { get; set; }
        
        [Required]
        public int Month { get; set; }
        
        [Required]
        public int Units { get; set; }

        [Required]
        public bool Active { get; set; }
 
    }
}