using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgmtModel.Entities
{
    public class ClientAdult : SystemBase
    {
        [Required]
        public int PersonID { get; set; }

        [Required]
        public bool Active { get; set; }

        public virtual System System { get; set; }

        public virtual PersonAdult Person { get; set; }

    }
}