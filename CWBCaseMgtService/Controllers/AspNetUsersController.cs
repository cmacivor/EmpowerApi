using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgmtModel.Entities;
using System.Threading.Tasks;
using DJSCaseMgtService.Models;



namespace DJSCaseMgtService.Controllers
{



    [RoutePrefix("api/Aspnetusers")]


    public class AspNetUsersController : ApiController
    {
        private DJSCaseMgtContext context = new DJSCaseMgtContext();
        public async Task<object> GetAll()
        {
            return context.AspNetUsers.ToList();
            //.Where(x=> x.ID>140894)
        }
    }
}