using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgtService.DataAccess.Services;
using DJSCaseMgtService.Utility;
using DJSCaseMgtModel.Entities;
using DJSCaseMgtModel.ViewModels;
using System.Web;
using System.Threading.Tasks;

namespace DJSCaseMgtService.Controllers
{
    [RoutePrefix("api/Schema")]
    public class SchemaController : ApiController
    {
        private SchemaGenerator context;

        public SchemaController(SchemaGenerator context)
        {
          this.context = context;
        }

        [HttpGet, Route("")]
        public Object Generate()
        {
            return this.context.Generate();
        }

    }
}
