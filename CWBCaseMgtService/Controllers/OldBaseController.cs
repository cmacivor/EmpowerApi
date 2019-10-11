using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Threading.Tasks;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgtService.DataAccess.Services;
using DJSCaseMgtModel.Entities;

namespace DJSCaseMgtService.Controllers
{
    public abstract class OldBaseController<T> : ApiController
        where T : EntityBase, new()
    {
        private IBaseOldRepository context;

        protected OldBaseController (IBaseOldRepository context)
        {
            this.context = context;
        }

        [Route("")]
        public async Task<IEnumerable<T>> Get()
        {
            return await this.context.GetListAsync<T>();
        }

        [HttpGet, Route("{id:int}")]
        public Task<T> Get(int id)
        {
            return this.context.GetByIdAsync<T>(id);
        }

        [HttpPost, Route("")]
        public Task<int?> Create([FromBody] T obj)
        {
            return this.context.CreateAsync<T>(obj);
        }

        [HttpPut, Route("{id:int}")]
        //public bool Update(int id, T obj)
        public Task<int> Update(int id, [FromBody] T obj)
        {
            return this.context.UpdateAsync<T>(id, obj);
            //return Ok();
        }

        [HttpPost, Route("{id:int}")]
        public async Task<int> Delete(int id)
        {
            var retVal = this.context.DeleteAsync<T>(id);

            return await retVal;
            //return this.context.DeleteAsync<T>(id);            
        }
    }
}
