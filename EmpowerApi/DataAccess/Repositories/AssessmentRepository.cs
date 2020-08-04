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
    public class AssessmentRepository : BaseRepository<Assessment>, IAssessmentRepository
    {
        private DJSCaseMgtContext context;

        public AssessmentRepository(DJSCaseMgtContext context) : base(context) 
        {
            this.context = context;
        }

        public IEnumerable<Assessment> GetAssessmentsForClientProfile(int clientProfileID)
        {
            try {
                var assessments = (from assessment in context.Assessment
                                   where assessment.ClientProfileID == clientProfileID &&
                                   assessment.Active == true
                                   select assessment).AsEnumerable();

                return assessments;
            } catch (Exception Ex) {
                return null;
            }
            
        }


        public string DeleteAssessment(int id)
        {
            string output = "";
            var req = context.Assessment.Where(x => x.ID == id).ToList() ;
            if (req.Count == 0)
                return null;
            else
                req.ForEach(x =>
                {
                    context.Assessment.Remove(x);
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

        public Assessment GetAssessment(int id)
        {
            var assessment = context.Assessment.FirstOrDefault(x => x.ID == id);

            return assessment;
        }
    }

    public interface IAssessmentRepository
    {
        IEnumerable<Assessment> GetAssessmentsForClientProfile(int clientProfileID);

       string DeleteAssessment(int id);

        Assessment GetAssessment(int id);
       
    }
}