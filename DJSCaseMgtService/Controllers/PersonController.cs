using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgmtModel.Entities;
using System.Threading.Tasks;
using DJSCaseMgtService.Utility;
using DJSCaseMgtService.Models;
using Microsoft.Owin.Hosting;
using System.Diagnostics;
using System.Web;
using System.Web.UI;

namespace DJSCaseMgtService.Controllers
{
 
    [RoutePrefix("api/Person")]
  

    public class PersonController : ApiController 
    {
        private IPersonRepository personRepository;
        private IClientProfileRepository clientProfileRepository;
        private IPersonSupplementalRepository personSupplementalRepository;
        private DJSCaseMgtContext context = new DJSCaseMgtContext();
        public PersonController(IPersonRepository personRepository,
                                IPersonSupplementalRepository personSupplementalRepository,
                                IClientProfileRepository clientProfileRepository) 
        {
            this.personRepository = personRepository;
            this.personSupplementalRepository = personSupplementalRepository;
            this.clientProfileRepository = clientProfileRepository;
        }

        [System.Web.Http.HttpGet, Route("")]
        public async Task<object> GetAll( )
        {
            return context.Person.Where(x => x.FirstName != "" && x.FirstName != null && x.LastName != "" && x.LastName != null).OrderBy(x => x.ID).ToList();
            //.Where(x=> x.ID>140894)
        }
     
        [System.Web.Http.HttpGet, Route("GetduplicatePersons/{id}")]

        public IEnumerable<dynamic> GetduplicatePersons (string id )
        {
           return (from p in context.Person
            join cp in context.ClientProfile on p.ID equals cp.PersonID
            where p.UniqueID.Contains(id) && cp.Active == true 
            select new {
                p.ID,
                p.LastName ,
                p.FirstName ,
                p.MiddleName ,
                p.SuffixID ,
                p.Suffix,
                p.JTS ,
                p.DOB ,
                p.RaceID ,
                p.Race  ,
                p.GenderID ,
                p.Gender  ,
                p.SSN ,
                p.ICN ,
                p.Active ,
                p.UniqueID ,
                p.tempFamilyProfileId ,
                p.tempAddrID ,
                ClientProfileID=cp.ID
            });}

        //to avoid duplicate JTS number and Duplicate SSN


        [System.Web.Http.HttpPost, Route("MeargePerson/{id}")]
        public IHttpActionResult MeargePerson(int id,List<int> PersonIdList)
        {
            try
            {
                var rows = context.Placement.Where(x => PersonIdList.Contains(x.ClientProfileID)).ToList();
                rows.ForEach(x =>
                {
                    x.ClientProfileID = id;
                });
                context.SaveChanges();
            }
            catch(Exception e) {
                return InternalServerError();
            }
            return Ok("Success");
        }
        //duplicate unique ids
        //Route("GetDuplicatePersons/{uniqueid:int}")
        
