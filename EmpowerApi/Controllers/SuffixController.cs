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
    [RoutePrefix("api/Suffix")]
    public class SuffixController : BaseController<Suffix>
    {
        private DJSCaseMgtContext context = new DJSCaseMgtContext();

        public SuffixController(IBaseRepository<Suffix> context) : base(context)
        {
        }

        [HttpGet, Route("GetAll")]
        public IHttpActionResult GetAll()
        {
            if (ModelState.IsValid)
            {
                var suffixes = new List<Suffix>();
   
                suffixes = GetCachedItems();

                if (suffixes == null || suffixes.Count() == 0)
                {
                    suffixes = context.Suffix.Where(x => x.Active == true).ToList();

                    SetCachedItems(suffixes);
                }

                return Ok(suffixes);
            }


            return null;
        }


        [HttpGet, Route("Delete/{id:int}")]
        public IHttpActionResult Delete(int id)
        {
            string result = "";
            if (ModelState.IsValid)
            {
                var record = context.Suffix.Where(x => x.ID == id).FirstOrDefault();
                if (record != null)
                {
                    context.Suffix.Remove(record);
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
