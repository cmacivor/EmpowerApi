using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgtModel.Entities;


namespace DJSCaseMgtService.Controllers
{
    [RoutePrefix("api/OfficeLocation")]
    public class OfficeLocationController : BaseController<OfficeLocation>
    {
        public OfficeLocationController(IBaseRepository baseRepository) : base(baseRepository) { }
    }
}
