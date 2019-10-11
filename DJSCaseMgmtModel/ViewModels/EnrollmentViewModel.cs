using DJSCaseMgmtModel.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DJSCaseMgmtModel.ViewModels
{
    public class EnrollmentViewModel
    {
        public Enrollment Enrollment { get; set; }

        public IEnumerable<ProgressNote> ProgressNote { get; set; }

        public IEnumerable<ServiceUnit> ServiceUnit { get; set; }
        public IEnumerable<EmploymentPlan> EmploymentPlan { get; set; }
        public IEnumerable<ActionPlan> ActionPlan { get; set; }

    }
}