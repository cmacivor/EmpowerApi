using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgmtModel.Entities;
using DJSCaseMgtService.Models;
using EmpowerApi.Controllers;

namespace DJSCaseMgtService.Controllers
{
    [RoutePrefix("api/ActionPlan")]
    public class ActionPlanController : BaseController<ActionPlan>
    {
        private IActionPlanRepository actionPlanRepository;
        private DJSCaseMgtContext context = new DJSCaseMgtContext();
        public ActionPlanController(IBaseRepository<ActionPlan> baseRepository, IActionPlanRepository actionPlanRepository) : base(baseRepository)
        {

            this.actionPlanRepository = actionPlanRepository;
        }


        [System.Web.Http.HttpPut, Route("UpdateActionPlan/{id:int}")]
        public int UpdateActionPlan(ActionPlan actionPlan)
        {

            var original = context.ActionPlan.Find(actionPlan.ID);
            try
            {
                if (original != null)
                {
                    context.Entry(original).CurrentValues.SetValues(actionPlan);
                    context.SaveChanges();
                }
            }
            catch (Exception e)
            {
                throw e;
            }

            return actionPlan.ID;

        }

    }
}
