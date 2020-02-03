﻿using DJSCaseMgmtModel.Entities;
using DJSCaseMgmtModel.ViewModels;
using DJSCaseMgtService.DataAccess.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;

namespace EmpowerApi.Controllers
{
    [RoutePrefix("api/ClientProfile")]
    public class ClientProfileController : ApiController
    {
        private IClientProfileRepository _clientProfileRepository;
        private IPlacementRepository _placementRepository;
        private IPersonRepository _personRepository;
        private IAssessmentRepository _assessmentRepository;
        private IPlacementOffenseRepository _placementOffenseRepository;
        private IEnrollmentRepository _enrollmentRepository;
        private IProgressNoteRepository _progressNoteRepository;
        private IServiceUnitRepository _serviceUnitRepository;

        public ClientProfileController(
            IClientProfileRepository clientProfileRepository, 
            IPlacementRepository placementRepository,
            IPersonRepository personRepository,
            IAssessmentRepository assessmentRepository,
            IPlacementOffenseRepository placementOffenseRepository,
            IEnrollmentRepository enrollmentRepository,
            IProgressNoteRepository progressNoteRepository,
            IServiceUnitRepository serviceUnitRepository)
        {
            _clientProfileRepository = clientProfileRepository;
            _placementRepository = placementRepository;
            _personRepository = personRepository;
            _assessmentRepository = assessmentRepository;
            _placementOffenseRepository = placementOffenseRepository;
            _enrollmentRepository = enrollmentRepository;
            _progressNoteRepository = progressNoteRepository;
        }


        [System.Web.Http.HttpPost, Route("Search")]
        public IEnumerable<ClientSearchResults> Search(ClientName name)
        {
            var retVal = _clientProfileRepository.Search(name.LastName, name.FirstName);
            return retVal;
        }


        [System.Web.Http.HttpGet, Route("{id}")]
        public async Task<Object> GetClientProfile(int id)
        {
            try
            {
                // Instantiate a new ClientProfileViewModel 
                ClientProfileViewModel cp = new ClientProfileViewModel();

                // Load ClientProfile for ClientProfileId
                var clientProfile = await _clientProfileRepository.GetClientProfile(id);
                cp.ClientProfile = (ClientProfile)clientProfile;

                // Load Person for ClientProfileId
                var personVM = _personRepository.GetPersonForClientProfile(id);
                cp.Person = personVM;

                // Load Assessment(s) for ClientProfileId
                var assessment = _assessmentRepository.GetAssessmentsForClientProfile(id);
                cp.Assessment = assessment;

                // Load Placement(s) for ClientProfileId            
                cp.Placement = GetPlacementsForClientProfile(id);

                return cp;


            }
            catch (Exception E)
            {
                throw E;
            }

        }


        private IEnumerable<PlacementViewModel> GetPlacementsForClientProfile(int clientProfileID)
        {
            IList<PlacementViewModel> placementVMs = new List<PlacementViewModel>();
            try
            {

                var placements = _placementRepository.GetPlacementsForClientProfile(clientProfileID);
                foreach (var placement in placements)
                {
                    // Load Related Enrollments
                    var enrollment = GetEnrollmentForPlacement(placement.ID);

                    // Load Related Offenses
                    var placementOffenses = _placementOffenseRepository.GetPlacementOffensesForPlacement(placement.ID);

                    // Add it to the collection
                    placementVMs.Add(new PlacementViewModel { Placement = placement, Enrollment = enrollment, PlacementOffense = placementOffenses });
                }

            }
            catch (Exception e)
            {
                throw e;
            }
            return placementVMs;
        }

        private IEnumerable<EnrollmentViewModel> GetEnrollmentForPlacement(int placementID)
        {
            IList<EnrollmentViewModel> enrollmentVM = new List<EnrollmentViewModel>();
            try
            {

                var enrollments = _enrollmentRepository.GetEnrollmentsForPlacement(placementID);

                foreach (var enrollment in enrollments)
                {
                    // Load Progress Notes for Enrollment
                    var progressNotes = _progressNoteRepository.GetProgressNotesForEnrollment(enrollment.ID);

                    // Load Service Units for Enrollment
                    var serviceUnits = _serviceUnitRepository.GetServiceUnitsForEnrollment(enrollment.ID);

                    // Assign to EnrollmentVM
                    enrollmentVM.Add(new EnrollmentViewModel { Enrollment = enrollment, ProgressNote = progressNotes, ServiceUnit = serviceUnits });
                }

            }
            catch (Exception e) { throw e; }


            return enrollmentVM;
        }


        [System.Web.Http.HttpGet, Route("InActiveClients")]
        public IEnumerable<ClientSearchResults> InActiveClients()
        {
            var retVal = _clientProfileRepository.InActiveClients();

            return retVal;
        }
    }
}
