using System;
using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgmtModel.Entities
{
    public class ActionPlan : EntityBase
    {
        [Required]
        public int EmploymentPlanID { get; set; }
        //public virtual Enrollment Enrollment { get; set; }
        public string Objective { get; set; }
        public string ActionSteps { get; set; }
        public string ResponsibleParty { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime ReviewDate { get; set; }
        public DateTime ProjEndDate { get; set; }
        [Required]
        public bool Active { get; set; }
    }
}