using DJSCaseMgmtModel.Entities;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgtService.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace EmpowerApi.Controllers
{
    [RoutePrefix("api/EducationLevel")]
    public class EducationLevelController : BaseController<EducationLevel>
    {
        private DJSCaseMgtContext context = new DJSCaseMgtContext();

        public EducationLevelController(IBaseRepository<EducationLevel> baseRepository) : base(baseRepository) { }

        [System.Web.Http.HttpGet, Route("GetAll")]
        public IHttpActionResult GetAll()
        {
            if (ModelState.IsValid)
            {
                var educationLevels = new List<EducationLevel>();

                educationLevels = GetCachedItems();

                if (educationLevels == null || educationLevels.Count() == 0)
                {
                    educationLevels = context.EducationLevel.Where(x => x.Active == true).OrderBy(x => x.Name).ToList();

                    SetCachedItems(educationLevels);
                }
                return Ok(educationLevels);
            }

            return null;
        }


        [System.Web.Http.HttpGet, Route("Delete/{id:int}")]
        public IHttpActionResult Delete(int id)
        {
            string result = "";
            if (ModelState.IsValid)
            {
                var record = context.EducationLevel.Where(x => x.ID == id).FirstOrDefault();
                if (record != null)
                {
                    context.EducationLevel.Remove(record);
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


    }
}
