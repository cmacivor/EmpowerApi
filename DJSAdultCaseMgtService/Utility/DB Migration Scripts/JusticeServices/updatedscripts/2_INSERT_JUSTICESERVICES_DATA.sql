use JusticeServices 
go

/** START OF: INSERTING MASTER TABLE DATA  **/
/** System **/
SET IDENTITY_INSERT [dbo].[System] ON
INSERT INTO [dbo].[System] ([ID], Name, Active, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate) 
VALUES (1, 'Juvenile', 1, 1, GetDate(), 1, GetDate()) 

INSERT INTO [dbo].[System] ([ID], Name, Active, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate) 
VALUES (2, 'Adult', 1, 1, GetDate(), 1, GetDate()) 
SET IDENTITY_INSERT [dbo].[System] OFF

/** AddressType **/
SET IDENTITY_INSERT [dbo].[AddressType] ON
INSERT INTO [dbo].[AddressType] (ID, Name, Description, Active, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate) 
VALUES (1, 'DJS-City', 'DJS City Address', 1, 1, GetDate(), 1, GetDate())

INSERT INTO [dbo].[AddressType] (ID, Name, Description, Active, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate) 
VALUES (2, 'DJS-NonCity', 'DJS Non-City Address', 1, 1, GetDate(), 1, GetDate())

INSERT INTO [dbo].[AddressType] (ID, Name, Description, Active, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate) 
VALUES (3, 'CSU-City', 'CSU City Address', 1, 1, GetDate(), 1, GetDate())  

INSERT INTO [dbo].[AddressType] (ID, Name, Description, Active, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate) 
VALUES (4, 'CSU-NonCity', 'CSU Non-City Address', 1, 1, GetDate(), 1, GetDate())  
SET IDENTITY_INSERT [dbo].[AddressType] OFF

/** Application **/
SET IDENTITY_INSERT [dbo].[Application] ON
INSERT INTO [dbo].[Application] ([ID], SystemID, Name, Active, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate) 
VALUES (1, 1, 'GILS Referral for Services and Case Management', 1, 1, GetDate(), 1, GetDate()) 

INSERT INTO [dbo].[Application] ([ID], SystemID, Name, Active, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate) 
VALUES (2, 1, 'Detention Center', 1, 1, GetDate(), 1, GetDate()) 

INSERT INTO [dbo].[Application] ([ID], SystemID, Name, Active, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate) 
VALUES (3, 2, 'Alternative Sentencing Tracker', 1, 1, GetDate(), 1, GetDate()) 

INSERT INTO [dbo].[Application] ([ID], SystemID, Name, Active, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate) 
VALUES (4, 2, 'Sentencing Programs', 1, 1, GetDate(), 1, GetDate()) 
SET IDENTITY_INSERT [dbo].[Application] OFF

/* Assessment SubType [jjscasemgt].[dbo].[tblAssessment] */
INSERT INTO [dbo].[AssessmentSubType]
(
	[SystemID],
	[Name],
	[Description],
	[Active],
	[CreatedBy],
	[CreatedDate],
	[UpdatedBy],
	[UpdatedDate]
)
SELECT 
	1 as [SystemID],
	SubType as [Name],
	SubType as [Description],
	1 as [Active],
	1 as [CreatedBy], 
	GetDate() as [CreatedDate],
	1 as [UpdatedBy], 
	GetDate() as [UpdatedDate] 
FROM [jjscasemgt].[dbo].[tblAssessment]
WHERE SubType Is Not Null
GROUP BY SubType
ORDER BY SubType

/* Assessment Type [jjscasemgt].[dbo].[tblAssessment]*/
INSERT INTO[dbo].[AssessmentType]
(
	[SystemID],
	[Name],
	[Description],
	[Active],
	[CreatedBy],
	[CreatedDate],
	[UpdatedBy],
	[UpdatedDate]
)
SELECT 
	1 as [SystemID],
	AssessmentType as [Name],
	AssessmentType as [Description],
	1 as [Active],
	1 as [CreatedBy], 
	GetDate() as [CreatedDate],
	1 as [UpdatedBy], 
	GetDate() as [UpdatedDate] 
FROM [jjscasemgt].[dbo].[tblAssessment]
WHERE AssessmentType Is Not Null
GROUP BY AssessmentType
ORDER BY AssessmentType

/** Document **/
SET IDENTITY_INSERT [dbo].[Document] ON
INSERT INTO [dbo].[Document]
	([ID], [SystemID], [Name], [FileName], [Description],[Active],[CreatedBy],[CreatedDate],[UpdatedBy],[UpdatedDate])
VALUES (1, 1,'Anger Management','Anger Management.pdf','Anger Management',1,1,getdate(),1,getdate())

INSERT INTO [dbo].[Document]
	([ID], [SystemID], [Name], [FileName], [Description],[Active],[CreatedBy],[CreatedDate],[UpdatedBy],[UpdatedDate])
VALUES (2, 1,'Community Monitoring','Community Monitoring.pdf','Community Monitoring',1,1,getdate(),1,getdate())

INSERT INTO [dbo].[Document]
	([ID], [SystemID], [Name], [FileName], [Description],[Active],[CreatedBy],[CreatedDate],[UpdatedBy],[UpdatedDate])
VALUES (3, 1,'Community Service Hourly','Community Service Hourly.pdf','Community Service Hourly',1,1,getdate(),1,getdate())

INSERT INTO [dbo].[Document]
	([ID], [SystemID], [Name], [FileName], [Description],[Active],[CreatedBy],[CreatedDate],[UpdatedBy],[UpdatedDate])
VALUES (4, 1, 'Community Service Weekend','Community Service Weekend.pdf','Community Service Weekend',1,1,getdate(),1,getdate())

INSERT INTO [dbo].[Document]
	([ID], [SystemID], [Name], [FileName], [Description],[Active],[CreatedBy],[CreatedDate],[UpdatedBy],[UpdatedDate])
VALUES (5, 1, 'Cultural Enrichment','Cultural Enrichment.pdf','Cultural Enrichment',1,1,getdate(),1,getdate())

INSERT INTO [dbo].[Document]
	([ID], [SystemID], [Name], [FileName], [Description],[Active],[CreatedBy],[CreatedDate],[UpdatedBy],[UpdatedDate])
VALUES (6, 1, 'Day Reporting Center','Day Reporting Center.pdf','Day Reporting Center',1,1,getdate(),1,getdate())

INSERT INTO [dbo].[Document]
	([ID], [SystemID], [Name], [FileName], [Description],[Active],[CreatedBy],[CreatedDate],[UpdatedBy],[UpdatedDate])
VALUES (7, 1, 'Family Ties','Family Ties.pdf','Family Ties',1,1,getdate(),1,getdate())

INSERT INTO [dbo].[Document]
	([ID], [SystemID], [Name], [FileName], [Description],[Active],[CreatedBy],[CreatedDate],[UpdatedBy],[UpdatedDate])
VALUES (8, 1, 'Level 1 Case Management','Level 1 Case Management.pdf','Level 1 Case Management',1,1,getdate(),1,getdate())

INSERT INTO [dbo].[Document]
	([ID], [SystemID], [Name], [FileName], [Description],[Active],[CreatedBy],[CreatedDate],[UpdatedBy],[UpdatedDate])
VALUES (9, 1, 'Outreach Phase II','Outreach Phase II.pdf','Outreach Phase II',1,1,getdate(),1,getdate())
SET IDENTITY_INSERT [dbo].[Document] OFF

/* Education Level [jjscasemgt].[dbo].[tblEducLevel] */
SET IDENTITY_INSERT [dbo].[EducationLevel] ON
INSERT INTO [dbo].[EducationLevel] (
	[ID],
	[Name],
	[Description],
	[Active],
	[CreatedBy],
	[CreatedDate],
	[UpdatedBy],
	[UpdatedDate]
)
SELECT 
	EducID as [ID],
	EducLevelCd as [Name],
	EducLevelCd as [Description],
	1 as [Active],
	1 as [CreatedBy],
	GetDate() as [CreatedDate],
	1 as [UpdatedBy],
	GetDate() as [UpdatedDate]
FROM [jjscasemgt].[dbo].[tblEducLevel]
ORDER BY EducLevelCd
SET IDENTITY_INSERT [dbo].[EducationLevel] OFF

/* Gender */
INSERT INTO [dbo].[Gender]
(
	[Name],
	[Description],
	[Active],
	[CreatedBy], 
	[CreatedDate],
	[UpdatedBy], 
	[UpdatedDate] 
)
SELECT 
	Gender as [Name],
	Gender as [Description],
	1 as [Active],	
	1 as [CreatedBy],
	GetDate() as [CreatedDate], 
	1 as [UpdatedBy], 
	GetDate() as [UpdatedDate] 
