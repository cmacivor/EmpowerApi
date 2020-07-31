using DJSCaseMgmtModel.Entities;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgtService.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;

namespace EmpowerApi.Controllers
{
    [RoutePrefix("api/CareerPathway")]
    public class CareerPathwayController : BaseController<CareerPathway>
    {
        private DJSCaseMgtContext context = new DJSCaseMgtContext();

        public CareerPathwayController(IBaseRepository<CareerPathway> context) : base(context)
        {
        }

        [HttpGet, Route("GetAll")]
        public IHttpActionResult GetAll()
        {
            if (ModelState.IsValid)
            {
                var careerPathways = new List<CareerPathway>();

                careerPathways = GetCachedItems();

                if (careerPathways == null || careerPathways.Count() == 0)
                {
                    careerPathways = context.CareerPathway.Where(x => x.Active == true).OrderBy(x => x.Name).ToList();

                    SetCachedItems(careerPathways);
                }

                return Ok(careerPathways);
            }

            return null;
        }

        [HttpGet, Route("Delete/{id:int}")]
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

    }
}
