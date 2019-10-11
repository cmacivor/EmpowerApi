using DJSCaseMgmtModel.Entities;
using DJSCaseMgtService.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DJSCaseMgtService.DataAccess.Repositories
{
    public class SubContactTypeRepository : BaseRepository<SubContactType>
    {
        public SubContactTypeRepository(DJSCaseMgtContext context) : base(context) { }
    }
}