FROM [jjscasemgt].[dbo].[tblJuvenileProfile]
WHERE Gender Is Not Null
GROUP BY Gender
ORDER BY Gender

/* JobStatus [jjscasemgt].[dbo].[tblJobStatus] */
SET IDENTITY_INSERT [dbo].[JobStatus] ON
INSERT INTO [dbo].[JobStatus] (
	[ID],
	[Name],
	[Description],
	[Active],
	[CreatedBy],
	[CreatedDate],
	[UpdatedBy],
	[UpdatedDate]
)
SELECT 
	JobStatusID as [ID],
	Description as [Name],
	Description as [Description],
	1 as [Active],
	1 as [CreatedBy],
	GetDate() as [CreatedDate],
	1 as [UpdatedBy],
	GetDate() as [UpdatedDate]
FROM [jjscasemgt].[dbo].[tblJobStatus]
ORDER BY Description
SET IDENTITY_INSERT [dbo].[JobStatus] OFF

/** JobTitle [jjscasemgt].[dbo].[tblStaff] **/
INSERT INTO [dbo].[JobTitle] (Name, Active, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate)
SELECT JobTitle, 1, 1, GetDate(), 1, GetDate()
FROM [jjscasemgt].[dbo].[tblStaff]
WHERE JobTitle <> 'NULL' and JobTitle <> ''
GROUP BY JobTitle
ORDER BY JobTitle

/* Judge [jjscasemgt].[dbo].[tblJudges] */
SET IDENTITY_INSERT [dbo].[Judge] ON
INSERT INTO [dbo].[Judge] (
	[ID],
	[SystemID],
	[Name],
	[Description],
	[Active],
	[CreatedBy],
	[CreatedDate],
	[UpdatedBy],
	[UpdatedDate]
)
SELECT 
	JudgeID as [ID],
	1 as [SystemID],
	Judges as [Name],
	Judges as [Description],
	~[Active] as [Active],
	1 as [CreatedBy],
	GetDate() as [CreatedDate],
	1 as [UpdatedBy],
	GetDate() as [UpdatedDate]
FROM [jjscasemgt].[dbo].tblJudges
ORDER BY Judges
SET IDENTITY_INSERT [dbo].[Judge] OFF

/* Marital Status [jjscasemgt].[dbo].[tblFamilyProfile] */
INSERT INTO MaritalStatus
(
	[Name],
	[Description],
	[Active],
	[CreatedBy],
	[CreatedDate],
	[UpdatedBy],
	[UpdatedDate]
)
SELECT 
	MaritalStatus as [Name],
	MaritalStatus as [Description],
	1 as [Active],
	1 as [CreatedBy],
	GetDate() as [CreatedDate],
	1 as [UpdatedBy],
	GetDate() as [UpdatedDate]
FROM
	[jjscasemgt].[dbo].[tblFamilyProfile]
WHERE MaritalStatus <> ''
GROUP BY MaritalStatus
ORDER BY MaritalStatus

/* ServiceLevel [jjscasemgt].[dbo].[tblServiceLevels] */
SET IDENTITY_INSERT [dbo].[PlacementLevel] ON
INSERT INTO [dbo].[PlacementLevel] 
(
	[ID],
	[SystemID],
	[Name],
	[Description],
	[Active],
	[CreatedBy],
	[CreatedDate],
	[UpdatedBy],
	[UpdatedDate]
)
SELECT  	
	ServLevelID as [ID],
	1 as [SystemID],
	Description as [Name],
	Description as [Description],
    1 as [Active],
	1 as [CreatedBy],
	GetDate() as [CreatedDate],
	1 as [UpdatedBy],
	GetDate() as [UpdatedDate]
FROM 
	[jjscasemgt].[dbo].[tblServiceLevels]
SET IDENTITY_INSERT [dbo].[PlacementLevel] OFF

/** Race [jjscasemgt].[dbo].[tblRace] **/
INSERT INTO [dbo].[Race]
(	
	[Name],
	[Description], 
	[Active],
	[CreatedBy], 
	[CreatedDate],
	[UpdatedBy], 
	[UpdatedDate] 
)
SELECT 
	RaceID as [Name],
	Race as [Description], 
	1 as [Active],
	1 as [CreatedBy],
	GetDate() as [CreatedDate], 
	1 as [UpdatedBy], 
	GetDate() as [UpdatedDate] 
FROM [jjscasemgt].[dbo].[tblRace]
ORDER BY RaceID

/* Relationship [jjscasemgt].[dbo].[tblRole] */
INSERT INTO [dbo].[Relationship] (
	[Name],
	[Description],
	[Active],
	[CreatedBy],
	[CreatedDate],
	[UpdatedBy],
	[UpdatedDate]
)
SELECT 
	RoleID as [Name],
	Description as [Description],
	1 as [Active],
	1 as [CreatedBy],
	GetDate() as [CreatedDate],
	1 as [UpdatedBy],
	GetDate() as [UpdatedDate]
FROM [jjscasemgt].[dbo].[tblRole] 
ORDER BY RoleID

/* ServiceCategory [jjscasemgt].[dbo].[tblServiceProfiles] */
INSERT INTO [dbo].[ServiceCategory]
(
	[SystemID],
	[Name],
	[Description],
	[Active],
	[CreatedBy],
	[CreatedDate],
	[UpdatedBy],
	[UpdatedDate]
)
SELECT 
	1 as [SystemID],
	Program as [Name],
	Program as [Description],
    0 as [Active],
	1 as [CreatedBy],
	GetDate() as [CreatedDate],
	1 as [UpdatedBy],
	GetDate() as [UpdatedDate]
FROM 
	[jjscasemgt].[dbo].[tblServiceProfiles]
WHERE Program is not null
GROUP BY Program
ORDER BY Program

/* ServiceOutcome [jjscasemgt].[dbo].[tblSrvOutcomes]  */
SET IDENTITY_INSERT [dbo].[ServiceOutcome] ON
INSERT INTO [dbo].[ServiceOutcome] 
(
	[ID],
	[SystemID],
	[Name],
	[Description],
	[Active],
	[CreatedBy],
	[CreatedDate],
	[UpdatedBy],
	[UpdatedDate]
)
SELECT
	Outcomeid as [ID],
	1 as [SystemID],
	Description as [Name],
	Description as [Description],
    ~[Active] as [Active],
	1 as [CreatedBy],
	GetDate() as [CreatedDate],
	1 as [UpdatedBy],
	GetDate() as [UpdatedDate]
FROM 
	[jjscasemgt].[dbo].[tblSrvOutcomes] 
SET IDENTITY_INSERT [dbo].[ServiceOutcome] OFF

/* ServiceRelease [jjscasemgt].[dbo].[tblSrvRelease] */
SET IDENTITY_INSERT [dbo].[ServiceRelease] ON
INSERT INTO [dbo].[ServiceRelease]
(
	[ID],
	[SystemID],
	[Name],
	[Description],
	[ExcludeFromEnrollmentCount],
	[Active],
	[CreatedBy],
	[CreatedDate],
	[UpdatedBy],
	[UpdatedDate]
)
SELECT
	ReleaseId as [ID],
	1 as [SystemID],
	Description as [Name],
	Description as [Description],
	[ExcludeFromEnrollmentCount] as [ExcludeFromEnrollmentCount],
	~[Active] as [Active], 
    --Active as [Active],
	1 as [CreatedBy],
	GetDate() as [CreatedDate],
	1 as [UpdatedBy],
	GetDate() as [UpdatedDate]
FROM 
	[jjscasemgt].[dbo].[tblSrvRelease] 
SET IDENTITY_INSERT [dbo].[ServiceRelease] OFF

/* Suffix [jjscasemgt].[dbo].[tblJuvenileProfile] */
INSERT INTO [dbo].[Suffix]
(     
	[Name],
    [Description],
    [Active],
    [CreatedBy],
    [CreatedDate],
    [UpdatedBy],
    [UpdatedDate]
)
SELECT 
	SufName as [Name],
    SufName as [Description],
	1 as [Active],	
	1 as [CreatedBy],
	GetDate() as [CreatedDate], 
	1 as [UpdatedBy], 
	GetDate() as [UpdatedDate] 
FROM [jjscasemgt].[dbo].[tblJuvenileProfile] jp
WHERE SufName <> 'NULL' AND SufName <> ''
GROUP BY SufName
ORDER BY SufName

