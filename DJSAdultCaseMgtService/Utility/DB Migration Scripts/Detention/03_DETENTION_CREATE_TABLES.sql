use JusticeServices 
go

/****** Object:  Table [dbo].[tblJuvPhoto]    Script Date: 03/11/2016 10:25:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[tblJuvPhoto](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[refservid] [int] NOT NULL,
	[img_data] [image] NULL,
	[img_contenttype] [varchar](50) NULL,
	[img_size] [int] NULL,
	[createddt] [datetime] NULL,
	[createdby] [varchar](30) NULL,
 CONSTRAINT [PK_tblJuvPhoto] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[tblPPItems]    Script Date: 03/11/2016 10:44:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblPPItems](
	[PPItemsID] [int] IDENTITY(1,1) NOT NULL,
	[PPItemDesc] [nvarchar](100) NULL,
	[Inactive] [bit] NULL,
	[AddDt] [datetime] NULL,
	[AddBy] [nvarchar](50) NULL,
	[UpdtDt] [datetime] NULL,
	[UpdtBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblPPItems] PRIMARY KEY CLUSTERED 
(
	[PPItemsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tblPPItems] ADD  CONSTRAINT [DF_tblPPItems_Inactive]  DEFAULT ((0)) FOR [Inactive]
GO

/****** Object:  Table [dbo].[tblDetPersProp]    Script Date: 03/11/2016 10:46:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblDetPersProp](
	[DetPPID] [int] IDENTITY(1,1) NOT NULL,
	[RefServID] [int] NULL,
	[PPItemsID] [int] NULL,
	[Quantity] [int] NULL,
	[Location] [nvarchar](7) NULL,
	[Money] [numeric](10, 2) NULL,
	[CreatedBy] [nvarchar](30) NULL,
	[CreatedDt] [datetime] NULL,
	[UpdtBy] [nvarchar](30) NULL,
	[UpdtDt] [datetime] NULL,
 CONSTRAINT [PK_tblDetPersProp] PRIMARY KEY CLUSTERED 
(
	[DetPPID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[tblMHQuestions]    Script Date: 03/11/2016 11:25:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[tblMHQuestions](
	[MHQuestID] [int] IDENTITY(1,1) NOT NULL,
	[MHQuestOrder] [real] NULL,
	[MHQuestText] [nvarchar](200) NULL,
	[MHQuestGroup] [int] NULL,
	[MHPrintNo] [char](10) NULL,
	[AllowAnswer] [bit] NULL,
	[AllowComment] [bit] NULL,
	[Active] [bit] NULL,
	[AddDt] [datetime] NULL,
	[AddBy] [nvarchar](50) NULL,
	[UpdtDt] [datetime] NULL,
	[UpdtBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblMHQuestions] PRIMARY KEY CLUSTERED 
(
	[MHQuestID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[tblMHQuestions] ADD  CONSTRAINT [DF_tblMHQuestions_TextOnly]  DEFAULT ((1)) FOR [AllowAnswer]
GO

ALTER TABLE [dbo].[tblMHQuestions] ADD  CONSTRAINT [DF_tblMHQuestions_AllowComment]  DEFAULT ((1)) FOR [AllowComment]
GO

/****** Object:  Table [dbo].[tblMHInterview]    Script Date: 03/11/2016 11:25:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblMHInterview](
	[MHInterviewID] [int] IDENTITY(1,1) NOT NULL,
	[RefServID] [int] NULL,
	[MHQuestionID] [int] NULL,
	[Answer] [bit] NULL,
	[Comments] [nvarchar](200) NULL,
	[CreatedBy] [nvarchar](30) NULL,
	[CreatedDt] [datetime] NULL,
	[UpdtBy] [nvarchar](30) NULL,
	[UpdtDt] [datetime] NULL,
 CONSTRAINT [PK_tblMHInterview] PRIMARY KEY CLUSTERED 
(
	[MHInterviewID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tblMHInterview] ADD  CONSTRAINT [DF_tblMHInterview_Answer]  DEFAULT (NULL) FOR [Answer]
GO


/****** Object:  Table [dbo].[tblCommLog]    Script Date: 03/11/2016 11:40:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblCommLog](
	[CommLogID] [int] IDENTITY(1,1) NOT NULL,
	[RefServID] [int] NULL,
	[CommDate] [datetime] NULL,
	[ContactType] [nvarchar](25) NULL,
	[Visitor] [nvarchar](100) NULL,
	[StaffID] [int] NULL,
	[CreatedBy] [nvarchar](30) NULL,
	[CreatedDt] [datetime] NULL,
	[UpdtBy] [nvarchar](30) NULL,
	[UpdtDt] [datetime] NULL,
 CONSTRAINT [PK_tblCommLog] PRIMARY KEY CLUSTERED 
(
	[CommLogID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[tblDiscipLog]    Script Date: 03/11/2016 11:46:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblDiscipLog](
	[DiscipLogID] [int] IDENTITY(1,1) NOT NULL,
	[RefServID] [int] NULL,
	[DiscipDate] [datetime] NULL,
	[Problem] [int] NULL,
	[OptHours] [int] NULL,
	[Attitude] [nvarchar](200) NULL,
	[StaffID] [int] NULL,
	[CreatedBy] [nvarchar](30) NULL,
	[CreatedDt] [datetime] NULL,
	[UpdtBy] [nvarchar](30) NULL,
	[UpdtDt] [datetime] NULL,
 CONSTRAINT [PK_tblDiscipLog] PRIMARY KEY CLUSTERED 
(
	[DiscipLogID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[tblDetProblems]    Script Date: 03/11/2016 11:47:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[tblDetProblems](
	[DetProbID] [int] IDENTITY(1,1) NOT NULL,
	[Severity] [char](5) NULL,
	[Text] [char](100) NULL,
	[IsoHours] [char](15) NULL,
	[SortOrder] [int] NULL,
	[Active] [bit] NULL,
	[AddDt] [datetime] NULL,
	[AddBy] [nvarchar](50) NULL,
	[UpdtDt] [datetime] NULL,
	[UpdtBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblDetProblems] PRIMARY KEY CLUSTERED 
(
	[DetProbID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[tblAdmissionTypes]    Script Date: 03/11/2016 12:02:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblAdmissionTypes](
	[AdmitId] [int] IDENTITY(1,1) NOT NULL,
	[AdmitDesc] [nvarchar](30) NULL,
 CONSTRAINT [PK_tblAdmissionTypes] PRIMARY KEY CLUSTERED 
(
	[AdmitId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[tblDetentionCodes]    Script Date: 03/11/2016 12:02:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[tblDetentionCodes](
	[DetCodeID] [char](2) NOT NULL,
	[DetCodeDesc] [nvarchar](100) NULL,
 CONSTRAINT [PK_tblDetentionCodes] PRIMARY KEY CLUSTERED 
(
	[DetCodeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[tblDetentionSupp]    Script Date: 03/11/2016 12:02:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[tblDetentionSupp](
	[RefServID] [int] NOT NULL,
	[DetCd] [char](2) NULL,
	[PodRoom] [varchar](10) NULL,
	[Pregnant] [int] NULL,
	[DueDate] [datetime] NULL,
	[Hospital] [nvarchar](50) NULL,
	[Physician] [nvarchar](50) NULL,
	[PhyAddr] [nvarchar](100) NULL,
	[PhyPhone] [nvarchar](25) NULL,
	[Dentist] [nvarchar](50) NULL,
	[DentAddr] [nvarchar](100) NULL,
	[DentPhone] [nvarchar](25) NULL,
	[MedInsurance] [nvarchar](50) NULL,
	[PlacingAgency] [nvarchar](25) NULL,
	[AdmittedBy] [int] NULL,
	[ReleasedBy] [int] NULL,
	[ReleasedTo] [nvarchar](50) NULL,
	[ReleasedToCode] [int] NULL,
	[RelToAddr1] [nvarchar](50) NULL,
	[RelToAddr2] [nvarchar](50) NULL,
	[LivingWith] [nvarchar](50) NULL,
	[LivingWithRel] [nvarchar](50) NULL,
	[EmerContact] [nvarchar](50) NULL,
	[EmerContactRel] [nvarchar](50) NULL,
	[EmerContactAddr] [nvarchar](100) NULL,
	[EmerContactPhone] [nvarchar](50) NULL,
	[PO] [int] NULL,
	[CurrMedication] [nvarchar](100) NULL,
	[CurrComplaints] [nvarchar](100) NULL,
	[SuicideWatch] [char](1) NULL,
	[HealthAtIntake] [nvarchar](50) NULL,
	[SchoolAtIntake] [int] NULL,
	[GradeAtIntake] [int] NULL,
	[DrugAllergy] [nvarchar](50) NULL,
	[FoodAllergy] [nvarchar](50) NULL,
	[OtherAllergy] [nvarchar](50) NULL,
	[Behavior] [char](1) NULL,
	[UnderInfluence] [char](1) NULL,
	[MaritalStatus] [bit] NULL,
	[TimeParentCalled] [datetime] NULL,
	[ParentCalled] [bit] NULL,
	[ScarsMarks] [nvarchar](50) NULL,
	[Religion] [nvarchar](50) NULL,
	[Gang] [nvarchar](50) NULL,
	[PPRecvDt] [datetime] NULL,
	[PPRtnDt] [datetime] NULL,
	[AgeAtIntake] [int] NULL,
	[AuthPhoneNo] [varchar](100) NULL,
	[ClothingIss] [bit] NULL,
	[PPReturned] [bit] NULL,
	[MHTherapist] [nvarchar](50) NULL,
	[MHAddlComments] [nvarchar](200) NULL,
	[Attorney] [nvarchar](50) NULL,
	[CSU] [nvarchar](50) NULL,
	[WardOf] [int] NULL,
	[AdmitOnPaper] [int] NULL,
	[AdmRemarks] [nvarchar](200) NULL,
	[FwdAddr1] [nvarchar](50) NULL,
	[FwdAddr2] [nvarchar](50) NULL,
	[FwdPhone] [nvarchar](25) NULL,
	[PrevDet] [int] NULL,
	[Alert] [bit] NULL,
	[Oriented] [bit] NULL,
	[Confused] [bit] NULL,
	[CreatedBy] [nvarchar](30) NULL,
	[CreatedDt] [datetime] NULL,
	[UpdtBy] [nvarchar](30) NULL,
	[UpdtDt] [datetime] NULL,
	[HiLite] [bit] NULL,
 CONSTRAINT [PK_tblDetentionSupp] PRIMARY KEY CLUSTERED 
(
	[RefServID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[tblDetentionSupp] ADD  CONSTRAINT [DF_tblDetentionSupp_Behavior]  DEFAULT ('A') FOR [Behavior]
GO

ALTER TABLE [dbo].[tblDetentionSupp] ADD  CONSTRAINT [DF_tblDetentionSupp_MaritalStatus]  DEFAULT (NULL) FOR [MaritalStatus]
GO

ALTER TABLE [dbo].[tblDetentionSupp] ADD  CONSTRAINT [DF_tblDetentionSupp_ParentCalled]  DEFAULT (NULL) FOR [ParentCalled]
GO

ALTER TABLE [dbo].[tblDetentionSupp] ADD  CONSTRAINT [DF_tblDetentionSupp_CSU]  DEFAULT ('13th') FOR [CSU]
GO

ALTER TABLE [dbo].[tblDetentionSupp] ADD  CONSTRAINT [DF_tblDetentionSupp_Alert]  DEFAULT ((0)) FOR [Alert]
GO

ALTER TABLE [dbo].[tblDetentionSupp] ADD  CONSTRAINT [DF_tblDetentionSupp_Oriented]  DEFAULT ((0)) FOR [Oriented]
GO

ALTER TABLE [dbo].[tblDetentionSupp] ADD  CONSTRAINT [DF_tblDetentionSupp_Confused]  DEFAULT ((0)) FOR [Confused]
GO

ALTER TABLE [dbo].[tblDetentionSupp] ADD  CONSTRAINT [DF_tblDetentionSupp_HiLite]  DEFAULT ((0)) FOR [HiLite]
GO


/****** Object:  Table [dbo].[tblDetMeals]    Script Date: 03/11/2016 12:03:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[tblDetMeals](
	[DetMealsID] [int] IDENTITY(1,1) NOT NULL,
	[RefServID] [int] NULL,
	[JuvenileID] [int] NULL,
	[MealDate] [datetime] NULL,
	[Comment] [nvarchar](100) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdtBy] [nvarchar](50) NULL,
	[UpdtDate] [datetime] NULL,
	[StaffID] [int] NULL,
	[StafPodRoom] [varchar](20) NULL,
	[Breakfast] [int] NOT NULL,
	[Lunch] [int] NOT NULL,
	[Dinner] [int] NOT NULL,
	[Snack] [int] NOT NULL,
 CONSTRAINT [PK_tblDetMeals] PRIMARY KEY CLUSTERED 
(
	[DetMealsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[tblMealsIdentity]    Script Date: 03/11/2016 12:04:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[tblMealsIdentity](
	[ItemId] [int] NOT NULL,
	[Item] [char](20) NULL,
 CONSTRAINT [PK_tblMealsIdentity] PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[tblWards]    Script Date: 03/11/2016 12:06:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblWards](
	[WardID] [int] IDENTITY(1,1) NOT NULL,
	[WardDesc] [nvarchar](30) NULL,
	[Active] [bit] NULL,
	[AddDt] [datetime] NULL,
	[AddBy] [nvarchar](50) NULL,
	[UpdtDt] [datetime] NULL,
	[UpdtBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblWards] PRIMARY KEY CLUSTERED 
(
	[WardID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblWards', @level2type=N'COLUMN',@level2name=N'WardID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblWards', @level2type=N'COLUMN',@level2name=N'WardID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblWards', @level2type=N'COLUMN',@level2name=N'WardID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblWards', @level2type=N'COLUMN',@level2name=N'WardDesc'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblWards', @level2type=N'COLUMN',@level2name=N'WardDesc'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2370 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblWards', @level2type=N'COLUMN',@level2name=N'WardDesc'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblWards', @level2type=N'COLUMN',@level2name=N'Active'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblWards', @level2type=N'COLUMN',@level2name=N'Active'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblWards', @level2type=N'COLUMN',@level2name=N'Active'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblWards', @level2type=N'COLUMN',@level2name=N'AddDt'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblWards', @level2type=N'COLUMN',@level2name=N'AddDt'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblWards', @level2type=N'COLUMN',@level2name=N'AddDt'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblWards', @level2type=N'COLUMN',@level2name=N'AddBy'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblWards', @level2type=N'COLUMN',@level2name=N'AddBy'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblWards', @level2type=N'COLUMN',@level2name=N'AddBy'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblWards', @level2type=N'COLUMN',@level2name=N'UpdtDt'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblWards', @level2type=N'COLUMN',@level2name=N'UpdtDt'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblWards', @level2type=N'COLUMN',@level2name=N'UpdtDt'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblWards', @level2type=N'COLUMN',@level2name=N'UpdtBy'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblWards', @level2type=N'COLUMN',@level2name=N'UpdtBy'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblWards', @level2type=N'COLUMN',@level2name=N'UpdtBy'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblWards'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblWards'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblWards'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblWards'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblWards'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=30000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblWards'
GO


/****** Object:  Table [dbo].[tblReleaseCodes]    Script Date: 03/11/2016 12:08:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[tblReleaseCodes](
	[RelID] [int] IDENTITY(1,1) NOT NULL,
	[Text] [char](100) NULL,
	[SortGroup] [int] NULL,
	[SortOrder] [int] NULL,
	[BeginDt] [datetime] NULL,
	[EndDt] [datetime] NULL,
	[Inactive] [bit] NULL,
	[AddDt] [datetime] NULL,
	[AddBy] [nvarchar](50) NULL,
	[UpdtDt] [datetime] NULL,
	[UpdtBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblReleaseCodes] PRIMARY KEY CLUSTERED 
(
	[RelID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[tblReleaseCodes] ADD  CONSTRAINT [DF_tblReleaseCodes_Inactive]  DEFAULT ((0)) FOR [Inactive]
GO

