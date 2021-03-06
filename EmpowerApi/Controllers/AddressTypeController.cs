using DJSCaseMgmtModel.Entities;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgtService.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using System.Web.Http.Cors;

namespace EmpowerApi.Controllers
{
    [RoutePrefix("api/AddressType")]
    //TODO: remove this? may not be necessary
    [EnableCors(origins: "https://justiceservicesdev.richva.ci.richmond.va.us", headers: "*", methods: "*")]
    public class AddressTypeController : BaseController<AddressType>
    {
        private DJSCaseMgtContext context = new DJSCaseMgtContext();

        public AddressTypeController(IBaseRepository<AddressType> baseRepository) : base(baseRepository)
        {

        }

        [HttpGet, Route("GetAll")]

        public IHttpActionResult GetAll()
        {
            IEnumerable<AddressType> output = null;
            if (ModelState.IsValid)
            {
                output = context.AddressType.Where(x => x.Active == true).ToList();
            }

            return Ok(output);
        }



        [HttpGet, Route("Delete/{id:int}")]
        public IHttpActionResult Delete(int id)
        {
            string result = "";
            if (ModelState.IsValid)
            {
                var record = context.AddressType.Where(x => x.ID == id).FirstOrDefault();
                if (record != null)
                {
                    context.AddressType.Remove(record);
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
