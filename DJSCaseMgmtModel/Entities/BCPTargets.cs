using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DJSCaseMgmtModel.Entities
{
    public class BCPTargets: EntityBase
    {
        public int BCPlanID { get; set; }
        public virtual BehaviorChangePlan BehaviorChangePlan { get; set; }
        public string Goal { get; set; }
        public string Strengths { get; set; }

        public string Challenges {get;set;}

        public bool Active { get; set; }

    }
}
