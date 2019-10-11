using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using Dapper;
using DJSCaseMgtModel.Entities;
using DJSCaseMgtService.Utility;
using System.Threading.Tasks;
using System.Configuration;

namespace DJSCaseMgtService.DataAccess.Repositories
{
    public class BaseOldRepository : IBaseOldRepository
    {
        public BaseOldRepository()
        {
        }

        public virtual IEnumerable<T> GetList<T>() where T : EntityBase
        {
            using (IDbConnection connection = new SqlConnection(Constant.DatabaseConnection))
            {
                return connection.GetList<T>("ORDER BY 1, 2");
            }
        }

        public virtual async Task<IEnumerable<T>> GetListAsync<T>() where T : EntityBase
        {
            using (IDbConnection connection = new SqlConnection(Constant.DatabaseConnection))
            {
                return await connection.GetListAsync<T>("ORDER BY 1, 2");
            }
        }

        public virtual T GetById<T>(int id) where T : EntityBase
        {
            using (IDbConnection connection = new SqlConnection(Constant.DatabaseConnection))
            {
                return connection.Get<T>(id);
            }
        }

        public virtual async Task<T> GetByIdAsync<T>(int id) where T : EntityBase
        {
            using (IDbConnection connection = new SqlConnection(Constant.DatabaseConnection))
            {
                return await connection.GetAsync<T>(id);
            }
        }

        public virtual int? Create<T>(T obj) where T : EntityBase
        {
            using (IDbConnection connection = new SqlConnection(Constant.DatabaseConnection))
            {
                obj.CreatedDate = DateTime.Now;
                obj.UpdatedDate = DateTime.Now;
                return connection.Insert(obj);
            }
        }

        public virtual async Task<int?> CreateAsync<T>(T obj) where T : EntityBase
        {
            using (IDbConnection connection = new SqlConnection(Constant.DatabaseConnection))
            {
                obj.CreatedDate = DateTime.Now;
                obj.UpdatedDate = DateTime.Now;
                return await connection.InsertAsync(obj);
            }
        }

        public virtual int Update<T>(int id, T obj) where T : EntityBase
        {
            using (IDbConnection connection = new SqlConnection(Constant.DatabaseConnection))
            {
                obj.ID = id;
                obj.UpdatedDate = DateTime.Now;
                return connection.Update(obj);
            }
        }

        public virtual async Task<int> UpdateAsync<T>(int id, T obj) where T : EntityBase
        {
            using (IDbConnection connection = new SqlConnection(Constant.DatabaseConnection))
            {
                obj.ID = id;
                obj.UpdatedDate = DateTime.Now;
                return await connection.UpdateAsync(obj);
            }
        }

        public virtual int Delete<T>(int id) where T : EntityBase
        {
            using (IDbConnection connection = new SqlConnection(Constant.DatabaseConnection))
            {
                try
                {
                    return connection.Delete<T>(id);
                }
                catch(Exception ex)
                {
                    return 0;
                }
                
            }
        }

        public virtual async Task<int> DeleteAsync<T>(int id) where T : EntityBase
        {
            using (IDbConnection connection = new SqlConnection(Constant.DatabaseConnection))
            {
                try
                {
                    return await connection.DeleteAsync<T>(id);
                }
                catch (Exception ex) {
                    return 0;
                }
                
            }
        }

        public virtual IEnumerable<T> GetListFilterObject<T>(object conditions) where T : EntityBase
        {
            using (IDbConnection connection = new SqlConnection(Constant.DatabaseConnection))
            {
                return connection.GetList<T>(conditions);
            }
        }

        public virtual async Task<IEnumerable<T>> GetListFilterObjectAsync<T>(object conditions) where T : EntityBase
        {
            using (IDbConnection connection = new SqlConnection(Constant.DatabaseConnection))
            {
                return await connection.GetListAsync<T>(conditions);
            }
        }

        public virtual IEnumerable<T> GetListFilterString<T>(string conditions) where T : EntityBase
        {
            using (IDbConnection connection = new SqlConnection(Constant.DatabaseConnection))
            {
                return connection.GetList<T>(conditions);
            }
        }

        public virtual async Task<IEnumerable<T>> GetListFilterStringAsync<T>(string conditions) where T : EntityBase
        {
            using (IDbConnection connection = new SqlConnection(Constant.DatabaseConnection))
            {
                return await connection.GetListAsync<T>(conditions);
            }
        }
    }
}