/** LoginRole 
--SELECT * FROM LoginRole
SET IDENTITY_INSERT [dbo].[LoginRole] ON

INSERT INTO [dbo].[LoginRole] ([ID], Name, Description, Active, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate) 
VALUES (1, 'None', 'This role has no rights.', 1, 1, GetDate(), 1, GetDate()) 

INSERT INTO [dbo].[LoginRole] ([ID], Name, Description, Active, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate) 
VALUES (2, 'Read', 'This role allows the ability to view data only.', 1, 1, GetDate(), 1, GetDate()) 

INSERT INTO [dbo].[LoginRole] ([ID], Name, Description, Active, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate) 
VALUES (3, 'Write', 'This role allows the ability to read, write, modify, create, delete data.', 1, 1, GetDate(), 1, GetDate()) 

INSERT INTO [dbo].[LoginRole] ([ID], Name, Description, Active, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate) 
VALUES (4, 'Full', 'This role allows the ability to read, write, modify, create, delete data, read log files and perform maintenance to the system.', 1, 1, GetDate(), 1, GetDate()) 

INSERT INTO [dbo].[LoginRole] ([ID], Name, Description, Active, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate) 
VALUES (5, 'Admin', 'With this role, all options are available, including creating users, creating user groups, and deleting objects FROM the device tree. Access restrictions to objects cannot be set for this type of user group.', 1, 1, GetDate(), 1, GetDate()) 

SET IDENTITY_INSERT [dbo].[LoginRole] OFF

/** LoginDomain **/
--SELECT * FROM LoginDomain

SET IDENTITY_INSERT [dbo].[LoginDomain] ON

INSERT INTO [dbo].[LoginDomain] ([ID], Name, Active, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate) 
VALUES (1, 'Internal', 1, 1, GetDate(), 1, GetDate()) 

INSERT INTO [dbo].[LoginDomain] ([ID], Name, Active, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate) 
VALUES (2, 'External', 1, 1, GetDate(), 1, GetDate()) 

INSERT INTO [dbo].[LoginDomain] ([ID], Name, Active, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate) 
VALUES (3, 'Both', 1, 1, GetDate(), 1, GetDate()) 

SET IDENTITY_INSERT [dbo].[LoginDomain] OFF**/

/** ContactType **/
--SELECT * FROM ContactType

SET IDENTITY_INSERT [dbo].[ContactType] ON

INSERT INTO [dbo].[ContactType] ([ID], Name, Description, Active, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate) 
VALUES (1, 'Case Planning', 'Case Planning', 1, 1, GetDate(), 1, GetDate()) 

INSERT INTO [dbo].[ContactType] ([ID], Name, Description, Active, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate) 
VALUES (2, 'Home Visit', 'Home Visit', 1, 1, GetDate(), 1, GetDate()) 

INSERT INTO [dbo].[ContactType] ([ID], Name, Description, Active, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate) 
VALUES (3, 'Incentive', 'Incentive', 1, 1, GetDate(), 1, GetDate()) 

INSERT INTO [dbo].[ContactType] ([ID], Name, Description, Active, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate) 
VALUES (4, 'Office Visit', 'Office Visit', 1, 1, GetDate(), 1, GetDate()) 

INSERT INTO [dbo].[ContactType] ([ID], Name, Description, Active, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate) 
VALUES (5, 'Phone Call', 'Phone Call', 1, 1, GetDate(), 1, GetDate()) 

INSERT INTO [dbo].[ContactType] ([ID], Name, Description, Active, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate) 
VALUES (6, 'Sanction', 'Sanction', 1, 1, GetDate(), 1, GetDate())

SET IDENTITY_INSERT [dbo].[ContactType] OFF

						/** END OF: INSERTING MASTER TABLE DATA  **/
						   /** START OF: INSERTING OTHER DATA  **/

/* Staff */
/* SELECT * from tblStaff */
SET IDENTITY_INSERT [dbo].[Staff] ON
INSERT INTO [dbo].[Staff]
    ([ID]
	,[Agency]
    ,[LastName]
    ,[FirstName]
    ,[NetLogin]
    ,[Password]
    ,[JobTitleID]
    ,[Phone]
    ,[Fax]
    ,[EMail]
    ,[Department]
    ,[OfficeLocation]
    ,[NetworkConnection]
    ,[AccessLevelReq]
    ,[SQLRole]
    ,[HireDate]
    ,[TerminationDate]
    ,[RestrictLevel]
    ,[Supervisor]
	,[Active]
    ,[CreatedBy]
    ,[CreatedDate]
    ,[UpdatedBy]
    ,[UpdatedDate])
SELECT
	StaffID as [ID],
	Agency as [Agency],	
	LName as [LastName],	
	FName as [FirstName],
	NetLogin as [NetLogin],
	Password as [Password],
	(SELECT a.ID FROM JobTitle a WHERE a.Name = JobTitle) as [JobTitleID],
	Phone as [PhoneNumber],
	Fax as [FaxNumber],
	Email as [Email],	
	Department as [Department],
	OfficeLocation as [OfficeLocation],
	NetworkConnection as [NetworkConnection],
	AccessLevelReq as [tempAccess],	
	SQLRole as [SQLRole],
	HireDt as [HireDate],
	TermDt as [TerminationDate],
	RestrictLevel as [RestrictLevel],
	Supervisor as [tempSupervisor], 
	~[Active] as [Active],
    1 as [CreatedBy],	
	GetDate() as [CreatedDate], 
	1 as [UpdatedBy], 
	GetDate() as [UpdatedDate] 
FROM [jjscasemgt].[dbo].[tblStaff]
WHERE  FName IS NOT NULL and LName IS NOT NULL and NetLogin IS NOT NULL and Password IS NOT NULL 
AND NetLogin <> ''
AND StaffID NOT IN (196, 303, 348, 403, 404, 426, 453)
ORDER BY NetLogin
SET IDENTITY_INSERT [dbo].[Staff] OFF


/** LoginName [jjscasemgt].[dbo].[tblStaff] WHERE NetLogin is null **/
/* Add System User as default user for marking insertions if no user is available */
--SET IDENTITY_INSERT [dbo].[Login] ON
--INSERT INTO [dbo].[Login] ([ID], FirstName, LastName, tempAccountName, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate)
--VALUES (1, 'SYSTEM', 'SYSTEM', 'SYSADM', 1, GetDate(), 1, GetDate())
--SET IDENTITY_INSERT [dbo].[Login] OFF

--INSERT INTO [dbo].[Login] (
--	[FirstName],
--	[LastName],
--	[MiddleName],
--	[Email],
--	[JobTitleID],
--	[Department],
--	[Agency],
--	[PhoneNumber],
--	[FaxNumber],
--	[OfficeLocation],
--	[tempAccountName],
--	[tempPassword],
--	[tempStaffID],
--	[tempAccess],
--	[tempNetworkConnection],
--	[tempSupervisor], 
--	[Active],
--	[CreatedBy],
--	[CreatedDate], 
--	[UpdatedBy], 
--	[UpdatedDate]
--)
--SELECT
--	FName as [FirstName],
--	LName as [LastName],
--	NULL as [MiddleName],
--	Email as [Email],
--	(SELECT a.ID FROM JobTitle a WHERE a.Name = JobTitle) as [JobTitleID],
--	Department as [Department],
--	Agency as [Agency],
--	Phone as [PhoneNumber],
--	Fax as [FaxNumber],
--	OfficeLocation as [OfficeLocation],
--	NetLogin as [tempAccountName],
--	[Password] as [tempPassword],
--	StaffID as [tempStaffID],
--	AccessLevelReq as [tempAccess],
--	NetworkConnection as [tempNetworkConnection],
--	Supervisor as [tempSupervisor], 
--	1 as [Active],
--	1 as [CreatedBy],	
--	GetDate() as [CreatedDate], 
--	1 as [UpdatedBy], 
--	GetDate() as [UpdatedDate] 
--FROM [jjscasemgt].[dbo].[tblStaff]
--WHERE  FName IS NOT NULL and LName IS NOT NULL and NetLogin IS NOT NULL and Password IS NOT NULL 
--AND NetLogin <> ''
--AND StaffID NOT IN (196, 303, 348, 403, 404, 426, 453)
--ORDER BY NetLogin

/** LoginProfile [jjscasemgt].[dbo].[tblStaff] **/
--INSERT INTO [dbo].[LoginProfile] (
--	[SystemID],
--	[ApplicationID],
--	[LoginID],
--	[LoginRoleID],
--	[LoginDomainID],
--	[AccountName],
--	[Password], 
--	[Active],
--	[CreatedBy], 
--	[CreatedDate],
--	[UpdatedBy], 
--	[UpdatedDate] 
--)
--SELECT
--	1 as [SystemID],
--	1 as [ApplicationID],
--	[ID] as [LoginID],
--	2 as [LoginRoleID],
--	CASE tempNetworkConnection
--         WHEN 'City' THEN 1
--         WHEN 'Richmond' THEN 1
--         WHEN 'State' THEN 2
--         WHEN 'City and State' THEN 3
--         ELSE 1
--      END as [LoginDomainID],
--	tempAccountName as [AccountName],
--	CONVERT(varbinary, tempPassword) as [Password],
--	1 as [Active],
--	1 as [CreatedBy],
--	GetDate() as [CreatedDate], 
--	1 as [UpdatedBy], 
--	GetDate() as [UpdatedDate] 
--FROM Login
--ORDER BY LoginID

