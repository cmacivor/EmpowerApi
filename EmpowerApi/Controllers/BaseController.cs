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
using System.Runtime.Caching;

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
            var items = GetCachedItems();

            if (items == null || items.Count() == 0)
            {
                return baseRepository.All();
            }

            return items;
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

        public List<T> GetCachedItems()
        {
            var cache = MemoryCache.Default;

            var cacheItemName = typeof(T).ToString();

            var cachedItems = cache.GetCacheItem(cacheItemName);

            if (cachedItems == null) return null;

            return (List<T>)cachedItems.Value;

        }

        public void SetCachedItems(List<T> items)
        {
            var cache = MemoryCache.Default;

            var cacheItemName = typeof(T).ToString();

            var policy = new CacheItemPolicy();
            policy.SlidingExpiration.Add(TimeSpan.FromMinutes(15));

            var cacheItem = new CacheItem(cacheItemName, items);

            cache.Set(cacheItem, policy);
        }


    }
}
