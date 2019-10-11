using DJSCaseMgmtModel.Entities;
using DJSCaseMgtService.oAuth;

using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace DJSCaseMgtService.oAuth
{
    public class AuthContext : IdentityDbContext<IdentityUser>
    {
        public AuthContext()
            : base(ConfigurationManager.ConnectionStrings["DJSCaseMgtContext"].ConnectionString)
        {
     
        }

        public DbSet<Client> Client { get; set; }
        public DbSet<RefreshToken> RefreshTokens { get; set; }
    }

}