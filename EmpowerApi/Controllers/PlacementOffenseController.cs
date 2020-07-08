using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgmtModel.Entities;
using EmpowerApi.Controllers;
using DJSCaseMgtService.Models;

namespace DJSCaseMgtService.Controllers
{
    [RoutePrefix("api/PlacementOffense")]
    public class PlacementOffenseController : BaseController<PlacementOffense>
    {
        private DJSCaseMgtContext context = new DJSCaseMgtContext();
        public PlacementOffenseController(IBaseRepository<PlacementOffense> baseRepository) : base(baseRepository) { }

        [HttpGet, Route("Delete/{id:int}")]
        public IHttpActionResult Delete(int id)
        {
            var placementOffense = context.PlacementOffense.FirstOrDefault(x => x.ID == id);
            if (placementOffense != null)
            {
                //placementOffense.Active = false;
                context.PlacementOffense.Remove(placementOffense);

                context.SaveChanges();

                return Ok();
            }

            return NotFound();
        }

    }
}
