using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgmtModel.Entities;
using EmpowerApi.Controllers;

namespace DJSCaseMgtService.Controllers
{
    [RoutePrefix("api/PersonSupplemental")]
    public class PersonSupplementalController : BaseController<PersonSupplemental>
    {
        public PersonSupplementalController(IBaseRepository<PersonSupplemental> baseRepository) : base(baseRepository) { }
    }
}