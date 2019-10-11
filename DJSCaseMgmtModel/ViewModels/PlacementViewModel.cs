using DJSCaseMgmtModel.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DJSCaseMgmtModel.ViewModels
{
    public class PlacementViewModel
    {
        public Placement Placement { get; set; }

        public IEnumerable<EnrollmentViewModel> Enrollment { get; set; }

        public IEnumerable<PlacementOffense> PlacementOffense { get; set; }
    }
}