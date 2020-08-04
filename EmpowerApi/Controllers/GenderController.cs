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
    [RoutePrefix("api/Gender")]
    public class GenderController : BaseController<Gender>
    {
        private DJSCaseMgtContext context = new DJSCaseMgtContext();
        public GenderController(IBaseRepository<Gender> baseRepository) : base(baseRepository)
        {
        }

        [HttpGet, Route("GetAll")]
        public IHttpActionResult GetAll()
        {
            if (ModelState.IsValid)
            {
                var genders = new List<Gender>();

                genders = GetCachedItems();

                if (genders == null || genders.Count() == 0)
                {
                    genders = context.Gender.Where(x => x.Active == true).OrderBy(x => x.Name).ToList();

                    SetCachedItems(genders);
                }

                return Ok(genders);
            }

            return null;
        }
    }
}
