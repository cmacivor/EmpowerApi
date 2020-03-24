using DJSCaseMgmtModel.Entities;
using DJSCaseMgmtModel.ViewModels;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgtService.Models;
using DJSCaseMgtService.oAuth;
using DJSCaseMgtService.Utility;
using EmpowerApi.Utility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;

namespace EmpowerApi.Controllers
{
    [RoutePrefix("api/Person")]
    public class PersonController : ApiController
    {
        private IPersonRepository _personRepository;
        private IClientProfileRepository _clientProfileRepository;
        private IPersonSupplementalRepository _personSupplementalRepository;
        private DJSCaseMgtContext context = new DJSCaseMgtContext();
        private AuthRepository _authRepository;

        public PersonController(IPersonRepository personRepository, IPersonSupplementalRepository personSupplementalRepository, IClientProfileRepository clientProfileRepository)
        {
            _personRepository = personRepository;
            _clientProfileRepository = clientProfileRepository;
            _personSupplementalRepository = personSupplementalRepository;
            _authRepository = new AuthRepository();
        }

        [System.Web.Http.HttpPut, Route("")]
        public async Task<object> Update(Person person)
        {
            if (ModelState.IsValid)
            {
                int systemID = _authRepository.GetSystemIDByLoggedInUserRole();

                if (systemID == Convert.ToInt32(EmpowerSystem.Juvenile))
                {
                    return await HandleUpdateForJuvenile(person);
                }

                return await HandleUpdateForAdultAndCWB(person);
            }

            return 0;
        }


        [System.Web.Http.HttpPost, Route("")]
        public async Task<object> Create(Person person)
        {
            int systemID = _authRepository.GetSystemIDByLoggedInUserRole();

            ClientProfile clientProfile = new ClientProfile
            {
                SystemID = systemID,
                Active = true,
                UpdatedBy = User.Identity.Name,
                CreatedBy = User.Identity.Name,
                CreatedDate = DateTime.Now,
                UpdatedDate = DateTime.Now
            };

            if (ModelState.IsValid)
            {
                if (person.SSN != null)
                {
                    person.SSN = Function.Encryptdata(person.SSN);
                }

                var ssnresult = context.Person.Where(x => x.SSN == person.SSN && x.SSN != null && x.SSN != "").FirstOrDefault();

                if (ssnresult == null)
                {
                    person.CreatedBy = User.Identity.Name;

                    //Create Person
                    _personRepository.Create(person);
                    var retVal = await _personRepository.Save();

                    if (person.ID != 0)
                    {
                        // Create New ClientProfile
                        clientProfile.PersonID = person.ID;
                        clientProfile.CreatedDate = DateTime.Now;
                        clientProfile.UpdatedDate = DateTime.Now;
                        clientProfile.UpdatedBy = User.Identity.Name;
                        clientProfile.CreatedBy = User.Identity.Name;
                        _clientProfileRepository.Create(clientProfile);
                        var cpVal = await _clientProfileRepository.Save();

                        // Create New PersonSupplemental
                        PersonSupplemental personSupplemental = new PersonSupplemental
                        {
                            PersonID = person.ID,
                            Active = true,
                            UpdatedBy = User.Identity.Name,
                            CreatedBy = User.Identity.Name,
                            CreatedDate = DateTime.Now,
                            UpdatedDate = DateTime.Now
                        };
                        _personSupplementalRepository.Create(personSupplemental);
                        var psVal = await _personSupplementalRepository.Save();
                    }

                    //decrypt it again for display
                    clientProfile.Person.SSN = Function.Decryptdata(clientProfile.Person.SSN);
                   
                    return clientProfile;
                }
                else
                {                  
                    if (ssnresult != null)
                    {
                        String name = "SSN";
                        return name;
                    }
                }
            }

            return null;
        }



