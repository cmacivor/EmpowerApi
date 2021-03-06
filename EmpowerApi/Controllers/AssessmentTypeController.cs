using DJSCaseMgmtModel.Entities;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgtService.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;

namespace EmpowerApi.Controllers
{
    [RoutePrefix("api/AssessmentType")]

    public class AssessmentTypeController : BaseController<AssessmentType>
    {
        private DJSCaseMgtContext context = new DJSCaseMgtContext();
        public AssessmentTypeController(IBaseRepository<AssessmentType> baseRepository) : base(baseRepository) { }


        #region "Service methods"

        [System.Web.Http.HttpGet, Route("GetAll")]
        public IHttpActionResult GetAll()
        {            
            int systemID = base.authRepository.GetSystemIDByLoggedInUserRole();

            if (ModelState.IsValid)
            {
                var assessmentTypes = new List<AssessmentType>();

                assessmentTypes = GetCachedItems();

                if (assessmentTypes == null || assessmentTypes.Count() == 0)
                {
                    assessmentTypes = context.AssessmentType.Where(x => x.Active == true && x.SystemID == systemID).ToList();

                    SetCachedItems(assessmentTypes);
                }

                return Ok(assessmentTypes);

            }

            return null;
        }



        [HttpGet, Route("Delete/{id:int}")]
        public IHttpActionResult Delete(int id)
        {
            string result = "";
            if (ModelState.IsValid)
            {
                var record = context.AssessmentType.Where(x => x.ID == id).FirstOrDefault();
                if (record != null)
                {
                    context.AssessmentType.Remove(record);
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
