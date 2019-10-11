using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgmtModel.Entities
{
    public class PersonAddress : EntityBase
    {
        [Required]
        public int PersonID { get; set; }
        public virtual Person Person { get; set; }

        [Required]
        public int AddressTypeID { get; set; }
        public virtual AddressType AddressType { get; set; }

        public string GISCode { get; set; }
        
        public decimal? Latitude { get; set; }
        
        public decimal? Longitude { get; set; }
        
        public string AddressLineOne { get; set; }
        
        public string AddressLineTwo { get; set; }
        
        public string City { get; set; }
        
        public string State { get; set; }
        
        public string Zip { get; set; }
        
        public string POBox { get; set; }        
        
        public string Comments { get; set; }

        public string TimeAtCurrentAddress { get; set; }

        public string PropertyTypes { get; set; }

        public bool? Homeless { get; set; }

        public string CouncilDistrict { get; set; }

        public int? PropertyTypeID { get; set; }
        public virtual PropertyType PropertyType { get; set; }




        [Required]
        public bool Active { get; set; }
    }
}