/* Offense */
SET IDENTITY_INSERT [dbo].[Offense] ON
INSERT INTO [dbo].[Offense]
(
	[ID],
    [Name],
    [DYFS],
    [VCCCode],
    [GeneralHeading],
    [Type],
    [Description],
    [Statute],
    [Active],
    [CreatedBy],
    [CreatedDate],
    [UpdatedBy],
    [UpdatedDate]
)
SELECT 
	OffenseID as [ID],
    Code as [Name],
    DYFS as [DYFS],
    VCCCode as [VCCCode],
    GeneralHeading as [GeneralHeading],
    OffenseType as [Type],
    OffenseDesc as [Description],
    Statute as [Statute],
    ~[Active] as [Active],
	1 as [CreatedBy],
	GetDate() as [CreatedDate],
	1 as [UpdatedBy],
	GetDate() as [UpdatedDate]
FROM [jjscasemgt].[dbo].[tblVAOffenseCodes]

SET IDENTITY_INSERT [dbo].[Offense] OFF

/* Schools [jjscasemgt].[dbo].[tblSchools] */
SET IDENTITY_INSERT [dbo].[school] ON
INSERT INTO [dbo].[School]
(
	[ID],
	[Name],
	[Phone],
	[Principal],
	[Address],
	[Zip],
	[Fax],
	[EducationLevel],
	[SchoolCode],
	[Active],
	[CreatedBy],
	[CreatedDate],
	[UpdatedBy],
	[UpdatedDate]
)
SELECT 
	[SchoolID] as [ID],
	School as [Name],
	Phone as [Phone],
	Principal as [Principal],
	[Address] as [Address],
	Zip as [Zip],
	Fax as [Fax],
	EducationLevel as [EducationLevel],
	SchoolCode as [SchoolCode],
	1 as [Active],
	1 as [CreatedBy], 
	GetDate() as [CreatedDate],
	1 as [UpdatedBy], 
	GetDate() as [UpdatedDate] 
FROM [jjscasemgt].[dbo].[tblSchools]
--ORDER BY School
SET IDENTITY_INSERT [dbo].[school] OFF

/* ServiceProgram [jjscasemgt].[dbo].[tblServiceProfiles] */
INSERT INTO [dbo].[ServiceProgram]
(
	[SystemID],
	[Name],
	[Active],
	[CreatedBy],
	[CreatedDate],
	[UpdatedBy],
	[UpdatedDate]
)
SELECT 
	1 as [SystemID],
	ServiceName as [Name],
   0 as [Active],
	1 as [CreatedBy],
	GetDate() as [CreatedDate],
	1 as [UpdatedBy],
	GetDate() as [UpdatedDate]
FROM [jjscasemgt].[dbo].[tblServiceProfiles]
GROUP BY ServiceName
ORDER BY ServiceName




/* ServiceProgramCategory [jjscasemgt].[dbo].[tblServiceProfiles] */
INSERT INTO [dbo].[ServiceProgramCategory]
(
	[SystemID],
    [ServiceProgramID],
    [ServiceCategoryID],
    [Active],
    [CreatedBy],
    [CreatedDate],
    [UpdatedBy],
    [UpdatedDate]
)
SELECT DISTINCT
	1 as [SystemID],
    (SELECT a.ID from ServiceProgram a WHERE a.Name = ServiceName) as [ServiceProgramID],
    (SELECT a.ID from ServiceCategory a WHERE a.Name = Program) as [ServiceCategoryID],
    0 as [Active],
	1 as [CreatedBy],
	GetDate() as [CreatedDate],
	1 as [UpdatedBy],
	GetDate() as [UpdatedDate]
FROM 
	[jjscasemgt].[dbo].[tblServiceProfiles] a
WHERE 
	Program IS NOT NULL
						   /**  END OF: INSERTING OTHER DATA   **/
						/** START OF: INSERTING PERSON RELATED DATA  **/

/* Person [jjscasemgt].[dbo].[tblJuvenileProfile] */
SET IDENTITY_INSERT [dbo].[Person] ON
INSERT INTO [dbo].[Person]
(
	[ID],
	--[tempFamilyProfileId],
	[tempAddrID],
	[LastName],
	[FirstName],
	[MiddleName],
	[SuffixID],
	[JTS],
	[DOB],
	[RaceID],
	[GenderID],
	[SSN],
	[ICN],	
	[Active],
	[CreatedBy], 
	[CreatedDate],
	[UpdatedBy], 
	[UpdatedDate]
	

)
SELECT
	jp.JuvenileID as [ID],
	--NULL as [tempFamilyProfileId],
	sup.HomeAddrID as [tempAddrID],
	jp.LName as [LastName],
	jp.FName as [FirstName],
	jp.MName as [MiddleName],
	(SELECT TOP 1 s.ID FROM Suffix s WHERE jp.SufName = s.Name) as [SuffixID],
	jp.JTS as [JTS],
	jp.DOB as [DOB],
	(SELECT TOP 1 r.ID FROM Race r WHERE jp.RaceID = r.Name) as [RaceID],
	(SELECT TOP 1 g.ID FROM Gender g WHERE jp.Gender = g.Name)  as [GenderID],
	jp.SSN as [SSN],	
	NULL as [ICN],
	1 as [Active],
	CASE 
		WHEN jp.CreatedBy IS NULL THEN 'load script' 
		ELSE jp.CreatedBy 
	END 

	 as [CreatedBy],
	CASE 
		WHEN jp.CreatedDt IS NULL THEN '2002-01-01 00:00:00' 
		ELSE jp.CreatedDt 
	END as [CreatedDate], 
	CASE 
		WHEN jp.UpdtBy IS NULL THEN 'load script' 
		ELSE jp.UpdtBy 
	END 
	 as [UpdatedBy],
	CASE 
		WHEN jp.UpdtDt IS NULL THEN '2002-01-01 00:00:00' 
		ELSE jp.UpdtDt 
	END as [UpdatedDate]
FROM [jjscasemgt].[dbo].[tblJuvenileProfile] jp
LEFT JOIN [jjscasemgt].[dbo].[tbljuvsupp] sup ON jp.JuvenileID = sup.JuvenileID
-- Below filter is to load only the juveniles with referral services
WHERE jp.JuvenileID IN (SELECT DISTINCT JuvenileID FROM jjscasemgt.dbo.tblReferral ref INNER JOIN jjscasemgt.dbo.tblRefServices refserv ON ref.ReferralID = refserv.ReferralID)
SET IDENTITY_INSERT [dbo].[Person] OFF

/* ClientProfile */
INSERT INTO [dbo].[ClientProfile]
(
	[SystemID],
	[PersonID],
	[Active],
	[CreatedBy], 
	[CreatedDate],
	[UpdatedBy], 
	[UpdatedDate] 
)
SELECT 
	1 as [SystemID],
	[ID] as [PersonID],
	1 as [Active],
	CreatedBy as [CreatedBy], 
	CreatedDate as [CreatedDate],
	UpdatedBy as [UpdatedBy], 
	GetDate() as [UpdatedDate] 
FROM [dbo].[Person]

