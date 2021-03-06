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
    [RoutePrefix("api/PropertyType")]
    public class PropertyTypeController : BaseController<PropertyType>
    {
        private DJSCaseMgtContext context = new DJSCaseMgtContext();
        public PropertyTypeController(IBaseRepository<PropertyType> baseRepository) : base(baseRepository) { }

        [System.Web.Http.HttpGet, Route("GetAll")]
        public IHttpActionResult GetAll()
        {
            if (ModelState.IsValid)
            {
                var propertyTypes = new List<PropertyType>();

                propertyTypes = GetCachedItems();

                if (propertyTypes == null || propertyTypes.Count() == 0)
                {
                    propertyTypes = context.PropertyType.Where(x => x.Active == true).OrderBy(x => x.Name).ToList();

                    SetCachedItems(propertyTypes);
                }

                return Ok(propertyTypes);
            }

            return null;
        }

        [System.Web.Http.HttpGet, Route("Delete/{id:int}")]
        public async Task<int> Delete(int id)
        {
            if (ModelState.IsValid)
            {
                var record = context.PropertyType.Where(x => x.ID == id).FirstOrDefault();
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
