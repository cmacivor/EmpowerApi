using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgmtModel.Entities;
using DJSCaseMgtService.Models;
using EmpowerApi.Controllers;

namespace DJSCaseMgtService.Controllers
{
    [RoutePrefix("api/Staff")]
    public class StaffController : BaseController<Staff>
    {
        private DJSCaseMgtContext context = new DJSCaseMgtContext();
        public StaffController(IBaseRepository<Staff> baseRepository) : base(baseRepository) { }
        #region "Service methods"

        [System.Web.Http.HttpGet, Route("GetAll")]
        public IHttpActionResult GetAll()
        {
            int systemID = base.authRepository.GetSystemIDByLoggedInUserRole();

            if (ModelState.IsValid)
            {
                var staff = new List<Staff>();

                staff = GetCachedItems();

                if (staff == null || staff.Count() == 0)
                {
                    staff = context.Staff.Where(x => x.Active == true && x.SystemID == systemID).ToList();

                    SetCachedItems(staff);
                }

                return Ok(staff);
            }

            return null;
        }
        #endregion
    }
}
