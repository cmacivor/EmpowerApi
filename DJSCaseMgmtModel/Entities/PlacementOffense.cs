using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgmtModel.Entities
{
    public class PlacementOffense : EntityBase
    {
        [Required]
        public int PlacementID { get; set; }
        public virtual Placement Placement { get; set; }

        public int OffenseID { get; set; }
        public virtual Offense Offense { get; set; }

        [Required]
        public bool Active { get; set; }
    }
}