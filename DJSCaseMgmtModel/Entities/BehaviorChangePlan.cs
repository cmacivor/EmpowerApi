using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgmtModel.Entities
{
    public class BehaviorChangePlan : EntityBase
    {
        [Required]
        public int ClientProfileID { get; set; }

        public int EnrollmentID { get; set; }

        public virtual Enrollment Enrollment { get; set; }

        public DateTime? BCPlanCreationDate { get; set; }

        public virtual Staff Source { get; set; }

        public string Comments { get; set; }

        public DateTime? ClientPlanReviewDate { get; set; }

        public DateTime? LCSWPlanReviewDate { get; set; }

        public bool Active { get; set; }






    }
}
