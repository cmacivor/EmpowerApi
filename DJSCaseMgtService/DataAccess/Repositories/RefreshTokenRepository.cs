using System;
using DJSCaseMgmtModel.Entities;
using DJSCaseMgtService.Models;
using System.Collections.Generic;
using System.Linq;
using System.Data.Entity;
using System.Web;
using System.Threading.Tasks;

namespace DJSCaseMgtService.DataAccess.Repositories
{
    public class RefreshTokenRepository : BaseRepository<RefreshToken>
    {

        public RefreshTokenRepository(DJSCaseMgtContext context) : base(context) 
        {

        }

    }
}