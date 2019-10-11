using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgmtModel.Entities
{
    public abstract class EntityBase : AuditBase
    {
        [Key]
        public int ID { get; set; }
    }
}