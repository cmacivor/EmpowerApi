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
using DJSCaseMgmtModel.ViewModels;
using DJSCaseMgtService.DataAccess.Repositories;

namespace DJSCaseMgtService.Controllers
{
    [RoutePrefix("api/ServiceProgram")]
    public class ServiceProgramController : BaseController<ServiceProgram>
    {
        private DJSCaseMgtContext context = new DJSCaseMgtContext();
        public ServiceProgramController(IBaseRepository<ServiceProgram> baseRepository) : base(baseRepository) { }


        #region "Service methods"

        [System.Web.Http.HttpGet, Route("GetAll")]
        public IHttpActionResult GetAll()
        {
            IEnumerable<ServiceProgram> output = null;
            if (ModelState.IsValid)
            {
                output = context.ServiceProgram.Where(x => x.Active == true).ToList();
            }

            return Ok(output);
        }


        [System.Web.Http.HttpGet, Route("GetAllServiceProgram")]
        public IEnumerable<ServiceProgramView> GetAllServiceProgram()
        {

            IEnumerable<ServiceProgramView> retVal = new List<ServiceProgramView>();

            string ServiceProgramSearch = @"Select sp.ID  as ServiceProgramID ,sp.Name as ServiceName
               from ServiceProgram sp
               where sp.active= 1 and sp.SystemID = 1";

            string SQL = ServiceProgramSearch;
            SQL += " ORDER BY sp.Name";
            retVal = context.Database.SqlQuery<ServiceProgramView>(SQL).ToList();
            return retVal;
            
        }


        [System.Web.Http.HttpPost, Route("ServiceProgramInsert/{ServiceProgramName}/{Active}")]
        public IHttpActionResult ServiceProgramInsert(string ServiceProgramName, bool Active)
        {
            string[] result = new string[2];

          
                try
                {
                    ServiceProgram objServiceProg = new ServiceProgram();
                    objServiceProg.Name = ServiceProgramName;
                    objServiceProg.Active = Active;
                    objServiceProg.CreatedDate = DateTime.Now;
                    objServiceProg.SystemID = 1;
                    objServiceProg.CreatedBy = User.Identity.Name;
                    objServiceProg.UpdatedDate = DateTime.Now;
                    objServiceProg.UpdatedBy = User.Identity.Name;
                    context.ServiceProgram.Add(objServiceProg);
                    context.SaveChanges();
                //After save pull the id and pass the message with the Id as response.
                var retval = context.ServiceProgram.FirstOrDefault(x => x.Name == ServiceProgramName && x.Active == true);
                result[0] = Convert.ToString(retval.ID);
                result[1] = "s";
                return Ok(result);

                }
                catch (Exception e)
                {
                string ex = e.Message;
                result[0] = null;
                result[1] = "f";
                return Ok(result);
                }

            }


        [System.Web.Http.HttpPost, Route("ServiceProgramEdit/{ServiceProgramID}/{ServiceProgram}/{ServiceActive}")]
        public IHttpActionResult ServiceProgramEdit(int ServiceProgramID, string ServiceProgram,bool ServiceActive)
        {
            string result = String.Empty;
            if (ModelState.IsValid)
            {
                var original = (from t in context.ServiceProgram
                                where t.ID == ServiceProgramID &&
                                t.Name == ServiceProgram && t.Active == ServiceActive
                                select t).FirstOrDefault();


                if (original != null)
                {
                    result = "e";
                }
                
                else
                {
                    try
                    {
                        //Field which will be update
                        var change = context.ServiceProgram.Single(x => x.ID == ServiceProgramID);
                        change.Name = ServiceProgram;
                        change.Active = ServiceActive;
                        context.SaveChanges();
                        result = "s";
                    }
                    catch (Exception e)
                    {
                        string ex = e.Message;
                        result = "f";

                    }
                }
            }
             return Ok(result);


        }


        [System.Web.Http.HttpGet, Route("Delete/{id:int}")]
        public IHttpActionResult Delete(int id)
        {
            string result = "";
            if (ModelState.IsValid)
            {
                var record = context.ServiceProgram.Where(x => x.ID == id).FirstOrDefault();
                if (record != null)
                {
                    context.ServiceProgram.Remove(record);
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