        private async Task<object> HandleUpdateForJuvenile(Person person)
        {
            if (person.SSN != null)
            {
                person.SSN = Function.Encryptdata(person.SSN);
            }
            var jtsresult = context.Person.Where(x => x.JTS == person.JTS && x.JTS != "" && x.JTS != null).FirstOrDefault();
            var ssnresult = context.Person.Where(x => x.SSN == person.SSN && x.SSN != "" && x.SSN != null).FirstOrDefault();

            if (jtsresult != null)
            {
                if (jtsresult.ID == person.ID) { jtsresult = null; }
            }
            if (ssnresult != null)
            {
                if (ssnresult.ID == person.ID)
                {
                    ssnresult = null;
                }
            }

            if (jtsresult == null && ssnresult == null)
            {
                person.UpdatedBy = User.Identity.Name;

                // person.SSN = Function.Encryptdata(person.SSN);
                _personRepository.Update(person);

                await _personRepository.Save();
            }
            else
            {
                if (jtsresult != null)
                {
                    String name = "JTS";

                    return name;
                }
                if (ssnresult != null)
                {
                    String name = "SSN";
                    return name;
                }
            }

            return person.ID;
        }

        private async Task<object> HandleUpdateForAdultAndCWB(Person person)
        {
            if (person.SSN != null)
            {
                person.SSN = DJSCaseMgtService.Utility.Function.Encryptdata(person.SSN);
            }

            var ssnresult = context.Person.Where(x => x.SSN == person.SSN && x.SSN != "" && x.SSN != null).FirstOrDefault();

            if (ssnresult != null)
            {
                if (ssnresult.ID == person.ID)
                {
                    ssnresult = null;
                }
            }

            if (ssnresult == null)
            {
                person.UpdatedBy = User.Identity.Name;

                _personRepository.Update(person);

                await _personRepository.Save();
            }
            else
            {
                if (ssnresult != null)
                {
                    String name = "SSN";
                    return name;
                }
            }

            return person.ID;
        }

        //duplicate unique ids
        //Route("GetDuplicatePersons/{uniqueid:int}")
        [System.Web.Http.HttpPost, Route("UpdateAlluniqueIds")]
        public IHttpActionResult UpdateAlluniqueIds(UniqidsReq ObjList)
        {
            try

            {
                foreach (Uniqids list in ObjList.list)
                {
                    int personid = list.PersonId;
                    string Unid = list.UniqueId;
                    var result = context.Person.Where(x => x.UniqueID.Contains(Unid.Trim())).ToList();
                    int count = result.Count;
                    int postfix = count + 1;
                    string UnqId = Unid + '-' + postfix.ToString();

                    var record = context.Person.Where(x => x.ID == personid).FirstOrDefault();
                    if (record != null)
                    {

                        record.UniqueID = UnqId;
                        context.SaveChanges();
                    }
                }
                return Ok("Success");
            }
            catch (Exception e)
            {
                return Ok("Failed");
            }
        }

        [System.Web.Http.HttpGet, Route("GetduplicatePersons/{id}")]
        public IEnumerable<dynamic> GetduplicatePersons(string id)
        {
            return (from p in context.Person
                    join cp in context.ClientProfile on p.ID equals cp.PersonID
                    where p.UniqueID.Contains(id) && cp.Active == true
                    select new
                    {
                        p.ID,
                        p.LastName,
                        p.FirstName,
                        p.MiddleName,
                        p.SuffixID,
                        p.Suffix,
                        p.JTS,
                        p.DOB,
                        p.RaceID,
                        p.Race,
                        p.GenderID,
                        p.Gender,
                        p.SSN,
                        p.FBINCIC,
                        p.StateORVCIN,
                        p.Alias,
                        p.ICN,
                        p.Active,
                        p.UniqueID,
                        p.tempFamilyProfileId,
                        p.tempAddrID,
                        ClientProfileID = cp.ID
                    });
        }

       public IHttpActionResult MeargePerson(MergePersonPostData data)
        {
            try
            {
                //Placements are created on the Referral tab
                var rows = context.Placement.Where(x => data.PersonIdList.Contains(x.ClientProfileID)).ToList();
                rows.ForEach(x =>
                {
                    x.ClientProfileID = data.id;
                });
                context.SaveChanges();
            }
            catch (Exception e)
            {
                return InternalServerError();
            }
            return Ok("Success");
        }
    }

    public class MergePersonPostData
    {
        public int id { get; set; }

        public List<int> PersonIdList { get; set; }
    }
}
