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
    /// <summary>
    /// API to access CareerPathway options
    /// </summary>
    [RoutePrefix("api/CareerPathway")]
    public class CareerPathwayController : BaseController<CareerPathway>
    {
        private DJSCaseMgtContext context = new DJSCaseMgtContext();
        /// <summary>
        /// CareerPathway repo
        /// </summary>
        /// <param name="baseRepository"></param>
        public CareerPathwayController(IBaseRepository<CareerPathway> baseRepository) : base(baseRepository) { }

        #region "Service methods"
        /// <summary>
        /// Get list of Career Pathways
        /// </summary>
        /// <returns></returns>
        [System.Web.Http.HttpGet, Route("GetAll")]
        public IHttpActionResult GetAll()
        {
            IEnumerable<CareerPathway> output = null;
            if (ModelState.IsValid)
            {
                output = context.CareerPathway.Where(x => x.Active == true).OrderBy(x => x.Name).ToList();
            }

            return Ok(output);
        }

        /// <summary>
        /// Deletes specific career pathway
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [System.Web.Http.HttpGet, Route("Delete/{id:int}")]
        public IHttpActionResult Delete(int id)
        {
            string result = "";
            if (ModelState.IsValid)
            {
                var record = context.CareerPathway.Where(x => x.ID == id).FirstOrDefault();
                if (record != null)
                {
                    record.Active = false;
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
        #endregion
    }
}
