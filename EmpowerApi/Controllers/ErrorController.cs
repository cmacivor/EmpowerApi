using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace EmpowerApi.Controllers
{
    public class ErrorController : ApiController
    {
        [HttpGet, HttpPost, HttpPut, HttpDelete, HttpHead, HttpOptions]
        public IHttpActionResult NotFound(string path)
        {
            // log error to ELMAH TODO: implement Elmah?
            //Elmah.ErrorSignal.FromCurrentContext().Raise(new HttpException(404, "404 Not Found: /" + path));

            // return 404
            return NotFound();
        }
    }
}
