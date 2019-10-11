using DJSCaseMgmtModel.Entities;
using DJSCaseMgmtModel.ViewModels;
using DJSCaseMgtService.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace DJSCaseMgtService.DataAccess.Repositories
{
    public class FamilyProfileRepository : BaseRepository<FamilyProfile>, IFamilyProfileRepository
    {
        private DJSCaseMgtContext context;

        public FamilyProfileRepository(DJSCaseMgtContext context) : base(context) 
        {
            this.context = context;
        }

        public string DeleteFamilyMember(int id)
        {
            string result="";
            var req = context.FamilyProfile.Where(x => x.FamilyMemberID == id).ToList();

            if (req.Count == 0)
            {
                result = "Member Not Found";
            }
            else {
                req.ForEach(r =>
                {
                    context.FamilyProfile.Remove(r);
                });
                try {
                    context.SaveChanges();
                    result = "Success";
                }
                catch (Exception ex) {
                    result = "Failed";
                }
            
            }

            return result;
        }
    }

    public interface IFamilyProfileRepository : IBaseRepository<FamilyProfile>
    {

        string DeleteFamilyMember(int id);
    }
}