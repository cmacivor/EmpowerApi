using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgmtModel.Entities
{
    public class ContactType : EntityBase
    {
        [Required]
        public string Name { get; set; }

        [StringLength(100)]
        public string Description { get; set; }

        [Required]
        public bool Active { get; set; }

        public int SystemID { get; set; }
    }
}