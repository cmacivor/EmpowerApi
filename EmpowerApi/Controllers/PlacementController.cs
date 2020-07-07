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
using System.Runtime.InteropServices;
using Microsoft.Ajax.Utilities;

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
            if (ModelState.IsValid)
            {
                // Create new Placement
                var createdPlacement = placementRepository.Create(placementVM.Placement);
                var retVal = await placementRepository.Save();

                //note: there are not PlacementOffenses in CWB
                //if (placementVM.PlacementOffense != null && placementVM.PlacementOffense.Count() > 0)
                //{
                //    // Create New PlacementOffenses
                //    foreach (var po in placementVM.PlacementOffense)
                //    {
                //        po.PlacementID = createdPlacement.ID; //placementVM.Placement.ID;

                //        placementOffenseRepository.Create(po);
                //        await placementOffenseRepository.Save();
                //    }
                //}

                //var placements = placementRepository.GetPlacementsForClientProfile(placementVM.Placement.ClientProfileID);

                //return placementVM;
                //return placements;

                return createdPlacement;
            }

            return null;
      
        }

        //[System.Web.Http.HttpPut, Route("{id:int}")]
        [System.Web.Http.HttpPut, Route("")]
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

            if (placementVM.PlacementOffense != null && placementVM.PlacementOffense.Count() > 0)
            {
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
            }
      
            return placementVM;
        }

        [System.Web.Http.HttpGet, Route("GetPlacement/{id:int}")]
        public Placement GetPlacement(int id)
        {
            var placement = placementRepository.GetPlacement(id);

            return placement;
        }

        [System.Web.Http.HttpGet, Route("GetPlacementsByClientProfileID/{id:int}")]
        public List<Placement> GetPlacementsByClientProfileID(int id)
        {
            var placements = placementRepository.GetPlacementsForClientProfile(id).ToList();

            return placements;
        }

        

        [System.Web.Http.HttpGet, Route("Deleteplacement/{id:int}")]
        public string Deleteplacement(int id)
        {
            var placements = placementRepository.DeletePlacement(id);
            return placements;
        }
    }
}

