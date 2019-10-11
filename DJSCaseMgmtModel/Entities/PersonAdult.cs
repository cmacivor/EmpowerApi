using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Newtonsoft.Json;

namespace DJSCaseMgmtModel.Entities
{    
    public class PersonAdult : EntityBase
    {
        [Required, StringLength(50)]
        public string LastName { get; set; }
 
        [Required, StringLength(50)]
        public string FirstName { get; set; }
        
        [StringLength(50)]
        public string MiddleName { get; set; }
        
        public int? SuffixID { get; set; }
        public virtual Suffix Suffix { get; set; }

        public string JTS { get; set; }
        
        public DateTime? DOB { get; set; }
        
        public int? RaceID { get; set; }
        public virtual Race Race { get; set; }

        public int? GenderID { get; set; }
        public virtual Gender Gender { get; set; }

        public string SSN { get; set; }
       // public byte SSNID { get; set; }
        
        public string ICN { get; set; }
        
        [Required]
        public bool Active { get; set; }

        public string UniqueID { get; set; }

        // ToDo: Start: Remove below fields after Data Migration
        public int? tempFamilyProfileId { get; set; }
        public int? tempAddrID { get; set; }
        // ToDo: End: Remove below fields after Data Migration
    }
}