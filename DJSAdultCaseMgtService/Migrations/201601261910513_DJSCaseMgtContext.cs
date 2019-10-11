namespace DJSCaseMgtService.Migrations
{
    using System;
    using System.Data.Entity.Migrations;

    public partial class DJSCaseMgtContext : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.AddressType",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    Name = c.String(nullable: false, maxLength: 20),
                    Description = c.String(maxLength: 100),
                    Active = c.Boolean(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID);

            CreateTable(
                "dbo.Application",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    Name = c.String(nullable: false, maxLength: 200),
                    Active = c.Boolean(nullable: false),
                    SystemID = c.Int(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID)
                .ForeignKey("dbo.System", t => t.SystemID, cascadeDelete: true)
                .Index(t => t.SystemID);

            CreateTable(
                "dbo.System",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    Name = c.String(nullable: false),
                    Active = c.Boolean(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID);

            CreateTable(
                "dbo.Assessment",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    ClientProfileID = c.Int(),
                    StaffID = c.Int(),
                    AssessmentDate = c.DateTime(),
                    AssessmentTypeID = c.Int(),
                    AssessmentSubtypeID = c.Int(),
                    AssessmentScore = c.String(),
                    Notes = c.String(),
                    Active = c.Boolean(nullable: false),
                    OffenseComments = c.String(),
                    FamilyComments = c.String(),
                    EducationComments = c.String(),
                    PeerComments = c.String(),
                    SubstanceComments = c.String(),
                    BehaviorComments = c.String(),
                    MentalComments = c.String(),
                    CurrentCharge = c.String(),
                    Placement = c.String(),
                    Service = c.String(),
                    SocialHistory = c.Boolean(),
                    Level1Case = c.Boolean(),
                    Level2Case = c.Boolean(),
                    CommentsStrength = c.String(),
                    Source = c.String(),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID)
                .ForeignKey("dbo.AssessmentSubtype", t => t.AssessmentSubtypeID)
                .ForeignKey("dbo.AssessmentType", t => t.AssessmentTypeID)
                .ForeignKey("dbo.ClientProfile", t => t.ClientProfileID)
                .ForeignKey("dbo.Staff", t => t.StaffID)
                .Index(t => t.ClientProfileID)
                .Index(t => t.StaffID)
                .Index(t => t.AssessmentTypeID)
                .Index(t => t.AssessmentSubtypeID);

            CreateTable(
                "dbo.AssessmentSubtype",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    Name = c.String(nullable: false, maxLength: 100),
                    Description = c.String(maxLength: 200),
                    Active = c.Boolean(nullable: false),
                    SystemID = c.Int(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID);

            CreateTable(
                "dbo.AssessmentType",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    Name = c.String(nullable: false, maxLength: 100),
                    Description = c.String(maxLength: 200),
                    Active = c.Boolean(nullable: false),
                    SystemID = c.Int(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID);

            CreateTable(
                "dbo.ClientProfile",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    PersonID = c.Int(nullable: false),
                    Active = c.Boolean(nullable: false),
                    SystemID = c.Int(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID)
                .ForeignKey("dbo.Person", t => t.PersonID, cascadeDelete: true)
                .ForeignKey("dbo.System", t => t.SystemID, cascadeDelete: true)
                .Index(t => t.PersonID)
                .Index(t => t.SystemID);

            CreateTable(
                "dbo.Person",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    LastName = c.String(nullable: false, maxLength: 50),
                    FirstName = c.String(nullable: false, maxLength: 50),
                    MiddleName = c.String(maxLength: 50),
                    SuffixID = c.Int(),
                    JTS = c.String(),
                    DOB = c.DateTime(),
                    RaceID = c.Int(),
                    GenderID = c.Int(),
                    SSN = c.String(),
                    SSNID = c.Byte(nullable: false),
                    ICN = c.String(),
                    Active = c.Boolean(nullable: false),
                    UniqueID = c.String(),
                    tempFamilyProfileId = c.Int(),
                    tempAddrID = c.Int(),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID)
                .ForeignKey("dbo.Gender", t => t.GenderID)
                .ForeignKey("dbo.Race", t => t.RaceID)
                .ForeignKey("dbo.Suffix", t => t.SuffixID)
                .Index(t => t.SuffixID)
                .Index(t => t.RaceID)
                .Index(t => t.GenderID);

            CreateTable(
                "dbo.Gender",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    Name = c.String(nullable: false, maxLength: 10),
                    Description = c.String(maxLength: 100),
                    Active = c.Boolean(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID);

            CreateTable(
                "dbo.Race",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    Name = c.String(nullable: false, maxLength: 2),
                    Description = c.String(maxLength: 200),
                    Active = c.Boolean(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID);

            CreateTable(
                "dbo.Suffix",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    Name = c.String(nullable: false, maxLength: 25),
                    Description = c.String(maxLength: 50),
                    Active = c.Boolean(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID);

            CreateTable(
                "dbo.Staff",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    Agency = c.String(),
                    LastName = c.String(),
                    FirstName = c.String(),
                    NetLogin = c.String(),
                    Password = c.String(),
                    JobTitleID = c.Int(),
                    Phone = c.String(),
                    Fax = c.String(),
                    EMail = c.String(),
                    Department = c.String(),
                    OfficeLocation = c.String(),
                    NetworkConnection = c.String(),
                    AccessLevelReq = c.String(),
                    SQLRole = c.String(),
                    HireDate = c.DateTime(),
                    TerminationDate = c.DateTime(),
                    RestrictLevel = c.String(),
                    Supervisor = c.String(),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID)
                .ForeignKey("dbo.JobTitle", t => t.JobTitleID)
                .Index(t => t.JobTitleID);

            CreateTable(
                "dbo.JobTitle",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    Name = c.String(nullable: false, maxLength: 100),
                    Description = c.String(maxLength: 50),
                    Active = c.Boolean(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID);

            CreateTable(
                "dbo.Client",
                c => new
                {
                    Id = c.String(nullable: false, maxLength: 128),
                    Secret = c.String(nullable: false),
                    Name = c.String(nullable: false, maxLength: 100),
                    ApplicationType = c.Int(nullable: false),
                    Active = c.Boolean(nullable: false),
                    RefreshTokenLifeTime = c.Int(nullable: false),
                    AllowedOrigin = c.String(maxLength: 100),
                })
                .PrimaryKey(t => t.Id);

            CreateTable(
                "dbo.Document",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    Name = c.String(nullable: false, maxLength: 100),
                    FileName = c.String(nullable: false, maxLength: 100),
                    Description = c.String(maxLength: 200),
                    Active = c.Boolean(nullable: false),
                    SystemID = c.Int(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID);

            CreateTable(
                "dbo.EducationLevel",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    Name = c.String(nullable: false, maxLength: 35),
                    Description = c.String(maxLength: 50),
                    Active = c.Boolean(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID);

            CreateTable(
                "dbo.Enrollment",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    PlacementID = c.Int(nullable: false),
                    ReferralDate = c.DateTime(),
                    ServiceProgramCategoryID = c.Int(),
                    SourceID = c.Int(),
                    BasisofReferral = c.String(),
                    Comments = c.String(),
                    SuppComments = c.String(),
                    BeginDate = c.DateTime(),
                    EndDate = c.DateTime(),
                    Outcome = c.String(),
                    ServiceOutcomeID = c.Int(),
                    ServiceReleaseID = c.Int(),
                    CounselorID = c.Int(),
                    SourceNotes = c.String(),
                    MonitorOption = c.String(),
                    ComHoursAssigned = c.Int(),
                    Active = c.Boolean(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID)
                .ForeignKey("dbo.Staff", t => t.CounselorID)
                .ForeignKey("dbo.ServiceOutcome", t => t.ServiceOutcomeID)
                .ForeignKey("dbo.ServiceProgramCategory", t => t.ServiceProgramCategoryID)
                .ForeignKey("dbo.ServiceRelease", t => t.ServiceReleaseID)
                .ForeignKey("dbo.Staff", t => t.SourceID)
                .Index(t => t.ServiceProgramCategoryID)
                .Index(t => t.SourceID)
                .Index(t => t.ServiceOutcomeID)
                .Index(t => t.ServiceReleaseID)
                .Index(t => t.CounselorID);

            CreateTable(
                "dbo.ServiceOutcome",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    Name = c.String(nullable: false, maxLength: 100),
                    Description = c.String(maxLength: 200),
                    Active = c.Boolean(nullable: false),
                    SystemID = c.Int(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID);

            CreateTable(
                "dbo.ServiceProgramCategory",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    ServiceProgramID = c.Int(nullable: false),
                    ServiceCategoryID = c.Int(),
                    Active = c.Boolean(nullable: false),
                    SystemID = c.Int(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID)
                .ForeignKey("dbo.ServiceCategory", t => t.ServiceCategoryID)
                .ForeignKey("dbo.ServiceProgram", t => t.ServiceProgramID, cascadeDelete: true)
                .Index(t => t.ServiceProgramID)
                .Index(t => t.ServiceCategoryID);

            CreateTable(
                "dbo.ServiceCategory",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    Name = c.String(nullable: false, maxLength: 100),
                    Description = c.String(maxLength: 200),
                    Active = c.Boolean(nullable: false),
                    SystemID = c.Int(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID);

            CreateTable(
                "dbo.ServiceProgram",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    Name = c.String(nullable: false, maxLength: 100),
                    ServiceProviderID = c.Int(),
                    Active = c.Boolean(nullable: false),
                    SystemID = c.Int(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID)
                .ForeignKey("dbo.ServiceProvider", t => t.ServiceProviderID)
                .Index(t => t.ServiceProviderID);

            CreateTable(
                "dbo.ServiceProvider",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    Name = c.String(nullable: false, maxLength: 100),
                    Description = c.String(maxLength: 200),
                    Active = c.Boolean(nullable: false),
                    SystemID = c.Int(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID);

            CreateTable(
                "dbo.ServiceRelease",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    Name = c.String(nullable: false, maxLength: 100),
                    Description = c.String(),
                    ExcludeFromEnrollmentCount = c.Boolean(nullable: false),
                    Active = c.Boolean(nullable: false),
                    SystemID = c.Int(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID);

            CreateTable(
                "dbo.ContactType",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    Name = c.String(nullable: false),
                    Description = c.String(maxLength: 100),
                    Active = c.Boolean(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID);

            CreateTable(
                "dbo.FamilyProfile",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    ClientProfilePersonID = c.Int(nullable: false),
                    FamilyMemberID = c.Int(nullable: false),
                    RelationshipID = c.Int(nullable: false),
                    PrimaryContactFlag = c.Boolean(),
                    Active = c.Boolean(),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID)
                .ForeignKey("dbo.Person", t => t.FamilyMemberID, cascadeDelete: true)
                .ForeignKey("dbo.Relationship", t => t.RelationshipID, cascadeDelete: true)
                .Index(t => t.FamilyMemberID)
                .Index(t => t.RelationshipID);

            CreateTable(
                "dbo.Relationship",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    Name = c.String(nullable: false, maxLength: 2),
                    Description = c.String(nullable: false, maxLength: 50),
                    Active = c.Boolean(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID);

            CreateTable(
                "dbo.JobStatus",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    Name = c.String(nullable: false, maxLength: 25),
                    Description = c.String(maxLength: 50),
                    Active = c.Boolean(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID);

            CreateTable(
                "dbo.Judge",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    Name = c.String(nullable: false, maxLength: 50),
                    Description = c.String(maxLength: 50),
                    Active = c.Boolean(nullable: false),
                    SystemID = c.Int(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID);

            CreateTable(
                "dbo.Login",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    FirstName = c.String(nullable: false),
                    LastName = c.String(nullable: false),
                    MiddleName = c.String(),
                    Email = c.String(),
                    JobTitleID = c.Int(),
                    Department = c.String(),
                    Agency = c.String(),
                    PhoneNumber = c.String(),
                    FaxNumber = c.String(),
                    OfficeLocation = c.String(),
                    Active = c.Boolean(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID)
                .ForeignKey("dbo.JobTitle", t => t.JobTitleID)
                .Index(t => t.JobTitleID);

            CreateTable(
                "dbo.LoginDomain",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    Name = c.String(nullable: false, maxLength: 20),
                    Active = c.Boolean(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID);

            CreateTable(
                "dbo.LoginProfile",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    ApplicationID = c.Int(nullable: false),
                    LoginID = c.Int(nullable: false),
                    LoginRoleID = c.Int(nullable: false),
                    LoginDomainID = c.Int(nullable: false),
                    AccountName = c.String(),
                    Password = c.Binary(),
                    Active = c.Boolean(nullable: false),
                    SystemID = c.Int(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID)
                .ForeignKey("dbo.Application", t => t.ApplicationID, cascadeDelete: true)
                .ForeignKey("dbo.Login", t => t.LoginID, cascadeDelete: true)
                .ForeignKey("dbo.LoginDomain", t => t.LoginDomainID, cascadeDelete: true)
                .ForeignKey("dbo.LoginRole", t => t.LoginRoleID, cascadeDelete: true)
                .Index(t => t.ApplicationID)
                .Index(t => t.LoginID)
                .Index(t => t.LoginRoleID)
                .Index(t => t.LoginDomainID);

            CreateTable(
                "dbo.LoginRole",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    Name = c.String(nullable: false, maxLength: 50),
                    Description = c.String(maxLength: 500),
                    Active = c.Boolean(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID);

            CreateTable(
                "dbo.MaritalStatus",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    Name = c.String(nullable: false, maxLength: 25),
                    Description = c.String(maxLength: 50),
                    Active = c.Boolean(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID);

            CreateTable(
                "dbo.Offense",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    Name = c.String(nullable: false, maxLength: 255),
                    DYFS = c.String(),
                    VCCCode = c.String(),
                    GeneralHeading = c.String(),
                    Type = c.String(),
                    Description = c.String(),
                    Statute = c.String(),
                    Active = c.Boolean(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID);

            CreateTable(
                "dbo.PersonAddress",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    PersonID = c.Int(nullable: false),
                    AddressTypeID = c.Int(nullable: false),
                    GISCode = c.String(),
                    Latitude = c.Decimal(precision: 18, scale: 2),
                    Longitude = c.Decimal(precision: 18, scale: 2),
                    AddressLineOne = c.String(),
                    AddressLineTwo = c.String(),
                    City = c.String(),
                    State = c.String(),
                    Zip = c.String(),
                    POBox = c.String(),
                    Comments = c.String(),
                    Active = c.Boolean(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID)
                .ForeignKey("dbo.AddressType", t => t.AddressTypeID, cascadeDelete: true)
                .ForeignKey("dbo.Person", t => t.PersonID, cascadeDelete: true)
                .Index(t => t.PersonID)
                .Index(t => t.AddressTypeID);

            CreateTable(
                "dbo.PersonSupplemental",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    PersonID = c.Int(nullable: false),
                    DocketNumber = c.String(),
                    POB = c.String(),
                    CourtRecord = c.String(),
                    MaritalStatusID = c.Int(),
                    JobStatusID = c.Int(),
                    Employer = c.String(),
                    HomePhone = c.String(),
                    WorkPhone = c.String(),
                    OtherPhone = c.String(),
                    BVCS = c.String(),
                    HeightFt = c.String(),
                    HeightIn = c.String(),
                    Weight = c.String(),
                    HairColor = c.String(),
                    EyeColor = c.String(),
                    HasMedicaid = c.Boolean(),
                    HasInsurance = c.Boolean(),
                    SchoolID = c.Int(),
                    EducID = c.Int(),
                    EducationLevelID = c.Int(),
                    SchoolYr = c.String(),
                    HasExceptionEduc = c.Boolean(),
                    HasDriversLicense = c.Boolean(),
                    OtherAgencyContacts = c.String(),
                    PhysicalHealth = c.String(),
                    MentalHealth = c.String(),
                    SubstanceAbuse = c.String(),
                    XRefJuv = c.Int(),
                    Comments = c.String(),
                    WorkPhoneExt = c.String(),
                    OtherPhoneExt = c.String(),
                    Income = c.String(),
                    HobbiesInterests = c.String(),
                    Active = c.Boolean(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID)
                .ForeignKey("dbo.EducationLevel", t => t.EducationLevelID)
                .ForeignKey("dbo.JobStatus", t => t.JobStatusID)
                .ForeignKey("dbo.MaritalStatus", t => t.MaritalStatusID)
                .ForeignKey("dbo.Person", t => t.PersonID, cascadeDelete: true)
                .ForeignKey("dbo.School", t => t.SchoolID)
                .Index(t => t.PersonID)
                .Index(t => t.MaritalStatusID)
                .Index(t => t.JobStatusID)
                .Index(t => t.SchoolID)
                .Index(t => t.EducationLevelID);

            CreateTable(
                "dbo.School",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    Name = c.String(nullable: false, maxLength: 50),
                    Phone = c.String(maxLength: 25),
                    Principal = c.String(maxLength: 50),
                    Address = c.String(maxLength: 255),
                    Zip = c.String(maxLength: 50),
                    Fax = c.String(maxLength: 25),
                    EducationLevel = c.String(),
                    SchoolCode = c.String(),
                    Active = c.Boolean(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID);

            CreateTable(
                "dbo.Placement",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    ClientProfileID = c.Int(nullable: false),
                    JudgeID = c.Int(),
                    CourtOrderDate = c.DateTime(),
                    NextCourtDate = c.DateTime(),
                    CourtOrderNarrative = c.String(),
                    PlacementLevelID = c.Int(),
                    Active = c.Boolean(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID)
                .ForeignKey("dbo.Judge", t => t.JudgeID)
                .ForeignKey("dbo.PlacementLevel", t => t.PlacementLevelID)
                .Index(t => t.JudgeID)
                .Index(t => t.PlacementLevelID);

            CreateTable(
                "dbo.PlacementLevel",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    Name = c.String(nullable: false, maxLength: 100),
                    Description = c.String(maxLength: 200),
                    Active = c.Boolean(nullable: false),
                    SystemID = c.Int(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID);

            CreateTable(
                "dbo.PlacementOffense",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    PlacementID = c.Int(nullable: false),
                    OffenseID = c.Int(nullable: false),
                    Active = c.Boolean(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID)
                .ForeignKey("dbo.Offense", t => t.OffenseID, cascadeDelete: true)
                .ForeignKey("dbo.Placement", t => t.PlacementID, cascadeDelete: true)
                .Index(t => t.PlacementID)
                .Index(t => t.OffenseID);

            CreateTable(
                "dbo.ProgressNote",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    EnrollmentID = c.Int(nullable: false),
                    CommentDate = c.DateTime(nullable: false),
                    Comment = c.String(),
                    ContactTypeID = c.Int(),
                    Duration = c.String(),
                    Active = c.Boolean(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID)
                .ForeignKey("dbo.ContactType", t => t.ContactTypeID)
                .ForeignKey("dbo.Enrollment", t => t.EnrollmentID, cascadeDelete: true)
                .Index(t => t.EnrollmentID)
                .Index(t => t.ContactTypeID);

            CreateTable(
                "dbo.RefreshToken",
                c => new
                {
                    Id = c.String(nullable: false, maxLength: 128),
                    Subject = c.String(nullable: false, maxLength: 50),
                    ClientId = c.String(nullable: false, maxLength: 50),
                    IssuedUtc = c.DateTime(nullable: false),
                    ExpiresUtc = c.DateTime(nullable: false),
                    ProtectedTicket = c.String(nullable: false),
                })
                .PrimaryKey(t => t.Id);

            CreateTable(
                "dbo.ServiceUnit",
                c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    EnrollmentID = c.Int(nullable: false),
                    Year = c.Int(nullable: false),
                    Month = c.Int(nullable: false),
                    Units = c.Int(nullable: false),
                    Active = c.Boolean(nullable: false),
                    SystemID = c.Int(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                    CreatedBy = c.Int(nullable: false),
                    UpdatedDate = c.DateTime(nullable: false),
                    UpdatedBy = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.ID)
                .ForeignKey("dbo.Enrollment", t => t.EnrollmentID, cascadeDelete: true)
                .Index(t => t.EnrollmentID);

        }

        public override void Down()
        {
            DropForeignKey("dbo.ServiceUnit", "EnrollmentID", "dbo.Enrollment");
            DropForeignKey("dbo.ProgressNote", "EnrollmentID", "dbo.Enrollment");
            DropForeignKey("dbo.ProgressNote", "ContactTypeID", "dbo.ContactType");
            DropForeignKey("dbo.PlacementOffense", "PlacementID", "dbo.Placement");
            DropForeignKey("dbo.PlacementOffense", "OffenseID", "dbo.Offense");
            DropForeignKey("dbo.Placement", "PlacementLevelID", "dbo.PlacementLevel");
            DropForeignKey("dbo.Placement", "JudgeID", "dbo.Judge");
            DropForeignKey("dbo.PersonSupplemental", "SchoolID", "dbo.School");
            DropForeignKey("dbo.PersonSupplemental", "PersonID", "dbo.Person");
            DropForeignKey("dbo.PersonSupplemental", "MaritalStatusID", "dbo.MaritalStatus");
            DropForeignKey("dbo.PersonSupplemental", "JobStatusID", "dbo.JobStatus");
            DropForeignKey("dbo.PersonSupplemental", "EducationLevelID", "dbo.EducationLevel");
            DropForeignKey("dbo.PersonAddress", "PersonID", "dbo.Person");
            DropForeignKey("dbo.PersonAddress", "AddressTypeID", "dbo.AddressType");
            DropForeignKey("dbo.LoginProfile", "LoginRoleID", "dbo.LoginRole");
            DropForeignKey("dbo.LoginProfile", "LoginDomainID", "dbo.LoginDomain");
            DropForeignKey("dbo.LoginProfile", "LoginID", "dbo.Login");
            DropForeignKey("dbo.LoginProfile", "ApplicationID", "dbo.Application");
            DropForeignKey("dbo.Login", "JobTitleID", "dbo.JobTitle");
            DropForeignKey("dbo.FamilyProfile", "RelationshipID", "dbo.Relationship");
            DropForeignKey("dbo.FamilyProfile", "FamilyMemberID", "dbo.Person");
            DropForeignKey("dbo.Enrollment", "SourceID", "dbo.Staff");
            DropForeignKey("dbo.Enrollment", "ServiceReleaseID", "dbo.ServiceRelease");
            DropForeignKey("dbo.Enrollment", "ServiceProgramCategoryID", "dbo.ServiceProgramCategory");
            DropForeignKey("dbo.ServiceProgramCategory", "ServiceProgramID", "dbo.ServiceProgram");
            DropForeignKey("dbo.ServiceProgram", "ServiceProviderID", "dbo.ServiceProvider");
            DropForeignKey("dbo.ServiceProgramCategory", "ServiceCategoryID", "dbo.ServiceCategory");
            DropForeignKey("dbo.Enrollment", "ServiceOutcomeID", "dbo.ServiceOutcome");
            DropForeignKey("dbo.Enrollment", "CounselorID", "dbo.Staff");
            DropForeignKey("dbo.Assessment", "StaffID", "dbo.Staff");
            DropForeignKey("dbo.Staff", "JobTitleID", "dbo.JobTitle");
            DropForeignKey("dbo.Assessment", "ClientProfileID", "dbo.ClientProfile");
            DropForeignKey("dbo.ClientProfile", "SystemID", "dbo.System");
            DropForeignKey("dbo.ClientProfile", "PersonID", "dbo.Person");
            DropForeignKey("dbo.Person", "SuffixID", "dbo.Suffix");
            DropForeignKey("dbo.Person", "RaceID", "dbo.Race");
            DropForeignKey("dbo.Person", "GenderID", "dbo.Gender");
            DropForeignKey("dbo.Assessment", "AssessmentTypeID", "dbo.AssessmentType");
            DropForeignKey("dbo.Assessment", "AssessmentSubtypeID", "dbo.AssessmentSubtype");
            DropForeignKey("dbo.Application", "SystemID", "dbo.System");
            DropIndex("dbo.ServiceUnit", new[] { "EnrollmentID" });
            DropIndex("dbo.ProgressNote", new[] { "ContactTypeID" });
            DropIndex("dbo.ProgressNote", new[] { "EnrollmentID" });
            DropIndex("dbo.PlacementOffense", new[] { "OffenseID" });
            DropIndex("dbo.PlacementOffense", new[] { "PlacementID" });
            DropIndex("dbo.Placement", new[] { "PlacementLevelID" });
            DropIndex("dbo.Placement", new[] { "JudgeID" });
            DropIndex("dbo.PersonSupplemental", new[] { "EducationLevelID" });
            DropIndex("dbo.PersonSupplemental", new[] { "SchoolID" });
            DropIndex("dbo.PersonSupplemental", new[] { "JobStatusID" });
            DropIndex("dbo.PersonSupplemental", new[] { "MaritalStatusID" });
            DropIndex("dbo.PersonSupplemental", new[] { "PersonID" });
            DropIndex("dbo.PersonAddress", new[] { "AddressTypeID" });
            DropIndex("dbo.PersonAddress", new[] { "PersonID" });
            DropIndex("dbo.LoginProfile", new[] { "LoginDomainID" });
            DropIndex("dbo.LoginProfile", new[] { "LoginRoleID" });
            DropIndex("dbo.LoginProfile", new[] { "LoginID" });
            DropIndex("dbo.LoginProfile", new[] { "ApplicationID" });
            DropIndex("dbo.Login", new[] { "JobTitleID" });
            DropIndex("dbo.FamilyProfile", new[] { "RelationshipID" });
            DropIndex("dbo.FamilyProfile", new[] { "FamilyMemberID" });
            DropIndex("dbo.ServiceProgram", new[] { "ServiceProviderID" });
            DropIndex("dbo.ServiceProgramCategory", new[] { "ServiceCategoryID" });
            DropIndex("dbo.ServiceProgramCategory", new[] { "ServiceProgramID" });
            DropIndex("dbo.Enrollment", new[] { "CounselorID" });
            DropIndex("dbo.Enrollment", new[] { "ServiceReleaseID" });
            DropIndex("dbo.Enrollment", new[] { "ServiceOutcomeID" });
            DropIndex("dbo.Enrollment", new[] { "SourceID" });
            DropIndex("dbo.Enrollment", new[] { "ServiceProgramCategoryID" });
            DropIndex("dbo.Staff", new[] { "JobTitleID" });
            DropIndex("dbo.Person", new[] { "GenderID" });
            DropIndex("dbo.Person", new[] { "RaceID" });
            DropIndex("dbo.Person", new[] { "SuffixID" });
            DropIndex("dbo.ClientProfile", new[] { "SystemID" });
            DropIndex("dbo.ClientProfile", new[] { "PersonID" });
            DropIndex("dbo.Assessment", new[] { "AssessmentSubtypeID" });
            DropIndex("dbo.Assessment", new[] { "AssessmentTypeID" });
            DropIndex("dbo.Assessment", new[] { "StaffID" });
            DropIndex("dbo.Assessment", new[] { "ClientProfileID" });
            DropIndex("dbo.Application", new[] { "SystemID" });
            DropTable("dbo.ServiceUnit");
            DropTable("dbo.RefreshToken");
            DropTable("dbo.ProgressNote");
            DropTable("dbo.PlacementOffense");
            DropTable("dbo.PlacementLevel");
            DropTable("dbo.Placement");
            DropTable("dbo.School");
            DropTable("dbo.PersonSupplemental");
            DropTable("dbo.PersonAddress");
            DropTable("dbo.Offense");
            DropTable("dbo.MaritalStatus");
            DropTable("dbo.LoginRole");
            DropTable("dbo.LoginProfile");
            DropTable("dbo.LoginDomain");
            DropTable("dbo.Login");
            DropTable("dbo.Judge");
            DropTable("dbo.JobStatus");
            DropTable("dbo.Relationship");
            DropTable("dbo.FamilyProfile");
            DropTable("dbo.ContactType");
            DropTable("dbo.ServiceRelease");
            DropTable("dbo.ServiceProvider");
            DropTable("dbo.ServiceProgram");
            DropTable("dbo.ServiceCategory");
            DropTable("dbo.ServiceProgramCategory");
            DropTable("dbo.ServiceOutcome");
            DropTable("dbo.Enrollment");
            DropTable("dbo.EducationLevel");
            DropTable("dbo.Document");
            DropTable("dbo.Client");
            DropTable("dbo.JobTitle");
            DropTable("dbo.Staff");
            DropTable("dbo.Suffix");
            DropTable("dbo.Race");
            DropTable("dbo.Gender");
            DropTable("dbo.Person");
            DropTable("dbo.ClientProfile");
            DropTable("dbo.AssessmentType");
            DropTable("dbo.AssessmentSubtype");
            DropTable("dbo.Assessment");
            DropTable("dbo.System");
            DropTable("dbo.Application");
            DropTable("dbo.AddressType");
        }
    }
}
