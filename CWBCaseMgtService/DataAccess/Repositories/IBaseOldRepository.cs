using DJSCaseMgtModel.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DJSCaseMgtService.DataAccess.Repositories
{
    public interface IBaseOldRepository
    {
        IEnumerable<T> GetList<T>() where T : EntityBase;
        Task<IEnumerable<T>> GetListAsync<T>() where T : EntityBase;
        T GetById<T>(int id) where T : EntityBase;
        Task<T> GetByIdAsync<T>(int id) where T : EntityBase;
        int? Create<T>(T obj) where T : EntityBase;
        Task<int?> CreateAsync<T>(T obj) where T : EntityBase;
        int Update<T>(int id, T obj) where T : EntityBase;
        Task<int> UpdateAsync<T>(int id, T obj) where T : EntityBase;
        int Delete<T>(int id) where T : EntityBase;
        Task<int> DeleteAsync<T>(int id) where T : EntityBase;
        IEnumerable<T> GetListFilterObject<T>(object conditions) where T : EntityBase;
        Task<IEnumerable<T>> GetListFilterObjectAsync<T>(object conditions) where T : EntityBase;
        IEnumerable<T> GetListFilterString<T>(string conditions) where T : EntityBase;
        Task<IEnumerable<T>> GetListFilterStringAsync<T>(string conditions) where T : EntityBase;
    }
}