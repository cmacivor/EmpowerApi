using DJSCaseMgmtModel.Entities;
using DJSCaseMgmtModel.ViewModels;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgtService.Models;
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
        private IPersonRepository personRepository;
        private DJSCaseMgtContext context = new DJSCaseMgtContext();


        [System.Web.Http.HttpPut]
        public async Task<object> Update(Person person)
        {
            if (ModelState.IsValid)
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

                    personRepository.Update(person);

                    await personRepository.Save();
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

            return 0;
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
