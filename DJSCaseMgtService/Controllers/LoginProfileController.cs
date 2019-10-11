using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgtService.Utility;
using DJSCaseMgmtModel.Entities;
using DJSCaseMgmtModel.ViewModels;
using System.Web;
using System.Threading.Tasks;

namespace DJSCaseMgtService.Controllers
{
    [RoutePrefix("api/LoginProfile")]
    public class LoginProfileController : BaseController<LoginProfile>
    {
        public LoginProfileController(IBaseRepository<LoginProfile> baseRepository) : base(baseRepository) { }
    }
}
