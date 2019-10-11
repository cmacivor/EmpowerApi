using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgmtModel.Entities;

namespace DJSCaseMgtService.Controllers
{
    [RoutePrefix("api/MaritalStatus")]
    public class MaritalStatusController : BaseController<MaritalStatus>
    {
        public MaritalStatusController(IBaseRepository<MaritalStatus> baseRepository) : base(baseRepository) { }
    }
}
