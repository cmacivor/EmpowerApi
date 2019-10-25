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
    [RoutePrefix("api/Race")]
    public class RaceController : BaseController<Race>
    {
        private DJSCaseMgtContext context = new DJSCaseMgtContext();

        public RaceController(IBaseRepository<Race> context) : base(context)
        {
        }

        [HttpGet, Route("GetAll")]
        public IHttpActionResult GetAll()
        {
            IEnumerable<Race> output = null;
            if (ModelState.IsValid)
            {
                output = context.Race.Where(x => x.Active == true).ToList();
            }

            return Ok(output);
        }

        [HttpGet, Route("Delete/{id:int}")]
        public IHttpActionResult Delete(int id)
        {
            string result = "";
            if (ModelState.IsValid)
            {
                var record = context.Race.Where(x => x.ID == id).FirstOrDefault();
                if (record != null)
                {
                    context.Race.Remove(record);
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
