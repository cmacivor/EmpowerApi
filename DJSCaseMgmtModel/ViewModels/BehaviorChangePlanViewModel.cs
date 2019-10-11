using DJSCaseMgmtModel.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace DJSCaseMgmtModel.ViewModels
{
    public class BehaviorChangePlanViewModel
    {
        public BehaviorChangePlan BehaviorChangePlan { get; set; }
        public IEnumerable<BCPTargets> BCPTargets { get; set; }

    }
}


