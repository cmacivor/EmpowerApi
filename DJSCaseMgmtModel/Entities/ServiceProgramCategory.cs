using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgmtModel.Entities
{
    public class ServiceProgramCategory : SystemBase
    {
        public int ServiceProgramID { get; set; }
        public virtual ServiceProgram ServiceProgram { get; set; }

        public int? ServiceCategoryID { get; set; }
        public virtual ServiceCategory ServiceCategory { get; set; }

        [Required]
        public bool Active { get; set; }
      }
}