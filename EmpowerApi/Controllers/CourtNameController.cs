using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Description;
using DJSCaseMgmtModel.Entities;
using DJSCaseMgtService.Models;
using DJSCaseMgtService.DataAccess.Repositories;
using EmpowerApi.Controllers;

namespace DJSCaseMgtService.Controllers
{
    [RoutePrefix("api/CourtName")]

    public class CourtNameController : BaseController<CourtName>
    {


        private DJSCaseMgtContext context = new DJSCaseMgtContext();
        public CourtNameController(IBaseRepository<CourtName> baseRepository) : base(baseRepository) { }

        #region "Service methods"

        [System.Web.Http.HttpGet, Route("GetAll")]
        public IHttpActionResult GetAll()
        {
            int systemID = base.authRepository.GetSystemIDByLoggedInUserRole();
            
            if (ModelState.IsValid)
            {
                var courtNames = new List<CourtName>();

                courtNames = GetCachedItems();

                if (courtNames == null || courtNames.Count() == 0)
                {
                    courtNames = context.CourtName.Where(x => x.Active == true && x.SystemID == systemID).OrderBy(x => x.Name).ToList();

                    SetCachedItems(courtNames);
                }
                return Ok(courtNames);

            }

            return null;
        }



        [System.Web.Http.HttpGet, Route("Delete/{id:int}")]
        public IHttpActionResult Delete(int id)
        {
            string result = "";
            if (ModelState.IsValid)
            {
                var record = context.CourtName.Where(x => x.ID == id).FirstOrDefault();
                if (record != null)
                {
                    context.CourtName.Remove(record);
                }
                try
                {
                    context.SaveChanges();
                    result = "s";
                    return Ok(result);
                }
                catch (Exception ex)
                {
                    result = "f";
                    return Ok(result);
                }
            }

            return Ok(result);
        }
        #endregion
    }
}
