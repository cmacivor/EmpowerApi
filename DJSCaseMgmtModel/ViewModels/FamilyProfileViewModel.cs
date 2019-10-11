using DJSCaseMgmtModel.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DJSCaseMgmtModel.ViewModels
{
    public class FamilyProfileViewModel
    {
        public FamilyProfile FamilyProfile { get; set; }

        public PersonSupplemental PersonSupplemental { get; set; }

        public List<PersonAddress> FamilyPersonAddress { get; set; }
    }
}