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
               // output = context.PersonAddress.Where(x => x.ID >11000 && x.ID<13001 ).ToList();
                output = context.PersonAddress.ToList();
            }

            return Ok(output);
        }
        #endregion
    }

}

