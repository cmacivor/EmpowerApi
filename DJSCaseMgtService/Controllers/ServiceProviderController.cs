using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Description;
using DJSCaseMgmtModel.Entities;
using DJSCaseMgtService.Models;
using DJSCaseMgtService.DataAccess.Repositories;

namespace DJSCaseMgtService.Controllers
{
    [RoutePrefix("api/ServiceProvider")]
    public class ServiceProviderController : BaseController<ServiceProvider>
    {
        private DJSCaseMgtContext context = new DJSCaseMgtContext();
        public ServiceProviderController(IBaseRepository<ServiceProvider> baseRepository) : base(baseRepository)  { }


        #region "Service methods"

        [System.Web.Http.HttpGet, Route("GetAll")]
        public IHttpActionResult GetAll()
        {
            IEnumerable<ServiceProvider> output = null;
            if (ModelState.IsValid)
            {
                output = context.ServiceProvider.Where(x => x.Active == true).ToList();
            }

            return Ok(output);
        }



        [System.Web.Http.HttpGet, Route("Delete/{id:int}")]
        public async Task<int> Delete(int id)
        {
            if (ModelState.IsValid)
            {
                var record = context.ServiceProvider.Where(x => x.ID == id).FirstOrDefault();
                if (record != null)
                {
                    record.Active = false;
                }
                try
                {
                    context.SaveChanges();
                    return 1;
                }
                catch (Exception ex)
                {
                    return 0;
                }
            }

            return 0;
        }
        #endregion
    }
}



