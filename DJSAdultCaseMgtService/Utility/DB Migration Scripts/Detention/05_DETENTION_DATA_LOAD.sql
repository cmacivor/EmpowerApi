USE JusticeServices
GO

-- INSERT INTO tblDetMeals
INSERT INTO [JusticeServices].[dbo].[tblDetMeals]
           ([RefServID]
           ,[JuvenileID]
           ,[MealDate]
           ,[Comment]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[UpdtBy]
           ,[UpdtDate]
           ,[StaffID]
           ,[StafPodRoom]
           ,[Breakfast]
           ,[Lunch]
           ,[Dinner]
           ,[Snack])
     SELECT
           RefServID
           ,JuvenileID
           ,MealDate
           ,Comment
           ,CreatedBy
           ,CreatedDate
           ,UpdtBy
           ,UpdtDate
           ,StaffID
           ,StafPodRoom
           ,Breakfast
           ,Lunch
           ,Dinner
           ,Snack
     FROM [JJSCaseMgt].[dbo].[tblDetMeals]
GO

-- INSERT tblReleaseCodes
INSERT INTO [JusticeServices].[dbo].[tblReleaseCodes]
           ([Text]
           ,[SortGroup]
           ,[SortOrder]
           ,[BeginDt]
           ,[EndDt]
           ,[Inactive]
           ,[AddDt]
           ,[AddBy]
           ,[UpdtDt]
           ,[UpdtBy])
     SELECT
           [Text]
           ,[SortGroup]
           ,[SortOrder]
           ,[BeginDt]
           ,[EndDt]
           ,[Inactive]
           ,[AddDt]
           ,[AddBy]
           ,[UpdtDt]
           ,[UpdtBy]
      FROM [JJSCaseMgt].[dbo].[tblReleaseCodes]
GO


-- INSERT INTO tblJuvPhoto
INSERT INTO [JusticeServices].[dbo].[tblJuvPhoto]
           ([refservid]
           ,[img_data]
           ,[img_contenttype]
           ,[img_size]
           ,[createddt]
           ,[createdby])
     SELECT
			[refservid]
           ,[img_data]
           ,[img_contenttype]
           ,[img_size]
           ,[createddt]
           ,[createdby]
     FROM [JJSCaseMgt].[dbo].[tblJuvPhoto]
GO

-- INSERT INTO tblPPItems
INSERT INTO [JusticeServices].[dbo].[tblPPItems]
           ([PPItemDesc]
           ,[Inactive]
           ,[AddDt]
           ,[AddBy]
           ,[UpdtDt]
           ,[UpdtBy])
	SELECT
			[PPItemDesc]
           ,[Inactive]
           ,[AddDt]
           ,[AddBy]
           ,[UpdtDt]
           ,[UpdtBy]
    FROM [JJSCaseMgt].[dbo].[tblPPItems]
GO

-- INSERT INTO [tblDetPersProp]
INSERT INTO [JusticeServices].[dbo].[tblDetPersProp]
           ([RefServID]
           ,[PPItemsID]
           ,[Quantity]
           ,[Location]
           ,[Money]
           ,[CreatedBy]
           ,[CreatedDt]
           ,[UpdtBy]
           ,[UpdtDt])
	SELECT
           [RefServID]
           ,[PPItemsID]
           ,[Quantity]
           ,[Location]
           ,[Money]
           ,[CreatedBy]
           ,[CreatedDt]
           ,[UpdtBy]
           ,[UpdtDt]
	FROM [JJSCaseMgt].[dbo].[tblDetPersProp]
GO

-- INSERT INTO tblMHQuestions
INSERT INTO [JusticeServices].[dbo].[tblMHQuestions]
           ([MHQuestOrder]
           ,[MHQuestText]
           ,[MHQuestGroup]
           ,[MHPrintNo]
           ,[AllowAnswer]
           ,[AllowComment]
           ,[Active]
           ,[AddDt]
           ,[AddBy]
           ,[UpdtDt]
           ,[UpdtBy])
     SELECT
           [MHQuestOrder]
           ,[MHQuestText]
           ,[MHQuestGroup]
           ,[MHPrintNo]
           ,[AllowAnswer]
           ,[AllowComment]
           ,[Active]
           ,[AddDt]
           ,[AddBy]
           ,[UpdtDt]
           ,[UpdtBy]
     FROM [JJSCaseMgt].[dbo].[tblMHQuestions]
