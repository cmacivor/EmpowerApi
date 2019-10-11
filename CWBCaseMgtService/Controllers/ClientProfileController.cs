﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgtService.Utility;
using DJSCaseMgmtModel.Entities;
using DJSCaseMgmtModel.ViewModels;
using System.Web;
using System.Threading.Tasks;

namespace DJSCaseMgtService.Controllers
{
    [RoutePrefix("api/ClientProfile")]
    public class ClientProfileController : ApiController
    {
        #region Private Variables

        private IClientProfileRepository clientProfileRepository;
        private IBaseRepository<ClientProfile> clientProfileBaseRepository;
        private IPersonRepository personRepository;
        private IAssessmentRepository assessmentRepository;
        private IPlacementRepository placementRepository;
        private IPlacementOffenseRepository placementOffenseRepository;
        private IEnrollmentRepository enrollmentRepository;
        private IProgressNoteRepository progressNoteRepository;
        private IServiceUnitRepository serviceUnitRepository;
        private IEmploymentPlanRepository employmentPlanRepository;
        private IActionPlanRepository actionPlanRepository;

        #endregion

        #region Constructor

        public ClientProfileController(IClientProfileRepository clientProfileRepository,
                                       IBaseRepository<ClientProfile> clientProfileBaseRepository,
                                       IPersonRepository personRepository,
                                       IAssessmentRepository assessmentRepository,
                                       IPlacementRepository placementRepository,
                                       IPlacementOffenseRepository placementOffenseRepository,
                                       IEnrollmentRepository enrollmentRepository,
                                       IProgressNoteRepository progressNoteRepository,
                                       IServiceUnitRepository serviceUnitRepository,
                                       IEmploymentPlanRepository employmentPlanRepository,
                                       IActionPlanRepository actionPlanRepository)            
        {
            this.clientProfileRepository = clientProfileRepository;
            this.clientProfileBaseRepository = clientProfileBaseRepository;
            this.personRepository = personRepository;
            this.assessmentRepository = assessmentRepository;
            this.placementRepository = placementRepository;
            this.placementOffenseRepository = placementOffenseRepository;
            this.enrollmentRepository = enrollmentRepository;
            this.progressNoteRepository = progressNoteRepository;
            this.serviceUnitRepository = serviceUnitRepository;
            this.employmentPlanRepository = employmentPlanRepository;
            this.actionPlanRepository = actionPlanRepository;
        }

        #endregion
      
        [System.Web.Http.HttpPost, Route("Search")]
        public IEnumerable<ClientSearchResults> Search(ClientName name)
        {
            var retVal = clientProfileRepository.Search(name.LastName, name.FirstName);
            return retVal;            
        }

        // for the 21 plus clients

        [System.Web.Http.HttpGet, Route("SearchPlus")]
        public IEnumerable<ClientSearchResults> Search21plus()
        {
            var retVal = clientProfileRepository.Search21plus();

            return retVal;
        }

        [System.Web.Http.HttpGet, Route("InActiveClients")]
        public IEnumerable<ClientSearchResults> InActiveClients()
        {
            var retVal = clientProfileRepository.InActiveClients();

            return retVal;
        }
        [System.Web.Http.HttpGet, Route("Activateclient/{id:int}")]
        public string Activateclient(int id)
        {
            var retVal = clientProfileRepository.Activateclient(id);

            return retVal;
        }

        [System.Web.Http.HttpGet, Route("DeleteClient/{id:int}")]
        public  string DeleteClientProfile(int id)
        {
            var retVal =  clientProfileRepository.DeleteClientProfile(id);
            return retVal;
        }

        [System.Web.Http.HttpPost, Route("DeleteMultipleClients")]
        public string DeleteMultipleClients(int[] ids)
        {
            try
            {
                foreach (int id in ids)
                {
                    var retVal = clientProfileRepository.DeleteClientProfile(id);
                }
                return "success";
            }
            catch (Exception e) {
                return "failed";
            }
        }

