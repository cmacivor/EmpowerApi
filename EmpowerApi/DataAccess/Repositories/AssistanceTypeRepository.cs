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
    public class AssistanceTypeRepository : BaseRepository<AssistanceType>
    {
        public AssistanceTypeRepository(DJSCaseMgtContext context) : base(context) { }
    }
}




