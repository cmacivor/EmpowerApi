using DJSCaseMgmtModel.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DJSCaseMgmtModel.ViewModels
{
    public class ClientProfileViewModel
    {
        public ClientProfile ClientProfile { get; set; }

        public PersonViewModel Person { get; set; }

        public IEnumerable<Assessment> Assessment { get; set; }

        public IEnumerable<PlacementViewModel> Placement { get; set; }

    }
}