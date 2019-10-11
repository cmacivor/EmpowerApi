using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgmtModel.Entities;
using DJSCaseMgtService.Models;

namespace DJSCaseMgtService.Controllers
{
    [RoutePrefix("api/Staff")]
    public class StaffController : BaseController<Staff>
    {
        private DJSCaseMgtContext context = new DJSCaseMgtContext();
        public StaffController(IBaseRepository<Staff> baseRepository) : base(baseRepository) { }
        #region "Service methods"

        [System.Web.Http.HttpGet, Route("GetAll")]
        public IHttpActionResult GetAll()
        {
            IEnumerable<Staff> output = null; 
            if (ModelState.IsValid)
            {
                output = context.Staff.Where(x => x.Active == true && x.SystemID == 3).ToList();
            }

            return Ok(output);
        }
        #endregion
    }
}