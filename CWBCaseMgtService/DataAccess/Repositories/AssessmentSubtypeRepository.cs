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
    public class AssessmentSubtypeRepository : BaseRepository<AssessmentSubtype>
    {
        public AssessmentSubtypeRepository(DJSCaseMgtContext context) : base(context) { }
    }
}