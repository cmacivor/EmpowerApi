using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DJSCaseMgmtModel.Entities
{
    public class FamilyProfile : EntityBase
    {        
        public int ClientProfilePersonID { get; set; }
        
        [ForeignKey("Person")]
        public int FamilyMemberID { get; set; }
        // Composite Foreign Key
        public virtual Person Person { get; set; }

        public int RelationshipID { get; set; }
        public virtual Relationship Relationship { get; set; }

        public bool? PrimaryContactFlag { get; set; }

        public bool? Active { get; set; }
        
    }
}