using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgmtModel.Entities
{
    public class Placement : EntityBase
    {
        [Required]
        public int ClientProfileID { get; set; }
        
        public int? JudgeID { get; set; }
        public virtual Judge Judge { get; set; }
        //ISR 1019
        public string CaseNumber { get; set; }

        public int? CourtNameID { get; set; }
        public virtual CourtName CourtName { get; set; }

        //ISR 1019

        public int? AssistanceTypeID { get; set; }
        public virtual AssistanceType AssistanceType { get; set; }
        public DateTime? CourtOrderDate { get; set; }
        
        public DateTime? NextCourtDate { get; set; }
        
        public string CourtOrderNarrative { get; set; }

        public string Comments { get; set; }

        public int? PlacementLevelID { get; set; }
        public virtual PlacementLevel PlacementLevel { get; set; }

        // Start: Not required fields
        //public int? SourceID { get; set; }
        //public virtual LoginProfile Source { get; set; }

        //public string PlacementCharges { get; set; }
        // End: Not required fields
        public int? CareerPathwayID { get; set; }
        public virtual CareerPathway CareerPathway { get; set; }
        public string EmployerName { get; set; }
        public string EmployerPosition { get; set; }
        public DateTime? EmployerStartDate { get; set; }
        public string EmployerFullPartTime { get; set; }
        public string EmployerBenefits { get; set; }
        public string EmployerWages { get; set; }

        [Required]
        public bool Active { get; set; }
    }
}