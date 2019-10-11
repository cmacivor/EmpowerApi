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
    [RoutePrefix("api/AddressTypeOld")]
    public class AddressTypeOldController : OldBaseController<AddressType>
    {
        public AddressTypeOldController(IBaseRepository baseRepository) : base(baseRepository) { }
    }
}
