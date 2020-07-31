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
    [RoutePrefix("api/MaritalStatus")]
    public class MaritalStatusController : BaseController<MaritalStatus>
    {
        private DJSCaseMgtContext context = new DJSCaseMgtContext();
        public MaritalStatusController(IBaseRepository<MaritalStatus> baseRepository) : base(baseRepository)
        {
        }

        [HttpGet, Route("GetAll")]
        public IHttpActionResult GetAll()
        {
            if (ModelState.IsValid)
            {
                var maritalStatuses = new List<MaritalStatus>();

                maritalStatuses = GetCachedItems();

                if (maritalStatuses == null || maritalStatuses.Count() == 0)
                {
                    maritalStatuses = context.MaritalStatus.Where(x => x.Active == true).OrderBy(x => x.Name).ToList();

                    SetCachedItems(maritalStatuses);
                }

                return Ok(maritalStatuses);
            }

            return null;
        }
    }
}
