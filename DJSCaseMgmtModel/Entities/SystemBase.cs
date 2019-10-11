using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgmtModel.Entities
{
    public abstract class SystemBase : EntityBase
    {
        [Required]
        public int SystemID { get; set; }
    }
}