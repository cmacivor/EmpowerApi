﻿using System;
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


namespace DJSCaseMgtService.Controllers
{
    [RoutePrefix("api/ServiceRelease")]
    public class ServiceReleaseController : BaseController<ServiceRelease>
    {
        private DJSCaseMgtContext context = new DJSCaseMgtContext();
        public ServiceReleaseController(IBaseRepository<ServiceRelease> baseRepository) : base(baseRepository) { }


        #region "Service methods"

        [System.Web.Http.HttpGet, Route("GetAll")]
        public IHttpActionResult GetAll()
        {
            IEnumerable<ServiceRelease> output = null;
            if (ModelState.IsValid)
            {
                output = context.ServiceRelease.Where(x => x.Active == true && x.SystemID == 1).ToList();
            }

            return Ok(output);
        }


        [System.Web.Http.HttpGet, Route("Delete/{id:int}")]
        public IHttpActionResult Delete(int id)
        {
            string result = "";
            if (ModelState.IsValid)
            {
                var record = context.ServiceRelease.Where(x => x.ID == id).FirstOrDefault();
                if (record != null)
                {
                    context.ServiceRelease.Remove(record);
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

