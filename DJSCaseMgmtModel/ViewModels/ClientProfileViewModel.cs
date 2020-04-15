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

        public IEnumerable<EducationLevel> EducationLevels { get; set; }

        public IEnumerable<FundingSource> FundingSources { get; set; }

        public IEnumerable<JobStatus> JobStatuses { get; set; }

        public IEnumerable<MaritalStatus> MaritalStatuses { get; set; }

        public IEnumerable<Gender> Genders { get; set; }

        public IEnumerable<Race> Races { get; set; }

        public IEnumerable<Suffix> Suffixes { get; set; }

    }
}