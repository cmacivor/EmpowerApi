using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgmtModel.Entities;
using EmpowerApi.Controllers;
using DJSCaseMgtService.Models;

namespace DJSCaseMgtService.Controllers
{
    [RoutePrefix("api/PersonSupplemental")]
    public class PersonSupplementalController : BaseController<PersonSupplemental>
    {
        private DJSCaseMgtContext context = new DJSCaseMgtContext();
        public PersonSupplementalController(IBaseRepository<PersonSupplemental> baseRepository) : base(baseRepository) { }



        [HttpGet, Route("GetByPersonID/{personID}")]
        public PersonSupplemental GetByPersonID(int? personID)
        {
            if (personID == null) return null;

            var personSupplemental = context.PersonSupplemental.FirstOrDefault(x => x.PersonID == personID);

            return personSupplemental;
        }
    }

   
}