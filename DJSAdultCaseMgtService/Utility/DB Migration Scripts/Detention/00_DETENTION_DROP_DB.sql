USE [JusticeServices]
GO

/****** Views - 19 ******/

/****** Object:  View [dbo].[vwYouthInfoRpt]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP VIEW [dbo].[vwYouthInfoRpt]
GO
/****** Object:  View [dbo].[vwStaffNameforMeal]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP VIEW [dbo].[vwStaffNameforMeal]
GO
/****** Object:  View [dbo].[vwStaffNameDetention]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP VIEW [dbo].[vwStaffNameDetention]
GO
/****** Object:  View [dbo].[vwStaffName]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP VIEW [dbo].[vwStaffName]
GO
/****** Object:  View [dbo].[vwMHComments]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP VIEW [dbo].[vwMHComments]
GO
/****** Object:  View [dbo].[vwMealCnts]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP VIEW [dbo].[vwMealCnts]
GO
/****** Object:  View [dbo].[vwDetPersProp2]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP VIEW [dbo].[vwDetPersProp2]
GO
/****** Object:  View [dbo].[vwDetPersProp]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP VIEW [dbo].[vwDetPersProp]
GO
/****** Object:  View [dbo].[vwDetMentalHealth]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP VIEW [dbo].[vwDetMentalHealth]
GO
/****** Object:  View [dbo].[vwDetMedical]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP VIEW [dbo].[vwDetMedical]
GO
/****** Object:  View [dbo].[vwDetFamily]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP VIEW [dbo].[vwDetFamily]
GO
/****** Object:  View [dbo].[vwDetFamilyAddress]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP VIEW [dbo].[vwDetFamilyAddress]
GO
/****** Object:  View [dbo].[vwDetFamilyDetail]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP VIEW [dbo].[vwDetFamilyDetail]
GO
/****** Object:  View [dbo].[vwDetentions]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP VIEW [dbo].[vwDetentions]
GO
/****** Object:  View [dbo].[vwDetDiscipLog]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP VIEW [dbo].[vwDetDiscipLog]
GO
/****** Object:  View [dbo].[vwDetCommLog]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP VIEW [dbo].[vwDetCommLog]
GO
/****** Object:  View [dbo].[vwDetAdmission]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP VIEW [dbo].[vwDetAdmission]
GO
/****** Object:  View [dbo].[vwCommunications]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP VIEW [dbo].[vwCommunications]
GO
/****** Object:  View [dbo].[vwAdmissionRelease]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP VIEW [dbo].[vwAdmissionRelease]
GO
/****** Object:  View [dbo].[vwDashBoardEnrollmentRpt]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP VIEW [dbo].[vwDashBoardEnrollmentRpt]
GO
/****** Object:  View [dbo].[vwDashBoardEnrollmentRptDetails]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP VIEW [dbo].[vwDashBoardEnrollmentRptDetails]
GO


/****** Functions -15 ******/
/****** Object:  UserDefinedFunction [dbo].[fnStaffPhone]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP FUNCTION [dbo].[fnStaffPhone]
GO
/****** Object:  UserDefinedFunction [dbo].[fnAdmittedBy]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP FUNCTION [dbo].[fnAdmittedBy]
GO
/****** Object:  UserDefinedFunction [dbo].[fnDateOnly]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP FUNCTION [dbo].[fnDateOnly]
GO
/****** Object:  UserDefinedFunction [dbo].[fnFamilyMember]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP FUNCTION [dbo].[fnFamilyMember]
GO
/****** Object:  UserDefinedFunction [dbo].[fnFamilyMemberAddrID]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP FUNCTION [dbo].[fnFamilyMemberAddrID]
GO
/****** Object:  UserDefinedFunction [dbo].[fnFamilyMemberMarital]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP FUNCTION [dbo].[fnFamilyMemberMarital]
GO
/****** Object:  UserDefinedFunction [dbo].[fnFamilyMemberPhone]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP FUNCTION [dbo].[fnFamilyMemberPhone]
GO
/****** Object:  UserDefinedFunction [dbo].[fnFamilyMemberSSN]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP FUNCTION [dbo].[fnFamilyMemberSSN]
GO
/****** Object:  UserDefinedFunction [dbo].[fnFixEmpty]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP FUNCTION [dbo].[fnFixEmpty]
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetPersonAddress]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP FUNCTION [dbo].[fnGetPersonAddress]
GO
/****** Object:  UserDefinedFunction [dbo].[fnOffenseList]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP FUNCTION [dbo].[fnOffenseList]
GO
/****** Object:  UserDefinedFunction [dbo].[fnProbationOfficer]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP FUNCTION [dbo].[fnProbationOfficer]
GO
/****** Object:  UserDefinedFunction [dbo].[fnStaffName]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP FUNCTION [dbo].[fnStaffName]
GO
/****** Object:  UserDefinedFunction [dbo].[fnTally]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP FUNCTION [dbo].[fnTally]
GO
/****** Object:  UserDefinedFunction [dbo].[fnDetCount]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP FUNCTION [dbo].[fnDetCount]
GO


/****** Stored procedures - 22 ******/
/****** Object:  StoredProcedure [dbo].[spUpdateStaffMealRecord]    Script Date: 4/16/2015 4:59:26 PM ******/
DROP PROCEDURE [dbo].[spUpdateStaffMealRecord]
GO
/****** Object:  StoredProcedure [dbo].[spTempMealsForJuvenileAndStaffReport]    Script Date: 4/16/2015 4:59:26 PM ******/
DROP PROCEDURE [dbo].[spTempMealsForJuvenileAndStaffReport]
GO
/****** Object:  StoredProcedure [dbo].[spselectStaffIDFullNameforCombo]    Script Date: 4/16/2015 4:59:26 PM ******/
DROP PROCEDURE [dbo].[spselectStaffIDFullNameforCombo]
GO
/****** Object:  StoredProcedure [dbo].[spSelectMealsForStaff]    Script Date: 4/16/2015 4:59:26 PM ******/
DROP PROCEDURE [dbo].[spSelectMealsForStaff]
GO
/****** Object:  StoredProcedure [dbo].[spSelectMealforALLCombo]    Script Date: 4/16/2015 4:59:26 PM ******/
DROP PROCEDURE [dbo].[spSelectMealforALLCombo]
GO
/****** Object:  StoredProcedure [dbo].[spPurgeMeals]    Script Date: 4/16/2015 4:59:26 PM ******/
DROP PROCEDURE [dbo].[spPurgeMeals]
GO
/****** Object:  StoredProcedure [dbo].[spMonthlyMealsReport]    Script Date: 4/16/2015 4:59:26 PM ******/
DROP PROCEDURE [dbo].[spMonthlyMealsReport]
GO
/****** Object:  StoredProcedure [dbo].[spInsertNewStaffMealRecord]    Script Date: 4/16/2015 4:59:26 PM ******/
DROP PROCEDURE [dbo].[spInsertNewStaffMealRecord]
GO
/****** Object:  StoredProcedure [dbo].[spInsertNewJuvenileToMeal]    Script Date: 4/16/2015 4:59:26 PM ******/
DROP PROCEDURE [dbo].[spInsertNewJuvenileToMeal]
GO
/****** Object:  StoredProcedure [dbo].[spInsert_CreateNewMeal]    Script Date: 4/16/2015 4:59:26 PM ******/
DROP PROCEDURE [dbo].[spInsert_CreateNewMeal]
GO
/****** Object:  StoredProcedure [dbo].[spDeleteStaffMealRecord]    Script Date: 4/16/2015 4:59:26 PM ******/
DROP PROCEDURE [dbo].[spDeleteStaffMealRecord]
GO
/****** Object:  StoredProcedure [dbo].[spChekforNewJuvenileMeal]    Script Date: 4/16/2015 4:59:26 PM ******/
DROP PROCEDURE [dbo].[spChekforNewJuvenileMeal]
GO
/****** Object:  StoredProcedure [dbo].[spCheckDuplicateStaffMeal]    Script Date: 4/16/2015 4:59:26 PM ******/
DROP PROCEDURE [dbo].[spCheckDuplicateStaffMeal]
GO
/****** Object:  StoredProcedure [dbo].[sp_BreakfastCombo]    Script Date: 4/16/2015 4:59:26 PM ******/
DROP PROCEDURE [dbo].[sp_BreakfastCombo]
GO
/****** Object:  StoredProcedure [dbo].[spMentalUpdt]    Script Date: 4/16/2015 4:59:26 PM ******/
DROP PROCEDURE [dbo].[spMentalUpdt]
GO
/****** Object:  StoredProcedure [dbo].[spMHInitialAdd]    Script Date: 4/16/2015 4:59:26 PM ******/
DROP PROCEDURE [dbo].[spMHInitialAdd]
GO
/****** Object:  StoredProcedure [dbo].[spSelectMealforALL]    Script Date: 4/16/2015 4:59:26 PM ******/
DROP PROCEDURE [dbo].[spSelectMealforALL]
GO
/****** Object:  StoredProcedure [dbo].[spUpdateMealforALL]    Script Date: 4/16/2015 4:59:26 PM ******/
DROP PROCEDURE [dbo].[spUpdateMealforALL]
GO
/****** Object:  StoredProcedure [dbo].[spMonthlyMealsReport]    Script Date: 4/16/2015 4:59:26 PM ******/
DROP PROCEDURE [dbo].[spMonthlyMealsReport]
GO