GO

-- INSERT INTO tblMHInterview
INSERT INTO [JusticeServices].[dbo].[tblMHInterview]
           ([RefServID]
           ,[MHQuestionID]
           ,[Answer]
           ,[Comments]
           ,[CreatedBy]
           ,[CreatedDt]
           ,[UpdtBy]
           ,[UpdtDt])
     SELECT
           [RefServID]
           ,[MHQuestionID]
           ,[Answer]
           ,[Comments]
           ,[CreatedBy]
           ,[CreatedDt]
           ,[UpdtBy]
           ,[UpdtDt]
     FROM [JJSCaseMgt].[dbo].[tblMHInterview]
GO

-- INSERT INTO [tblCommLog]
INSERT INTO [JusticeServices].[dbo].[tblCommLog]
           ([RefServID]
           ,[CommDate]
           ,[ContactType]
           ,[Visitor]
           ,[StaffID]
           ,[CreatedBy]
           ,[CreatedDt]
           ,[UpdtBy]
           ,[UpdtDt])
     SELECT
           [RefServID]
           ,[CommDate]
           ,[ContactType]
           ,[Visitor]
           ,[StaffID]
           ,[CreatedBy]
           ,[CreatedDt]
           ,[UpdtBy]
           ,[UpdtDt]
	FROM [JJSCaseMgt].[dbo].[tblCommLog]
GO

-- INSERT INTO [tblDiscipLog]
INSERT INTO [JusticeServices].[dbo].[tblDiscipLog]
           ([RefServID]
           ,[DiscipDate]
           ,[Problem]
           ,[OptHours]
           ,[Attitude]
           ,[StaffID]
           ,[CreatedBy]
           ,[CreatedDt]
           ,[UpdtBy]
           ,[UpdtDt])
     SELECT
           [RefServID]
           ,[DiscipDate]
           ,[Problem]
           ,[OptHours]
           ,[Attitude]
           ,[StaffID]
           ,[CreatedBy]
           ,[CreatedDt]
           ,[UpdtBy]
           ,[UpdtDt]
     FROM [JJSCaseMgt].[dbo].[tblDiscipLog]
GO

-- INSERT INTO [tblDetProblems]
INSERT INTO [JusticeServices].[dbo].[tblDetProblems]
           ([Severity]
           ,[Text]
           ,[IsoHours]
           ,[SortOrder]
           ,[Active]
           ,[AddDt]
           ,[AddBy]
           ,[UpdtDt]
           ,[UpdtBy])
     SELECT
           [Severity]
           ,[Text]
           ,[IsoHours]
           ,[SortOrder]
           ,[Active]
           ,[AddDt]
           ,[AddBy]
           ,[UpdtDt]
           ,[UpdtBy]
     FROM [JJSCaseMgt].[dbo].[tblDetProblems]
GO

-- INSERT INTO [tblAdmissionTypes]
INSERT INTO [JusticeServices].[dbo].[tblAdmissionTypes]
           ([AdmitDesc])
     SELECT
           AdmitDesc
           FROM [JJSCaseMgt].[dbo].[tblAdmissionTypes]
GO

-- INSERT INTO [tblDetentionCodes]
INSERT INTO [JusticeServices].[dbo].[tblDetentionCodes]
           ([DetCodeID]
           ,[DetCodeDesc])
     SELECT
           DetCodeID,
           DetCodeDesc
           FROM [JJScaseMgt].[dbo].[tblDetentionCodes]
GO

