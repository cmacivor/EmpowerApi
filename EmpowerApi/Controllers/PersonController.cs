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
                //var jtsresult = context.Person.Where(x => x.JTS == person.JTS && x.JTS != "" && x.JTS != null).FirstOrDefault();
                var ssnresult = context.Person.Where(x => x.SSN == person.SSN && x.SSN != "" && x.SSN != null).FirstOrDefault();

                //if (jtsresult!=null  ) {
                //    if (jtsresult.ID == person.ID) { jtsresult = null; }

                //}
                if (ssnresult != null)
                {

                    if (ssnresult.ID == person.ID)
                    {
                        ssnresult = null;
                    }
                }


                //if (jtsresult == null && ssnresult == null)
                if (ssnresult == null)
                {

                    person.UpdatedBy = User.Identity.Name;

                    // person.SSN = Function.Encryptdata(person.SSN);
                    personRepository.Update(person);

                    await personRepository.Save();
                }
                else
                {

                    //if (jtsresult != null)
                    //{

                    //    String name = "JTS";

                    //    return name;
                    //}
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
    }
}
