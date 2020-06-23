using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgmtModel.Entities;
using DJSCaseMgmtModel.ViewModels;
using System.Threading.Tasks;
using System.Data.Entity;
using DJSCaseMgtService.Models;
using EmpowerApi.Controllers;

namespace DJSCaseMgtService.Controllers
{
    [RoutePrefix("api/EmploymentPlan")]
    public class EmploymentPlanController : BaseController<EmploymentPlan>
    {
        private IEmploymentPlanRepository employmentPlanRepository;
        private DJSCaseMgtContext context = new DJSCaseMgtContext();
        public EmploymentPlanController(IBaseRepository<EmploymentPlan> baseRepository, IEmploymentPlanRepository employmentPlanRepository)
            : base(baseRepository)
        {
            this.employmentPlanRepository = employmentPlanRepository;
        }
        [System.Web.Http.HttpGet, Route("DeleteEmploymentPlan/{id:int}")]
        public string DeleteEmploymentPlan(int id)
        {
            var employments = employmentPlanRepository.DeleteEmploymentPlan(id);

            return employments;
        }

        [System.Web.Http.HttpPut, Route("UpdateEmploymentPlan/{id:int}")]
        public int UpdateEmploymentPlan(EmploymentPlan employment)
        {
            var original = context.EmploymentPlan.Find(employment.ID);
            try
            {
                if (original != null)
                {
                    context.Entry(original).CurrentValues.SetValues(employment);
                    context.SaveChanges();
                }
            }
            catch (Exception e)
            {
                throw e;
            }

            return employment.ID;

        }

        [System.Web.Http.HttpGet, Route("GetEmploymentPlan/{id:int}")]
        public EmploymentPlan GetEmploymentPlan(int id)
        {
            var employmentPlan = context.EmploymentPlan.FirstOrDefault(x => x.EnrollmentID == id);

            return employmentPlan;
        }

    }
}