-- Insert into PersonSupplemental from JJSCaseMgt.tbljuvsupp 
INSERT INTO [dbo].[PersonSupplemental]
(
	[PersonID],
	[DocketNumber],
	[POB],
	[CourtRecord],
	[MaritalStatusID],
	[JobStatusID],
	[Employer],
	[HomePhone],
	[WorkPhone],
	[OtherPhone],
	[BVCS],
	[HeightFt],
	[HeightIn],
	[Weight],
	[HairColor],
	[EyeColor],
	[HasMedicaid],
	[HasInsurance],
	[SchoolID],
	[EducID],
	[EducationLevelID],
	[SchoolYr],
	[HasExceptionEduc],
	[HasDriversLicense],
	[OtherAgencyContacts],
	[PhysicalHealth],
	[MentalHealth],
	[SubstanceAbuse],
	[XRefJuv],
	[Comments],
	[WorkPhoneExt],
	[OtherPhoneExt],
	[income],
	[HobbiesInterests],
	[Active],
	[CreatedBy],
	[CreatedDate],
	[UpdatedBy],
	[UpdatedDate]
)
SELECT 
	js.JuvenileID as [PersonID],
	js.DocketNumber as [DocketNumber],
	js.POB as [POB],
	null as [CourtRecord], -- not available for juvenile
	Null as [MaritalStatusID], -- not available for juvenile
	1 as [JobStatusID], -- need to read from actual master table
	null as [Employer], -- not available for juvenile
	js.HomePhone as [HomePhone],
	null as [WorkPhone], -- not available for juvenile
	null as [OtherPhone], -- not available for juvenile
	js.BVCS as [BVCS], 
	js.HeightFt as [HeightFt],
	js.HeightIn as [HeightIn],
	js.[Weight] as [Weight],
	js.HairColor as [HairColor],
	js.EyeColor as [EyeColor],
	CASE js.Medicaid
		WHEN 'N' THEN 0
		WHEN 'Y' THEN 1
		ELSE Null
	END as [HasMedicaid],
	CASE js.Insurance
		WHEN 'N' THEN 0
		WHEN 'Y' THEN 1
		ELSE Null
	END as [HasInsurance],
	CASE
		WHEN (SELECT TOP 1 a.ID FROM School a WHERE js.SchoolID = a.ID) IS NOT NULL THEN js.SchoolID
		ELSE Null
	END as [SchoolID],
	null as [EducID], -- not available for juvenile
	(SELECT TOP 1 b.ID FROM EducationLevel b WHERE js.EducLevelCD = b.Name)  as [EducationLevelID],
	js.SchoolYr as [SchoolYr],
	CASE js.ExceptionEduc
		WHEN 'N' THEN 0
		WHEN 'Y' THEN 1
		ELSE Null
	END as [HasExceptionEduc],
	CASE js.DriversLicense
		WHEN 'N' THEN 0
		WHEN 'Y' THEN 1
		ELSE Null
	END as [HasDriversLicense],
	js.OtherAgencyContacts as [OtherAgencyContacts],
	js.PhysicalHealth as [PhysicalHealth],
	js.MentalHealth as [MentalHealth],
	null as [SubstanceAbuse], -- not available for juvenile
	null as [XRefJuv], -- not available for juvenile
	null as [Comments], -- not available for juvenile
	null as [WorkPhoneExt], -- not available for juvenile
	null as [OtherPhoneExt], -- not available for juvenile
	null as [income], -- not available for juvenile
	js.HobbiesInterests as [HobbiesInterests],
	1 as [Active], 
	CASE 
		WHEN js.CreatedBy IS NULL THEN 'load script' 
		ELSE js.CreatedBy 
	END 
 as
	 [CreatedBy], -- need to read from actual master table
	GetDate() as [CreatedDate], -- need to read from actual master table
	CASE 
		WHEN js.UpdtBy IS NULL THEN 'load script' 
		ELSE js.UpdtBy 
	END as [UpdatedBy], -- need to read from actual master table
	GetDate() as [UpdatedDate] -- need to read from actual master table
FROM
	[jjscasemgt].[dbo].[tbljuvsupp] js,
	Person p
WHERE js.JuvenileID = p.ID 

/* Person [jjscasemgt].[dbo].[tblFamilyProfile] */
INSERT INTO [dbo].[Person]
(
	[tempFamilyProfileId],
	[tempAddrID],
	[LastName],
	[FirstName],
	[MiddleName],
	[SuffixID],
	[JTS],
	[DOB],
	[RaceID],
	[GenderID],
	[SSN],	
	[Active],
	[CreatedBy], 
	[CreatedDate],
	[UpdatedBy], 
	[UpdatedDate] 
	
)
SELECT
	fp.FamilyProfileId as [tempFamilyProfileId],
	fp.AddrID as [tempAddrID],
	fp.LName as [LastName],
	fp.FName as [FirstName],
	fp.MName as [MiddleName],
	(SELECT ID FROM Suffix WHERE fp.SufName = Name) as [SuffixID],
	null as [JTS],
	fp.DOB as [DOB],
	null as [RaceID],
	null as [GenderID],
	fp.SSN as [SSN],	
	1 as [Active],
	CASE 
		WHEN fp.CreatedBy IS NULL THEN 'load script' 
		ELSE fp.CreatedBy 
	END as [CreatedBy],
	CASE 
		WHEN fp.CreatedDt IS NULL THEN '2002-01-01 00:00:00' 
		ELSE fp.CreatedDt 
	END as [CreatedDate], 
	CASE 
		WHEN fp.UpdtBy IS NULL THEN 'load script' 
		ELSE fp.UpdtBy 
	END as [UpdatedBy],
	CASE 
		WHEN fp.UpdtDt IS NULL THEN '2002-01-01 00:00:00' 
		ELSE fp.UpdtDt 
	END as [UpdatedDate]
FROM [jjscasemgt].[dbo].tblFamilyProfile fp
-- Below filter is to load only the family profiles of Juveniles who have referral services.
INNER JOIN [jjscasemgt].[dbo].tblJuvFamily jf ON fp.FamilyProfileID = jf.FamilyProfileID
WHERE jf.JuvenileID IN (SELECT ID FROM PERSON)

/** FamilyProfile [jjscasemgt].[dbo].tblJuvFamily **/
INSERT INTO [dbo].[FamilyProfile]
(
	ClientProfilePersonID,
	FamilyMemberID,
	RelationshipID,
	PrimaryContactFlag,
	CreatedBy,
	CreatedDate,
	UpdatedBy,
	UpdatedDate
)
SELECT 
DISTINCT 
	CASE 
		WHEN (SELECT ID FROM ClientProfile WHERE PersonID = a.JuvenileId) IS NULL THEN 1
		ELSE (SELECT ID FROM ClientProfile WHERE PersonID = a.JuvenileId)
	END as [ClientProfilePersonID], 
	b.ID as [FamilyMemberID], 
	c.ID as [RelationshipID], 
	a.PrimaryContact as [PrimaryContactFlag], 
	CASE 
		WHEN a.CreatedBy IS NULL THEN 'load script' 
		ELSE a.CreatedBy 
	END as  [CreatedBy],
	CASE 
		WHEN a.CreatedDt IS NULL THEN '2002-01-01 00:00:00' 
		ELSE a.CreatedDt 
	END as [CreatedDate], 
	CASE 
		WHEN a.UpdtBy IS NULL THEN 'load script' 
		ELSE a.UpdtBy 
	END as [UpdatedBy],
	CASE 
		WHEN a.UpdtDt IS NULL THEN '2002-01-01 00:00:00' 
		ELSE a.UpdtDt 
	END as [UpdatedDate]
FROM [jjscasemgt].[dbo].tblJuvFamily a
INNER JOIN Person b ON a.FamilyProfileID = b.tempFamilyProfileId
INNER JOIN Relationship c ON a.RoleId = c.Name 
WHERE a.JuvenileID IN (SELECT ID FROM Person)
ORDER BY 1, 2

