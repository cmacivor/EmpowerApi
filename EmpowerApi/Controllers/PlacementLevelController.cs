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
    [RoutePrefix("api/PlacementLevel")]
    public class PlacementLevelController : BaseController<PlacementLevel>
    {
        private DJSCaseMgtContext context = new DJSCaseMgtContext();

        public PlacementLevelController(IBaseRepository<PlacementLevel> baseRepository) : base(baseRepository) { }



        [System.Web.Http.HttpGet, Route("GetAll")]
        public IHttpActionResult GetAll()
        {
            int systemID = base.authRepository.GetSystemIDByLoggedInUserRole();

            if (ModelState.IsValid)
            {
                var placementLevels = new List<PlacementLevel>();

                placementLevels = GetCachedItems();

                if (placementLevels == null || placementLevels.Count() == 0)
                {
                    placementLevels = context.PlacementLevel.Where(x => x.Active == true && x.SystemID == systemID).OrderBy(x => x.Name).ToList();

                    SetCachedItems(placementLevels);
                }

                return Ok(placementLevels);

            }

            return null;
        }
    }
}
