using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DJSCaseMgmtModel.ViewModels
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
