using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DJSCaseMgmtModel.Entities
{
    public class GoalSteps
    {
        public int BCPTargetsID { get; set; }
        public virtual BCPTargets BCPTargets { get; set;}
        public string GoalStep { get; set; }

        public DateTime? DueDate { get; set; }
        public DateTime? CompletionDate { get; set; }
        
    }
}
