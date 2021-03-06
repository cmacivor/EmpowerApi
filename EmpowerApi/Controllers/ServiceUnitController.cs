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
using EmpowerApi.Controllers;

namespace DJSCaseMgtService.Controllers
{
    [RoutePrefix("api/ServiceUnit")]
    public class ServiceUnitController : BaseController<ServiceUnit>
    {
        private DJSCaseMgtContext context = new DJSCaseMgtContext();
        public ServiceUnitController(IBaseRepository<ServiceUnit> baseRepository) : base(baseRepository) { }


        #region "Service methods"

        [System.Web.Http.HttpGet, Route("GetAll")]
        public IHttpActionResult GetAll()
        {
            int systemID = base.authRepository.GetSystemIDByLoggedInUserRole();

            IEnumerable<ServiceUnit> output = null;
            if (ModelState.IsValid)
            {
                output = context.ServiceUnit.Where(x => x.Active == true && x.SystemID == systemID).ToList();
            }

            return Ok(output);
        }

        [System.Web.Http.HttpGet, Route("GetByEnrollmentID/{id:int}")]
        public IHttpActionResult GetByEnrollmentID(int id)
        {
            int systemID = base.authRepository.GetSystemIDByLoggedInUserRole();

            var serviceUnits = context.ServiceUnit.Where(x => x.Active == true && x.SystemID == systemID && x.EnrollmentID == id);

            return Ok(serviceUnits);
        }

        [System.Web.Http.HttpGet, Route("GetByID/{id:int}")]
        public IHttpActionResult GetById(int id)
        {
            var serviceUnit = context.ServiceUnit.FirstOrDefault(x => x.ID == id);

            return Ok(serviceUnit);
        }

        [System.Web.Http.HttpPut, Route("UpdateServiceUnit/{id:int}")]
        public int UpdateServiceUnit(ServiceUnit serviceUnit)
        {
            var original = context.ServiceUnit.Find(serviceUnit.ID);
            try
            {
                if (original != null)
                {
                    context.Entry(original).CurrentValues.SetValues(serviceUnit);
                    context.SaveChanges();
                }
            }
            catch (Exception e)
            {
                throw e;
            }

            return serviceUnit.ID;

        }

        [System.Web.Http.HttpGet, Route("Delete/{id:int}")]
        public async Task<int> Delete(int id)
        {
            if (ModelState.IsValid)
            {
                var record = context.ServiceUnit.Where(x => x.ID == id).FirstOrDefault();
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