/****** Tables - 14 ******/
/****** Object:  Table [dbo].[tblJuvPhoto]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP TABLE [dbo].[tblJuvPhoto]
GO
/****** Object:  Table [dbo].[tblWards]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP TABLE [dbo].[tblWards]
GO
/****** Object:  Table [dbo].[tblReleaseCodes]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP TABLE [dbo].[tblReleaseCodes]
GO
/****** Object:  Table [dbo].[tblPPItems]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP TABLE [dbo].[tblPPItems]
GO
/****** Object:  Table [dbo].[tblMHQuestions]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP TABLE [dbo].[tblMHQuestions]
GO
/****** Object:  Table [dbo].[tblMHInterview]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP TABLE [dbo].[tblMHInterview]
GO
/****** Object:  Table [dbo].[tblMealsIdentity]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP TABLE [dbo].[tblMealsIdentity]
GO
/****** Object:  Table [dbo].[tblDiscipLog]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP TABLE [dbo].[tblDiscipLog]
GO
/****** Object:  Table [dbo].[tblDetProblems]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP TABLE [dbo].[tblDetProblems]
GO
/****** Object:  Table [dbo].[tblDetPersProp]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP TABLE [dbo].[tblDetPersProp]
GO
/****** Object:  Table [dbo].[tblDetMeals]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP TABLE [dbo].[tblDetMeals]
GO
/****** Object:  Table [dbo].[tblDetentionSupp]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP TABLE [dbo].[tblDetentionSupp]
GO
/****** Object:  Table [dbo].[tblDetentionCodes]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP TABLE [dbo].[tblDetentionCodes]
GO
/****** Object:  Table [dbo].[tblCommLog]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP TABLE [dbo].[tblCommLog]
GO
/****** Object:  Table [dbo].[tblAdmissionTypes]    Script Date: 4/16/2015 4:59:25 PM ******/
DROP TABLE [dbo].[tblAdmissionTypes]
GO

