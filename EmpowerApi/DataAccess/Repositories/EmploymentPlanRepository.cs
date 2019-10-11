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
    public class EmploymentPlanRepository : BaseRepository<EmploymentPlan>, IEmploymentPlanRepository
    {
        private DJSCaseMgtContext context;

        public EmploymentPlanRepository(DJSCaseMgtContext context) : base(context)
        {
            this.context = context;
        }

        public IEnumerable<EmploymentPlan> GetEmploymentForEnrollment(int enrollmentID)
        {
            var employment = (from e in context.EmploymentPlan
                               where e.EnrollmentID == enrollmentID &&
                               e.Active == true
                               select e).AsEnumerable();

            return employment;
        }

        public string DeleteEmploymentPlan(int id)
        {
            string output = "";
            var req = context.EmploymentPlan.Where(x => x.ID == id).ToList();
            if (req.Count == 0)
                return null;
            else
                req.ForEach(x =>
                {
                    context.EmploymentPlan.Remove(x);
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

public interface IEmploymentPlanRepository
    {
        IEnumerable<EmploymentPlan> GetEmploymentForEnrollment(int enrollmentID);

        string DeleteEmploymentPlan(int id);
    }
}