using DJSCaseMgmtModel.Entities;
using DJSCaseMgtService.DataAccess.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace EmpowerApi.Controllers
{
    [RoutePrefix("api/Gender")]
    public class GenderController : BaseController<Gender>
    {
        public GenderController(IBaseRepository<Gender> baseRepository) : base(baseRepository) { }
    }
}