-- Insert into PersonSupplemental from JJSCaseMgt.tblFamilyProfile 
INSERT INTO [dbo].[PersonSupplemental]
(
	[PersonID],
	[DocketNumber],
	[POB],
	[CourtRecord],
	[MaritalStatusID],
	[JobStatusID],
	[Employer],
	[HomePhone],
	[WorkPhone],
	[OtherPhone],
	[BVCS],
	[HeightFt],
	[HeightIn],
	[Weight],
	[HairColor],
	[EyeColor],
	[HasMedicaid],
	[HasInsurance],
	[SchoolID],
	[EducID],
	[EducationLevelID],
	[SchoolYr],
	[HasExceptionEduc],
	[HasDriversLicense],
	[OtherAgencyContacts],
	[PhysicalHealth],
	[MentalHealth],
	[SubstanceAbuse],
	[XRefJuv],
	[Comments],
	[WorkPhoneExt],
	[OtherPhoneExt],
	[income],
	[HobbiesInterests],
	[Active],
	[CreatedBy],
	[CreatedDate],
	[UpdatedBy],
	[UpdatedDate]
)
SELECT 
	P.ID as [PersonID],
	null as [DocketNumber], -- not available for FamilyProfile
	fp.POB as [POB],
	fp.CourtRecord as [CourtRecord],		
	CASE
		WHEN (SELECT TOP 1 ms.ID FROM maritalstatus ms WHERE ms.Name = fp.MaritalStatus) IS NULL THEN 6 -- 6 for UNKNOWN
		ELSE (SELECT TOP 1 ms.ID FROM maritalstatus ms WHERE ms.Name = fp.MaritalStatus)
	END as [MaritalStatusID],
	CASE
		WHEN (fp.JobStatusID = 999 OR fp.JobStatusID = 0) THEN 12 -- 12 for NA
		ELSE fp.JobStatusID
	END as [JobStatusID],
	--fp.JobStatusID as [JobStatusID],
	fp.Employer as [Employer],
	fp.HomePhone as [HomePhone],	
	fp.WorkPhone as [WorkPhone],	
	fp.OtherPhone as [OtherPhone],	
	null as [BVCS], -- not available for FamilyProfile
	null as [HeightFt], -- not available for FamilyProfile
	null as [HeightIn], -- not available for FamilyProfile
	null as [Weight], -- not available for FamilyProfile
	null as [HairColor], -- not available for FamilyProfile
	null as [EyeColor], -- not available for FamilyProfile
	null as [HasMedicaid], -- not available for FamilyProfile
	null as [HasInsurance], -- not available for FamilyProfile
	null as [SchoolID], -- not available for FamilyProfile
	null as [EducID],-- not available for FamilyProfile
	CASE
		WHEN (SELECT TOP 1 el.ID FROM EducationLevel el WHERE el.Name = fp.EducLevelCd) IS NULL THEN 17 -- 17 for UNKNOWN
		ELSE (SELECT TOP 1 el.ID FROM EducationLevel el WHERE el.Name = fp.EducLevelCd)
	END as [EducationLevelID],
	--fp.EducLevelCd as [EducationLevelID], -- need to read from actual master table
	null as [SchoolYr],-- not available for FamilyProfile
	null as [HasExceptionEduc], -- not available for FamilyProfile
	null as [HasDriversLicense], -- not available for FamilyProfile
	null as [OtherAgencyContacts], -- not available for FamilyProfile
	fp.PhysicalHealth as [PhysicalHealth],
	fp.MentalHealth as [MentalHealth],
	fp.SubstanceAbuse as [SubstanceAbuse],
	fp.xRefJuv as [XRefJuv],
	fp.Comments as [Comments],
	fp.WorkPhoneExt as [WorkPhoneExt],
	fp.OtherPhoneExt as [OtherPhoneExt],
	fp.Income as [Income],
	null as [HobbiesInterests], -- not available for FamilyProfile
	1 as [Active], -- need to read from actual master table
	CASE 
		WHEN fp.CreatedBy IS NULL THEN 'load script' 
		ELSE fp.CreatedBy 
	END as [CreatedBy],
	CASE 
		WHEN fp.CreatedDt IS NULL THEN GetDate() 
		ELSE fp.CreatedDt 
	END as [CreatedDate], 
	CASE 
		WHEN fp.UpdtBy IS NULL THEN 'load script' 
		ELSE fp.UpdtBy 
	END as [UpdatedBy],
	CASE 
		WHEN fp.UpdtDt IS NULL THEN GetDate() 
		ELSE fp.UpdtDt
	END as [UpdatedDate]
	FROM
	[jjscasemgt].[dbo].[tblFamilyProfile] fp,
	Person p
WHERE fp.FamilyProfileID = p.tempfamilyprofileid 

-- Insert into PersonAddress from JJSCaseMgt.tblAddress 
-- Load data only for city address
INSERT INTO [dbo].[PersonAddress]
(
	[PersonID],
	[AddressTypeID],
	[GISCode],
	[Latitude],
	[Longitude],
	[AddressLineOne],
	[AddressLineTwo],
	[City],
	[State],
	[Zip],
	[POBox],
	[Comments],
	[Active],
	[CreatedBy], 
	[CreatedDate],
	[UpdatedBy], 
	[UpdatedDate] 
)
SELECT
	p.ID as [PersonID],
	jxrefadd.AddrTypeID as [AddressTypeID],
	LTRIM(RTRIM(jadd.StAddrID)) as [GISCode],
	NULL as [Latitude],
	NULL as [Longitude],
	NULL as [AddressLineOne],
	NULL as [AddressLineTwo],
	LTRIM(RTRIM(jadd.City)) as [City],
	LTRIM(RTRIM(jadd.State)) as [State],
	LTRIM(RTRIM(jadd.Zip)) as [Zip],
	NULL as [POBox],	
	NULL as [Comments],	
	1 as [Active],
    1 as [CreatedBy],
	CASE 
		WHEN jadd.CreatedOn IS NULL THEN GetDate() 
		ELSE jadd.CreatedOn 
	END as [CreatedDate], 
    1 as [UpdatedBy],
	CASE 
		WHEN jadd.UpdatedOn IS NULL THEN GetDate() 
		ELSE jadd.UpdatedOn 
	END as [UpdatedDate]
FROM 
	[jjscasemgt].[dbo].[tblXRefAddress] jxrefadd,
	[jjscasemgt].[dbo].[tblAddress] jadd,
	Person p
WHERE 
	p.tempAddrID = jxrefadd.XRefAddrID
	AND
	jxrefadd.AddrID = jadd.AddrID
	AND
	p.tempFamilyProfileID IS NULL
	AND
	LTRIM(RTRIM(jadd.StAddrID)) not like '-%'	

-- Insert into PersonAddress from JJSCaseMgt.tblAddress 
-- Load data only for non-city address
INSERT INTO [dbo].[PersonAddress]
(
	[PersonID],
	[AddressTypeID],
	[GISCode],
	[Latitude],
	[Longitude],
	[AddressLineOne],
	[AddressLineTwo],
	[City],
	[State],
	[Zip],
	[POBox],	
	[Active],
	[CreatedBy], 
	[CreatedDate],
	[UpdatedBy], 
	[UpdatedDate] 
)
SELECT
	p.ID as [PersonID],
	CASE WHEN jxrefadd.AddrTypeID = 1 THEN 2 
		 WHEN jxrefadd.AddrTypeID = 3 THEN 4
		 ELSE NULL
	END as [AddressTypeID],
	NULL as [GISCode],   -- GIS Code will be NULL for non-city addresses
	NULL as [Latitude],  -- Latitude will be loaded using BING with a separate script
	NULL as [Longitude], -- Longitude will be loaded using BING with a separate script
	RTRIM(
	 CASE WHEN jaddout.Building_Num <> '' THEN jaddout.Building_Num END
	 + CASE WHEN jaddout.Building_Num <> '' THEN ' ' + jaddout.St_Direction ELSE jaddout.St_Direction END
	 + CASE WHEN jaddout.St_Direction <> '' THEN ' ' + jaddout.Street_Name ELSE jaddout.Street_Name END
	 + CASE WHEN jaddout.Street_Name <> '' THEN ' ' + jaddout.Nomenclature ELSE jaddout.Nomenclature END
	 ) as [AddressLineOne],
	RTRIM( CASE WHEN jaddout.Nomenclature <> '' THEN '' + jaddout.Extended_Type ELSE jaddout.Extended_Type END
	 + CASE WHEN jaddout.Extended_Type <> '' THEN ' ' + jaddout.Extended_Num ELSE jaddout.Extended_Num END
	 ) as [AddressLineTwo],
	LTRIM(RTRIM(jadd.City)) as [City],
	LTRIM(RTRIM(jadd.State)) as [State],
	LTRIM(RTRIM(jadd.Zip)) as [Zip],
	NULL as [POBox],	
	1 as [Active],
    1 as [CreatedBy],
	CASE 
		WHEN jadd.CreatedOn IS NULL THEN GetDate() 
		ELSE jadd.CreatedOn 
	END as [CreatedDate], 
    1 as [UpdatedBy],
	CASE 
		WHEN jadd.UpdatedOn IS NULL THEN GetDate() 
		ELSE jadd.UpdatedOn 
	END as [UpdatedDate]
FROM 
	[jjscasemgt].[dbo].[tblXRefAddress] jxrefadd,
	[jjscasemgt].[dbo].[tblAddress] jadd,
	Person p,
	[jjscasemgt].[dbo].[tblAddressOut] jaddout
WHERE 
	p.tempAddrID = jxrefadd.XRefAddrID
	AND
	jxrefadd.AddrID = jadd.AddrID
	AND
	p.tempFamilyProfileID IS NULL	
	AND
	LTRIM(RTRIM(jadd.StAddrID)) like '-%'
	AND
	jadd.StAddrID = jaddout.Cor_Addr_Num

-- Insert into PersonAddress from JJSCaseMgt.tblAddress for FamilyProfile Persons
-- Load data only for city address
INSERT INTO [dbo].[PersonAddress]
(
	[PersonID],
	[AddressTypeID],
	[GISCode],
	[Latitude],
	[Longitude],
	[AddressLineOne],
	[AddressLineTwo],
	[City],
	[State],
	[Zip],
	[POBox],
	[Comments],
	[Active],
	[CreatedBy], 
	[CreatedDate],
	[UpdatedBy], 
	[UpdatedDate] 
)
SELECT
	p.ID as [PersonID],
	jxrefadd.AddrTypeID as [AddressTypeID],
	LTRIM(RTRIM(jadd.StAddrID)) as [GISCode],
	NULL as [Latitude],
	NULL as [Longitude],
	NULL as [AddressLineOne],
	NULL as [AddressLineTwo],
	LTRIM(RTRIM(jadd.City)) as [City],
	LTRIM(RTRIM(jadd.State)) as [State],
	LTRIM(RTRIM(jadd.Zip)) as [Zip],
	NULL as [POBox],	
	NULL as [Comments],	
	1 as [Active],
    1 as [CreatedBy],
	CASE 
		WHEN jadd.CreatedOn IS NULL THEN GetDate() 
		ELSE jadd.CreatedOn 
	END as [CreatedDate], 
    1 as [UpdatedBy],
	CASE 
		WHEN jadd.UpdatedOn IS NULL THEN GetDate() 
		ELSE jadd.UpdatedOn 
	END as [UpdatedDate]
