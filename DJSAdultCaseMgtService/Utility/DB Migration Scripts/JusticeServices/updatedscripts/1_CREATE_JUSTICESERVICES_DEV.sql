use JusticeServices 
go
/****** Object:  UserDefinedFunction [dbo].[Split]    Script Date: 2/8/2016 12:17:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Split](@String nvarchar(4000), @Delimiter char(1))
RETURNS @Results TABLE (Items nvarchar(4000))
AS
BEGIN
DECLARE @INDEX INT
DECLARE @SLICE nvarchar(4000)
-- HAVE TO SET TO 1 SO IT DOESNT EQUAL Z
--     ERO FIRST TIME IN LOOP
SELECT @INDEX = 1
WHILE @INDEX !=0
BEGIN
-- GET THE INDEX OF THE FIRST OCCURENCE OF THE SPLIT CHARACTER
SELECT @INDEX = CHARINDEX(@Delimiter,@STRING)
-- NOW PUSH EVERYTHING TO THE LEFT OF IT INTO THE SLICE VARIABLE
IF @INDEX !=0
SELECT @SLICE = LEFT(@STRING,@INDEX - 1)
ELSE
SELECT @SLICE = @STRING
-- PUT THE ITEM INTO THE RESULTS SET
INSERT INTO @Results(Items) VALUES(@SLICE)
-- CHOP THE ITEM REMOVED OFF THE MAIN STRING
SELECT @STRING = RIGHT(@STRING,LEN(@STRING) - @INDEX)
-- BREAK OUT IF WE ARE DONE
IF LEN(@STRING) = 0 BREAK
END
RETURN
END

GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AddressType]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AddressType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[Active] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.AddressType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Application]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Application](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Active] [bit] NOT NULL,
	[SystemID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.Application] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Assessment]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Assessment](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientProfileID] [int] NULL,
	[StaffID] [int] NULL,
	[AssessmentDate] [datetime] NULL,
	[AssessmentTypeID] [int] NULL,
	[AssessmentSubtypeID] [int] NULL,
	[AssessmentScore] [nvarchar](max) NULL,
	[Notes] [nvarchar](max) NULL,
	[Active] [bit] NOT NULL,
	[OffenseComments] [nvarchar](max) NULL,
	[FamilyComments] [nvarchar](max) NULL,
	[EducationComments] [nvarchar](max) NULL,
	[PeerComments] [nvarchar](max) NULL,
	[SubstanceComments] [nvarchar](max) NULL,
	[BehaviorComments] [nvarchar](max) NULL,
	[MentalComments] [nvarchar](max) NULL,
	[CurrentCharge] [nvarchar](max) NULL,
	[Placement] [nvarchar](max) NULL,
	[Service] [nvarchar](max) NULL,
	[SocialHistory] [bit] NULL,
	[Level1Case] [bit] NULL,
	[Level2Case] [bit] NULL,
	[CommentsStrength] [nvarchar](max) NULL,
	[Source] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.Assessment] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AssessmentSubtype]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AssessmentSubtype](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](200) NULL,
	[Active] [bit] NOT NULL,
	[SystemID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.AssessmentSubtype] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AssessmentType]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AssessmentType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](200) NULL,
	[Active] [bit] NOT NULL,
	[SystemID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.AssessmentType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ClientProfile]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientProfile](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PersonID] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[SystemID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.ClientProfile] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ContactType]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[Active] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.ContactType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Document]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Document](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[FileName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](200) NULL,
	[Active] [bit] NOT NULL,
	[SystemID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.Document] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EducationLevel]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EducationLevel](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](35) NOT NULL,
	[Description] [nvarchar](50) NULL,
	[Active] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.EducationLevel] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Enrollment]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Enrollment](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PlacementID] [int] NOT NULL,
	[ReferralDate] [datetime] NULL,
	[ServiceProgramCategoryID] [int] NULL,
	[SourceID] [int] NULL,
	[BasisofReferral] [nvarchar](max) NULL,
	[Comments] [nvarchar](max) NULL,
	[SuppComments] [nvarchar](max) NULL,
	[BeginDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[Outcome] [nvarchar](max) NULL,
	[ServiceOutcomeID] [int] NULL,
	[ServiceReleaseID] [int] NULL,
	[CounselorID] [int] NULL,
	[SourceNotes] [nvarchar](max) NULL,
	[MonitorOption] [nvarchar](max) NULL,
	[ComHoursAssigned] [int] NULL,
	[Active] [bit] NOT NULL,
	[ICN] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.Enrollment] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FamilyProfile]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FamilyProfile](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientProfilePersonID] [int] NOT NULL,
	[FamilyMemberID] [int] NOT NULL,
	[RelationshipID] [int] NOT NULL,
	[PrimaryContactFlag] [bit] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
	[Active] [bit] NOT NULL DEFAULT 1,
 CONSTRAINT [PK_dbo.FamilyProfile] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Gender]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gender](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](10) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[Active] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.Gender] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[JobStatus]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobStatus](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](25) NOT NULL,
	[Description] [nvarchar](50) NULL,
	[Active] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.JobStatus] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[JobTitle]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobTitle](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](50) NULL,
	[Active] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.JobTitle] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Judge]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Judge](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](50) NULL,
	[Active] [bit] NOT NULL,
	[SystemID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.Judge] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

--GO
--/****** Object:  Table [dbo].[Login]    Script Date: 7/16/2015 5:19:30 PM ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--CREATE TABLE [dbo].[Login](
--	[ID] [int] IDENTITY(1,1) NOT NULL,
--	[FirstName] [nvarchar](max) NOT NULL,
--	[LastName] [nvarchar](max) NOT NULL,
--	[MiddleName] [nvarchar](max) NULL,
--	[Email] [nvarchar](max) NULL,
--	[JobTitleID] [int] NULL,
--	[Department] [nvarchar](max) NULL,
--	[Agency] [nvarchar](max) NULL,
--	[PhoneNumber] [nvarchar](max) NULL,
--	[FaxNumber] [nvarchar](max) NULL,
--	[OfficeLocation] [nvarchar](max) NULL,
--	[Active] [bit] NOT NULL,
--	[CreatedDate] [datetime] NOT NULL,
--	[CreatedBy] [int] NOT NULL,
--	[UpdatedDate] [datetime] NOT NULL,
--	[UpdatedBy] [int] NOT NULL,
-- CONSTRAINT [PK_dbo.Login] PRIMARY KEY CLUSTERED 
--(
--	[ID] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

--GO
--/****** Object:  Table [dbo].[LoginDomain]    Script Date: 7/16/2015 5:19:30 PM ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--CREATE TABLE [dbo].[LoginDomain](
--	[ID] [int] IDENTITY(1,1) NOT NULL,
--	[Name] [nvarchar](20) NOT NULL,
--	[Active] [bit] NOT NULL,
--	[CreatedDate] [datetime] NOT NULL,
--	[CreatedBy] [int] NOT NULL,
--	[UpdatedDate] [datetime] NOT NULL,
--	[UpdatedBy] [int] NOT NULL,
-- CONSTRAINT [PK_dbo.LoginDomain] PRIMARY KEY CLUSTERED 
--(
--	[ID] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]

--GO
--/****** Object:  Table [dbo].[LoginProfile]    Script Date: 7/16/2015 5:19:30 PM ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--SET ANSI_PADDING ON
--GO
--CREATE TABLE [dbo].[LoginProfile](
--	[ID] [int] IDENTITY(1,1) NOT NULL,
--	[ApplicationID] [int] NOT NULL,
--	[LoginID] [int] NOT NULL,
--	[LoginRoleID] [int] NOT NULL,
--	[LoginDomainID] [int] NOT NULL,
--	[AccountName] [nvarchar](max) NULL,
--	[Password] [varbinary](max) NULL,
--	[Active] [bit] NOT NULL,
--	[SystemID] [int] NOT NULL,
--	[CreatedDate] [datetime] NOT NULL,
--	[CreatedBy] [int] NOT NULL,
--	[UpdatedDate] [datetime] NOT NULL,
--	[UpdatedBy] [int] NOT NULL,
-- CONSTRAINT [PK_dbo.LoginProfile] PRIMARY KEY CLUSTERED 
--(
--	[ID] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

--GO
--SET ANSI_PADDING OFF
--GO
--/****** Object:  Table [dbo].[LoginRole]    Script Date: 7/16/2015 5:19:30 PM ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--CREATE TABLE [dbo].[LoginRole](
--	[ID] [int] IDENTITY(1,1) NOT NULL,
--	[Name] [nvarchar](50) NOT NULL,
--	[Description] [nvarchar](500) NULL,
--	[Active] [bit] NOT NULL,
--	[CreatedDate] [datetime] NOT NULL,
--	[CreatedBy] [int] NOT NULL,
--	[UpdatedDate] [datetime] NOT NULL,
--	[UpdatedBy] [int] NOT NULL,
-- CONSTRAINT [PK_dbo.LoginRole] PRIMARY KEY CLUSTERED 
--(
--	[ID] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MaritalStatus]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MaritalStatus](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](25) NOT NULL,
	[Description] [nvarchar](50) NULL,
	[Active] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.MaritalStatus] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Offense]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Offense](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[DYFS] [nvarchar](max) NULL,
	[VCCCode] [nvarchar](max) NULL,
	[GeneralHeading] [nvarchar](max) NULL,
	[Type] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[Statute] [nvarchar](max) NULL,
	[Active] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.Offense] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Person]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Person](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[MiddleName] [nvarchar](50) NULL,
	[SuffixID] [int] NULL,
	[JTS] [nvarchar](max) NULL,
	[DOB] [datetime] NULL,
	[RaceID] [int] NULL,
	[GenderID] [int] NULL,
	[SSN] [nvarchar](max) NULL,
	[ICN] [nvarchar](max) NULL,
	[Active] [bit] NOT NULL,
	[tempFamilyProfileId] [int] NULL,
	[tempAddrID] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
	[UniqueID]  [nvarchar](50) NULL,
 CONSTRAINT [PK_dbo.Person] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PersonAddress]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonAddress](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PersonID] [int] NOT NULL,
	[AddressTypeID] [int] NOT NULL,
	[GISCode] [nvarchar](max) NULL,
	[Latitude] [decimal](18, 2) NULL,
	[Longitude] [decimal](18, 2) NULL,
	[AddressLineOne] [nvarchar](max) NULL,
	[AddressLineTwo] [nvarchar](max) NULL,
	[City] [nvarchar](max) NULL,
	[State] [nvarchar](max) NULL,
	[Zip] [nvarchar](max) NULL,
	[POBox] [nvarchar](max) NULL,
	[Comments] [nvarchar](max) NULL,
	[Active] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.PersonAddress] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PersonSupplemental]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonSupplemental](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PersonID] [int] NOT NULL,
	[DocketNumber] [nvarchar](max) NULL,
	[POB] [nvarchar](max) NULL,
	[CourtRecord] [nvarchar](max) NULL,
	[MaritalStatusID] [int] NULL,
	[JobStatusID] [int] NULL,
	[Employer] [nvarchar](max) NULL,
	[HomePhone] [nvarchar](max) NULL,
	[WorkPhone] [nvarchar](max) NULL,
	[OtherPhone] [nvarchar](max) NULL,
	[BVCS] [nvarchar](max) NULL,
	[HeightFt] [nvarchar](max) NULL,
	[HeightIn] [nvarchar](max) NULL,
	[Weight] [nvarchar](max) NULL,
	[HairColor] [nvarchar](max) NULL,
	[EyeColor] [nvarchar](max) NULL,
	[HasMedicaid] [bit] NULL,
	[HasInsurance] [bit] NULL,
	[SchoolID] [int] NULL,
	[EducID] [int] NULL,
	[EducationLevelID] [int] NULL,
	[SchoolYr] [nvarchar](max) NULL,
	[HasExceptionEduc] [bit] NULL,
	[HasDriversLicense] [bit] NULL,
	[OtherAgencyContacts] [nvarchar](max) NULL,
	[PhysicalHealth] [nvarchar](max) NULL,
	[MentalHealth] [nvarchar](max) NULL,
	[SubstanceAbuse] [nvarchar](max) NULL,
	[XRefJuv] [int] NULL,
	[Comments] [nvarchar](max) NULL,
	[WorkPhoneExt] [nvarchar](max) NULL,
	[OtherPhoneExt] [nvarchar](max) NULL,
	[Income] [nvarchar](max) NULL,
	[HobbiesInterests] [nvarchar](max) NULL,
	[Active] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.PersonSupplemental] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Placement]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Placement](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientProfileID] [int] NOT NULL,
	[JudgeID] [int] NULL,
	[CourtOrderDate] [datetime] NULL,
	[NextCourtDate] [datetime] NULL,
	[CourtOrderNarrative] [nvarchar](max) NULL,
	[PlacementLevelID] [int] NULL,
	[Active] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.Placement] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PlacementLevel]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlacementLevel](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](200) NULL,
	[Active] [bit] NOT NULL,
	[SystemID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.PlacementLevel] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PlacementOffense]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlacementOffense](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PlacementID] [int] NOT NULL,
	[OffenseID] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.PlacementOffense] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProgressNote]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProgressNote](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EnrollmentID] [int] NOT NULL,
	[CommentDate] [datetime] NOT NULL,
	[Comment] [nvarchar](max) NULL,
	[ContactTypeID] [int] NULL,
	[Duration] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
	[Active] [bit] NOT NULL DEFAULT 1,
 CONSTRAINT [PK_dbo.ProgressNote] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Race]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Race](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](2) NOT NULL,
	[Description] [nvarchar](200) NULL,
	[Active] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.Race] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Relationship]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Relationship](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](2) NOT NULL,
	[Description] [nvarchar](50) NOT NULL,
	[Active] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.Relationship] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[School]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[School](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Phone] [nvarchar](25) NULL,
	[Principal] [nvarchar](50) NULL,
	[Address] [nvarchar](255) NULL,
	[Zip] [nvarchar](50) NULL,
	[Fax] [nvarchar](25) NULL,
	[EducationLevel] [nvarchar](max) NULL,
	[SchoolCode] [nvarchar](max) NULL,
	[Active] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.School] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ServiceCategory]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceCategory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](200) NULL,
	[Active] [bit] NOT NULL,
	[SystemID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.ServiceCategory] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ServiceOutcome]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceOutcome](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](200) NULL,
	[Active] [bit] NOT NULL,
	[SystemID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.ServiceOutcome] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ServiceProgram]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceProgram](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[ServiceProviderID] [int] NULL,
	[Active] [bit] NOT NULL,
	[SystemID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.ServiceProgram] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ServiceProgramCategory]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceProgramCategory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ServiceProgramID] [int] NOT NULL,
	[ServiceCategoryID] [int] NULL,
	[Active] [bit] NOT NULL,
	[SystemID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.ServiceProgramCategory] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ServiceProvider]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceProvider](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](200) NULL,
	[Active] [bit] NOT NULL,
	[SystemID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.ServiceProvider] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ServiceRelease]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceRelease](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[ExcludeFromEnrollmentCount] [bit] NOT NULL,
	[Active] [bit] NOT NULL,
	[SystemID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.ServiceRelease] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ServiceUnit]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceUnit](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EnrollmentID] [int] NOT NULL,
	[Year] [int] NOT NULL,
	[Month] [int] NOT NULL,
	[Units] [int] NOT NULL,
	[SystemID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
	[Active]    [bit] not null,
   
	
 CONSTRAINT [PK_dbo.ServiceUnit] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Staff]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Agency] [nvarchar](max) NULL,
	[LastName] [nvarchar](max) NULL,
	[FirstName] [nvarchar](max) NULL,
	[NetLogin] [nvarchar](max) NULL,
	[Password] [nvarchar](max) NULL,
	[JobTitleID] [int] NULL,
	[Phone] [nvarchar](max) NULL,
	[Fax] [nvarchar](max) NULL,
	[EMail] [nvarchar](max) NULL,
	[Department] [nvarchar](max) NULL,
	[OfficeLocation] [nvarchar](max) NULL,
	[NetworkConnection] [nvarchar](max) NULL,
	[AccessLevelReq] [nvarchar](max) NULL,
	[SQLRole] [nvarchar](max) NULL,
	[HireDate] [datetime] NULL,
	[TerminationDate] [datetime] NULL,
	[RestrictLevel] [nvarchar](max) NULL,
	[Supervisor] [nvarchar](max) NULL,
	[Active]    [bit] not null,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
	
 CONSTRAINT [PK_dbo.Staff] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Suffix]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suffix](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](25) NOT NULL,
	[Description] [nvarchar](50) NULL,
	[Active] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.Suffix] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[System]    Script Date: 7/16/2015 5:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[System](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Active] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy]  [nvarchar](50) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UpdatedBy]  [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.System] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 3/3/2016 9:26:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 3/3/2016 9:26:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 3/3/2016 9:26:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 3/3/2016 9:26:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 3/3/2016 9:26:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Client]    Script Date: 3/3/2016 9:39:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client](
	[Id] [nvarchar](128) NOT NULL,
	[Secret] [nvarchar](max) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[ApplicationType] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[RefreshTokenLifeTime] [int] NOT NULL,
	[AllowedOrigin] [nvarchar](100) NULL,
 CONSTRAINT [PK_dbo.Client] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RefreshToken]    Script Date: 3/3/2016 9:39:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RefreshToken](
	[Id] [nvarchar](128) NOT NULL,
	[Subject] [nvarchar](50) NOT NULL,
	[ClientId] [nvarchar](50) NOT NULL,
	[IssuedUtc] [datetime] NOT NULL,
	[ExpiresUtc] [datetime] NOT NULL,
	[ProtectedTicket] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dbo.RefreshToken] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserModel]    Script Date: 3/3/2016 9:39:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserModel](
	[id] [int] NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[password] [nvarchar](50) NOT NULL,
	[confirmpassword] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_UserModel_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO

ALTER TABLE [dbo].[Application]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Application_dbo.System_SystemID] FOREIGN KEY([SystemID])
REFERENCES [dbo].[System] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Application] CHECK CONSTRAINT [FK_dbo.Application_dbo.System_SystemID]
GO
ALTER TABLE [dbo].[Assessment]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Assessment_dbo.AssessmentSubtype_AssessmentSubtypeID] FOREIGN KEY([AssessmentSubtypeID])
REFERENCES [dbo].[AssessmentSubtype] ([ID])
GO
ALTER TABLE [dbo].[Assessment] CHECK CONSTRAINT [FK_dbo.Assessment_dbo.AssessmentSubtype_AssessmentSubtypeID]
GO
ALTER TABLE [dbo].[Assessment]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Assessment_dbo.AssessmentType_AssessmentTypeID] FOREIGN KEY([AssessmentTypeID])
REFERENCES [dbo].[AssessmentType] ([ID])
GO
ALTER TABLE [dbo].[Assessment] CHECK CONSTRAINT [FK_dbo.Assessment_dbo.AssessmentType_AssessmentTypeID]
GO
ALTER TABLE [dbo].[Assessment]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Assessment_dbo.ClientProfile_ClientProfileID] FOREIGN KEY([ClientProfileID])
REFERENCES [dbo].[ClientProfile] ([ID])
GO
ALTER TABLE [dbo].[Assessment] CHECK CONSTRAINT [FK_dbo.Assessment_dbo.ClientProfile_ClientProfileID]
GO
ALTER TABLE [dbo].[Assessment]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Assessment_dbo.Staff_StaffID] FOREIGN KEY([StaffID])
REFERENCES [dbo].[Staff] ([ID])
GO
ALTER TABLE [dbo].[Assessment] CHECK CONSTRAINT [FK_dbo.Assessment_dbo.Staff_StaffID]
GO
ALTER TABLE [dbo].[ClientProfile]  WITH CHECK ADD  CONSTRAINT [FK_dbo.ClientProfile_dbo.Person_PersonID] FOREIGN KEY([PersonID])
REFERENCES [dbo].[Person] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ClientProfile] CHECK CONSTRAINT [FK_dbo.ClientProfile_dbo.Person_PersonID]
GO
ALTER TABLE [dbo].[ClientProfile]  WITH CHECK ADD  CONSTRAINT [FK_dbo.ClientProfile_dbo.System_SystemID] FOREIGN KEY([SystemID])
REFERENCES [dbo].[System] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ClientProfile] CHECK CONSTRAINT [FK_dbo.ClientProfile_dbo.System_SystemID]
GO
ALTER TABLE [dbo].[Enrollment]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Enrollment_dbo.Placement_PlacementID] FOREIGN KEY([PlacementID])
REFERENCES [dbo].[Placement] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Enrollment] CHECK CONSTRAINT [FK_dbo.Enrollment_dbo.Placement_PlacementID]
GO
ALTER TABLE [dbo].[Enrollment]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Enrollment_dbo.ServiceOutcome_ServiceOutcomeID] FOREIGN KEY([ServiceOutcomeID])
REFERENCES [dbo].[ServiceOutcome] ([ID])
GO
ALTER TABLE [dbo].[Enrollment] CHECK CONSTRAINT [FK_dbo.Enrollment_dbo.ServiceOutcome_ServiceOutcomeID]
GO
ALTER TABLE [dbo].[Enrollment]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Enrollment_dbo.ServiceProgramCategory_ServiceProgramCategoryID] FOREIGN KEY([ServiceProgramCategoryID])
REFERENCES [dbo].[ServiceProgramCategory] ([ID])
GO
ALTER TABLE [dbo].[Enrollment] CHECK CONSTRAINT [FK_dbo.Enrollment_dbo.ServiceProgramCategory_ServiceProgramCategoryID]
GO
ALTER TABLE [dbo].[Enrollment]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Enrollment_dbo.ServiceRelease_ServiceReleaseID] FOREIGN KEY([ServiceReleaseID])
REFERENCES [dbo].[ServiceRelease] ([ID])
GO
ALTER TABLE [dbo].[Enrollment] CHECK CONSTRAINT [FK_dbo.Enrollment_dbo.ServiceRelease_ServiceReleaseID]
GO
ALTER TABLE [dbo].[Enrollment]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Enrollment_dbo.Staff_CounselorID] FOREIGN KEY([CounselorID])
REFERENCES [dbo].[Staff] ([ID])
GO
ALTER TABLE [dbo].[Enrollment] CHECK CONSTRAINT [FK_dbo.Enrollment_dbo.Staff_CounselorID]
GO
ALTER TABLE [dbo].[Enrollment]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Enrollment_dbo.Staff_SourceID] FOREIGN KEY([SourceID])
REFERENCES [dbo].[Staff] ([ID])
GO
ALTER TABLE [dbo].[Enrollment] CHECK CONSTRAINT [FK_dbo.Enrollment_dbo.Staff_SourceID]
--GO
--ALTER TABLE [dbo].[FamilyProfile]  WITH CHECK ADD  CONSTRAINT [FK_dbo.FamilyProfile_dbo.ClientProfile_ClientProfilePersonID] FOREIGN KEY([ClientProfilePersonID])
--REFERENCES [dbo].[ClientProfile] ([ID])
--ON DELETE CASCADE
--GO
--ALTER TABLE [dbo].[FamilyProfile] CHECK CONSTRAINT [FK_dbo.FamilyProfile_dbo.ClientProfile_ClientProfilePersonID]
GO
ALTER TABLE [dbo].[FamilyProfile]  WITH CHECK ADD  CONSTRAINT [FK_dbo.FamilyProfile_dbo.Person_FamilyMemberID] FOREIGN KEY([FamilyMemberID])
REFERENCES [dbo].[Person] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FamilyProfile] CHECK CONSTRAINT [FK_dbo.FamilyProfile_dbo.Person_FamilyMemberID]
GO
ALTER TABLE [dbo].[FamilyProfile]  WITH CHECK ADD  CONSTRAINT [FK_dbo.FamilyProfile_dbo.Relationship_RelationshipID] FOREIGN KEY([RelationshipID])
REFERENCES [dbo].[Relationship] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FamilyProfile] CHECK CONSTRAINT [FK_dbo.FamilyProfile_dbo.Relationship_RelationshipID]
GO

ALTER TABLE [dbo].[Person]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Person_dbo.Gender_GenderID] FOREIGN KEY([GenderID])
REFERENCES [dbo].[Gender] ([ID])
GO
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_dbo.Person_dbo.Gender_GenderID]
GO
ALTER TABLE [dbo].[Person]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Person_dbo.Race_RaceID] FOREIGN KEY([RaceID])
REFERENCES [dbo].[Race] ([ID])
GO
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_dbo.Person_dbo.Race_RaceID]
GO
ALTER TABLE [dbo].[Person]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Person_dbo.Suffix_SuffixID] FOREIGN KEY([SuffixID])
REFERENCES [dbo].[Suffix] ([ID])
GO
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_dbo.Person_dbo.Suffix_SuffixID]
GO
ALTER TABLE [dbo].[PersonAddress]  WITH CHECK ADD  CONSTRAINT [FK_dbo.PersonAddress_dbo.AddressType_AddressTypeID] FOREIGN KEY([AddressTypeID])
REFERENCES [dbo].[AddressType] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PersonAddress] CHECK CONSTRAINT [FK_dbo.PersonAddress_dbo.AddressType_AddressTypeID]
GO
ALTER TABLE [dbo].[PersonAddress]  WITH CHECK ADD  CONSTRAINT [FK_dbo.PersonAddress_dbo.Person_PersonID] FOREIGN KEY([PersonID])
REFERENCES [dbo].[Person] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PersonAddress] CHECK CONSTRAINT [FK_dbo.PersonAddress_dbo.Person_PersonID]
GO
ALTER TABLE [dbo].[PersonSupplemental]  WITH CHECK ADD  CONSTRAINT [FK_dbo.PersonSupplemental_dbo.EducationLevel_EducationLevelID] FOREIGN KEY([EducationLevelID])
REFERENCES [dbo].[EducationLevel] ([ID])
GO
ALTER TABLE [dbo].[PersonSupplemental] CHECK CONSTRAINT [FK_dbo.PersonSupplemental_dbo.EducationLevel_EducationLevelID]
GO
ALTER TABLE [dbo].[PersonSupplemental]  WITH CHECK ADD  CONSTRAINT [FK_dbo.PersonSupplemental_dbo.JobStatus_JobStatusID] FOREIGN KEY([JobStatusID])
REFERENCES [dbo].[JobStatus] ([ID])
GO
ALTER TABLE [dbo].[PersonSupplemental] CHECK CONSTRAINT [FK_dbo.PersonSupplemental_dbo.JobStatus_JobStatusID]
GO
ALTER TABLE [dbo].[PersonSupplemental]  WITH CHECK ADD  CONSTRAINT [FK_dbo.PersonSupplemental_dbo.MaritalStatus_MaritalStatusID] FOREIGN KEY([MaritalStatusID])
REFERENCES [dbo].[MaritalStatus] ([ID])
GO
ALTER TABLE [dbo].[PersonSupplemental] CHECK CONSTRAINT [FK_dbo.PersonSupplemental_dbo.MaritalStatus_MaritalStatusID]
GO
ALTER TABLE [dbo].[PersonSupplemental]  WITH CHECK ADD  CONSTRAINT [FK_dbo.PersonSupplemental_dbo.Person_PersonID] FOREIGN KEY([PersonID])
REFERENCES [dbo].[Person] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PersonSupplemental] CHECK CONSTRAINT [FK_dbo.PersonSupplemental_dbo.Person_PersonID]
GO
ALTER TABLE [dbo].[PersonSupplemental]  WITH CHECK ADD  CONSTRAINT [FK_dbo.PersonSupplemental_dbo.School_SchoolID] FOREIGN KEY([SchoolID])
REFERENCES [dbo].[School] ([ID])
GO
ALTER TABLE [dbo].[PersonSupplemental] CHECK CONSTRAINT [FK_dbo.PersonSupplemental_dbo.School_SchoolID]
GO
ALTER TABLE [dbo].[Placement]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Placement_dbo.Judge_JudgeID] FOREIGN KEY([JudgeID])
REFERENCES [dbo].[Judge] ([ID])
GO
ALTER TABLE [dbo].[Placement] CHECK CONSTRAINT [FK_dbo.Placement_dbo.Judge_JudgeID]
GO
ALTER TABLE [dbo].[Placement]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Placement_dbo.PlacementLevel_PlacementLevelID] FOREIGN KEY([PlacementLevelID])
REFERENCES [dbo].[PlacementLevel] ([ID])
GO
ALTER TABLE [dbo].[Placement] CHECK CONSTRAINT [FK_dbo.Placement_dbo.PlacementLevel_PlacementLevelID]
GO
ALTER TABLE [dbo].[PlacementOffense]  WITH CHECK ADD  CONSTRAINT [FK_dbo.PlacementOffense_dbo.Offense_OffenseID] FOREIGN KEY([OffenseID])
REFERENCES [dbo].[Offense] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PlacementOffense] CHECK CONSTRAINT [FK_dbo.PlacementOffense_dbo.Offense_OffenseID]
GO
ALTER TABLE [dbo].[PlacementOffense]  WITH CHECK ADD  CONSTRAINT [FK_dbo.PlacementOffense_dbo.Placement_PlacementID] FOREIGN KEY([PlacementID])
REFERENCES [dbo].[Placement] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PlacementOffense] CHECK CONSTRAINT [FK_dbo.PlacementOffense_dbo.Placement_PlacementID]
GO
ALTER TABLE [dbo].[ProgressNote]  WITH CHECK ADD  CONSTRAINT [FK_dbo.ProgressNote_dbo.ContactType_ContactTypeID] FOREIGN KEY([ContactTypeID])
REFERENCES [dbo].[ContactType] ([ID])
GO
ALTER TABLE [dbo].[ProgressNote] CHECK CONSTRAINT [FK_dbo.ProgressNote_dbo.ContactType_ContactTypeID]
GO
ALTER TABLE [dbo].[ProgressNote]  WITH CHECK ADD  CONSTRAINT [FK_dbo.ProgressNote_dbo.Enrollment_EnrollmentID] FOREIGN KEY([EnrollmentID])
REFERENCES [dbo].[Enrollment] ([ID])
ON DELETE CASCADE  
GO
ALTER TABLE [dbo].[ProgressNote] CHECK CONSTRAINT [FK_dbo.ProgressNote_dbo.Enrollment_EnrollmentID]
GO
ALTER TABLE [dbo].[ServiceProgram]  WITH CHECK ADD  CONSTRAINT [FK_dbo.ServiceProgram_dbo.ServiceProvider_ServiceProviderID] FOREIGN KEY([ServiceProviderID])
REFERENCES [dbo].[ServiceProvider] ([ID])
GO
ALTER TABLE [dbo].[ServiceProgram] CHECK CONSTRAINT [FK_dbo.ServiceProgram_dbo.ServiceProvider_ServiceProviderID]
GO
ALTER TABLE [dbo].[ServiceProgramCategory]  WITH CHECK ADD  CONSTRAINT [FK_dbo.ServiceProgramCategory_dbo.ServiceCategory_ServiceCategoryID] FOREIGN KEY([ServiceCategoryID])
REFERENCES [dbo].[ServiceCategory] ([ID])
GO
ALTER TABLE [dbo].[ServiceProgramCategory] CHECK CONSTRAINT [FK_dbo.ServiceProgramCategory_dbo.ServiceCategory_ServiceCategoryID]
GO
ALTER TABLE [dbo].[ServiceProgramCategory]  WITH CHECK ADD  CONSTRAINT [FK_dbo.ServiceProgramCategory_dbo.ServiceProgram_ServiceProgramID] FOREIGN KEY([ServiceProgramID])
REFERENCES [dbo].[ServiceProgram] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ServiceProgramCategory] CHECK CONSTRAINT [FK_dbo.ServiceProgramCategory_dbo.ServiceProgram_ServiceProgramID]
GO
ALTER TABLE [dbo].[ServiceUnit]  WITH CHECK ADD  CONSTRAINT [FK_dbo.ServiceUnit_dbo.Enrollment_EnrollmentID] FOREIGN KEY([EnrollmentID])
REFERENCES [dbo].[Enrollment] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ServiceUnit] CHECK CONSTRAINT [FK_dbo.ServiceUnit_dbo.Enrollment_EnrollmentID]
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Staff_dbo.JobTitle_JobTitleID] FOREIGN KEY([JobTitleID])
REFERENCES [dbo].[JobTitle] ([ID])
GO
ALTER TABLE [dbo].[Staff] CHECK CONSTRAINT [FK_dbo.Staff_dbo.JobTitle_JobTitleID]
GO
