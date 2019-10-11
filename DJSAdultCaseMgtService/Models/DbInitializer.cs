using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace DJSCaseMgtService.Models
{
    public class DbInitializer : DropCreateDatabaseIfModelChanges<DJSCaseMgtContext>
    {
        protected override void Seed(DJSCaseMgtContext context)
        {
            context.SaveChanges();
        } 
    }
}