using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Threading.Tasks;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgmtModel.Entities;

namespace DJSCaseMgtService.Controllers
{

    public abstract class BaseController<T> : ApiController
        where T : EntityBase, new()
    {
        #region Private Variables

        private IBaseRepository<T> baseRepository;

        #endregion

        protected BaseController(IBaseRepository<T> context)
        {
            this.baseRepository = context;
        }

        [System.Web.Http.HttpGet]
        public IEnumerable<T> All()
        {
            return baseRepository.All();
        }

        [System.Web.Http.HttpPost]
        public async Task<object> Create(T entity)
        {
            if (ModelState.IsValid)
            {
                baseRepository.Create(entity);

                var retVal = await baseRepository.Save();

                return entity ;
            }

            return null;
        }


        [System.Web.Http.HttpPut]
        public async Task<int> Update(T entity)
        {
            if (ModelState.IsValid)
            {
                baseRepository.Update(entity);

                await baseRepository.Save();

                return entity.ID;
            }

            return 0;
        }
    }
}