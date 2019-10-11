using DJSCaseMgmtModel.Entities;
using DJSCaseMgmtModel.ViewModels;
using DJSCaseMgtService.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using DJSCaseMgtService.Utility;

namespace DJSCaseMgtService.DataAccess.Repositories
{
    public class PersonRepository : BaseRepository<Person>, IPersonRepository
    {
        private DJSCaseMgtContext context;

        public PersonRepository(DJSCaseMgtContext context) : base(context) 
        {
            this.context = context;
        }        

        public PersonViewModel GetPersonForClientProfile(int clientProfileID)
        {
            // Create new instance of PersonViewModel
            PersonViewModel personVM = new PersonViewModel();
            try {
                // Get Person, this may use the base repositories FInd method
                var person = (from p in context.Person
                              join cp in context.ClientProfile on p.ID equals cp.PersonID
                              where cp.ID == clientProfileID
                              select p).FirstOrDefault();
                //Decrypt SSN
                if (person.SSN != null)
                { person.SSN = Function.Decryptdata(person.SSN); }

                var personSupplemental = (from ps in context.PersonSupplemental
                                          where ps.PersonID == person.ID
                                          select ps).FirstOrDefault();

                var personAddress = (from pa in context.PersonAddress
                                     where pa.PersonID == person.ID
                                     select pa).AsEnumerable();
                IEnumerable<FamilyProfileViewModel> familyProfileVMs = GetFamilyProfileForPerson(person.ID);

                // Load PersonViewModel with the data
                personVM.Person = person; // Assign Person
                personVM.PersonSupplemental = personSupplemental; // Assign PersonSupplemental
                personVM.PersonAddress = personAddress; // Assign PersonAddress
                personVM.FamilyProfile = familyProfileVMs; // Assign FamilyProfile
            } catch (Exception E) {
                return null;
            }
            return personVM;
        }

        public IEnumerable<FamilyProfileViewModel> GetFamilyProfileForPerson(int personID)
        {
            IList<FamilyProfileViewModel> familyProfileVMs = new List<FamilyProfileViewModel>();

          
            var familyProfiles = (from fp in context.FamilyProfile
                                  join cp in context.ClientProfile on fp.ClientProfilePersonID equals cp.ID
                                  where cp.PersonID == personID && fp.Active==true
                                  select fp).AsEnumerable();

        

            foreach (var fp in familyProfiles)

            {
                if (fp.Person.SSN != null)
                { fp.Person.SSN = Function.Decryptdata(fp.Person.SSN); }

                var fpSupplemental = (from ps in context.PersonSupplemental
                                      where ps.PersonID == fp.FamilyMemberID
                                      select ps).FirstOrDefault();
                var personAddress = (from pa in context.PersonAddress
                                         where pa.PersonID == fp.FamilyMemberID
                                         select pa).ToList();
                familyProfileVMs.Add(new FamilyProfileViewModel { FamilyProfile = fp, PersonSupplemental = fpSupplemental, FamilyPersonAddress= personAddress });
            }
            return familyProfileVMs;
        }


        //public string CreatePerson(Person person)
        //{
        //    //Generate Unitque id based on input 
           
        //}
    }

    public interface IPersonRepository : IBaseRepository<Person>
    {
        PersonViewModel GetPersonForClientProfile(int clientProfileID);
        IEnumerable<FamilyProfileViewModel> GetFamilyProfileForPerson(int personID);

      // string CreatePerson(Person person);
    }
}