        [System.Web.Http.HttpPost, Route("AdminDeleteClientProfile")]
        public string DeleteMultipleClientsByAdmin(int[] ids)
        {
            try
            {
                foreach (int id in ids)
                {
                    var retVal = clientProfileRepository.AdminDeleteClientProfile(id);
                }
                return "success";
            }
            catch (Exception e)
            {
                return "failed";
            }
        }


        
        [System.Web.Http.HttpPost, Route(" ")]
        public async Task<object> Create(ClientProfile clientProfile)
        {
            if (ModelState.IsValid)
            {                
                clientProfileBaseRepository.Create(clientProfile);

                var retVal = await clientProfileBaseRepository.Save();


                return clientProfile;
            }

            return null;
        }

        [System.Web.Http.HttpGet, Route("{id}")]
        public async Task<Object> GetClientProfile(int id)
        {
            try
            {
                // Instantiate a new ClientProfileViewModel 
                ClientProfileViewModel cp = new ClientProfileViewModel();

                // Load ClientProfile for ClientProfileId
                var clientProfile = await clientProfileRepository.GetClientProfile(id);
                cp.ClientProfile = (ClientProfile)clientProfile;

                // Load Person for ClientProfileId
                var personVM = personRepository.GetPersonForClientProfile(id);
                cp.Person = personVM;

                // Load Assessment(s) for ClientProfileId
                var assessment = assessmentRepository.GetAssessmentsForClientProfile(id);
                cp.Assessment = assessment;

                // Load Placement(s) for ClientProfileId            
                cp.Placement = GetPlacementsForClientProfile(id);

                return cp;


            }
            catch (Exception E) {
                throw E;
            }
            
        }

        [System.Web.Http.HttpGet, Route("Person")]
        public IEnumerable<Person> GetAllPersonsWithNoClientProfile()
        {
            IEnumerable<Person> persons = clientProfileRepository.GetAllPersonsWithNoClientProfile();
            return persons;
        }

        [System.Web.Http.HttpGet, Route("FamilyProfile/{id:int}")]
        public IEnumerable<FamilyProfileViewModel> GetFamilyProfilesForPerson(int id)
        {
            IEnumerable<FamilyProfileViewModel> familyProfiles = personRepository.GetFamilyProfileForPerson(id);
            return familyProfiles;
        }

        [System.Web.Http.HttpGet, Route("Placement/{id:int}")]
        public IEnumerable<PlacementViewModel> GetPlacementsByClientProfile(int id)
        {
            var placements = GetPlacementsForClientProfile(id); 
            return placements;
        }

      

        [System.Web.Http.HttpGet, Route("Enrollment/{id:int}")]
        public IEnumerable<EnrollmentViewModel> GetEnrollmentsByPlacementId(int id)
        {
            IEnumerable<EnrollmentViewModel> enrollments = GetEnrollmentForPlacement(id);
            return enrollments;
        }

        [System.Web.Http.HttpGet, Route("ProgressNote/{id:int}")]
        public IEnumerable<ProgressNote> GetProgressNotesForEnrollment(int id)
        {
            IEnumerable<ProgressNote> progressNotes = progressNoteRepository.GetProgressNotesForEnrollment(id);
            return progressNotes;
        }
        //Delete progressNote
        [System.Web.Http.HttpGet, Route("DeleteProgressNote/{id:int}")]
        public string DeleteProgressNote(int id)
        {
         string progressNotes = progressNoteRepository.DeleteProgressNote(id);
            return progressNotes;
        }

        [System.Web.Http.HttpGet, Route("ServiceUnit/{id:int}")]
        public IEnumerable<ServiceUnit> GetServiceUnitsForEnrollment(int id)
        {
            IEnumerable<ServiceUnit> serviceUnits = serviceUnitRepository.GetServiceUnitsForEnrollment(id);
            return serviceUnits;
        }
        //Delete serviceUnit
        [System.Web.Http.HttpGet, Route("DeleteServiceUnit/{id:int}")]
        public string DeleteserviceUnit(int id)
        {
            var serviceUnits = serviceUnitRepository.DeleteserviceUnit(id);
            return serviceUnits;
        }

