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
    public class PlacementOffenseRepository : BaseRepository<PlacementOffense>, IPlacementOffenseRepository
    {
        private DJSCaseMgtContext context;
        
        public PlacementOffenseRepository(DJSCaseMgtContext context) : base(context) 
        {
            this.context = context;
        }

        public IEnumerable<PlacementOffense> GetPlacementOffensesForPlacement(int placementID)
        {
            var placementOffenses = (from po in context.PlacementOffense
                                     where po.PlacementID == placementID
                                     select po).AsEnumerable();

            return placementOffenses;
        }
    }
    
    public interface IPlacementOffenseRepository : IBaseRepository<PlacementOffense>
    {
        IEnumerable<PlacementOffense> GetPlacementOffensesForPlacement(int placementID);
    }
}