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
    [RoutePrefix("api/ServiceCategory")]
    public class ServiceCategoryController : BaseController<ServiceCategory>
    {
        private DJSCaseMgtContext context = new DJSCaseMgtContext();

        public ServiceCategoryController(IBaseRepository<ServiceCategory> context) : base(context)
        {
        }

        [HttpGet, Route("GetAll")]
        public IHttpActionResult GetAll()
        {
            int systemID = base.authRepository.GetSystemIDByLoggedInUserRole();

            IEnumerable<ServiceCategory> output = null;
            if (ModelState.IsValid)
            {
                output = context.ServiceCategory.Where(x => x.Active == true && x.SystemID == systemID).ToList();
            }

            return Ok(output);
        }

        [HttpGet, Route("Delete/{id:int}")]
        public IHttpActionResult Delete(int id)
        {
            string result = "";
            if (ModelState.IsValid)
            {
                var record = context.ServiceCategory.Where(x => x.ID == id).FirstOrDefault();
                if (record != null)
                {
                    context.ServiceCategory.Remove(record);
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
