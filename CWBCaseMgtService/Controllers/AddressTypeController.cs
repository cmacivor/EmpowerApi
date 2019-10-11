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


namespace DJSCaseMgtService.Controllers
{
    [RoutePrefix("api/AddressType")]
    public class AddressTypeController : BaseController<AddressType> 
    {
        #region Consructor
        private DJSCaseMgtContext context = new DJSCaseMgtContext();
        public AddressTypeController(IBaseRepository<AddressType> baseRepository) : base(baseRepository) { }

        #endregion

        #region "Service methods"

        [System.Web.Http.HttpGet, Route("GetAll")]
        [Authorize]
        public IHttpActionResult GetAll()
        {
            IEnumerable<AddressType> output = null;
            if (ModelState.IsValid)
            {
                 output = context.AddressType.Where(x => x.Active == true).ToList();
            }

            return Ok(output);
        } 



        [System.Web.Http.HttpGet, Route("Delete/{id:int}")]
        [Authorize]
        public IHttpActionResult Delete(int id)
        {
            string result= "";
            if (ModelState.IsValid)
            {
                var record = context.AddressType.Where(x => x.ID == id).FirstOrDefault();
                if (record != null)
                {
                    context.AddressType.Remove(record);
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