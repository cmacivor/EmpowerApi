using DJSCaseMgmtModel.Entities;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgtService.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace EmpowerApi.Controllers
{
    [RoutePrefix("api/ServiceOutcome")]
    public class ServiceOutcomeController : BaseController<ServiceOutcome>
    {
        private DJSCaseMgtContext context = new DJSCaseMgtContext();

        public ServiceOutcomeController(IBaseRepository<ServiceOutcome> context) : base(context)
        {
        }

        [System.Web.Http.HttpGet, Route("GetAll")]
        public IHttpActionResult GetAll()
        {
            int systemID = base.authRepository.GetSystemIDByLoggedInUserRole();

            if (ModelState.IsValid)
            {
                var serviceOutcomes = new List<ServiceOutcome>();

                serviceOutcomes = GetCachedItems();

                if (serviceOutcomes == null || serviceOutcomes.Count() == 0)
                {
                    serviceOutcomes = context.ServiceOutcome.Where(x => x.Active == true && x.SystemID == systemID).ToList();

                    SetCachedItems(serviceOutcomes);
                }

                return Ok(serviceOutcomes);
            }

            return null;
        }


        [HttpGet, Route("Delete/{id:int}")]
        public IHttpActionResult Delete(int id)
        {
            string result = "";
            if (ModelState.IsValid)
            {
                var record = context.ServiceOutcome.Where(x => x.ID == id).FirstOrDefault();
                if (record != null)
                {
                    context.ServiceOutcome.Remove(record);
                }
                try
                {
                    context.SaveChanges();
                    result = "s";
                    return Ok(result);
                }
                catch (Exception ex)
                {
                    result = "f";
                    return Ok(result);
                }
            }

            return Ok(result);
        }

    }
}
