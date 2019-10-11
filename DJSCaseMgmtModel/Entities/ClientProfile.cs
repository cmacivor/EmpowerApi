using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgmtModel.Entities
{
    public class ClientProfile : SystemBase
    {
        [Required]
        public int PersonID { get; set; }

        [Required]
        public bool Active { get; set; }

        public virtual System System { get; set; }

        public virtual Person Person { get; set; }

    }
}