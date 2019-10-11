using System;
using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgmtModel.Entities
{
    public class Assessment : EntityBase
    {
        public int? ClientProfileID { get; set; }
        public virtual ClientProfile ClientProfile { get; set; }

        public int? StaffID { get; set; }
        public virtual Staff Staff { get; set; }

        public DateTime? AssessmentDate { get; set; }
        
        public int? AssessmentTypeID { get; set; }
        public virtual AssessmentType AssessmentType { get; set; }

        public int? AssessmentSubtypeID { get; set; }
        public virtual AssessmentSubtype AssessmentSubtype { get; set; }

        public string AssessmentScore { get; set; }
        
        public string Notes { get; set; }

        [Required]
        public bool Active { get; set; }

        // Probaly below fields will be removed, need to get the feedback from User
        public string OffenseComments { get; set; }
        
        public string FamilyComments { get; set; }
        
        public string EducationComments { get; set; }
        
        public string PeerComments { get; set; }
        
        public string SubstanceComments { get; set; }
        
        public string BehaviorComments { get; set; }
        
        public string MentalComments { get; set; }
        
        public string CurrentCharge { get; set; }
        
        public string Placement { get; set; }
        
        public string Service { get; set; }
        
        public bool? SocialHistory { get; set; }
        
        public bool? Level1Case { get; set; }
        
        public bool? Level2Case { get; set; }
        
        public string CommentsStrength { get; set; }
        
        public string Source { get; set; }        
        

        
    }
}