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
    [RoutePrefix("api/AssistanceType")]
    public class AssistanceTypeController : BaseController<AssistanceType>
    {
        private DJSCaseMgtContext context = new DJSCaseMgtContext();

        public AssistanceTypeController(IBaseRepository<AssistanceType> context) : base(context)
        {
        }

        [HttpGet, Route("GetAll")]
        public IHttpActionResult GetAll()
        {
            if (ModelState.IsValid)
            {
                var assistanceTypes = new List<AssistanceType>();

                assistanceTypes = GetCachedItems();

                if (assistanceTypes == null || assistanceTypes.Count() == 0)
                {
                    assistanceTypes = context.AssistanceType.Where(x => x.Active == true).OrderBy(x => x.Name).ToList();

                    SetCachedItems(assistanceTypes);
                }

                return Ok(assistanceTypes);
            }

            return null;
        }


        [HttpGet, Route("Delete/{id:int}")]
        public IHttpActionResult Delete(int id)
        {
            string result = "";
            if (ModelState.IsValid)
            {
                var record = context.AssistanceType.Where(x => x.ID == id).FirstOrDefault();
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
