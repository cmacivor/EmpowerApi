using DJSCaseMgmtModel.Entities;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgtService.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Runtime.InteropServices;
using System.Web.Http;

namespace EmpowerApi.Controllers
{
    [RoutePrefix("api/PersonAddress")]
    public class PersonAddressController : BaseController<PersonAddress>
    {
        private DJSCaseMgtContext context = new DJSCaseMgtContext();
        public PersonAddressController(IBaseRepository<PersonAddress> baseRepository) : base(baseRepository) { }

        #region "Service methods"

        [System.Web.Http.HttpGet, Route("GetAll")]
        public IHttpActionResult GetAll()
        {
            IEnumerable<PersonAddress> output = null;
            if (ModelState.IsValid)
            {

                output = context.PersonAddress.ToList();
            }

            return Ok(output);
        }


        [HttpGet, Route("GetByPersonID/{id:int}")]
        //[HttpGet, Route("")]
        public IHttpActionResult GetByPersonID(int id)
        {
            var personAddress = context.PersonAddress.FirstOrDefault(x => x.PersonID == id);

            if (personAddress ==null)
            {
                return NotFound();
            }

            return Ok(personAddress);
        }

        #endregion
    }
}
