using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DJSCaseMgtService.Models
{
    public class Uniqids
    {
        public int PersonId { get; set; }
        public string UniqueId { get; set; }
    }

    public class UniqidsReq
    {
        public IList<Uniqids> list { get; set; }
       
    }
}