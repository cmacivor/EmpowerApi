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
    [RoutePrefix("api/JobTitle")]
    public class JobTitleController : BaseController<JobTitle>
    {
        public JobTitleController(IBaseRepository<JobTitle> baseRepository) : base(baseRepository) { }
    }
}