FROM 
	[jjscasemgt].[dbo].[tblXRefAddress] jxrefadd,
	[jjscasemgt].[dbo].[tblAddress] jadd,
	Person p
WHERE 
	p.tempAddrID = jxrefadd.XRefAddrID
	AND
	jxrefadd.AddrID = jadd.AddrID
	AND
	p.tempFamilyProfileID IS NOT NULL
	AND
	LTRIM(RTRIM(jadd.StAddrID)) not like '-%'	

-- Insert into PersonAddress from JJSCaseMgt.tblAddress for FamilyProfile Persons
-- Load data only for non-city address
INSERT INTO [dbo].[PersonAddress]
(
	[PersonID],
	[AddressTypeID],
	[GISCode],
	[Latitude],
	[Longitude],
	[AddressLineOne],
	[AddressLineTwo],
	[City],
	[State],
	[Zip],
	[POBox],	
	[Active],
	[CreatedBy], 
	[CreatedDate],
	[UpdatedBy], 
	[UpdatedDate] 
)
SELECT
	p.ID as [PersonID],
	CASE WHEN jxrefadd.AddrTypeID = 1 THEN 2 
		 WHEN jxrefadd.AddrTypeID = 3 THEN 4
		 ELSE NULL
	END as [AddressTypeID],
	NULL as [GISCode],   -- GIS Code will be NULL for non-city addresses
	NULL as [Latitude],  -- Latitude will be loaded using BING with a separate script
	NULL as [Longitude], -- Longitude will be loaded using BING with a separate script
	RTRIM(
	 CASE WHEN jaddout.Building_Num <> '' THEN jaddout.Building_Num END
	 + CASE WHEN jaddout.Building_Num <> '' THEN ' ' + jaddout.St_Direction ELSE jaddout.St_Direction END
	 + CASE WHEN jaddout.St_Direction <> '' THEN ' ' + jaddout.Street_Name ELSE jaddout.Street_Name END
	 + CASE WHEN jaddout.Street_Name <> '' THEN ' ' + jaddout.Nomenclature ELSE jaddout.Nomenclature END
	 ) as [AddressLineOne],
	RTRIM( CASE WHEN jaddout.Nomenclature <> '' THEN '' + jaddout.Extended_Type ELSE jaddout.Extended_Type END
	 + CASE WHEN jaddout.Extended_Type <> '' THEN ' ' + jaddout.Extended_Num ELSE jaddout.Extended_Num END
	 ) as [AddressLineTwo],
	LTRIM(RTRIM(jadd.City)) as [City],
	LTRIM(RTRIM(jadd.State)) as [State],
	LTRIM(RTRIM(jadd.Zip)) as [Zip],
	NULL as [POBox],	
	1 as [Active],
    1 as [CreatedBy],
	CASE 
		WHEN jadd.CreatedOn IS NULL THEN GetDate() 
		ELSE jadd.CreatedOn 
	END as [CreatedDate], 
    1 as [UpdatedBy],
	CASE 
		WHEN jadd.UpdatedOn IS NULL THEN GetDate() 
		ELSE jadd.UpdatedOn 
	END as [UpdatedDate]
FROM 
	[jjscasemgt].[dbo].[tblXRefAddress] jxrefadd,
	[jjscasemgt].[dbo].[tblAddress] jadd,
	Person p,
	[jjscasemgt].[dbo].[tblAddressOut] jaddout
WHERE 
	p.tempFamilyProfileID IS NOT NULL
	AND
	p.tempAddrID = jxrefadd.XRefAddrID
	AND
	jxrefadd.AddrID = jadd.AddrID
	AND
	jadd.StAddrID = jaddout.Cor_Addr_Num

					/** END OF: INSERTING PERSON RELATED DATA  **/
				   /** START OF: INSERTING CLIENT PROFILE RELATED DATA  **/

/* Assessment [jjscasemgt].[dbo].[tblAssessment] */
SET IDENTITY_INSERT [dbo].[Assessment] ON
INSERT INTO [dbo].[Assessment]
(
	[ID],
    [ClientProfileID],
    [StaffID],
    [OffenseComments],
    [FamilyComments],
    [EducationComments],
    [PeerComments],
    [SubstanceComments],
    [BehaviorComments],
    [MentalComments],
    [CurrentCharge],
    [Placement],
    [Service],
    [SocialHistory],
    [Level1Case],
    [Level2Case],
    [CommentsStrength],
    [Source],
    [AssessmentDate],
    [AssessmentTypeID],
    [AssessmentSubtypeID],
    [AssessmentScore],
    [Notes],
    [Active],
    [CreatedBy],
    [CreatedDate],
    [UpdatedBy],
    [UpdatedDate]
)
SELECT 
	tas.AssessID as [ID],
    (SELECT TOP 1 cp.[ID] FROM ClientProfile cp WHERE cp.PersonID = tas.JuvenileID) as [ClientProfileID],
	CASE
		WHEN (SELECT TOP 1 k.ID FROM staff k WHERE tas.StaffId <> k.ID) IS NULL THEN 1
		ELSE (SELECT TOP 1 k.ID FROM staff k WHERE tas.CreatedBy = k.NetLogin) 
	END as StaffID,
    OffenseComments as [OffenseComments],
    FamilyComments as [FamilyComments],
    EducationComments as [EducationComments],
    PeerComments as [PeerComments],
    SubstanceComments as [SubstanceComments],
    BehaviorComments as [BehaviorComments],
    MentalComments as [MentalComments],
    CurrentCharge as [CurrentCharge],
    Placement as [Placement],
    [Service] as [Service],
	CASE tas.SocialHistory
		WHEN 'N' THEN 0
		WHEN 'Y' THEN 1
		ELSE Null
	END as [SocialHistory],     
	CASE tas.Level1Case_Div
		WHEN 'N' THEN 0
		WHEN 'Y' THEN 1
		ELSE Null
	END as [Level1Case],     
	CASE tas.Level2Case
		WHEN 'N' THEN 0
		WHEN 'Y' THEN 1
		ELSE Null
	END as [Level2Case],
    CommentsStrength as [CommentsStrength],
    Source as [Source],
    AssessmentDate as [AssessmentDate],
	(SELECT TOP 1 at.[ID] FROM AssessmentType at WHERE tas.AssessmentType = at.Name) as [AssessmentTypeID],
	(SELECT TOP 1 ast.[ID] FROM AssessmentSubType ast WHERE tas.SubType = ast.Name ) as [AssessmentSubtypeID],
    AssessmentScore as [AssessmentScore],
    Notes as [Notes],
	1 as [Active],
    1 as [CreatedBy],
	CASE 
		WHEN tas.CreatedDt IS NULL THEN '2002-01-01 00:00:00' 
		ELSE tas.CreatedDt 
	END as [CreatedDate], 
    1 as [UpdatedBy],
	CASE 
		WHEN tas.UpdtDt IS NULL THEN '2002-01-01 00:00:00' 
		ELSE tas.UpdtDt 
	END as [UpdatedDate]		
FROM
	[jjscasemgt].[dbo].[tblAssessment] tas
SET IDENTITY_INSERT [dbo].[Assessment] OFF


/* Referral [jjscasemgt].[dbo].[tblReferral] */
SET IDENTITY_INSERT [dbo].[Placement] ON
INSERT INTO [dbo].[Placement]
(
	[ID],
    [ClientProfileID],
    [CourtOrderDate],
    [NextCourtDate],
    [CourtOrderNarrative],
    [PlacementLevelID],
    --[SourceID],
--    [PlacementCharges],
--    [AgeAtTime],
    [JudgeID],
    [Active],
    [CreatedBy],
    [CreatedDate],
    [UpdatedBy],
    [UpdatedDate]
)
SELECT 
	ref.ReferralID as [ID],
	CASE
		WHEN (SELECT a.ID from ClientProfile a WHERE a.PersonID = ref.JuvenileID) IS NULL THEN 1 
		ELSE (SELECT a.ID from ClientProfile a WHERE a.PersonID = ref.JuvenileID)
	END as [ClientProfileID],
    ref.CourtOrderDt as [CourtOrderDate],
    ref.NextCourtDt as [NextCourtDate],
    ref.CourtOrderNarr as [CourtOrderNarrative],
    ref.PlacementLevelID as [PlacementLevelID],
	--( SELECT TOP 1 x.ID from LoginProfile x WHERE x.SystemID = 1 and x.AccountName IN (
	--SELECT b.NetLogin FROM [jjscasemgt].[dbo].[tblStaff] b 
	--WHERE b.StaffID = ref.ReferralSourceID) 
	--) as [SourceID],
