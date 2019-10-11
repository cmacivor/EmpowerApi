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

namespace DJSCaseMgtService.Controllers
{
[RoutePrefix("api/LoginServices")]
    public class LoginServicesController : ApiController
    {

        private LoginServices context;

        public LoginServicesController(LoginServices context)
        {
            this.context = context;
        }

        //[HttpGet, Route("LoginProfile")]
        //public IEnumerable<LoginProfile> GetLoginProfiles()
        //{
        //    return this.context.GetLoginProfiles();
        //}

        //[HttpGet, Route("Login")]
        //public IEnumerable<Login> GetLogins()
        //{
        //    return this.context.GetLogins();
        //}
    }
}
