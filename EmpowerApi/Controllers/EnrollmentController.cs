using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgmtModel.Entities;
using DJSCaseMgmtModel.ViewModels;
using System.Threading.Tasks;
using System.Data.Entity;
using DJSCaseMgtService.Models;
using EmpowerApi.Controllers;

namespace DJSCaseMgtService.Controllers
{
    [RoutePrefix("api/Enrollment")]
    public class EnrollmentController : BaseController<Enrollment>
    {
        private IEnrollmentRepository enrollmentRepository;
        private DJSCaseMgtContext context = new DJSCaseMgtContext();
        public EnrollmentController(IBaseRepository<Enrollment> baseRepository, IEnrollmentRepository enrollmentRepository)
            : base(baseRepository)
        {
            this.enrollmentRepository = enrollmentRepository;
        }
        [System.Web.Http.HttpGet, Route("DeleteEnrollment/{id:int}")]
        public string DeleteEnrollment(int id)
        {
            var enrollments = enrollmentRepository.DeleteEnrollment(id);

            return enrollments;
        }


        [System.Web.Http.HttpPut, Route("UpdateEnrollment/{id:int}")]
        public int UpdateEnrollment(Enrollment enrollment)
        {
            var original = context.Enrollment.Find(enrollment.ID);
            try
            {
                if (original != null)
                {
                    context.Entry(original).CurrentValues.SetValues(enrollment);
                    context.SaveChanges();
                }
            }
            catch (Exception e)
            {
                throw e;
            }

            return enrollment.ID;
        }

        [System.Web.Http.HttpGet, Route("GetEnrollment/{id:int}")]
        public Enrollment GetEnrollment(int id)
        {
            var enrollment = context.Enrollment.FirstOrDefault(x => x.ID == id);

            return enrollment;
        }
    }
}
