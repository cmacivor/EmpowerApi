using DJSCaseMgmtModel.Entities;
using DJSCaseMgmtModel.ViewModels;
using DJSCaseMgtService.Models;
using DJSCaseMgtService.Utility;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Core.Objects;
using System.Data.Entity.SqlServer;
using System.Data.SqlClient;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using System.Web;

namespace DJSCaseMgtService.DataAccess.Repositories
{
    public class ClientProfileRepository : BaseRepository<ClientProfile>, IClientProfileRepository
    {
        private DJSCaseMgtContext context;

        public ClientProfileRepository(DJSCaseMgtContext context) : base(context)
        {
            this.context = context;
        }

        public async Task<Object> GetClientProfile(int clientProfileId)
        {
           
            try {
              var   retVal = (from cp in context.ClientProfile
                              where cp.ID == clientProfileId
                              select cp).FirstOrDefaultAsync();
                return await retVal;
            } catch (Exception e) {
                return null;
            }
           
        }

        public IEnumerable<ClientSearchResults> Search21plus()
        {
            IEnumerable<ClientSearchResults> retVal = new List<ClientSearchResults>();

            string ClientSearch =
               @"SELECT top 1000
            	    cp.ID, p.LastName, p.FirstName, p.MiddleName, p.JTS, p.SSN, p.DOB, 
            	    (SELECT Name FROM Gender WHERE ID = p.GenderID) as Gender
                FROM 
            	    Person p
            	    INNER JOIN ClientProfile cp ON cp.PersonID = p.ID
                WHERE 
                    cp.Active = 1 AND
                    datediff(day,p.DOB,getDate())>7670 AND
                 
                    cp.SystemID = 3 ";


           
                string SQL = ClientSearch;


            SQL += " ORDER BY p.LastName, p.FirstName";
            retVal = context.Database.SqlQuery<ClientSearchResults>(SQL).ToList();
            //  Decrypted SSN
            retVal.ToList().ForEach(
                x =>
                {
                    if (x.SSN != null)
                    {
                        x.SSN = Function.Decryptdata(x.SSN);
                    }
                    else {
                    }
                });

            return retVal;
        }


        public IEnumerable<ClientSearchResults> InActiveClients()
        {
            IEnumerable<ClientSearchResults> retVal = new List<ClientSearchResults>();

            string ClientSearch =
               @"SELECT 
            	    cp.ID, p.LastName, p.FirstName, p.MiddleName, p.JTS, p.SSN, p.DOB, 
            	    (SELECT Name FROM Gender WHERE ID = p.GenderID) as Gender
                FROM 
            	    Person p
            	    INNER JOIN ClientProfile cp ON cp.PersonID = p.ID
                WHERE 
                    cp.Active = 0 AND cp.SystemID = 3 " ;

            string SQL = ClientSearch;


            SQL += " ORDER BY p.LastName, p.FirstName";
            retVal = context.Database.SqlQuery<ClientSearchResults>(SQL).ToList();
            //  Decrypted SSN
            retVal.ToList().ForEach(
                x =>
                {
                    if (x.SSN != null)
                    {
                        x.SSN = Function.Decryptdata(x.SSN);
                    }
                    else
                    {
                    }
                });

            return retVal;
        }

