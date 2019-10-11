using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using DJSCaseMgmtModel.Entities;
using System.Data.Entity.ModelConfiguration.Conventions;
using System.Data.Entity.Infrastructure;
using System.Configuration;
using Microsoft.AspNet.Identity.EntityFramework;

namespace DJSCaseMgtService.Models
{
    //public class DJSCaseMgtContext : IdentityDbContext<IdentityUser>
    public class DJSCaseMgtContext :DbContext
    {
        public DJSCaseMgtContext()
            : base(ConfigurationManager.ConnectionStrings["DJSCaseMgtContext"].ConnectionString)
        {
            //Database.Initialize(false);            
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)

        {
            modelBuilder.Entity<Enrollment>().HasRequired(m => m.Source).WithMany();
            modelBuilder.Entity<Enrollment>().HasRequired(m => m.Counselor).WithMany();
            // base.OnModelCreating(modelBuilder);
            modelBuilder.Conventions.Remove<PluralizingTableNameConvention>();

            //modelBuilder.Entity<Person>()
            //    .HasOptional(p => p.PersonSupplemental)
            //    .WithRequired(ps => ps.Person);
        }
        public System.Data.Entity.DbSet<AspNetUsers> AspNetUsers { get; set; }
        public System.Data.Entity.DbSet<AddressType> AddressType { get; set; }
        public System.Data.Entity.DbSet<Application> Application { get; set; }
        public System.Data.Entity.DbSet<Assessment> Assessment { get; set; }
        public System.Data.Entity.DbSet<AssessmentSubtype> AssessmentSubtype { get; set; }
        public System.Data.Entity.DbSet<AssessmentType> AssessmentType { get; set; }
        public System.Data.Entity.DbSet<ClientProfile> ClientProfile { get; set; }
        public System.Data.Entity.DbSet<ContactType> ContactType { get; set; }
        public System.Data.Entity.DbSet<SubContactType> SubContactType { get; set; }
        public System.Data.Entity.DbSet<Document> Document { get; set; }        
        public System.Data.Entity.DbSet<EducationLevel> EducationLevel { get; set; }
        public System.Data.Entity.DbSet<Enrollment> Enrollment { get; set; }
        public System.Data.Entity.DbSet<FamilyProfile> FamilyProfile { get; set; }
        public System.Data.Entity.DbSet<Gender> Gender { get; set; }
        public System.Data.Entity.DbSet<JobStatus> JobStatus { get; set; }
        public System.Data.Entity.DbSet<JobTitle> JobTitle { get; set; }
        public System.Data.Entity.DbSet<Judge> Judge { get; set; }
        public System.Data.Entity.DbSet<Login> Login { get; set; }
        public System.Data.Entity.DbSet<LoginDomain> LoginDomain { get; set; }
        public System.Data.Entity.DbSet<LoginProfile> LoginProfile { get; set; }
        public System.Data.Entity.DbSet<LoginRole> LoginRole { get; set; }
        public System.Data.Entity.DbSet<MaritalStatus> MaritalStatus { get; set; }
        public System.Data.Entity.DbSet<Offense> Offense { get; set; }
        public System.Data.Entity.DbSet<Person> Person { get; set; }
        public System.Data.Entity.DbSet<PersonAddress> PersonAddress { get; set; }
        public System.Data.Entity.DbSet<PersonSupplemental> PersonSupplemental { get; set; }
        public System.Data.Entity.DbSet<Placement> Placement { get; set; }
        public System.Data.Entity.DbSet<PlacementLevel> PlacementLevel { get; set; }
        public System.Data.Entity.DbSet<PlacementOffense> PlacementOffense { get; set; }
        public System.Data.Entity.DbSet<ProgressNote> ProgressNote { get; set; }
        public System.Data.Entity.DbSet<Race> Race { get; set; }
        public System.Data.Entity.DbSet<Relationship> Relationship { get; set; }
        // Sanction Incentives - Need to check the table name
        public System.Data.Entity.DbSet<School> School { get; set; }
        public System.Data.Entity.DbSet<ServiceCategory> ServiceCategory { get; set; }
        public System.Data.Entity.DbSet<ServiceOutcome> ServiceOutcome { get; set; }
        public System.Data.Entity.DbSet<ServiceProgram> ServiceProgram { get; set; }
        public System.Data.Entity.DbSet<ServiceProgramCategory> ServiceProgramCategory { get; set; }
        public System.Data.Entity.DbSet<ServiceProvider> ServiceProvider { get; set; }
        public System.Data.Entity.DbSet<ServiceRelease> ServiceRelease { get; set; }
        public System.Data.Entity.DbSet<ServiceUnit> ServiceUnit { get; set; }
        public System.Data.Entity.DbSet<Staff> Staff { get; set; }
        public System.Data.Entity.DbSet<Suffix> Suffix { get; set; }
        public System.Data.Entity.DbSet<Client> Clients { get; set; }
        public System.Data.Entity.DbSet<RefreshToken> RefreshTokens { get; set; }
        public System.Data.Entity.DbSet<UserModel> UserModel { get; set; }
        
        public System.Data.Entity.DbSet<DJSCaseMgmtModel.Entities.System> System { get; set; }
        public object ApplicationUsers { get; internal set; }
        // Role Access
    }
}
