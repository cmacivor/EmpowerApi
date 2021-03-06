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
    [RoutePrefix("api/Relationship")]
    public class RelationshipController : BaseController<Relationship>
    {
        private DJSCaseMgtContext context = new DJSCaseMgtContext();
        public RelationshipController(IBaseRepository<Relationship> context) : base(context)
        {
        }

        [HttpGet, Route("GetAll")]
        public IHttpActionResult GetAll()
        {
            if (ModelState.IsValid)
            {
                var relationships = new List<Relationship>();

                relationships = GetCachedItems();

                if (relationships == null || relationships.Count() == 0)
                {
                    relationships = context.Relationship.Where(x => x.Active == true).ToList();

                    SetCachedItems(relationships);
                }

                return Ok(relationships);
            }

            return null;
        }

        [HttpGet, Route("Delete/{id:int}")]
        public IHttpActionResult Delete(int id)
        {
            string result = "";
            if (ModelState.IsValid)
            {
                var record = context.Relationship.Where(x => x.ID == id).FirstOrDefault();
                if (record != null)
                {
                    context.Relationship.Remove(record);
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