        public IEnumerable<ClientSearchResults> Search(string lastname, string firstname)
        {
            IEnumerable<ClientSearchResults> retVal = new List<ClientSearchResults>();

             string ClientSearch =
                @"SELECT 
            	    cp.ID, p.LastName, p.FirstName, p.MiddleName, p.JTS, p.SSN, p.StateORVCIN, p.DOB, 
            	    (SELECT Name FROM Gender WHERE ID = p.GenderID) as Gender
                FROM 
            	    Person p
            	    INNER JOIN ClientProfile cp ON cp.PersonID = p.ID
                WHERE 
                    cp.Active = 1 AND
          
                    cp.SystemID = 3 
                     ";

             if (firstname == null && lastname == null)
                 return null;
             else
             {
                 string SQL = ClientSearch;

                 if (!string.IsNullOrWhiteSpace(firstname))
                     firstname = Function.EncodeForLike(firstname) + "%";

                 if (!string.IsNullOrWhiteSpace(firstname) && string.IsNullOrWhiteSpace(lastname))
                     SQL += "AND SOUNDEX('" + firstname +"') = SOUNDEX(p.FirstName)";
                 else if (string.IsNullOrWhiteSpace(firstname) && !string.IsNullOrWhiteSpace(lastname))
                     SQL += "AND SOUNDEX('" + lastname + "') = SOUNDEX(p.LastName)";
                 else if (!string.IsNullOrWhiteSpace(firstname) && !string.IsNullOrWhiteSpace(lastname))
                     SQL += "AND SOUNDEX('" + firstname + "') = SOUNDEX(p.FirstName) AND SOUNDEX('" + lastname + "') = SOUNDEX(p.LastName)";

                 SQL += " ORDER BY p.LastName, p.FirstName";

                 SqlParameter[] sqlParams = 
                    {
                        new SqlParameter("LastName", lastname),
                        new SqlParameter("FirstName", firstname)
                    };

                 retVal =  context.Database.SqlQuery<ClientSearchResults>(SQL).ToList();
                // Decrypted SSN

                retVal.ToList().ForEach(
                    x =>
                    {
                        if (x.SSN != null)
                        {
                            x.SSN = Function.Decryptdata(x.SSN);
                        }
                        else {

                        }


                    });
            }

             return retVal;
        }
        public  string DeleteClientProfile(int clientProfileId)//Temporary Delete
        {
            string result = "";
            var req = context.ClientProfile.Where(x => x.ID == clientProfileId).ToList();
            

            if (req.Count == 0)
                return null;
            else

           
            req.ForEach(x =>
            {
                x.Active = false;
                x.UpdatedBy = HttpContext.Current.User.Identity.Name;
                //context.ClientProfile.Remove(x);
            });
            try
            {
                context.SaveChanges();
                result= "Success";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
                    result =ex.Message;
            }
            return result;
        }


        public string Activateclient(int clientProfileId)//Reactivate if  its inactive
        {
            string result = "";
            var req = context.ClientProfile.Where(x => x.ID == clientProfileId).ToList();


            if (req.Count == 0)
                return null;
            else


                req.ForEach(x =>
                {
                    x.Active = true;
                    x.UpdatedBy = HttpContext.Current.User.Identity.Name;
                    //context.ClientProfile.Remove(x);
                });
            try
            {
                context.SaveChanges();
                result = "Success";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
                result = ex.Message;
            }
            return result;
        }

        public string AdminDeleteClientProfile(int clientProfileId)//Permanent delete by SuperUser.
        {
            string result = "";
            var req = context.ClientProfile.Where(x => x.ID == clientProfileId).ToList();


            if (req.Count == 0)
                return null;
            else


                req.ForEach(x =>
                {
                    context.ClientProfile.Remove(x);
                });
            try
            {
                context.SaveChanges();
                result = "Success";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
                result = ex.Message;
            }
            return result;
        }

        public IEnumerable<Person> GetAllPersonsWithNoClientProfile()
        {
            return null;
            //using (IDbConnection connection = Connection)
            //{
            //    var persons = connection.Query<Person, Suffix, Gender, Race, Person>
            //    (SQLPersonsData, (p, s, g, r) =>
            //    {
            //        p.Suffix = s;
            //        p.Gender = g;
            //        p.Race = r;

            //        return p;
            //    }).AsEnumerable();

            //    return persons;
            //}
        }
    }

    public interface IClientProfileRepository : IBaseRepository<ClientProfile>
    {
        Task<Object> GetClientProfile(int clientProfileId);
        IEnumerable<ClientSearchResults> Search(string lastname, string firstname);

        IEnumerable<ClientSearchResults> Search21plus();

        IEnumerable<ClientSearchResults> InActiveClients();
        IEnumerable<Person> GetAllPersonsWithNoClientProfile();
        string DeleteClientProfile(int clientProfileId);
        string Activateclient(int clientProfileId);

        string AdminDeleteClientProfile(int clientProfileId);
    }
}