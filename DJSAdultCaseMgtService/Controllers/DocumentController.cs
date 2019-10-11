using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgmtModel.Entities;
using DJSCaseMgtService.Models;
using System.Threading.Tasks;

namespace DJSCaseMgtService.Controllers
{
    [RoutePrefix("api/Document")]
  
    public class DocumentController : BaseController<Document>
    {
        private DJSCaseMgtContext context = new DJSCaseMgtContext();
        public DocumentController(IBaseRepository<Document> baseRepository) : base(baseRepository) { }
        #region "Service methods"

        [System.Web.Http.HttpGet, Route("GetAll")]
        public IHttpActionResult GetAll()
        {
            IEnumerable<Document> output = null;
            if (ModelState.IsValid)
            {
                output = context.Document.Where(x => x.Active == true && x.SystemID == 2).ToList();
            }

            return Ok(output);
        }



        [System.Web.Http.HttpGet, Route("Delete/{id:int}")]
        public async Task<int> Delete(int id)
        {
            if (ModelState.IsValid)
            {
                var record = context.Document.Where(x => x.ID == id).FirstOrDefault();
                if (record != null)
                {
                    record.Active = false;
                }
                try
                {
                    context.SaveChanges();
                    return 1;
                }
                catch (Exception ex)
                {
                    return 0;
                }
            }

            return 0;
        }
        #endregion
    }
}