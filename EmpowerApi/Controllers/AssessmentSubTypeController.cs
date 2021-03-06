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
    [RoutePrefix("api/AssessmentSubtype")]
    public class AssessmentSubTypeController : BaseController<AssessmentSubtype>
    {
        private DJSCaseMgtContext context = new DJSCaseMgtContext();

        public AssessmentSubTypeController(IBaseRepository<AssessmentSubtype> context) : base(context)
        {

        }

        [HttpGet, Route("GetAll")]
        public IHttpActionResult GetAll()
        {
            int systemID = base.authRepository.GetSystemIDByLoggedInUserRole();

            if (ModelState.IsValid)
            {
                var assessmentSubtypes = new List<AssessmentSubtype>();

                assessmentSubtypes = GetCachedItems();

                if (assessmentSubtypes == null || assessmentSubtypes.Count() == 0)
                {
                    assessmentSubtypes = context.AssessmentSubtype.Where(x => x.Active == true && x.SystemID == systemID).ToList();

                    SetCachedItems(assessmentSubtypes);
                }

                return Ok(assessmentSubtypes);
            }

            return null;
        }

        [HttpGet, Route("Delete/{id:int}")]
        public IHttpActionResult Delete(int id)
        {
            string result = "";
            if (ModelState.IsValid)
            {
                var record = context.AssessmentSubtype.Where(x => x.ID == id).FirstOrDefault();
                if (record != null)
                {
                    context.AssessmentSubtype.Remove(record);
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
