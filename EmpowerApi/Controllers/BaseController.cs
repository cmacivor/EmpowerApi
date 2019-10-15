using DJSCaseMgmtModel.Entities;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgtService.oAuth;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;

namespace EmpowerApi.Controllers
{
    public abstract class BaseController<T> : ApiController
        where T : EntityBase, new()
    {
        private IBaseRepository<T> baseRepository;
        public AuthRepository authRepository;

        protected BaseController(IBaseRepository<T> context)
        {
            baseRepository = context;
            authRepository = new AuthRepository();
        }

        [HttpGet]
        public IEnumerable<T> All()
        {
            return baseRepository.All();
        }


        [HttpPost]
        public async Task<object> Create(T entity)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
            }

            if (ModelState.IsValid)
            {
                baseRepository.Create(entity);

                var retVal = await baseRepository.Save();

                return entity;
            }

            return null;
        }
        
        [HttpPut]
        public async Task<object> Update(T entity)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
            }

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