-- INSERT INTO [tblDetentionSupp]
INSERT INTO [JusticeServices].[dbo].[tblDetentionSupp]
           ([RefServID]
           ,[DetCd]
           ,[PodRoom]
           ,[Pregnant]
           ,[DueDate]
           ,[Hospital]
           ,[Physician]
           ,[PhyAddr]
           ,[PhyPhone]
           ,[Dentist]
           ,[DentAddr]
           ,[DentPhone]
           ,[MedInsurance]
           ,[PlacingAgency]
           ,[AdmittedBy]
           ,[ReleasedBy]
           ,[ReleasedTo]
           ,[ReleasedToCode]
           ,[RelToAddr1]
           ,[RelToAddr2]
           ,[LivingWith]
           ,[LivingWithRel]
           ,[EmerContact]
           ,[EmerContactRel]
           ,[EmerContactAddr]
           ,[EmerContactPhone]
           ,[PO]
           ,[CurrMedication]
           ,[CurrComplaints]
           ,[SuicideWatch]
           ,[HealthAtIntake]
           ,[SchoolAtIntake]
           ,[GradeAtIntake]
           ,[DrugAllergy]
           ,[FoodAllergy]
           ,[OtherAllergy]
           ,[Behavior]
           ,[UnderInfluence]
           ,[MaritalStatus]
           ,[TimeParentCalled]
           ,[ParentCalled]
           ,[ScarsMarks]
           ,[Religion]
           ,[Gang]
           ,[PPRecvDt]
           ,[PPRtnDt]
           ,[AgeAtIntake]
           ,[AuthPhoneNo]
           ,[ClothingIss]
           ,[PPReturned]
           ,[MHTherapist]
           ,[MHAddlComments]
           ,[Attorney]
           ,[CSU]
           ,[WardOf]
           ,[AdmitOnPaper]
           ,[AdmRemarks]
           ,[FwdAddr1]
           ,[FwdAddr2]
           ,[FwdPhone]
           ,[PrevDet]
           ,[Alert]
           ,[Oriented]
           ,[Confused]
           ,[CreatedBy]
           ,[CreatedDt]
           ,[UpdtBy]
           ,[UpdtDt]
           ,[HiLite])
     SELECT
           [RefServID]
           ,[DetCd]
           ,[PodRoom]
           ,[Pregnant]
           ,[DueDate]
           ,[Hospital]
           ,[Physician]
           ,[PhyAddr]
           ,[PhyPhone]
           ,[Dentist]
           ,[DentAddr]
           ,[DentPhone]
           ,[MedInsurance]
           ,[PlacingAgency]
           ,[AdmittedBy]
           ,[ReleasedBy]
           ,[ReleasedTo]
           ,[ReleasedToCode]
           ,[RelToAddr1]
           ,[RelToAddr2]
           ,[LivingWith]
           ,[LivingWithRel]
           ,[EmerContact]
           ,[EmerContactRel]
           ,[EmerContactAddr]
           ,[EmerContactPhone]
           ,[PO]
           ,[CurrMedication]
           ,[CurrComplaints]
           ,[SuicideWatch]
           ,[HealthAtIntake]
           ,[SchoolAtIntake]
           ,[GradeAtIntake]
           ,[DrugAllergy]
           ,[FoodAllergy]
           ,[OtherAllergy]
           ,[Behavior]
           ,[UnderInfluence]
           ,[MaritalStatus]
           ,[TimeParentCalled]
           ,[ParentCalled]
           ,[ScarsMarks]
           ,[Religion]
           ,[Gang]
           ,[PPRecvDt]
           ,[PPRtnDt]
           ,[AgeAtIntake]
           ,[AuthPhoneNo]
           ,[ClothingIss]
           ,[PPReturned]
           ,[MHTherapist]
           ,[MHAddlComments]
           ,[Attorney]
           ,[CSU]
           ,[WardOf]
           ,[AdmitOnPaper]
           ,[AdmRemarks]
           ,[FwdAddr1]
           ,[FwdAddr2]
           ,[FwdPhone]
           ,[PrevDet]
           ,[Alert]
           ,[Oriented]
           ,[Confused]
           ,[CreatedBy]
           ,[CreatedDt]
           ,[UpdtBy]
           ,[UpdtDt]
           ,[HiLite]
           FROM [JJSCaseMgt].[dbo].[tblDetentionSupp]
GO


-- INERT INTO [tblMealsIdentity]
INSERT INTO [JusticeServices].[dbo].[tblMealsIdentity]
           ([ItemId]
           ,[Item])
     SELECT
           ItemId
           ,Item
           FROM [JJSCaseMgt].[dbo].[tblMealsIdentity]
GO

-- INSERT INTO [tblWards]
INSERT INTO [JusticeServices].[dbo].[tblWards]
           ([WardDesc]
           ,[Active]
           ,[AddDt]
           ,[AddBy]
           ,[UpdtDt]
           ,[UpdtBy])
     SELECT
           [WardDesc]
           ,[Active]
           ,[AddDt]
           ,[AddBy]
           ,[UpdtDt]
           ,[UpdtBy]
           FROM [JJSCaseMgt].[dbo].[tblWards]
GO



