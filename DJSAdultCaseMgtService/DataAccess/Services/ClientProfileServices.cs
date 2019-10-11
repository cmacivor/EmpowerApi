using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using Dapper;
using DJSCaseMgtModel.Entities;
using DJSCaseMgtModel.ViewModels;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgtService.Utility;
using System.Threading.Tasks;
using System.Configuration;

namespace DJSCaseMgtService.DataAccess.Services
{
    public class ClientProfileServices : IClientProfileServices
    {
        #region Private Variables

        //private readonly IDbConnection Connection;
        //private IBaseOldRepository context;
        //private readonly string SQLClientSearch;
        //private readonly string SQLPersonsData;

        #endregion

        #region Constructor

        public ClientProfileServices()
        {
            //this.context = context;
            //Connection = new SqlConnection(Constant.DatabaseConnection);
            //SQLClientSearch = SQLQuery.ClientSearch;
            //SQLPersonsData = SQLQuery.PersonsData;
        }

        #endregion

        #region Public Methods

        //public async Task<int?> CreateFamilyProfile(FamilyProfile familyProfile)
        //{
        //    // Open connection
        //    Connection.Open();

        //    // Open Transaction
        //    using (var trans = Connection.BeginTransaction())
        //    {
        //        try
        //        {
        //            // Create Person Record
        //            int? personID = this.context.Create<Person>(familyProfile.Person);

        //            if (personID != null)
        //            {
        //                // Create PersonSupplemental Record  
        //                //familyProfile.Person.PersonSupplemental.PersonID = (int)personID;
        //                //int? personSupplementalID = this.context.Create<PersonSupplemental>(familyProfile.Person.PersonSupplemental);

        //                // Create FamilyProfile Record
        //                familyProfile.FamilyMemberID = (int)personID;
        //                int? familyProfileID = await this.context.CreateAsync<FamilyProfile>(familyProfile);

        //                if (familyProfileID != null)
        //                {
        //                    /*** If there is a familyProfileID, then commit ***/
        //                    trans.Commit();

        //                    // and return familyProfileID
        //                    return (int)familyProfileID;
        //                }
        //                else
        //                {
        //                    /*** If new FamilyProfileID is not generated, then rollback ***/
        //                    trans.Rollback();
        //                    return null;
        //                }
        //            }
        //            else
        //            {
        //                /*** If new PersonID is not generated, then rollback ***/
        //                trans.Rollback();
        //                return null;
        //            }
        //        }
        //        catch
        //        {
        //            trans.Rollback();
        //            return null;
        //        }
        //    }
        //}

        //public async Task<int?> UpdateFamilyProfile(FamilyProfile familyProfile)
        //{
        //    // Open connection
        //    Connection.Open();

        //    // Open Transaction
        //    using (var trans = Connection.BeginTransaction())
        //    {
        //        try
        //        {
        //            // Update Person
        //            int? personID = this.context.Update<Person>(familyProfile.Person.ID, familyProfile.Person);

        //            // Update PersonSupplemental
        //            //if (familyProfile.Person.PersonSupplemental != null)
        //            //{
        //            //    int? personSupplementalID = this.context.Update<PersonSupplemental>(familyProfile.Person.PersonSupplemental.ID, familyProfile.Person.PersonSupplemental);
        //            //}

        //            // Update FamilyProfile
        //            int? familyProfileID = await this.context.UpdateAsync<FamilyProfile>(familyProfile.ID, familyProfile);
        //            if (familyProfileID != null)
        //            {
        //                /*** If there is a familyProfileID, then commit ***/
        //                trans.Commit();

        //                // and return familyProfileID
        //                return (int)familyProfileID;
        //            }
        //            else
        //            {
        //                /*** If new FamilyProfileID is not generated, then rollback ***/
        //                trans.Rollback();
        //                return null;
        //            }
        //        }
        //        catch
        //        {
        //            trans.Rollback();
        //            return null;
        //        }
        //    }
        //}

        //public async Task<IEnumerable<ClientSearchResults>> Search(ClientName name)
        //{
        //    int systemid = Constant.SystemID;
        //    string fName = (name.FirstName == null || name.FirstName == "") ? "" : name.FirstName;
        //    string lName = (name.LastName == null || name.LastName == "") ? "" : name.LastName;

        //    if (fName == "" && lName == "")
        //        return null;
        //    else
        //    {
        //        IEnumerable<ClientSearchResults> data;

        //        string SQL = SQLClientSearch;
        //        /* TODO - Change SystemID */

        //        if (fName != "")
        //            fName = Function.EncodeForLike(name.FirstName) + "%";

        //        if (fName != "" && lName == "")
        //            SQL += "AND SOUNDEX(@FirstName) = SOUNDEX(p.FirstName)";
        //        else if (fName == "" && lName != "")
        //            SQL += "AND SOUNDEX(@LastName) = SOUNDEX(p.LastName)";
        //        else if (fName != "" && lName != "")
        //            SQL += "AND SOUNDEX(@FirstName) = SOUNDEX(p.FirstName) AND SOUNDEX(@LastName) = SOUNDEX(p.LastName)";

        //        SQL += " ORDER BY p.LastName, p.FirstName";

        //        using (IDbConnection connection = Connection)
        //        {
        //            data = await connection.QueryAsync<ClientSearchResults>(SQL, new { SystemID = systemid, FirstName = fName, LastName = lName });
        //            return data;
        //        }
        //    }
        //}

        ////Overload to pass in parameters from browser
        //public async Task<IEnumerable<ClientSearchResults>> Search(string lastname, string firstname)
        //{
        //    ClientName clientname = new ClientName();
        //    clientname.LastName = lastname;
        //    clientname.FirstName = firstname;

        //    return await Search(clientname);
        //}

        //public IEnumerable<Person> GetAllPersonsWithNoClientProfile()
        //{
        //    using (IDbConnection connection = Connection)
        //    {
        //        var persons = connection.Query<Person, Suffix, Gender, Race, Person>
        //        (SQLPersonsData, (p, s, g, r) =>
        //        {
        //            p.Suffix = s;
        //            p.Gender = g;
        //            p.Race = r;

        //            return p;
        //        }).AsEnumerable();

        //        return persons;
        //    }
        //}

        #endregion

    }
}
