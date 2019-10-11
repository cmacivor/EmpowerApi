using DJSCaseMgmtModel.Entities;
using DJSCaseMgtService.Models;
using DJSCaseMgmtModel.ViewModels;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace DJSCaseMgtService.DataAccess.Repositories
{
    public class ServiceProgramCategoryRepository : BaseRepository<ServiceProgramCategory>, IServiceProgramCategory
    {
        private DJSCaseMgtContext context;

        public ServiceProgramCategoryRepository(DJSCaseMgtContext context) : base(context) 
        {
            
        }

        public IEnumerable<ServiceProgramCategoryView> GetAllServiceProgramCategory()
        {
            IEnumerable<ServiceProgramCategoryView> retVal = new List<ServiceProgramCategoryView>();

            string ServiceProgramCategorySearch = @"Select sp.ID as ServiceProgramID ,sp.Name as ServiceProgram,sc.Name as ServiceCategory, sc.ID as ServiceCategoryID
               from ServiceProgram sp,ServiceCategory sc,ServiceProgramCategory spc
               where sp.ID = spc.ServiceProgramID 
               and sc.ID = spc.ServiceCategoryID
               and spc.Active = 1 and sc.SystemID = 1 ";

            string SQL = ServiceProgramCategorySearch;
            SQL += " ORDER BY sp.Name";
            retVal = context.Database.SqlQuery<ServiceProgramCategoryView>(SQL).ToList();
            return retVal;


        }
    }


    

    public interface IServiceProgramCategory
    {
        IEnumerable<ServiceProgramCategoryView> GetAllServiceProgramCategory();

    }
}