using System.Web.Http;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgmtModel.Entities;
using System.Threading.Tasks;
using DJSCaseMgtService.Models;
using DJSCaseMgmtModel.ViewModels;
using DJSCaseMgtService.Utility;

namespace DJSCaseMgtService.Controllers
{
    [RoutePrefix("api/FamilyProfile")]
    public class FamilyProfileController : ApiController 
    {
        private DJSCaseMgtContext context;
        private IPersonRepository personRepository;
        private IPersonSupplementalRepository personSupplementalRepository;
        private IFamilyProfileRepository familyProfileRepository;
        private IPersonAddressRepository personAddressRepository;

        public FamilyProfileController(DJSCaseMgtContext context,
                                       IPersonRepository personRepository,
                                       IPersonSupplementalRepository personSupplementalRepository,
                                       IFamilyProfileRepository familyProfileRepository,
                                        IPersonAddressRepository personAddressRepository)
        {
            this.context = context;
            this.personRepository = personRepository;
            this.personSupplementalRepository = personSupplementalRepository;
            this.familyProfileRepository = familyProfileRepository;
            this.personAddressRepository = personAddressRepository;
        }

        [System.Web.Http.HttpPost, Route("")]
        public async Task<object> Create(FamilyProfileViewModel familyProfileVM)
        {
            if (ModelState.IsValid)
            {
                //By default family profile set to active
                familyProfileVM.FamilyProfile.Active = true;

                if(familyProfileVM.FamilyProfile.Person.SSN!=null)
                {
                    familyProfileVM.FamilyProfile.Person.SSN = Function.Encryptdata(familyProfileVM.FamilyProfile.Person.SSN);

                }
              
                // Create Person
                personRepository.Create(familyProfileVM.FamilyProfile.Person);
                var retVal = await personRepository.Save();

                if (familyProfileVM.FamilyProfile.Person.ID != 0)
                {
                    //Create New Person Supplemental Record
                    familyProfileVM.PersonSupplemental.PersonID = familyProfileVM.FamilyProfile.Person.ID;

                    //create address for family member

                  //  familyProfileVM.FamilyPersonAddress.PersonID = familyProfileVM.FamilyProfile.Person.ID;

                    // Create FamilyProfile Record
                    familyProfileVM.FamilyProfile.FamilyMemberID = familyProfileVM.FamilyProfile.Person.ID;

                    FamilyProfile newFamilyProfile = familyProfileVM.FamilyProfile;
                    newFamilyProfile.Person = null;

                    // Save to the database
                    personSupplementalRepository.Create(familyProfileVM.PersonSupplemental);
                    var personSupplementalID = await personSupplementalRepository.Save();

                  //  personAddressRepository.Create(familyProfileVM.FamilyPersonAddress);
                   // var FamilyPersonAddressID = await personAddressRepository.Save();

                    familyProfileRepository.Create(newFamilyProfile);
                    var familyProfileID = await familyProfileRepository.Save();
                }

                return familyProfileVM;
            }

            return null;
        }

        [System.Web.Http.HttpPut, Route("{id:int}")]
        public async Task<object> Update(FamilyProfileViewModel familyProfileVM)
        {

            if (ModelState.IsValid)
            {
                if (!System.String.IsNullOrEmpty(familyProfileVM.FamilyProfile.Person.SSN))
                {
                    familyProfileVM.FamilyProfile.Person.SSN = Function.Encryptdata(familyProfileVM.FamilyProfile.Person.SSN);
                }
                // Create Person
                personRepository.Update(familyProfileVM.FamilyProfile.Person);
                var retVal = await personRepository.Save();

                familyProfileVM.FamilyProfile.Person= null;

                // Update database
                personSupplementalRepository.Update(familyProfileVM.PersonSupplemental);
                var personSupplementalID = await personSupplementalRepository.Save();

               // personAddressRepository.Update(familyProfileVM.FamilyPersonAddress);
              //  var FamilyPersonAddressID = await personAddressRepository.Save();

                familyProfileRepository.Update(familyProfileVM.FamilyProfile);
                var familyProfileID = await familyProfileRepository.Save();

                return familyProfileVM;
            }

            return null;
        }


        [System.Web.Http.HttpGet, Route("DeleteMember/{id:int}")]
        public string DeleteMember(int id)
        {
            var retVal = familyProfileRepository.DeleteFamilyMember(id);
            return retVal;
        }
       
    }
}
