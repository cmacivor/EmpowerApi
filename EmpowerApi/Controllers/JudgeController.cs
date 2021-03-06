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
    [RoutePrefix("api/Judge")]

    public class JudgeController : BaseController<Judge>
    {


        private DJSCaseMgtContext context = new DJSCaseMgtContext();
        public JudgeController(IBaseRepository<Judge> baseRepository) : base(baseRepository) { }

        #region "Service methods"

        [System.Web.Http.HttpGet, Route("GetAll")]
        public IHttpActionResult GetAll()
        {
            int systemID = base.authRepository.GetSystemIDByLoggedInUserRole();

            if (ModelState.IsValid)
            {
                var judges = new List<Judge>();

                judges = GetCachedItems();

                if (judges == null || judges.Count() == 0)
                {
                    judges = context.Judge.Where(x => x.Active == true && x.SystemID == systemID).OrderBy(x => x.Name).ToList();

                    SetCachedItems(judges);
                }

                return Ok(judges);
            }

            return null;
        }



        [System.Web.Http.HttpGet, Route("Delete/{id:int}")]
        public IHttpActionResult Delete(int id)
        {
            string result = "";
            if (ModelState.IsValid)
            {
                var record = context.Judge.Where(x => x.ID == id).FirstOrDefault();
                if (record != null)
                {
                    context.Judge.Remove(record);
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

