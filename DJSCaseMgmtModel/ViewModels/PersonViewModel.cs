using DJSCaseMgmtModel.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DJSCaseMgmtModel.ViewModels
{
    public class PersonViewModel
    {
        public Person Person { get; set; }

        public IEnumerable<PersonAddress> PersonAddress { get; set; }

        public PersonSupplemental PersonSupplemental { get; set; }

        public IEnumerable<FamilyProfileViewModel> FamilyProfile { get; set; }
    }
}