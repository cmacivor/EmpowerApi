using DJSCaseMgmtModel.Entities;
using DJSCaseMgtService.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using System.Web;

namespace DJSCaseMgtService.DataAccess.Repositories
{
    public interface IBaseRepository<T> where T : EntityBase
    {
        IEnumerable<T> All();
        IEnumerable<T> FindBy(Expression<Func<T, bool>> predicate);
        
        T Create(T entity);
        void Update(T entity);
        T Delete(T entity);
        
        Task<int?> Save();
    }

    public abstract class BaseRepository<T> : IBaseRepository<T>
      where T : EntityBase
    {
        private DJSCaseMgtContext context;
        protected readonly IDbSet<T> _dbset;

        public BaseRepository(DJSCaseMgtContext context)
        {
            this.context = context;
            this._dbset = context.Set<T>();
        }

        public virtual IEnumerable<T> All()
        {
            return _dbset.AsEnumerable<T>();
        }

        public IEnumerable<T> FindBy(System.Linq.Expressions.Expression<Func<T, bool>> predicate)
        {
            IEnumerable<T> query = _dbset.Where(predicate).AsEnumerable();
            return query;
        }

        public virtual T Create(T entity)
        {
            try
            {
                return context.Set<T>().Add(entity);
            }
            catch (Exception ex)
            {  }
            return entity;
        }

        public virtual void Update(T entity)
        {
            context.Entry(entity).State = System.Data.Entity.EntityState.Modified;            
        }

        public virtual T Delete(T entity)
        {
            return context.Set<T>().Remove(entity);
        }
       
        public async Task<int?> Save()
        {
            return await context.SaveChangesAsync(); 
        }

        //public void Dispose()
        //{
        //    context.Dispose();
        //}
    }
}