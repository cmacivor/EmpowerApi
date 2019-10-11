using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;

namespace DJSCaseMgmtModel.Entities
{
    public class Enrollment : EntityBase
    {
        public int PlacementID { get; set; }
        //public virtual Placement Placement { get; set; }
        
        public DateTime? ReferralDate { get; set; }
        
        public int? ServiceProgramCategoryID { get; set; }
        public virtual ServiceProgramCategory ServiceProgramCategory { get; set; }
        
        public int? SourceID { get; set; }
       
        public virtual Staff Source { get; set; }
        
        public string BasisofReferral { get; set; }
        
        public string Comments { get; set; }
        
        public string SuppComments { get; set; }
        
        public DateTime? BeginDate { get; set; }
        
        public DateTime? EndDate { get; set; }
        
        public string Outcome { get; set; }
        
        public int? ServiceOutcomeID { get; set; }
        public virtual ServiceOutcome ServiceOutcome { get; set; }
        
        public int? ServiceReleaseID { get; set; }
        public virtual ServiceRelease ServiceRelease { get; set; }
        
        //public DateTime? DateofReferral { get; set; }
        
        public int? CounselorID { get; set; }
       
        public virtual Staff Counselor { get; set;}
        
        public string SourceNotes { get; set; }
        
        public string MonitorOption { get; set; }
        
        public int? ComHoursAssigned { get; set; }

        public DateTime? DateCaseAssigned { get; set; }

        [Required]
        public bool Active { get; set; }

        public string ICN { get; set; }
        
     
    }
}