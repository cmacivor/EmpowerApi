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
  
    [RoutePrefix("api/Gender")]
    public class GenderController : BaseController<Gender>
    {
        public GenderController(IBaseRepository<Gender> baseRepository) : base(baseRepository) { }
    }
}
