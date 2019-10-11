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

namespace DJSCaseMgtService.Controllers
{
    [RoutePrefix("api/ContactType")]
    public class ContactTypeController : BaseController<ContactType>
    {
        private DJSCaseMgtContext context = new DJSCaseMgtContext();
        public ContactTypeController(IBaseRepository<ContactType> baseRepository) : base(baseRepository) { }


        #region "Service methods"
        [System.Web.Http.HttpGet, Route("GetAll")]
        public IHttpActionResult GetAll()
        {
            IEnumerable<ContactType> output = null;
            if (ModelState.IsValid)
            {
                output = context.ContactType.Where(x => x.Active == true && x.SystemID==1).ToList();
            }

            return Ok(output);
        }
        [System.Web.Http.HttpGet, Route("Delete/{id:int}")]
        public IHttpActionResult Delete(int id)
        {
            string result = "";
            if (ModelState.IsValid)
            {
                var record = context.ContactType.Where(x => x.ID == id).FirstOrDefault();
                if (record != null)
                {
                    context.ContactType.Remove(record);
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