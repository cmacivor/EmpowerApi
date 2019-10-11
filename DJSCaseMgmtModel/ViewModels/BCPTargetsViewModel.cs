using System;
using System.Collections.Generic;
using System.Linq;
using DJSCaseMgmtModel.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DJSCaseMgmtModel.ViewModels
{
    class BCPTargetsViewModel
    {
        public BCPTargets BCPTarget { get; set;}
        public IEnumerable<GoalSteps> GoalStep { get; set; }
    }



}

