using DJSCaseMgmtModel.Entities;
using DJSCaseMgtService.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace DJSCaseMgtService.DataAccess.Repositories
{
    public class ServiceUnitRepository : BaseRepository<ServiceUnit>, IServiceUnitRepository
    {
        private DJSCaseMgtContext context;

        public ServiceUnitRepository(DJSCaseMgtContext context) : base(context) 
        {
            this.context = context;
        }

        public IEnumerable<ServiceUnit> GetServiceUnitsForEnrollment(int enrollmentID)
        {
            var serviceUnits = (from su in context.ServiceUnit
                                where su.EnrollmentID == enrollmentID && su.Active==true
                                select su).AsEnumerable();

            return serviceUnits;
        }
        public string DeleteserviceUnit(int id)
        {
            string output = "";
            var req = context.ServiceUnit.Where(x => x.ID == id).ToList();
            if (req.Count == 0)
                return null;
            else
                req.ForEach(x =>
                {
                    context.ServiceUnit.Remove(x);
                });
            try
            {
                context.SaveChanges();
                output = "Success";
            }
            catch (Exception ex)
            {
                output = "Failed";
            }
            return output;
        }
    }
    

    public interface IServiceUnitRepository
    {
        IEnumerable<ServiceUnit> GetServiceUnitsForEnrollment(int enrollmentID);

        string DeleteserviceUnit(int id);
    }
}