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
    public class PlacementRepository : BaseRepository<Placement>, IPlacementRepository
    {
        private DJSCaseMgtContext context;

        public PlacementRepository(DJSCaseMgtContext context)
            : base(context)
        {
            this.context = context;
        }

        public IEnumerable<Placement> GetPlacementsForClientProfile(int clientProfileID)
        {
            var placements = (from p in context.Placement
                              where p.ClientProfileID == clientProfileID &&
                              p.Active==true
                              select p).AsEnumerable();

            return placements;
        }

        public string DeletePlacement(int id)
        {
            string output = "";
            var req = context.Placement.Where(x => x.ID == id).ToList();
            if (req.Count == 0)
                return null;
            else
                req.ForEach(x =>
                {
                    context.Placement.Remove(x);
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
        ////getplacement by id
        //public string Placementforprint(int id)
        //{
          
        //    var req = context.Placement.Where(x => x.ID == id).AsEnumerable();

        //    return req;
        //}
    }

    
    



public interface IPlacementRepository : IBaseRepository<Placement>
    {
        IEnumerable<Placement> GetPlacementsForClientProfile(int clientProfileID);
          string DeletePlacement(int id);
    }
}