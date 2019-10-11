use JusticeServices 
go

ALTER TABLE [dbo].[Staff] DROP CONSTRAINT [FK_dbo.Staff_dbo.JobTitle_JobTitleID]
GO
ALTER TABLE [dbo].[ServiceUnit] DROP CONSTRAINT [FK_dbo.ServiceUnit_dbo.Enrollment_EnrollmentID]
GO
ALTER TABLE [dbo].[ServiceProgramCategory] DROP CONSTRAINT [FK_dbo.ServiceProgramCategory_dbo.ServiceProgram_ServiceProgramID]
GO
ALTER TABLE [dbo].[ServiceProgramCategory] DROP CONSTRAINT [FK_dbo.ServiceProgramCategory_dbo.ServiceCategory_ServiceCategoryID]
GO
ALTER TABLE [dbo].[ServiceProgram] DROP CONSTRAINT [FK_dbo.ServiceProgram_dbo.ServiceProvider_ServiceProviderID]
GO
ALTER TABLE [dbo].[ProgressNote] DROP CONSTRAINT [FK_dbo.ProgressNote_dbo.Enrollment_EnrollmentID]
GO
ALTER TABLE [dbo].[ProgressNote] DROP CONSTRAINT [FK_dbo.ProgressNote_dbo.ContactType_ContactTypeID]
GO
ALTER TABLE [dbo].[PlacementOffense] DROP CONSTRAINT [FK_dbo.PlacementOffense_dbo.Placement_PlacementID]
GO
ALTER TABLE [dbo].[PlacementOffense] DROP CONSTRAINT [FK_dbo.PlacementOffense_dbo.Offense_OffenseID]
GO
ALTER TABLE [dbo].[Placement] DROP CONSTRAINT [FK_dbo.Placement_dbo.PlacementLevel_PlacementLevelID]
GO
ALTER TABLE [dbo].[Placement] DROP CONSTRAINT [FK_dbo.Placement_dbo.Judge_JudgeID]
GO
ALTER TABLE [dbo].[PersonSupplemental] DROP CONSTRAINT [FK_dbo.PersonSupplemental_dbo.School_SchoolID]
GO
ALTER TABLE [dbo].[PersonSupplemental] DROP CONSTRAINT [FK_dbo.PersonSupplemental_dbo.Person_PersonID]
GO
ALTER TABLE [dbo].[PersonSupplemental] DROP CONSTRAINT [FK_dbo.PersonSupplemental_dbo.MaritalStatus_MaritalStatusID]
GO
ALTER TABLE [dbo].[PersonSupplemental] DROP CONSTRAINT [FK_dbo.PersonSupplemental_dbo.JobStatus_JobStatusID]
GO
ALTER TABLE [dbo].[PersonSupplemental] DROP CONSTRAINT [FK_dbo.PersonSupplemental_dbo.EducationLevel_EducationLevelID]
GO
ALTER TABLE [dbo].[PersonAddress] DROP CONSTRAINT [FK_dbo.PersonAddress_dbo.Person_PersonID]
GO
ALTER TABLE [dbo].[PersonAddress] DROP CONSTRAINT [FK_dbo.PersonAddress_dbo.AddressType_AddressTypeID]
GO
ALTER TABLE [dbo].[Person] DROP CONSTRAINT [FK_dbo.Person_dbo.Suffix_SuffixID]
GO
ALTER TABLE [dbo].[Person] DROP CONSTRAINT [FK_dbo.Person_dbo.Race_RaceID]
GO
ALTER TABLE [dbo].[Person] DROP CONSTRAINT [FK_dbo.Person_dbo.Gender_GenderID]
GO
ALTER TABLE [dbo].[LoginProfile] DROP CONSTRAINT [FK_dbo.LoginProfile_dbo.LoginRole_LoginRoleID]
GO
ALTER TABLE [dbo].[LoginProfile] DROP CONSTRAINT [FK_dbo.LoginProfile_dbo.LoginDomain_LoginDomainID]
GO
ALTER TABLE [dbo].[LoginProfile] DROP CONSTRAINT [FK_dbo.LoginProfile_dbo.Login_LoginID]
GO
ALTER TABLE [dbo].[LoginProfile] DROP CONSTRAINT [FK_dbo.LoginProfile_dbo.Application_ApplicationID]
GO
ALTER TABLE [dbo].[Login] DROP CONSTRAINT [FK_dbo.Login_dbo.JobTitle_JobTitleID]
GO
ALTER TABLE [dbo].[FamilyProfile] DROP CONSTRAINT [FK_dbo.FamilyProfile_dbo.Relationship_RelationshipID]
GO
ALTER TABLE [dbo].[FamilyProfile] DROP CONSTRAINT [FK_dbo.FamilyProfile_dbo.Person_FamilyMemberID]
GO
ALTER TABLE [dbo].[Enrollment] DROP CONSTRAINT [FK_dbo.Enrollment_dbo.Staff_SourceID]
GO
ALTER TABLE [dbo].[Enrollment] DROP CONSTRAINT [FK_dbo.Enrollment_dbo.Staff_CounselorID]
GO
ALTER TABLE [dbo].[Enrollment] DROP CONSTRAINT [FK_dbo.Enrollment_dbo.ServiceRelease_ServiceReleaseID]
GO
ALTER TABLE [dbo].[Enrollment] DROP CONSTRAINT [FK_dbo.Enrollment_dbo.ServiceProgramCategory_ServiceProgramCategoryID]
GO
ALTER TABLE [dbo].[Enrollment] DROP CONSTRAINT [FK_dbo.Enrollment_dbo.ServiceOutcome_ServiceOutcomeID]
GO
ALTER TABLE [dbo].[Enrollment] DROP CONSTRAINT [FK_dbo.Enrollment_dbo.Placement_PlacementID]
GO
ALTER TABLE [dbo].[ClientProfile] DROP CONSTRAINT [FK_dbo.ClientProfile_dbo.System_SystemID]
GO
ALTER TABLE [dbo].[ClientProfile] DROP CONSTRAINT [FK_dbo.ClientProfile_dbo.Person_PersonID]
GO
ALTER TABLE [dbo].[Assessment] DROP CONSTRAINT [FK_dbo.Assessment_dbo.Staff_StaffID]
GO
ALTER TABLE [dbo].[Assessment] DROP CONSTRAINT [FK_dbo.Assessment_dbo.ClientProfile_ClientProfileID]
GO
ALTER TABLE [dbo].[Assessment] DROP CONSTRAINT [FK_dbo.Assessment_dbo.AssessmentType_AssessmentTypeID]
GO
ALTER TABLE [dbo].[Assessment] DROP CONSTRAINT [FK_dbo.Assessment_dbo.AssessmentSubtype_AssessmentSubtypeID]
GO
ALTER TABLE [dbo].[Application] DROP CONSTRAINT [FK_dbo.Application_dbo.System_SystemID]
GO
ALTER TABLE [dbo].[AspNetUserRoles] DROP CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles] DROP CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserLogins] DROP CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserClaims] DROP CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
/****** Object:  Table [dbo].[System]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[System]
GO
/****** Object:  Table [dbo].[Suffix]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[Suffix]
GO
/****** Object:  Table [dbo].[Staff]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[Staff]
GO
/****** Object:  Table [dbo].[ServiceUnit]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[ServiceUnit]
GO
/****** Object:  Table [dbo].[ServiceRelease]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[ServiceRelease]
GO
/****** Object:  Table [dbo].[ServiceProvider]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[ServiceProvider]
GO
/****** Object:  Table [dbo].[ServiceProgramCategory]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[ServiceProgramCategory]
GO
/****** Object:  Table [dbo].[ServiceProgram]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[ServiceProgram]
GO
/****** Object:  Table [dbo].[ServiceOutcome]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[ServiceOutcome]
GO
/****** Object:  Table [dbo].[ServiceCategory]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[ServiceCategory]
GO
/****** Object:  Table [dbo].[School]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[School]
GO
/****** Object:  Table [dbo].[Relationship]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[Relationship]
GO
/****** Object:  Table [dbo].[Race]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[Race]
GO
/****** Object:  Table [dbo].[ProgressNote]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[ProgressNote]
GO
/****** Object:  Table [dbo].[PlacementOffense]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[PlacementOffense]
GO
/****** Object:  Table [dbo].[PlacementLevel]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[PlacementLevel]
GO
/****** Object:  Table [dbo].[Placement]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[Placement]
GO
/****** Object:  Table [dbo].[PersonSupplemental]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[PersonSupplemental]
GO
/****** Object:  Table [dbo].[PersonAddress]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[PersonAddress]
GO
/****** Object:  Table [dbo].[Person]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[Person]
GO
/****** Object:  Table [dbo].[Offense]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[Offense]
GO
/****** Object:  Table [dbo].[MaritalStatus]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[MaritalStatus]
GO
/****** Object:  Table [dbo].[Judge]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[Judge]
GO
/****** Object:  Table [dbo].[JobTitle]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[JobTitle]
GO
/****** Object:  Table [dbo].[JobStatus]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[JobStatus]
GO
/****** Object:  Table [dbo].[Gender]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[Gender]
GO
/****** Object:  Table [dbo].[FamilyProfile]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[FamilyProfile]
GO
/****** Object:  Table [dbo].[Enrollment]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[Enrollment]
GO
/****** Object:  Table [dbo].[EducationLevel]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[EducationLevel]
GO
/****** Object:  Table [dbo].[Document]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[Document]
GO
/****** Object:  Table [dbo].[ContactType]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[ContactType]
GO
/****** Object:  Table [dbo].[ClientProfile]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[ClientProfile]
GO
/****** Object:  Table [dbo].[AssessmentType]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[AssessmentType]
GO
/****** Object:  Table [dbo].[AssessmentSubtype]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[AssessmentSubtype]
GO
/****** Object:  Table [dbo].[Assessment]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[Assessment]
GO
/****** Object:  Table [dbo].[Application]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[Application]
GO
/****** Object:  Table [dbo].[AddressType]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[AddressType]
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 7/16/2015 5:20:09 PM ******/
DROP TABLE [dbo].[__MigrationHistory]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 3/3/2016 9:13:38 AM ******/
DROP TABLE [dbo].[AspNetRoles]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 3/3/2016 9:14:14 AM ******/
DROP TABLE [dbo].[AspNetUserClaims]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 3/3/2016 9:14:37 AM ******/
DROP TABLE [dbo].[AspNetUserLogins]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 3/3/2016 9:14:53 AM ******/
DROP TABLE [dbo].[AspNetUserRoles]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 3/3/2016 9:15:14 AM ******/
DROP TABLE [dbo].[AspNetUsers]
GO
DROP TABLE [dbo].[UserModel]
GO
/****** Object:  Table [dbo].[RefreshToken]    Script Date: 3/3/2016 9:39:27 AM ******/
DROP TABLE [dbo].[RefreshToken]
GO
/****** Object:  Table [dbo].[Client]    Script Date: 3/3/2016 9:39:27 AM ******/
DROP TABLE [dbo].[Client]
GO
/* audit tables*/
GO
/****** Object:  Table [dbo].[ServiceUnit_Audit]    Script Date: 5/25/2016 1:40:23 PM ******/
DROP TABLE [dbo].[ServiceUnit_Audit]
GO
/****** Object:  Table [dbo].[ProgressNote_Audit]    Script Date: 5/25/2016 1:40:23 PM ******/
DROP TABLE [dbo].[ProgressNote_Audit]
GO
/****** Object:  Table [dbo].[PersonSupplemental_Audit]    Script Date: 5/25/2016 1:40:23 PM ******/
DROP TABLE [dbo].[PersonSupplemental_Audit]
GO
/****** Object:  Table [dbo].[PersonAddress_Audit]    Script Date: 5/25/2016 1:40:23 PM ******/
DROP TABLE [dbo].[PersonAddress_Audit]
GO
/****** Object:  Table [dbo].[Person_Audit]    Script Date: 5/25/2016 1:40:23 PM ******/
DROP TABLE [dbo].[Person_Audit]
GO
/****** Object:  Table [dbo].[FamilyProfile_Audit]    Script Date: 5/25/2016 1:40:23 PM ******/
DROP TABLE [dbo].[FamilyProfile_Audit]
GO
/****** Object:  Table [dbo].[Enrollment_Audit]    Script Date: 5/25/2016 1:40:23 PM ******/
DROP TABLE [dbo].[Enrollment_Audit]
GO
/****** Object:  Table [dbo].[ClientProfile_Audit]    Script Date: 5/25/2016 1:40:23 PM ******/
DROP TABLE [dbo].[ClientProfile_Audit]
GO
/****** Object:  Table [dbo].[Assessment_Audit]    Script Date: 5/25/2016 1:40:23 PM ******/
DROP TABLE [dbo].[Assessment_Audit]
GO
/****** Object:  StoredProcedure [dbo].[GenerateTriggers]    Script Date: 5/25/2016 1:40:23 PM ******/
DROP PROCEDURE [dbo].[GenerateTriggers]
GO

/*****droping the user defined function script date 2/8/2016 12:23:00*******/
DROP FUNCTION [dbo].[Split]
GO