        [System.Web.Http.HttpGet, Route("testperson")]
        public IHttpActionResult testperson()
        {
            //if (id == "")
            //    return BadRequest();
            return Ok(context.Person.Take(10));
            //throw new Exception("  test success");



        }
        //duplicate unique ids
        //Route("GetDuplicatePersons/{uniqueid:int}")
        [System.Web.Http.HttpPost, Route("UpdateAlluniqueIds")]
        public IHttpActionResult UpdateAlluniqueIds(UniqidsReq ObjList)
        {
            //if (id == "")
            //    return BadRequest();

            try

            {
                foreach (Uniqids list in ObjList.list)
                {
                    int personid = list.PersonId;
                    string Unid = list.UniqueId;
                var result = context.Person.Where(x => x.UniqueID.Contains(Unid.Trim())).ToList();
                int count = result.Count;
                int postfix = count + 1;
                string UnqId = Unid+'-' + postfix.ToString();

                var record = context.Person.Where(x => x.ID == personid).FirstOrDefault();
                if (record != null) { 
                  
                    record.UniqueID = UnqId;
                    context.SaveChanges();
                    }
                }
                    return Ok("Success");
                }
                catch (Exception e) {
                    return Ok("Failed");
                }
        

        }
        //update all ssn with encrypted code
        [System.Web.Http.HttpPost, Route("UpdateAllSsns")]
        public IHttpActionResult UpdateAllSsns(EncryptSSN ObjList)
        {
            //if (id == "")
            //    return BadRequest();
            try
            {
                foreach (SsnList list in ObjList.list)
                {
                    int personid = list.PersonId;
                    string Unid = list.SSNs;
                   // var result = context.Person.Where(x => x.SSN.Contains(Unid.Trim())).ToList();
                   
                    string UnqId = Unid.ToString();
                    string uniqs = Function.Encryptdata(UnqId);

                    var record = context.Person.Where(x => x.ID == personid).FirstOrDefault();
                    if (record != null)
                    {

                        record.SSN = uniqs;
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

        [System.Web.Http.HttpPost, Route("")]
        public async Task<object> Create(Person person)
        {
            ClientProfile clientProfile = new ClientProfile { 
                SystemID = Constant.SystemID, Active = true,
                UpdatedBy = User.Identity.Name, CreatedBy = User.Identity.Name, CreatedDate = DateTime.Now, UpdatedDate = DateTime.Now
            };
        
            if (ModelState.IsValid)
            {

                if (person.SSN != null)
                {

                    person.SSN = Function.Encryptdata(person.SSN);
                }
               // var jtsresult = context.Person.Where(x => x.JTS == person.JTS).FirstOrDefault();
                var ssnresult = context.Person.Where(x => x.SSN == person.SSN && x.SSN != null && x.SSN != "").FirstOrDefault();

                //if (jtsresult == null && ssnresult == null)
                if (ssnresult == null)
                {
                    person.CreatedBy = User.Identity.Name;

                   

                    //Create Person
                    personRepository.Create(person);
                    var retVal = await personRepository.Save();

                    if (person.ID != 0)
                    {
                        // Create New ClientProfile
                        clientProfile.PersonID = person.ID;
                        clientProfile.CreatedDate = DateTime.Now;
                        clientProfile.UpdatedDate = DateTime.Now;
                        clientProfile.UpdatedBy = User.Identity.Name;
                        clientProfile.CreatedBy = User.Identity.Name;
                        clientProfileRepository.Create(clientProfile);
                        var cpVal = await clientProfileRepository.Save();

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
                        personSupplementalRepository.Create(personSupplemental);
                        var psVal = await personSupplementalRepository.Save();
                    }
                    //}
                    //catch (Exception e)
                    //{
                    //    Trace.WriteLine(e.Message);
                    //}
                    return clientProfile;
                }
                else
                {

                   
                    //if (jtsresult != null) {

                    //    String name = "JTS";

                    //    return name;
                    //}
                    if (ssnresult != null)
                    {
                        String name = "SSN";
                        return name;
                    }

                  
                }


            }

            return null;
        }

        [System.Web.Http.HttpPut]
        public async Task<object> Update(Person person)
        {

           
            if (ModelState.IsValid)
            {
                if (person.SSN != null)
                {

                    person.SSN = Function.Encryptdata(person.SSN);
                }
                var jtsresult = context.Person.Where(x => x.JTS == person.JTS && x.JTS != "" && x.JTS != null).FirstOrDefault();
                var ssnresult = context.Person.Where(x => x.SSN == person.SSN && x.SSN!="" && x.SSN != null).FirstOrDefault();
                 
                if (jtsresult!=null  ) {
                    if (jtsresult.ID == person.ID) { jtsresult = null; }
                    
                }
                if (ssnresult != null) {

                    if (ssnresult.ID == person.ID)
                    {
                        ssnresult = null;
                    }
                }
               

                if (jtsresult == null && ssnresult == null)
                {

                    person.UpdatedBy = User.Identity.Name;

                   // person.SSN = Function.Encryptdata(person.SSN);
                    personRepository.Update(person);

                    await personRepository.Save();
                }
                else {

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

            return 0;
        }
       
       
    }
}
