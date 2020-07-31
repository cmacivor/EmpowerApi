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
    [RoutePrefix("api/JobStatus")]
    public class JobStatusController : BaseController<JobStatus>
    {
        private DJSCaseMgtContext context = new DJSCaseMgtContext();

        public JobStatusController(IBaseRepository<JobStatus> context) : base(context)
        {
        }

        [HttpGet, Route("GetAll")]
        public IHttpActionResult GetAll()
        {
            if (ModelState.IsValid)
            {
                var jobStatuses = new List<JobStatus>();

                jobStatuses = GetCachedItems();

                if (jobStatuses == null || jobStatuses.Count() == 0)
                {
                    jobStatuses = context.JobStatus.Where(x => x.Active == true).OrderBy(x => x.Name).ToList();

                    SetCachedItems(jobStatuses);
                }

                return Ok(jobStatuses);
            }

            return null;
        }

        [HttpGet, Route("Delete/{id:int}")]
        public IHttpActionResult Delete(int id)
        {
            string result = "";
            if (ModelState.IsValid)
            {
                var record = context.JobStatus.Where(x => x.ID == id).FirstOrDefault();
                if (record != null)
                {
                    context.JobStatus.Remove(record);
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
