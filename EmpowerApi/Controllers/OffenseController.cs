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
    [AllowAnonymous]
    [RoutePrefix("api/Offense")]
    public class OffenseController : BaseController<Offense>
    {
        private DJSCaseMgtContext context = new DJSCaseMgtContext();
        public OffenseController(IBaseRepository<Offense> baseRepository) : base(baseRepository) { }

        [System.Web.Http.HttpGet, Route("GetAll")]
        public IHttpActionResult GetAll()
        {
            IEnumerable<Offense> output = null;
            if (ModelState.IsValid)
            {
                var offenses = new List<Offense>();

                offenses = GetCachedItems();

                if (offenses == null || offenses.Count() == 0)
                {
                    offenses = context.Offense.Where(x => x.Active == true).ToList();

                    SetCachedItems(offenses);
                }

                return Ok(offenses);
            }

            return null;
        }

        [System.Web.Http.HttpGet, Route("Delete/{id:int}")]
        public IHttpActionResult Delete(int id)
        {
            string result = "";
            if (ModelState.IsValid)
            {
                var record = context.Offense.Where(x => x.ID == id).FirstOrDefault();
                if (record != null)
                {
                    context.Offense.Remove(record);
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
