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
    public class EnrollmentRepository : BaseRepository<Enrollment>, IEnrollmentRepository
    {
        private DJSCaseMgtContext context;
        
        public EnrollmentRepository(DJSCaseMgtContext context) : base(context) 
        {
            this.context = context;
        }

        public IEnumerable<Enrollment> GetEnrollmentsForPlacement(int placementID)
        {
            var enrollments = (from e in context.Enrollment
                               where e.PlacementID == placementID && 
                               e.Active==true
                               select e).AsEnumerable();

            return enrollments;
        }
    
    public string DeleteEnrollment(int id)
        {
            string output = "";
            var req = context.Enrollment.Where(x => x.ID == id).ToList() ;
            if (req.Count == 0)
                return null;
            else
                req.ForEach(x =>
                {
                    context.Enrollment.Remove(x);
                });
            try
            {
                context.SaveChanges();
             output= "Success";
            }
            catch (Exception ex)
            {
                output= "Failed";
            }
            return output;
        }
}

    public interface IEnrollmentRepository
    {
        IEnumerable<Enrollment> GetEnrollmentsForPlacement(int placementID);

        string DeleteEnrollment(int id);
    }
}