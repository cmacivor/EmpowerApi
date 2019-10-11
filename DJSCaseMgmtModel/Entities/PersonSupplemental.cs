using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System;
using System.Collections.Generic;

namespace DJSCaseMgmtModel.Entities
{
    public class PersonSupplemental : EntityBase
    {
        public int PersonID { get; set; }
        public virtual Person Person { get; set; }
        
        public string DocketNumber { get; set; }
        
        public string POB { get; set; }
        
        public string CourtRecord { get; set; }
        
        public int? MaritalStatusID { get; set; }
        public virtual MaritalStatus MaritalStatus { get; set; }
        
        public int? JobStatusID { get; set; }
        public virtual JobStatus JobStatus { get; set; }
        
        public string Employer { get; set; }
        
        public string HomePhone { get; set; }
        
        public string WorkPhone { get; set; }
        
        public string OtherPhone { get; set; }
        
        public string BVCS { get; set; }
        
        public string HeightFt { get; set; }
        
        public string HeightIn { get; set; }
        
        public string Weight { get; set; }
        
        public string HairColor { get; set; }
        
        public string EyeColor { get; set; }
        
        public bool? HasMedicaid { get; set; }
        
        public bool? HasInsurance { get; set; }
        

        public int? SchoolID { get; set; }
        public virtual School School { get; set; }
        
        public int? EducID { get; set; }
        
        public int? EducationLevelID { get; set; }
        public virtual EducationLevel EducationLevel { get; set; }
        
        public string SchoolYr { get; set; }
        
        public bool? HasExceptionEduc { get; set; }
        
        public bool? HasDriversLicense { get; set; }
        
        public string OtherAgencyContacts { get; set; }
        
        public string PhysicalHealth { get; set; }
        
        public string MentalHealth { get; set; }
        
        public string SubstanceAbuse { get; set; }
        
        public int? XRefJuv { get; set; }
        
        public string Comments { get; set; }
        
        public string WorkPhoneExt { get; set; }
        
        public string OtherPhoneExt { get; set; }
        
        public string Income { get; set; }        
        
        public string HobbiesInterests { get; set; }

        public string Language { get; set; }
        public bool? HasInterpreter { get; set; }
        public bool? HasEmergencyContactNo { get; set; }

        [Required]
        public bool Active { get; set; }

        public string IDType { get; set;}

        public string IDNumber { get; set; }

        public DateTime? IssueDate { get; set; }

        public DateTime? ExpirationDate { get; set; }

        public string ScarMarks { get; set; }

        public bool? IsDisable { get; set; }

        public string LivingSituation { get; set; }

        public string HighestEducation { get; set; }

        public string StudentStatus { get; set; }

        public string Supervisor { get; set; }

        public string JobTitle { get; set; }

        public string HoursPerWeek { get; set; }

        public string EmployerAddress { get; set; }

        public string EmployerAddressCity { get; set; }

        public string EmployerAddressZip { get; set; }

        public string EmployerAddressState { get; set; }
        public string FundingSrc { get; set; }
        public int? FundingSourceID { get; set; }
        public virtual FundingSource FundingSource { get; set; }

      
        //public int? CarrerStationID { get; set; }
        
       // public virtual CarrerStation CarrerStation { get; set; }

        
        public string CareerSt { get; set;}

        public bool? HasConvictedFelony { get; set; }

        public bool? HasConvictedOffence { get; set; }

        public bool? HasConvictedCrimeIntegrity { get; set; }

        public bool? HasConvictedMisdemeanor { get; set; }

        public bool? HasVehicle { get; set; }

        public bool? HasFHH { get; set; }
        public string HouseholdIncome { get; set; }
        public string HouseholdSize { get; set; }



    }
}