using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Description;
using DJSCaseMgmtModel.Entities;
using DJSCaseMgtService.Models;
using DJSCaseMgmtModel.ViewModels;
using DJSCaseMgtService.DataAccess.Repositories;

namespace DJSCaseMgtService.Controllers
{
    [RoutePrefix("api/ServiceProgramCategory")]
    public class ServiceProgramCategoryController : BaseController<ServiceProgramCategory>
    {
        public IServiceProgramCategory ServiceProgramCategoryRepository;
        private DJSCaseMgtContext context = new DJSCaseMgtContext();
        public ServiceProgramCategoryController(IBaseRepository<ServiceProgramCategory> baseRepository) : base(baseRepository) { }

        #region "Service methods"

        [System.Web.Http.HttpGet, Route("GetAll")]
        public IHttpActionResult GetAll()
        {
            IEnumerable<ServiceProgramCategory> output = null;
            if (ModelState.IsValid)
            {
                output = context.ServiceProgramCategory.Where(x => x.Active == true && x.SystemID == 1).ToList();
            }

            return Ok(output);
        }

        [System.Web.Http.HttpGet, Route("AllServiceProgramCategory")]
        public IEnumerable<ServiceProgramCategoryView> AllServiceProgramCategory()
        {

            IEnumerable<ServiceProgramCategoryView> retVal = new List<ServiceProgramCategoryView>();

            string ServiceProgramCategorySearch = @"Select sp.ID  as ServiceProgramID ,sp.Name as ServiceName,sc.Name as CategoryName, sc.ID as ServiceCategoryID
               from ServiceProgram sp,ServiceCategory sc,ServiceProgramCategory spc
               where sp.ID = spc.ServiceProgramID 
               and sc.ID = spc.ServiceCategoryID
               and spc.Active = 1 and sc.SystemID = 1 ";

            string SQL = ServiceProgramCategorySearch;
            SQL += " ORDER BY sp.Name";
            retVal = context.Database.SqlQuery<ServiceProgramCategoryView>(SQL).ToList();
            //return retVal;
            IEnumerable<ServiceProgramCategoryView> output = ServiceProgramCategoryRepository.GetAllServiceProgramCategory();



            return output;
        }


        [System.Web.Http.HttpPost, Route("SelectedServiceCategory/{ServiceProgramID}/{ServiceProgramName}")]
        public IHttpActionResult SelectedServiceCategory(int ServiceProgramID, string ServiceProgramName)
        {
  

            IEnumerable<ServiceProgramCategoryView> retVal = new List<ServiceProgramCategoryView>();

            string ServiceProgramCategorySearch = @"Select sc.Name as CategoryName, sc.ID as ServiceCategoryID , spc.Active as Active
               from ServiceProgram sp,ServiceCategory sc,ServiceProgramCategory spc
               where sp.ID = spc.ServiceProgramID 
               and sc.ID = spc.ServiceCategoryID
               and spc.Active = 1 and sc.SystemID = 1 ";
            string SQL = ServiceProgramCategorySearch + " and sp.ID = " + ServiceProgramID + " and sp.Name = " + "'"+ ServiceProgramName + "'";


            retVal = context.Database.SqlQuery<ServiceProgramCategoryView>(SQL).ToList();
            return Ok(retVal);


        }

        [System.Web.Http.HttpPost, Route("MeargeServiceCategory/{ServiceProgramID}/{ServiceCategoryID}")]
        public IHttpActionResult MeargeServiceCategory(int ServiceProgramID, int ServiceCategoryID)
        {
            string result = String.Empty;
           
                if ((from t in context.ServiceProgramCategory
                     where t.ServiceCategoryID == ServiceCategoryID &&
                     t.ServiceProgramID == ServiceProgramID && t.Active == true
                     select t).Count() > 0)
                {
                    result = "e";
                    return Ok(result);

                }
                else
                {
                    try
                    {
                        ServiceProgramCategory spCInsert = new ServiceProgramCategory();
                        spCInsert.ServiceCategoryID = ServiceCategoryID;
                        spCInsert.ServiceProgramID = ServiceProgramID;
                        spCInsert.Active = true;
                        spCInsert.SystemID = 1;
                        spCInsert.CreatedDate = DateTime.Now;
                        spCInsert.CreatedBy = User.Identity.Name;
                        spCInsert.UpdatedDate = DateTime.Now;
                        spCInsert.UpdatedBy = User.Identity.Name;
                        context.ServiceProgramCategory.Add(spCInsert);
                        context.SaveChanges();
                        result = "s";
                        return Ok(result);

                    }
                    catch (Exception e)
                    {
                        string ex = e.Message;
                        result = "f";
                        return Ok(result);
                    }

                }


            
            }

        //For edit

        [System.Web.Http.HttpPost, Route("EditServiceProgramCategory/{ServiceProgramID}/{ServiceCategoryID}/{IsActive}")]
        public IHttpActionResult EditServiceProgramCategory(int ServiceProgramID, int ServiceCategoryID,bool isActive)
        {
            string result = String.Empty;

            if ((from t in context.ServiceProgramCategory
                 where t.ServiceCategoryID == ServiceCategoryID &&
                 t.ServiceProgramID == ServiceProgramID && t.Active == isActive
                 select t).Count() > 0)
            {
                result = "e";
                return Ok(result);

            }
            else
            {
                try
                {
                    //Field which will be update
                    var change = context.ServiceProgramCategory.Single(x => x.ServiceProgramID == ServiceProgramID && x.ServiceCategoryID == ServiceCategoryID);
                    //change.Name = ServiceProgram;
                    change.Active = isActive;
                    context.SaveChanges();
                    result = "s";
                    return Ok(result);

                }
                catch (Exception e)
                {
                    string ex = e.Message;
                    result = "f";
                    return Ok(result);
                }

            }



        }
        [System.Web.Http.HttpGet, Route("Delete/{id:int}")]
        public IHttpActionResult Delete(int id)
        {
            string result = "";
            if (ModelState.IsValid)
            {
                var record = context.ServiceProgramCategory.Where(x => x.ID == id).FirstOrDefault();
                if (record != null)
                {
                    context.ServiceProgramCategory.Remove(record);
                }
                try
                {
                    context.SaveChanges();
                    result = "s";
                    return Ok(result);
                }
                catch (Exception ex)
                {
                    result = "f";
                    return Ok(result);
                }
            }

            return Ok(result);
        }
        #endregion
    }
}


