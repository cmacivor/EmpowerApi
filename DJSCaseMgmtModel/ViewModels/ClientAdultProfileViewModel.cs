using DJSCaseMgmtModel.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DJSCaseMgmtModel.ViewModels
{
    public class ClientAdultProfileViewModel
    {
        public ClientAdult ClientProfile { get; set; }

        public PersonAdultViewModel Person { get; set; }

        public IEnumerable<Assessment> Assessment { get; set; }

        public IEnumerable<PlacementViewModel> Placement { get; set; }

    }
}