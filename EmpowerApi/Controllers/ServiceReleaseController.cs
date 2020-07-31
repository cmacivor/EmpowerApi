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
    [RoutePrefix("api/ServiceRelease")]
    public class ServiceReleaseController : BaseController<ServiceRelease>
    {
        private DJSCaseMgtContext context = new DJSCaseMgtContext();

        public ServiceReleaseController(IBaseRepository<ServiceRelease> context) : base(context)
        {
        }


        [HttpGet, Route("GetAll")]
        public IHttpActionResult GetAll()
        {
            int systemID = base.authRepository.GetSystemIDByLoggedInUserRole();

            if (ModelState.IsValid)
            {
                var serviceReleases = new List<ServiceRelease>();

                serviceReleases = GetCachedItems();

                if (serviceReleases == null || serviceReleases.Count() == 0)
                {
                    serviceReleases = context.ServiceRelease.Where(x => x.Active == true && x.SystemID == systemID).ToList();

                    SetCachedItems(serviceReleases);
                }

                return Ok(serviceReleases);
            }

            return null;
        }


        [HttpGet, Route("Delete/{id:int}")]
        public IHttpActionResult Delete(int id)
        {
            string result = "";
            if (ModelState.IsValid)
            {
                var record = context.ServiceRelease.Where(x => x.ID == id).FirstOrDefault();
                if (record != null)
                {
                    context.ServiceRelease.Remove(record);
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
