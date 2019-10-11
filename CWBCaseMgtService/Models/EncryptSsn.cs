using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DJSCaseMgtService.Models
{
    public class SsnList
    {
        public int PersonId { get; set; }
        public string SSNs { get; set; }

    }

    public class EncryptSSN
    {
        public IList<SsnList> list { get; set; }

    }
}