--    as [PlacementCharges],
--    Age as [AgeAtTime],
    JudgeID as [JudgeID],
	1 as [Active],
    1 as [CreatedBy],
	CASE 
		WHEN ref.CreatedDt IS NULL THEN '2002-01-01 00:00:00' 
		ELSE ref.CreatedDt 
	END as [CreatedDate], 
    1 as [UpdatedBy],
	CASE 
		WHEN ref.UpdtDt IS NULL THEN '2002-01-01 00:00:00' 
		ELSE ref.UpdtDt 
	END as [UpdatedDate]
FROM 
	[jjscasemgt].[dbo].[tblReferral] ref
WHERE ref.ReferralID IN 
(SELECT DISTINCT ReferralID FROM [jjscasemgt].[dbo].[tblRefServices])-- This filter is added to eliminate the load of records in referral table without ref services

SET IDENTITY_INSERT [dbo].[Placement] OFF

/* Enrollment [jjscasemgt].[dbo].[tblReferral] */
INSERT INTO [DBO].[PlacementOffense]
(
	[PlacementID],
	[OffenseID],
	[Active],
	[CreatedBy],
	[CreatedDate],
	[UpdatedBy],
	[UpdatedDate]
)
SELECT 
	a.ReferralID as [PlacementID], 
	c.Items as [OffenseID],
	1 as [Active],
	1 as [CreatedBy], 
	GetDate() as [CreatedDate],
	1 as [UpdatedBy], 
	GetDate() as [UpdatedDate]
FROM 
	[jjscasemgt].[dbo].[tblVAOffenseCodes] b,
	[jjscasemgt].[dbo].[tblReferral] a
	cross apply
	dbo.Split(A.PlacementCharges, ',') c
WHERE
	b.OffenseID = c.Items
	/*Modified to avoid script error*/
	AND a.PlacementCharges not LIKE '%.%'
    AND a.ReferralID IN 
(SELECT DISTINCT ReferralID FROM [jjscasemgt].[dbo].[tblRefServices])-- This join is added to eliminate the load of records in referral table without ref services
ORDER BY JuvenileID

/* Enrollment [jjscasemgt].[dbo].[tblRefServices] */
SET IDENTITY_INSERT [dbo].[Enrollment] ON
INSERT INTO [dbo].[Enrollment]
(
	[ID],
    [PlacementID],
	[ReferralDate],
    [ServiceProgramCategoryID],
    [SourceID],
    [BasisofReferral],
    [Comments],
    [SuppComments],
    [BeginDate],
    [EndDate],
    [Outcome],
    [ServiceOutcomeID],
    [ServiceReleaseID],
   
    [CounselorID],
    [SourceNotes],
    [MonitorOption],
    [ComHoursAssigned],
    [Active],
    [CreatedBy],
    [CreatedDate],
    [UpdatedBy],
    [UpdatedDate]
)
SELECT
	refSer.RefServID as [ID],
	refSer.ReferralID as [PlacementID],
	refser.DateofReferral as [ReferralDate],
	(SELECT TOP 1 ID
	FROM
		(
			SELECT spc.ID, sp.Name+sc.Name as Name 
			FROM ServiceProgramCategory spc 
			INNER JOIN ServiceProgram sp ON spc.ServiceProgramID = sp.ID
			INNER JOIN ServiceCategory sc ON spc.ServiceCategoryID = sc.ID
		) a
		WHERE Name = (
			SELECT TOP 1 ServiceName+Program FROM [jjscasemgt].[dbo].[tblServiceProfiles] t 
			WHERE t.ServiceProfileID = refSer.ServiceProfileID)
	) as [ServiceProgramCategoryID],
    ( SELECT TOP 1 s.ID from Staff s WHERE s.Netlogin IN (
		SELECT b.NetLogin FROM [jjscasemgt].[dbo].[tblStaff] b 
		WHERE b.StaffID = refSer.RefSourceID) 
	) as [SourceID],
    refSer.BasisofReferral as [BasisofReferral],
    refSer.Comments as [Comments],
    refSer.SuppComments as [SuppComments],
    refSer.BeginDt as [BeginDate],
    refSer.EndDt as [EndDate],
    refSer.Outcome as [Outcome],
	(SELECT TOP 1 k.ID FROM ServiceOutcome k WHERE refSer.OutcomeID = k.ID) as [ServiceOutcomeID],
	(SELECT TOP 1 k.ID FROM ServiceRelease k WHERE refSer.ReleaseID = k.ID) as [ServiceReleaseID],
   
    ( SELECT TOP 1 s1.ID from staff s1 WHERE s1.NetLogin IN (
		SELECT b.NetLogin FROM [jjscasemgt].[dbo].[tblStaff] b 
		WHERE b.StaffID = refSer.CounselorID) 
	) as [CounselorID],
    refSer.RefSourceNotes as [SourceNotes],
    refSer.MonitorOption as [MonitorOption],
    refSer.ComHoursAssigned as [ComHoursAssigned],
	1 as [Active],
    1 as [CreatedBy],
	CASE 
		WHEN refSer.CreatedDt IS NULL THEN '2002-01-01 00:00:00' 
		ELSE refSer.CreatedDt 
	END as [CreatedDate], 
    1 as [UpdatedBy],
	CASE 
		WHEN refSer.UpdtDt IS NULL THEN '2002-01-01 00:00:00' 
		ELSE refSer.UpdtDt 
	END as [UpdatedDate]
FROM 
	[jjscasemgt].[dbo].[tblRefServices] refSer
WHERE 
	refSer.ReferralID IN (SELECT ReferralID FROM [jjscasemgt].[dbo].[tblReferral])

SET IDENTITY_INSERT [dbo].[Enrollment] OFF


/* ProgressNote [jjscasemgt].[dbo].[tblProgressNotes] */
SET IDENTITY_INSERT [dbo].[ProgressNote] ON
INSERT INTO [dbo].[ProgressNote]
(
	[ID],
	[EnrollmentID],
	[CommentDate],
	[Comment],
	[ContactTypeID],
	[Duration],
	[CreatedBy],
	[CreatedDate],
	[UpdatedBy],
	[UpdatedDate]
)
SELECT
	pn.recID as [ID],
	pn.RefServID as [EnrollmentID],
	pn.DateComment as [CommentDate],
	pn.SuppCommentRow as [Comment],
	NULL as [ContactTypeID],
	NULL as [Duration],
    1 as [CreatedBy],
	CASE 
		WHEN pn.AddDt IS NULL THEN '2002-01-01 00:00:00' 
		ELSE pn.AddDt 
	END as [CreatedDate],
    1 as [UpdatedBy],
	CASE 
		WHEN pn.UpdtDt IS NULL THEN '2002-01-01 00:00:00' 
		ELSE pn.UpdtDt 
	END as [UpdatedDate]
FROM jjscasemgt.[dbo].[tblProgressNotes] pn
WHERE pn.RefServID IN (SELECT ID FROM Enrollment)
ORDER BY pn.recID 

SET IDENTITY_INSERT [dbo].[ProgressNote] OFF

/* ServiceUnit */
/* 
   select * from [dbo].[ServiceUnit] 
   select * from [jjscasemgt].[dbo].[tblMthService]	

   	delete from [dbo].[ServiceUnit] 
	DBCC CHECKIDENT('ServiceUnit', RESEED, 0)
*/
INSERT INTO [dbo].[ServiceUnit] 
(
    [SystemID],
    [EnrollmentID],
    [Year],
    [Month],
    [Units],
    [CreatedBy],
    [CreatedDate],
    [UpdatedBy],
    [UpdatedDate],
    [Active]
	
)
SELECT
    1 as [SystemID],
    su.RefServID as [EnrollmentID],
    su.[Year] as [Year],
    su.[Month] as [Month],
    su.Units as [Units],
	
    1 as [CreatedBy],
	CASE 
		WHEN su.CreatedDt IS NULL THEN '2002-01-01 00:00:00' 
		ELSE su.CreatedDt 
	END as [CreatedDate], 
    1 as [UpdatedBy],
	CASE 
		WHEN su.UpdtDt IS NULL THEN '2002-01-01 00:00:00' 
		ELSE su.UpdtDt 
	END as [UpdatedDate],
	1  as [Active]
FROM
	[jjscasemgt].[dbo].[tblMthService] su
WHERE
	su.RefServID IN (SELECT ID FROM Enrollment)


				   /**  END OF: INSERTING CLIENT PROFILE RELATED DATA   **/
