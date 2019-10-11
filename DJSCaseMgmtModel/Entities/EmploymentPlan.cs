using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;

namespace DJSCaseMgmtModel.Entities
{
    public class EmploymentPlan : EntityBase
    {
        public int EnrollmentID { get; set; }

        //public virtual Enrollment Enrollment { get; set; }
        public string EmploymentGoal { get; set; }

        public string EduTrainGoal { get; set; }

        public string WorkExperience { get; set; }

        public string Strengths { get; set; }

        public string HighestEd { get; set; }

        public string AddtlTraining { get; set; }

        public string Credentials { get; set; }

        public string Barriers { get; set; }

        [Required]
        public bool Active { get; set; }
    }
}