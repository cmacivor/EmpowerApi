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

namespace DJSCaseMgtService.Controllers
{
    [RoutePrefix("api/Placement")]
    public class PlacementController : ApiController
    {
        #region Private Variables

        private IPlacementRepository placementRepository;
        private IPlacementOffenseRepository placementOffenseRepository;

        #endregion

        #region Constructor

        public PlacementController(IPlacementRepository placementRepository,
                                   IPlacementOffenseRepository placementOffenseRepository)
        {
            this.placementRepository = placementRepository;
            this.placementOffenseRepository = placementOffenseRepository;
        }

        #endregion

        [System.Web.Http.HttpPost, Route("")]
        public async Task<object> Create(PlacementViewModel placementVM)
        {
            // Create new Placement
            placementRepository.Create(placementVM.Placement);
            var retVal = await placementRepository.Save();
            //Commented because we dont need Offence in CWB.
            //if(placementVM.Placement.ID != 0)
            //{
            //    // Create New PlacementOffenses
            //    foreach(var po in placementVM.PlacementOffense)
            //    {
            //        po.PlacementID = placementVM.Placement.ID;

            //        placementOffenseRepository.Create(po);
            //        await placementOffenseRepository.Save();
            //    }
            //}

            return placementVM;
        }

        [System.Web.Http.HttpPut, Route("{id:int}")]
        public async Task<object> Update(PlacementViewModel placementVM)
        {
            // Update Placement
            placementRepository.Update(placementVM.Placement);
            var retVal = await placementRepository.Save();

            // Get all existing PlacementOffenses for Placement
            var existingPlacementOffenses = placementOffenseRepository.GetPlacementOffensesForPlacement(placementVM.Placement.ID);

            // Find the Deleted offenses                        
            var deletedOffenses = existingPlacementOffenses.Where
                                  (ep => placementVM.PlacementOffense.All(cp => cp.ID != ep.ID));

            // Delete removed offenses
            foreach (var delO in deletedOffenses)
            {
                placementOffenseRepository.Delete(delO);
            }
            await placementOffenseRepository.Save();

            // Add newly added PlacementOffenses
            foreach (var po in placementVM.PlacementOffense)
            {
                if (po.ID == 0)
                {
                    po.PlacementID = placementVM.Placement.ID;

                    placementOffenseRepository.Create(po);
                    await placementOffenseRepository.Save();
                }
            }

            return placementVM;
        }

        [System.Web.Http.HttpGet, Route("Deleteplacement/{id:int}")]
        public string Deleteplacement(int id)
        {
            var placements = placementRepository.DeletePlacement(id);
            return placements;
        }
    }
}

