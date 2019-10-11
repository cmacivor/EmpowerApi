using DJSCaseMgmtModel.Entities;
using DJSCaseMgtService.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace DJSCaseMgtService.DataAccess.Repositories
{
    public class ActionPlanRepository : BaseRepository<ActionPlan>, IActionPlanRepository
    {
        private DJSCaseMgtContext context;

        public ActionPlanRepository(DJSCaseMgtContext context) : base(context)
        {
            this.context = context;
        }

        public IEnumerable<ActionPlan> GetActionPlansForEmploymentPlan(int employmentPlanID)
        {

            //var emp = (from x in context.EmploymentPlan
            //           where x.EnrollmentID == employmentPlanID && x.Active == true
            //           select x).First();
            //var test = emp.ID;

            var actionPlan = (from x in context.ActionPlan
                                 where x.EmploymentPlanID == employmentPlanID && x.Active == true
                                 select x).AsEnumerable();

            return actionPlan;
        }
        public string DeleteActionPlan(int id)
        {
            string output = "";
            var req = context.ActionPlan.Where(x => x.ID == id).ToList();
            if (req.Count == 0)
                return null;
            else
                req.ForEach(x =>
                {
                    context.ActionPlan.Remove(x);
                });
            try
            {
                context.SaveChanges();
                output = "Success";
            }
            catch (Exception ex)
            {
                output = "Failed";
            }
            return output;
        }

    }

    public interface IActionPlanRepository
    {
        IEnumerable<ActionPlan> GetActionPlansForEmploymentPlan(int employmentPlanID);

        string DeleteActionPlan(int id);
    }
}