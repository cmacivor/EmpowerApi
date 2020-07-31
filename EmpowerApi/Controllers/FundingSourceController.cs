using DJSCaseMgmtModel.Entities;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgtService.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;

namespace EmpowerApi.Controllers
{
    [RoutePrefix("api/FundingSource")]
    public class FundingSourceController : BaseController<FundingSource>
    {
        private DJSCaseMgtContext context = new DJSCaseMgtContext();
        public FundingSourceController(IBaseRepository<FundingSource> baseRepository) : base(baseRepository) { }


        [System.Web.Http.HttpGet, Route("GetAll")]
        public IHttpActionResult GetAll()
        {
            if (ModelState.IsValid)
            {
                var fundingSources = new List<FundingSource>();

                fundingSources = GetCachedItems();

                if (fundingSources == null || fundingSources.Count() == 0)
                {
                    fundingSources = context.FundingSource.Where(x => x.Active == true).OrderBy(x => x.Name).ToList();

                    SetCachedItems(fundingSources);
                }

                return Ok(fundingSources);
            }

            return null;

        }

        [System.Web.Http.HttpGet, Route("Delete/{id:int}")]
        public async Task<int> Delete(int id)
        {
            if (ModelState.IsValid)
            {
                var record = context.FundingSource.Where(x => x.ID == id).FirstOrDefault();
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
    }
}
