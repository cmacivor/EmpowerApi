using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgmtModel.Entities;
using DJSCaseMgtService.Models;
using System.Threading.Tasks;
using EmpowerApi.Controllers;

namespace DJSCaseMgtService.Controllers
{
    [RoutePrefix("api/SubContactType")]
    public class SubContactTypeController : BaseController<SubContactType>
    {
        private DJSCaseMgtContext context = new DJSCaseMgtContext();
        public SubContactTypeController(IBaseRepository<SubContactType> baseRepository) : base(baseRepository) { }


        #region "Service methods"
        [System.Web.Http.HttpGet, Route("GetAll")]
        public IHttpActionResult GetAll()
        {

            IEnumerable<SubContactType> output = null;
            if (ModelState.IsValid)
            {
                var subContactTypes = new List<SubContactType>();

                subContactTypes = GetCachedItems();

                if (subContactTypes == null || subContactTypes.Count() == 0)
                {
                    subContactTypes = context.SubContactType.OrderBy(x => x.Name).Where(x => x.Active == true).ToList();

                    SetCachedItems(subContactTypes);
                }

                return Ok(subContactTypes);
            }

            return null;
        }
        [System.Web.Http.HttpGet, Route("Delete/{id:int}")]
        public IHttpActionResult Delete(int id)
        {
            string result = "";
            if (ModelState.IsValid)
            {
                var record = context.SubContactType.Where(x => x.ID == id).FirstOrDefault();
                if (record != null)
                {
                    context.SubContactType.Remove(record);
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
    #endregion
}
