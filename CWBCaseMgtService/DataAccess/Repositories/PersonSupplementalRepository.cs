using DJSCaseMgmtModel.Entities;
using DJSCaseMgtService.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace DJSCaseMgtService.DataAccess.Repositories
{
    public class PersonSupplementalRepository : BaseRepository<PersonSupplemental>, IPersonSupplementalRepository
    {
        public PersonSupplementalRepository(DJSCaseMgtContext context) : base(context) { }
    }

    public interface IPersonSupplementalRepository : IBaseRepository<PersonSupplemental>
    {

    }
}