        [System.Web.Http.HttpGet, Route("Assessment/{id:int}")]
        public IEnumerable<Assessment> GetAssessmentsForClientProfile(int id)
        {
            var assessments = assessmentRepository.GetAssessmentsForClientProfile(id);
            
            return assessments;
        }
        [System.Web.Http.HttpGet, Route("DeleteAssessment/{id:int}")]
        public string DeleteAssessment(int id)
        {
            var assessments = assessmentRepository.DeleteAssessment(id);

            return assessments;
        }
        [System.Web.Http.HttpGet, Route("ActionPlan/{id:int}")]
        public IEnumerable<ActionPlan> GetActionPlansForEmploymentPlan(int id)
        {
            IEnumerable<ActionPlan> actionPlan = actionPlanRepository.GetActionPlansForEmploymentPlan(id);
            return actionPlan;
        }
        //Delete progressNote
        [System.Web.Http.HttpGet, Route("DeleteActionPlan/{id:int}")]
        public string DeleteActionPlansForEmploymentPlan(int id)
        {
            string actionPlan = actionPlanRepository.DeleteActionPlan(id);
            return actionPlan;
        }

        #region Private Helper Methods

        private IEnumerable<EnrollmentViewModel> GetEnrollmentForPlacement(int placementID)
        {
            IList<EnrollmentViewModel> enrollmentVM = new List<EnrollmentViewModel>();
            try {

                var enrollments = enrollmentRepository.GetEnrollmentsForPlacement(placementID);

                foreach (var enrollment in enrollments)
                {
                    // Load Progress Notes for Enrollment
                    var progressNotes = progressNoteRepository.GetProgressNotesForEnrollment(enrollment.ID);

                    // Load Service Units for Enrollment
                    var serviceUnits = serviceUnitRepository.GetServiceUnitsForEnrollment(enrollment.ID);

                    //Load EmploymentPlan for Enrollment
                    var employmentPlan = employmentPlanRepository.GetEmploymentForEnrollment(enrollment.ID);

                    //Load ActionPlan for Enrollment
                    var actionPlan = actionPlanRepository.GetActionPlansForEmploymentPlan(enrollment.ID);

                    // Assign to EnrollmentVM
                    enrollmentVM.Add(new EnrollmentViewModel { Enrollment = enrollment, ProgressNote = progressNotes, ServiceUnit = serviceUnits, EmploymentPlan = employmentPlan, ActionPlan = actionPlan });

                    // Assign to EnrollmentVM
                    //enrollmentVM.Add(new EnrollmentViewModel { Enrollment = enrollment, ProgressNote = progressNotes, ServiceUnit = serviceUnits });
                }

            } catch (Exception e) { throw e; }
          

            return enrollmentVM;
        }

        private IEnumerable<PlacementViewModel> GetPlacementsForClientProfile(int clientProfileID)
        {
            IList<PlacementViewModel> placementVMs = new List<PlacementViewModel>();
            try
            {
              
                var placements = placementRepository.GetPlacementsForClientProfile(clientProfileID);
                foreach (var placement in placements)
                {
                    // Load Related Enrollments
                    var enrollment = GetEnrollmentForPlacement(placement.ID);

                    // Load Related Offenses
                    var placementOffenses = placementOffenseRepository.GetPlacementOffensesForPlacement(placement.ID);

                    // Add it to the collection
                    placementVMs.Add(new PlacementViewModel { Placement = placement, Enrollment = enrollment, PlacementOffense = placementOffenses });
                }

            } catch (Exception e) {
                throw e;
            }
            return placementVMs;
        }

        #endregion
    }
}