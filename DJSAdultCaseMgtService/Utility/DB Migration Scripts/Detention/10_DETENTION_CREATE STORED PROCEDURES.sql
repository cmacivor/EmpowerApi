USE [JusticeServices]
GO

/****** Object:  StoredProcedure [dbo].[spMentalUpdt]    Script Date: 03/11/2016 11:31:17 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


/****** Object:  Stored Procedure dbo.spMentalUpdt    Script Date: 12/7/2005 1:14:53 PM ******/
CREATE PROCEDURE [dbo].[spMentalUpdt] 
	@inMHKey int,
	@inAnswer char(5),
	@inComments char(200),
	@inUserID char(30),
	@inDt datetime
	
AS

--=============================================================================
--    Called from Mental.aspx.  Update tblMHInterview with juvenile's answers to questions.
--==============================================================================

--=================================================== convert text answer to int
	BEGIN	

			
		DECLARE @iAnswer int
	
		IF @inAnswer = "true"
			BEGIN
				SET @iAnswer = 1
			END
		ELSE
			BEGIN
				SET @iAnswer = 0
			END

--=================================================== Is this a 2st time update or not? 
			
		DECLARE @chk	 char(30)
		DECLARE Created	 Cursor
		FOR 
			SELECT 	CreatedBy
			FROM		tblMHInterview
			WHERE	(MHInterviewID = @inMHKey)

		OPEN Created
		FETCH NEXT FROM  Created
					INTO  @chk
		CLOSE Created
		DEALLOCATE Created

--=================================================== Update CREATED info if doesn't exist
		IF @chk is null
			BEGIN
				UPDATE 	tblMHInterview
				SET		Answer = @iAnswer,
						Comments = @inComments,
						CreatedBy = @inUserID,
						CreatedDt = @inDt
				WHERE 	MHInterviewID = @inMHKey
			END
	
--=================================================== Update UPDT info otherwise
		ELSE
			BEGIN
				UPDATE 	tblMHInterview
				SET		Answer = @iAnswer,
						Comments = @inComments,
						UpdtBy = @inUserID,
						UpdtDt = @inDt
				WHERE 	MHInterviewID = @inMHKey
			END


	END

RETURN

GO


GRANT EXEC ON [dbo].[spMentalUpdt] TO [JusticeServicesAppId]
Go
USE [JusticeServices]
GO

/****** Object:  StoredProcedure [dbo].[spMHInitialAdd]    Script Date: 03/11/2016 11:23:47 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


/****** Object:  Stored Procedure dbo.spMHInitialAdd    Script Date: 12/7/2005 1:14:53 PM ******/
CREATE PROCEDURE [dbo].[spMHInitialAdd] 
	@inID int
AS

--=============================================================================
--    Called from Mental.aspx.  If new referral, this procedure generates 1 answer (tblMHInterview) 
--    record for each [current] question on tblMHQuestions.  Then Mental.aspx will update those
--    records as intake interviews the juvenile.
--==============================================================================

--=================================================== Check to see if records for answers for this juvenile exist already
	BEGIN	
		
		DECLARE @Acnt int

		DECLARE Answers	 Cursor
		FOR 
			SELECT 	COUNT(*)
			FROM		tblMHInterview
			WHERE	(RefServID = 	@inID)

		OPEN Answers
			

		FETCH NEXT FROM  Answers
					INTO  @Acnt


		CLOSE Answers
		DEALLOCATE Answers

		--PRINT @Acnt

		IF @Acnt > 0
			BEGIN	
				GOTO Finish
			END


--====================================================  Add default records for answers if none exist
--                                                                                                         (active is 0 if active; 1 if inactive)
--                                                                                                         (badly named column - think of active flag as 'inactive' flag)
	
		DECLARE	@ID int
		
		DECLARE Questions Cursor
	
		FOR
			SELECT    	MHQuestID  
			FROM 		tblMHQuestions q          
			WHERE       	active = 0 
		             ORDER BY   	q.MHQuestID
	          
	             OPEN Questions

	
--====================================================  insert all interview questions active for the service date for this juvenilte
		FETCH NEXT From Questions
			INTO @ID
	
		WHILE @@FETCH_STATUS = 0
			BEGIN
	
				INSERT INTO tblMHInterview 	(RefServid,	MHQuestionId,		Answer,		Comments) 
						VALUES   	(@inID,		@ID,			null,		null)
				FETCH NEXT FROM Questions
					INTO @ID
	
		            END

		CLOSE Questions
		DEALLOCATE Questions

FINISH:

RETURN
END

GO


GRANT EXEC ON [dbo].[spMHInitialAdd] TO [JusticeServicesAppId]
Go
USE [JusticeServices]
GO

/****** Object:  StoredProcedure [dbo].[spMonthlyMealsReport]    Script Date: 03/11/2016 13:31:03 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


/****** Object:  Stored Procedure dbo.spMonthlyMealsReport    Script Date: 12/7/2005 1:14:53 PM ******/
CREATE PROCEDURE [dbo].[spMonthlyMealsReport]
(
--@m_MealDate_par datetime ,
@m_MealMonth_par int,
@m_MealYear_par int,
--
-- parameters for B-Breakfast
@par_b11  int  output,
@par_b21  int  output,
@par_b31  int  output,
@par_b41  int  output,
@par_b51  int  output,
@par_b61  int  output,
-- parameters for B-Lunch
@par_b12  int  output,
@par_b22  int  output,
@par_b32 int  output,
@par_b42  int  output,
@par_b52  int  output,
@par_b62  int  output,
-- parameters for B-Dinner
@par_b13 int  output,
@par_b23 int  output,
@par_b33 int  output,
@par_b43 int  output,
@par_b53  int  output,
@par_b63  int  output,
-- parameters for B-Snack
@par_b14 int  output,
@par_b24 int  output,
@par_b34 int  output,
@par_b44 int  output,
@par_b54  int  output,
@par_b64  int  output,
--
-- parameters for C-Breakfast
@par_c11  int  output,
@par_c21  int  output,
@par_c31  int  output,
@par_c41  int  output,
@par_c51  int  output,
@par_c61  int  output,
-- parameters for C- Lunch
@par_c12  int  output,
@par_c22  int  output,
@par_c32 int  output,
@par_c42 int  output,
@par_c52 int  output,
@par_c62  int  output,
-- parameters for C- Dinner
@par_c13  int  output,
@par_c23  int  output,
@par_c33 int  output,
@par_c43 int  output,
@par_c53 int  output,
@par_c63  int  output,
-- parameters for C- Snack
@par_c14 int  output,
@par_c24  int  output,
@par_c34 int  output,
@par_c44 int  output,
@par_c54 int  output,
@par_c64  int  output,
--
-- parameters for D-Breakfast
@par_d11  int  output,
@par_d21  int  output,
@par_d31  int  output,
@par_d41  int  output,
@par_d51  int  output,
@par_d61  int  output,
-- parameters for D-Lunch
@par_d12  int  output,
@par_d22  int  output,
@par_d32 int  output,
@par_d42  int  output,
@par_d52  int  output,
@par_d62  int  output,
-- parameters for D- Dinner
@par_d13  int  output,
@par_d23  int  output,
@par_d33 int  output,
@par_d43 int  output,
@par_d53 int  output,
@par_d63  int  output,
-- parameters for D-Snack
@par_d14 int  output,
@par_d24 int  output,
@par_d34 int  output,
@par_d44 int  output,
@par_d54  int  output,
@par_d64  int  output,
--
-- parameters for E-Breakfast
@par_e11  int  output,
@par_e21  int  output,
@par_e31  int  output,
@par_e41  int  output,
@par_e51  int  output,
@par_e61  int  output,
-- parameters for E-Lunch
@par_e12  int  output,
@par_e22 int  output,
@par_e32  int  output,
@par_e42  int  output,
@par_e52  int  output,
@par_e62  int  output,
-- parameters for E-Dinner
@par_e13  int  output,
@par_e23 int  output,
@par_e33  int  output,
@par_e43 int  output,
@par_e53 int  output,
@par_e63 int  output,
-- parameters for E-Snack
@par_e14 int  output,
@par_e24 int  output,
@par_e34  int  output,
@par_e44 int  output,
@par_e54 int  output,
@par_e64 int  output,
--
-- parameters for F-Breakfast
@par_f11  int  output,
@par_f21  int  output,
@par_f31  int  output,
@par_f41  int  output,
@par_f51  int  output,
@par_f61  int  output,
-- parameters for F-Lunch
@par_f12  int  output,
@par_f22  int  output,
@par_f32  int  output,
@par_f42  int  output,
@par_f52  int  output,
@par_f62 int  output,
-- parameters for F-Dinner
@par_f13 int  output,
@par_f23 int  output,
@par_f33  int  output,
@par_f43  int  output,
@par_f53  int  output,
@par_f63  int  output,
-- parameters for F-Snack
@par_f14  int  output,
@par_f24  int  output,
@par_f34 int  output,
@par_f44 int  output,
@par_f54 int  output,
@par_f64  int  output,
--
-- parameters for G-Breakfast
@par_g11  int  output,
@par_g21  int  output,
@par_g31  int  output,
@par_g41  int  output,
@par_g51  int  output,
@par_g61  int  output,
-- parameters for G-Lunch
@par_g12  int  output,
@par_g22  int  output,
@par_g32  int  output,
@par_g42  int  output,
@par_g52  int  output,
@par_g62 int  output,
-- parameters for G -Dinner
@par_g13 int  output,
@par_g23 int  output,
@par_g33  int  output,
@par_g43  int  output,
@par_g53  int  output,
@par_g63  int  output,
-- parameters for G-Snack
@par_g14  int  output,
@par_g24  int  output,
@par_g34 int  output,
@par_g44 int  output,
@par_g54 int  output,
@par_g64  int  output,
--

-- parameters for Total-Breakfast
@par_t11 int  output,
@par_t21 int  output,
@par_t31 int  output,
@par_t41 int  output,
@par_t51 int  output,
@par_t61 int  output,

-- parameters for Total-Lunch
@par_t12 int  output,
@par_t22 int  output,
@par_t32 int  output,
@par_t42 int  output,
@par_t52 int  output,
@par_t62 int  output,

-- parameters for Total-Dinner
@par_t13 int  output,
@par_t23 int  output,
@par_t33 int  output,
@par_t43 int  output,
@par_t53 int  output,
@par_t63 int  output,

-- parameters for Total-Snack
@par_t14 int  output,
@par_t24 int  output,
@par_t34 int  output,
@par_t44 int  output,
@par_t54 int  output,
@par_t64 int  output

)
AS
declare 
@m_MealDate datetime ,
@m_PodRoom varchar(20),
@m_Breakfast int,
@m_Lunch int,
@m_Dinner int,
@m_Snack int,
@m_indJuv varchar(20),
--
@w_Pod varchar(1)
--@w_Staff_Pod varchar(7)

CREATE TABLE  #tmpMeals
 (
	numrec int identity not null,
	MealDate datetime ,
	PodRoom varchar(20),
	Breakfast int,
	Lunch int,
	Dinner int,
	Snack int,
 	indJuv VARCHAR(8)
)
--@m_MealMonth_par

INSERT INTO #tmpMeals
	SELECT MealDate, StafPodRoom as PodRoom,Breakfast, Lunch, Dinner, Snack, indJuv='Staff'
	FROM  tblDetMeals
--WHERE (MealDate=@m_MealDate_par) and (StaffId IS NOT NULL)
	WHERE (Month(MealDate)=@m_MealMonth_par) and Year(MealDate ) = @m_MealYear_par and (StaffId IS NOT NULL)
	UNION
	SELECT dbo.tblDetMeals.MealDate, dbo.tblDetentionSupp.PodRoom,dbo.tblDetMeals.Breakfast,dbo.tblDetMeals.Lunch,dbo.tblDetMeals.Dinner,dbo.tblDetMeals.Snack,indJuv='Juvenile'
FROM dbo.tblDetMeals INNER JOIN dbo.tblDetentionSupp ON dbo.tblDetMeals.RefServID=dbo.tblDetentionSupp.RefServID
--WHERE (dbo.tblDetMeals.MealDate=@m_MealDate_par)
WHERE (Month(dbo.tblDetMeals.MealDate)=@m_MealMonth_par) and Year(MealDate ) =@m_MealYear_par
ORDER BY indJuv,PodRoom
 Select * from #tmpMeals

-- Create a Cursor 

BEGIN    


DECLARE MealsJuvenileAndStaffReport_cursor
	CURSOR FOR
	SELECT MealDate, PodRoom, Breakfast, Lunch, Dinner, Snack, indJuv
	FROM #tmpMeals
	ORDER BY indJuv,PodRoom
	
-- Open Cursor
	OPEN MealsJuvenileAndStaffReport_cursor
	FETCH NEXT FROM MealsJuvenileAndStaffReport_cursor
	INTO
		@m_MealDate  ,
		@m_PodRoom ,
		@m_Breakfast,
		@m_Lunch ,
		@m_Dinner,
		@m_Snack ,
		@m_indJuv
-- set parameters for B- Breakfast
	set @par_b11 = 0
	set @par_b21 = 0
	set @par_b31 = 0
	set @par_b41 = 0
	set @par_b51 = 0
	set @par_b61 = 0
--set parameters for B- Lunch
	set @par_b12 = 0
	set @par_b22 = 0
	set @par_b32 = 0
	set @par_b42 = 0
	set @par_b52 = 0
	set @par_b62 = 0
--set parameters for B- Dinner
	set @par_b13= 0
	set @par_b23 = 0
	set @par_b33 = 0
	set @par_b43 = 0
	set @par_b53 = 0
	set @par_b63 = 0
--set parameters for B-Snack
	set @par_b14= 0
	set @par_b24 = 0
	set @par_b34 = 0
	set @par_b44= 0
	set @par_b54 = 0
	set @par_b64 = 0


-- set parameters for C- Breakfast
	set @par_c11 = 0
	set @par_c21 = 0
	set @par_c31 = 0
	set @par_c41 = 0
	set @par_c51 = 0
	set @par_c61 = 0
-- set parameters for C- Lunch
	set @par_c12= 0
	set @par_c22 = 0
	set @par_c32 = 0
	set @par_c42 = 0
	set @par_c52 = 0
	set @par_c62 = 0
-- set parameters for C-Dinner
	set @par_c13= 0
	set @par_c23 = 0
	set @par_c33 = 0
	set @par_c43 = 0
	set @par_c53 = 0
	set @par_c63 = 0
-- set parameters for C-Snack
	set @par_c14= 0
	set @par_c24 = 0
	set @par_c34 = 0
	set @par_c44 = 0
	set @par_c54 = 0
	set @par_c64 = 0

-- set parameters for D- Breakfast
	set @par_d11 = 0
	set @par_d21 = 0
	set @par_d31 = 0
	set @par_d41 = 0
	set @par_d51 = 0
	set @par_d61 = 0
--set parameters for B- Lunch
	set @par_d12 = 0
	set @par_d22 = 0
	set @par_d32 = 0
	set @par_d42 = 0
	set @par_d52 = 0
	set @par_d62 = 0
-- set parameters for D-Dinner
	set @par_d13 = 0
	set @par_d23 = 0
	set @par_d33 = 0
	set @par_d43 = 0
	set @par_d53 = 0

	set @par_d63 = 0
-- set parameters for D-Snack
	set @par_d14 = 0
	set @par_d24 = 0
	set @par_d34 = 0

	set @par_d44 = 0
	set @par_d54 = 0
	set @par_d64 = 0
--
-- set parameters for E- Breakfast
	set @par_e11 = 0
	set @par_e21 = 0
	set @par_e31 = 0
	set @par_e41 = 0
	set @par_e51 = 0
	set @par_e61 = 0
-- set parameters for E- Lunch
	set @par_e12 = 0
	set @par_e22 = 0
	set @par_e32 = 0
	set @par_e42 = 0
	set @par_e52 = 0
	set @par_e62 = 0
-- set parameters for E- Dinner
	set @par_e13= 0
	set @par_e23 = 0
	set @par_e33 = 0
	set @par_e43 = 0
	set @par_e53 = 0
	set @par_e63 = 0
-- set parameters for E- Snack
	set @par_e14= 0
	set @par_e24 = 0
	set @par_e34 = 0
	set @par_e44 = 0
	set @par_e54 = 0
	set @par_e64 = 0
--
-- set parameters for F- Breakfast
	set @par_f11 = 0
	set @par_f21 = 0
	set @par_f31 = 0
	set @par_f41 = 0
	set @par_f51 = 0
	set @par_f61 = 0
--set parameters for F-Lunch
	set @par_f12 = 0
	set @par_f22 = 0
	set @par_f32 = 0
	set @par_f42 = 0
	set @par_f52 = 0
	set @par_f62 = 0
--set parameters for F- Dinner
	set @par_f13 = 0
	set @par_f23 = 0
	set @par_f33 = 0
	set @par_f43 = 0
	set @par_f53 = 0
	set @par_f63 = 0
--set parameters for F- Snack
	set @par_f14 = 0
	set @par_f24 = 0
	set @par_f34 = 0
	set @par_f44 = 0
	set @par_f54 = 0
	set @par_f64 = 0

--
-- set parameters for G- Breakfast
	set @par_g11 = 0
	set @par_g21 = 0
	set @par_g31 = 0
	set @par_g41 = 0
	set @par_g51 = 0
	set @par_g61 = 0
--set parameters for G-Lunch
	set @par_g12 = 0
	set @par_g22 = 0
	set @par_g32 = 0
	set @par_g42 = 0
	set @par_g52 = 0
	set @par_g62 = 0
--set parameters for G- Dinner
	set @par_g13 = 0
	set @par_g23 = 0
	set @par_g33 = 0
	set @par_g43 = 0
	set @par_g53 = 0
	set @par_g63 = 0
--set parameters for G- Snack
	set @par_g14 = 0
	set @par_g24 = 0
	set @par_g34 = 0
	set @par_g44 = 0
	set @par_g54 = 0
	set @par_g64 = 0

-- set parameters for Total - Breakfast
	set @par_t11= 0
	set @par_t21= 0
	set @par_t31 = 0
	set @par_t41= 0
	set @par_t51 = 0
	set @par_t61 = 0

-- set parameters for Total -Lunch
	set @par_t12 = 0
	set @par_t22 = 0
	set @par_t32 = 0
	set @par_t42 = 0
	set @par_t52 = 0
	set @par_t62 = 0

-- set parameters for Total -Dinner
	set @par_t13 = 0
	set @par_t23 = 0
	set @par_t33 = 0
	set @par_t43 = 0
	set @par_t53 = 0
	set @par_t63 = 0

-- set parameters for Total -Snack
	set @par_t14 = 0
	set @par_t24 = 0
	set @par_t34 = 0
	set @par_t44 = 0
	set @par_t54 = 0
	set @par_t64 = 0
--
	WHILE @@FETCH_STATUS = 0      -- While loop
	BEGIN

	if (@m_PodRoom is null)
	begin
		GoTo GetNext
	end
	
	
	set @w_Pod = substring(rtrim(ltrim(@m_PodRoom)),1,1) -- check first letter for PodRoom C-1,C12,C1.....will be Pod C
		

	-- Pod B Juvenile and Staff ---------------------------------------------------------------------------  beg
	
	if  ( @w_Pod  ='B' and  @m_indJuv='Juvenile')
			begin
				--BREAKFAST
				if @m_Breakfast = 1 
					begin
					set @par_b11=@par_b11 + 1 -- B-Dinning Hall
					set @par_b51=@par_b51 + 1 -- B -Total Youth
					set @par_t41=@par_t41 + 1   -- Total - Grand Total Youth
					set @par_t61=@par_t61 + 1   -- Total - TOTAL
					end
				if @m_Breakfast = 2
					begin
					set @par_b21=@par_b21 + 1
					set @par_b51=@par_b51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1

					end
				if @m_Breakfast = 3
					begin
					set @par_b31=@par_b31 + 1
					set @par_b51=@par_b51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				if @m_Breakfast = 4
					begin
					set @par_b41=@par_b41 + 1
					set @par_b51=@par_b51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end

				--LUNCH
				if @m_Lunch= 1 
					begin
					set @par_b12=@par_b12 + 1
					set @par_b52=@par_b52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1

					end
				if @m_Lunch = 2
					begin
					set @par_b22=@par_b22 + 1
					set @par_b52=@par_b52 + 1
					set @par_t42=@par_t42 + 1

					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 3
					begin
					set @par_b32=@par_b32 + 1
					set @par_b52=@par_b52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 4
					begin
					set @par_b42=@par_b42 + 1
					set @par_b52=@par_b52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end

				--DINNER
				if @m_Dinner= 1 
					begin
					set @par_b13=@par_b13 + 1
					set @par_b53=@par_b53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 2
					begin
					set @par_b23=@par_b23 + 1
					set @par_b53=@par_b53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 3
					begin
					set @par_b33=@par_b33 + 1
					set @par_b53=@par_b53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 4
					begin
					set @par_b43=@par_b43 + 1
					set @par_b53=@par_b53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end

				--SNACK
				if @m_Snack= 1 
					begin
					set @par_b14=@par_b14 + 1
					set @par_b54=@par_b54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 2
					begin
					set @par_b24=@par_b24 + 1
					set @par_b54=@par_b54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack= 3
					begin
					set @par_b34=@par_b34 + 1
					set @par_b54=@par_b54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 4
					begin
					set @par_b44=@par_b44 + 1
					set @par_b54=@par_b54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
			end

		if  ( @w_Pod  ='B' and  @m_indJuv='Staff')
			begin
				if ( @m_Breakfast = 1 or @m_Breakfast = 2 or @m_Breakfast = 3 or @m_Breakfast = 4)
					begin
					set @par_b61=@par_b61 + 1
					set @par_t51=@par_t51 + 1
					set @par_t61=@par_t61 + 1
					end
				if ( @m_Lunch = 1 or @m_Lunch = 2 or @m_Lunch = 3 or @m_Lunch = 4)
					begin
					set @par_b62=@par_b62 + 1
					set @par_t52=@par_t52 + 1
					set @par_t62=@par_t62 + 1
					end
				if ( @m_Dinner = 1 or @m_Dinner  = 2 or @m_Dinner  = 3 or @m_Dinner  = 4)
					begin
					set @par_b63=@par_b63 + 1
					set @par_t53=@par_t53+ 1
					set @par_t63=@par_t63 + 1
					end

				if ( @m_Snack = 1 or @m_Snack  = 2 or @m_Snack  = 3 or @m_Snack  = 4)
					begin
					set @par_b64=@par_b64 + 1
					set @par_t54=@par_t54+ 1
					set @par_t64=@par_t64 + 1
					end
				


			end
				
	-- Pod B Juvenile and Staff ---------------------------------------------------------------------------  End


	-- Pod C Juvenile and Staff ---------------------------------------------------------------------------  Beg

		if  ( @w_Pod  ='C' and  @m_indJuv='Juvenile')
		begin
			--BREAKFAST
				if @m_Breakfast = 1 
					begin
					set @par_c11=@par_c11 + 1 -- C-Dinning Hall
					set @par_c51=@par_c51 + 1 -- C -Total Youth
					set @par_t41=@par_t41 + 1   -- Total - Grand Total Youth
					set @par_t61=@par_t61 + 1   -- Total - TOTAL
					end
				if @m_Breakfast = 2
					begin
					set @par_c21=@par_c21 + 1
					set @par_c51=@par_c51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				if @m_Breakfast = 3
					begin
					set @par_c31=@par_c31 + 1
					set @par_c51=@par_c51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				if @m_Breakfast = 4
					begin
					set @par_c41=@par_c41 + 1
					set @par_c51=@par_c51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end

				--LUNCH
				if @m_Lunch= 1 
					begin
					set @par_c12=@par_c12 + 1
					set @par_c52=@par_c52 + 1

					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 2
					begin

					set @par_c22=@par_c22 + 1
					set @par_c52=@par_c52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 3
					begin
					set @par_c32=@par_c32 + 1
					set @par_c52=@par_c52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 4
					begin
					set @par_c42=@par_c42 + 1
					set @par_c52=@par_c52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				--DINNER
				if @m_Dinner= 1 
					begin
					set @par_c13=@par_c13 + 1
					set @par_c53=@par_c53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 2
					begin
					set @par_c23=@par_c23 + 1
					set @par_c53=@par_c53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 3
					begin
					set @par_c33=@par_c33 + 1
					set @par_c53=@par_c53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 4
					begin
					set @par_c43=@par_c43 + 1
					set @par_c53=@par_c53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				--SNACK
				if @m_Snack= 1 
					begin
					set @par_c14=@par_c14 + 1
					set @par_c54=@par_c54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 2
					begin
					set @par_c24=@par_c24 + 1
					set @par_c54=@par_c54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack= 3
					begin
					set @par_c34=@par_c34 + 1
					set @par_c54=@par_c54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 4
					begin
					set @par_c44=@par_c44 + 1
					set @par_c54=@par_c54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end



		end




		if  ( @w_Pod  ='C' and  @m_indJuv='Staff')
		begin

			if ( @m_Breakfast = 1 or @m_Breakfast = 2 or @m_Breakfast = 3 or @m_Breakfast = 4)
					begin
					set @par_c61=@par_c61 + 1
					set @par_t51=@par_t51 + 1
					set @par_t61=@par_t61 + 1
					end
			if ( @m_Lunch = 1 or @m_Lunch = 2 or @m_Lunch = 3 or @m_Lunch = 4)
					begin
					set @par_c62=@par_c62 + 1
					set @par_t52=@par_t52 + 1
					set @par_t62=@par_t62 + 1
					end
			if ( @m_Dinner = 1 or @m_Dinner  = 2 or @m_Dinner  = 3 or @m_Dinner  = 4)
					begin
					set @par_c63=@par_c63 + 1
					set @par_t53=@par_t53+ 1
					set @par_t63=@par_t63 + 1
					end
			
			if ( @m_Snack = 1 or @m_Snack  = 2 or @m_Snack  = 3 or @m_Snack  = 4)
					begin
					set @par_c64=@par_c64 + 1
					set @par_t54=@par_t54+ 1
					set @par_t64=@par_t64 + 1
					end

			

		end
		
	-- Pod C Juvenile and Staff ---------------------------------------------------------------------------  End


	-- Pod D Juvenile and Staff ---------------------------------------------------------------------------  Beg
			if  ( @w_Pod  ='D' and  @m_indJuv='Juvenile')
			begin
				--BREAKFAST
				if @m_Breakfast = 1 
					begin
					set @par_d11=@par_d11 + 1 -- D-Dinning Hall
					set @par_d51=@par_d51 + 1 -- D -Total Youth
					set @par_t41=@par_t41 + 1   -- Total - Grand Total Youth
					set @par_t61=@par_t61 + 1   -- Total - TOTAL
					end
				if @m_Breakfast = 2
					begin
					set @par_d21=@par_d21 + 1
					set @par_d51=@par_d51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				if @m_Breakfast = 3
					begin
					set @par_d31=@par_d31 + 1
					set @par_d51=@par_d51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				if @m_Breakfast = 4
					begin
					set @par_d41=@par_d41 + 1
					set @par_d51=@par_d51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end

				--LUNCH
				if @m_Lunch= 1 


					begin

					set @par_d12=@par_d12 + 1
					set @par_d52=@par_d52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 2
					begin
					set @par_d22=@par_d22 + 1
					set @par_d52=@par_d52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 3
					begin
					set @par_d32=@par_d32 + 1
					set @par_d52=@par_d52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 4
					begin
					set @par_d42=@par_d42 + 1
					set @par_d52=@par_d52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				--DINNER
				if @m_Dinner= 1 
					begin
					set @par_d13=@par_d13 + 1
					set @par_d53=@par_d53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 2
					begin
					set @par_d23=@par_d23 + 1
					set @par_d53=@par_d53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 3
					begin
					set @par_d33=@par_d33 + 1
					set @par_d53=@par_d53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 4
					begin
					set @par_d43=@par_d43 + 1
					set @par_d53=@par_d53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				--SNACK
				if @m_Snack= 1 
					begin
					set @par_d14=@par_d14 + 1
					set @par_d54=@par_d54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 2
					begin
					set @par_d24=@par_d24 + 1
					set @par_d54=@par_d54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack= 3
					begin
					set @par_d34=@par_d34 + 1
					set @par_d54=@par_d54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 4
					begin
					set @par_d44=@par_d44 + 1
					set @par_d54=@par_d54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end

			end

			if  ( @w_Pod  ='D' and  @m_indJuv='Staff')
			begin
				if ( @m_Breakfast = 1 or @m_Breakfast = 2 or @m_Breakfast = 3 or @m_Breakfast = 4)
					begin
					set @par_d61=@par_d61 + 1
					set @par_t51=@par_t51 + 1
					set @par_t61=@par_t61 + 1
					end
				if ( @m_Lunch = 1 or @m_Lunch = 2 or @m_Lunch = 3 or @m_Lunch = 4)
					begin
					set @par_d62=@par_d62 + 1
					set @par_t52=@par_t52 + 1
					set @par_t62=@par_t62 + 1
					end
				if ( @m_Dinner = 1 or @m_Dinner  = 2 or @m_Dinner  = 3 or @m_Dinner  = 4)
					begin
					set @par_d63=@par_d63 + 1
					set @par_t53=@par_t53+ 1
					set @par_t63=@par_t63 + 1
					end
				if ( @m_Snack = 1 or @m_Snack  = 2 or @m_Snack  = 3 or @m_Snack  = 4)
					begin
					set @par_d64=@par_d64 + 1

					set @par_t54=@par_t54+ 1
					set @par_t64=@par_t64 + 1
					end

			end
	-- Pod D Juvenile and Staff ---------------------------------------------------------------------------  End
	
	-- Pod E Juvenile and Staff ---------------------------------------------------------------------------  Begin

			if  ( @w_Pod  ='E' and  @m_indJuv='Juvenile')
			begin
				--BREAKFAST
				if @m_Breakfast = 1 
					begin
					set @par_e11=@par_e11 + 1 -- E-Dinning Hall
					set @par_e51=@par_e51 + 1 -- E -Total Youth
					set @par_t41=@par_t41 + 1   -- Total - Grand Total Youth
					set @par_t61=@par_t61 + 1   -- Total - TOTAL
					end
				if @m_Breakfast = 2
					begin
					set @par_e21=@par_e21 + 1
					set @par_e51=@par_e51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				if @m_Breakfast = 3
					begin
					set @par_e31=@par_e31 + 1
					set @par_e51=@par_e51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				if @m_Breakfast = 4
					begin

					set @par_e41=@par_e41 + 1
					set @par_e51=@par_e51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				--LUNCH
				if @m_Lunch= 1 
					begin
					set @par_e12=@par_e12 + 1
					set @par_e52=@par_e52 + 1
					set @par_t42=@par_t42 + 1

					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 2
					begin
					set @par_e22=@par_e22 + 1
					set @par_e52=@par_e52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 3
					begin
					set @par_e32=@par_e32 + 1
					set @par_e52=@par_e52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 4
					begin
					set @par_e42=@par_e42 + 1
					set @par_e52=@par_e52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end

				--DINNER
				if @m_Dinner= 1 
					begin
					set @par_e13=@par_e13 + 1
					set @par_e53=@par_e53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 2
					begin
					set @par_e23=@par_e23 + 1
					set @par_e53=@par_e53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 3
					begin
					set @par_e33=@par_e33 + 1
					set @par_e53=@par_e53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 4
					begin
					set @par_e43=@par_e43 + 1
					set @par_e53=@par_e53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end

					
				--SNACK
				if @m_Snack= 1 
					begin
					set @par_e14=@par_e14 + 1
					set @par_e54=@par_e54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 2
					begin
					set @par_e24=@par_e24 + 1
					set @par_e54=@par_e54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack= 3
					begin
					set @par_e34=@par_e34 + 1
					set @par_e54=@par_e54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 4
					begin
					set @par_e44=@par_e44 + 1
					set @par_e54=@par_e54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end

			end


			if  ( @w_Pod  ='E' and  @m_indJuv='Staff')
			begin
				if ( @m_Breakfast = 1 or @m_Breakfast = 2 or @m_Breakfast = 3 or @m_Breakfast = 4)
					begin
					set @par_e61=@par_e61 + 1
					set @par_t51=@par_t51 + 1
					set @par_t61=@par_t61 + 1
					end
				if ( @m_Lunch = 1 or @m_Lunch = 2 or @m_Lunch = 3 or @m_Lunch = 4)
					begin
					set @par_e62=@par_e62 + 1
					set @par_t52=@par_t52 + 1
					set @par_t62=@par_t62 + 1
					end
				if ( @m_Dinner = 1 or @m_Dinner  = 2 or @m_Dinner  = 3 or @m_Dinner  = 4)
					begin
					set @par_e63=@par_e63 + 1
					set @par_t53=@par_t53+ 1
					set @par_t63=@par_t63 + 1
					end
				if ( @m_Snack = 1 or @m_Snack  = 2 or @m_Snack  = 3 or @m_Snack  = 4)
					begin
					set @par_e64=@par_e64 + 1
					set @par_t54=@par_t54+ 1
					set @par_t64=@par_t64 + 1
					end

			end


	-- Pod E Juvenile and Staff ---------------------------------------------------------------------------  End	

	-- Pod F Juvenile and Staff ---------------------------------------------------------------------------  Beg

			if  ( @w_Pod  ='F' and  @m_indJuv='Juvenile')
			begin
				--BREAKFAST
				if @m_Breakfast = 1 
					begin
					set @par_f11=@par_f11 + 1 -- E-Dinning Hall
					set @par_f51=@par_f51 + 1 -- E -Total Youth
					set @par_t41=@par_t41 + 1   -- Total - Grand Total Youth
					set @par_t61=@par_t61 + 1   -- Total - TOTAL
					end
				if @m_Breakfast = 2
					begin
					set @par_f21=@par_f21 + 1
					set @par_f51=@par_f51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				if @m_Breakfast = 3
					begin
					set @par_f31=@par_f31 + 1
					set @par_f51=@par_f51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				if @m_Breakfast = 4
					begin
					set @par_f41=@par_f41 + 1
					set @par_f51=@par_f51 + 1

					set @par_t41=@par_t41 + 1

					set @par_t61=@par_t61 + 1
					end
				--LUNCH
				if @m_Lunch= 1 
					begin
					set @par_f12=@par_f12 + 1
					set @par_f52=@par_f52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 2
					begin
					set @par_f22=@par_f22 + 1
					set @par_f52=@par_f52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 3
					begin
					set @par_f32=@par_f32 + 1
					set @par_f52=@par_f52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 4
					begin
					set @par_f42=@par_f42 + 1
					set @par_f52=@par_f52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end

				--DINNER
				if @m_Dinner= 1 
					begin
					set @par_f13=@par_f13 + 1
					set @par_f53=@par_f53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 2
					begin
					set @par_f23=@par_f23 + 1
					set @par_f53=@par_f53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 3
					begin
					set @par_f33=@par_f33 + 1
					set @par_f53=@par_f53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 4
					begin
					set @par_f43=@par_f43 + 1
					set @par_f53=@par_f53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end

					
				--SNACK
				if @m_Snack= 1 
					begin
					set @par_f14=@par_f14 + 1
					set @par_f54=@par_f54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 2
					begin
					set @par_f24=@par_f24 + 1
					set @par_f54=@par_f54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack= 3
					begin
					set @par_f34=@par_f34 + 1
					set @par_f54=@par_f54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 4
					begin
					set @par_f44=@par_f44 + 1
					set @par_f54=@par_f54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end

			end

			



			if  ( @w_Pod  ='F' and  @m_indJuv='Staff')
			begin
				if ( @m_Breakfast = 1 or @m_Breakfast = 2 or @m_Breakfast = 3 or @m_Breakfast = 4)
					begin
					set @par_f61=@par_f61 + 1
					set @par_t51=@par_t51 + 1
					set @par_t61=@par_t61 + 1
					end
				if ( @m_Lunch = 1 or @m_Lunch = 2 or @m_Lunch = 3 or @m_Lunch = 4)
					begin
					set @par_f62=@par_f62 + 1
					set @par_t52=@par_t52 + 1
					set @par_t62=@par_t62 + 1
					end
				if ( @m_Dinner = 1 or @m_Dinner  = 2 or @m_Dinner  = 3 or @m_Dinner  = 4)
					begin
					set @par_f63=@par_f63 + 1
					set @par_t53=@par_t53+ 1
					set @par_t63=@par_t63 + 1
					end
				if ( @m_Snack = 1 or @m_Snack  = 2 or @m_Snack  = 3 or @m_Snack  = 4)
					begin
					set @par_f64=@par_f64 + 1
					set @par_t54=@par_t54+ 1
					set @par_t64=@par_t64 + 1
					end

			end


	-- Pod F Juvenile and Staff ---------------------------------------------------------------------------  End	

	-- Pod G Juvenile and Staff ---------------------------------------------------------------------------  Beg

			if  ( @w_Pod  ='G' and  @m_indJuv='Juvenile')
			begin
				--BREAKFAST
				if @m_Breakfast = 1 
					begin
					set @par_g11=@par_g11 + 1 -- E-Dinning Hall
					set @par_g51=@par_g51 + 1 -- E -Total Youth
					set @par_t41=@par_t41 + 1   -- Total - Grand Total Youth
					set @par_t61=@par_t61 + 1   -- Total - TOTAL
					end
				if @m_Breakfast = 2
					begin
					set @par_g21=@par_g21 + 1
					set @par_g51=@par_g51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				if @m_Breakfast = 3
					begin
					set @par_g31=@par_g31 + 1
					set @par_g51=@par_g51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				if @m_Breakfast = 4

					begin
					set @par_g41=@par_g41 + 1
					set @par_g51=@par_g51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end


				--LUNCH
				if @m_Lunch= 1 
					begin
					set @par_g12=@par_g12 + 1
					set @par_g52=@par_g52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 2
					begin
					set @par_g22=@par_g22 + 1
					set @par_g52=@par_g52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 3
					begin
					set @par_g32=@par_g32 + 1
					set @par_g52=@par_g52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 4
					begin
					set @par_g42=@par_g42 + 1
					set @par_g52=@par_g52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end

				--DINNER
				if @m_Dinner= 1 
					begin
					set @par_g13=@par_g13 + 1
					set @par_g53=@par_g53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 2
					begin
					set @par_g23=@par_g23 + 1
					set @par_g53=@par_g53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 3
					begin
					set @par_g33=@par_g33 + 1
					set @par_g53=@par_g53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 4
					begin
					set @par_g43=@par_g43 + 1
					set @par_g53=@par_g53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end

					
				--SNACK
				if @m_Snack= 1 
					begin
					set @par_g14=@par_g14 + 1
					set @par_g54=@par_g54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 2
					begin
					set @par_g24=@par_g24 + 1
					set @par_g54=@par_g54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack= 3
					begin
					set @par_g34=@par_g34 + 1
					set @par_g54=@par_g54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 4
					begin
					set @par_g44=@par_g44 + 1
					set @par_g54=@par_g54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end

			end


			if  ( @w_Pod  ='G' and  @m_indJuv='Staff')
			begin
				if ( @m_Breakfast = 1 or @m_Breakfast = 2 or @m_Breakfast = 3 or @m_Breakfast = 4)
					begin
					set @par_g61=@par_g61 + 1
					set @par_t51=@par_t51 + 1
					set @par_t61=@par_t61 + 1
					end
				if ( @m_Lunch = 1 or @m_Lunch = 2 or @m_Lunch = 3 or @m_Lunch = 4)
					begin
					set @par_g62=@par_g62 + 1
					set @par_t52=@par_t52 + 1
					set @par_t62=@par_t62 + 1
					end
				if ( @m_Dinner = 1 or @m_Dinner  = 2 or @m_Dinner  = 3 or @m_Dinner  = 4)
					begin
					set @par_g63=@par_g63 + 1
					set @par_t53=@par_t53+ 1
					set @par_t63=@par_t63 + 1
					end
				if ( @m_Snack = 1 or @m_Snack  = 2 or @m_Snack  = 3 or @m_Snack  = 4)
					begin
					set @par_g64=@par_g64 + 1
					set @par_t54=@par_t54+ 1
					set @par_t64=@par_t64 + 1
					end

			end


	-- Pod G Juvenile and Staff ---------------------------------------------------------------------------  End	

	-- Pod Control Room  and Staff ---------------------------------------------------------------------------  Beg

			--if (substring(ltrim(rtrim(@m_PodRoom)),1,3) ='Con'    and  @m_indJuv='Staff')
	
			if (cast(@m_PodRoom as varchar) ='Control Room'  and  @m_indJuv='Staff')
			begin

				--print ' return par:  ' + cast(@par_b11 as varchar)
				if ( @m_Breakfast = 1 or @m_Breakfast = 2 or @m_Breakfast = 3 or @m_Breakfast = 4)
					begin
					set @par_t11=@par_t11 + 1
					set @par_t51=@par_t51 + 1
					set @par_t61=@par_t61 + 1
					end
				if ( @m_Lunch = 1 or @m_Lunch = 2 or @m_Lunch = 3 or @m_Lunch = 4)

					begin
					set @par_t12=@par_t12 + 1
					set @par_t52=@par_t52 + 1
					set @par_t62=@par_t62 + 1
					end
				if ( @m_Dinner = 1 or @m_Dinner  = 2 or @m_Dinner  = 3 or @m_Dinner  = 4)
					begin
					set @par_t13=@par_t13 + 1
					set @par_t53=@par_t53+ 1
					set @par_t63=@par_t63 + 1
					end
				if ( @m_Snack = 1 or @m_Snack  = 2 or @m_Snack  = 3 or @m_Snack  = 4)
					begin
					set @par_t14=@par_t14 + 1
					set @par_t54=@par_t54+ 1
					set @par_t64=@par_t64 + 1
					end
			end
	-- Pod Control Roomand Staff ---------------------------------------------------------------------------  End	
	-- Pod Intake Staff  ---------------------------------------------------------------------------  Beg

			if  ( rtrim(ltrim(@m_PodRoom))  ='Intake Staff' and  @m_indJuv='Staff')
			begin

				if ( @m_Breakfast = 1 or @m_Breakfast = 2 or @m_Breakfast = 3 or @m_Breakfast = 4)
					begin
					set @par_t21=@par_t21 + 1
					set @par_t51=@par_t51 + 1
					set @par_t61=@par_t61 + 1
					end
				if ( @m_Lunch = 1 or @m_Lunch = 2 or @m_Lunch = 3 or @m_Lunch = 4)
					begin
					set @par_t22=@par_t22 + 1
					set @par_t52=@par_t52 + 1
					set @par_t62=@par_t62 + 1
					end
				if ( @m_Dinner = 1 or @m_Dinner  = 2 or @m_Dinner  = 3 or @m_Dinner  = 4)
					begin
					set @par_t23=@par_t23 + 1
					set @par_t53=@par_t53+ 1
					set @par_t63=@par_t63 + 1
					end
				if ( @m_Snack = 1 or @m_Snack  = 2 or @m_Snack  = 3 or @m_Snack  = 4)
					begin
					set @par_t24=@par_t24 + 1
					set @par_t54=@par_t54+ 1
					set @par_t64=@par_t64 + 1
					end
			end
		-- Pod Intake  Staff ---------------------------------------------------------------------------  End	
		-- Pod Medical Staff  ---------------------------------------------------------------------------  Beg

			if  ( rtrim(ltrim(@m_PodRoom))  ='Medical' and  @m_indJuv='Staff')
			begin

				if ( @m_Breakfast = 1 or @m_Breakfast = 2 or @m_Breakfast = 3 or @m_Breakfast = 4)
					begin
					set @par_t31=@par_t31 + 1
					set @par_t51=@par_t51 + 1
					set @par_t61=@par_t61 + 1
					end
				if ( @m_Lunch = 1 or @m_Lunch = 2 or @m_Lunch = 3 or @m_Lunch = 4)
					begin
					set @par_t32=@par_t32 + 1
					set @par_t52=@par_t52 + 1
					set @par_t62=@par_t62 + 1
					end
				if ( @m_Dinner = 1 or @m_Dinner  = 2 or @m_Dinner  = 3 or @m_Dinner  = 4)
					begin
					set @par_t33=@par_t33 + 1
					set @par_t53=@par_t53+ 1
					set @par_t63=@par_t63 + 1
					end
				if ( @m_Snack = 1 or @m_Snack  = 2 or @m_Snack  = 3 or @m_Snack  = 4)
					begin
					set @par_t34=@par_t34 + 1
					set @par_t54=@par_t54+ 1
					set @par_t64=@par_t64 + 1
					end
			end
	-- Pod Medical Staff ---------------------------------------------------------------------------  End	
	
	--		GoTo GetNext
		GetNext:
			FETCH NEXT FROM MealsJuvenileAndStaffReport_cursor
			INTO
				@m_MealDate  ,
				@m_PodRoom ,
				@m_Breakfast,
				@m_Lunch ,
				@m_Dinner,
				@m_Snack ,
				@m_indJuv
	END ------------------------------------------------- End While loop
	

END 


Close MealsJuvenileAndStaffReport_cursor
Deallocate MealsJuvenileAndStaffReport_cursor






GO


GRANT EXEC ON [spMonthlyMealsReport] TO [JusticeServicesAppID]
GO
USE [JusticeServices]
GO

/****** Object:  StoredProcedure [dbo].[spPurgeMeals]    Script Date: 03/11/2016 12:59:55 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


/****** Object:  Stored Procedure dbo.spPurgeMeals    Script Date: 12/7/2005 1:14:53 PM ******/
CREATE PROCEDURE [dbo].[spPurgeMeals] 
	@inDate datetime


AS

--================================================================================
--    Called from AdminList.aspx.  This procedure will delete all records from tblDetMeals older than the 
--            supplied date.
--================================================================================

	BEGIN

		DELETE from tblDetMeals
		WHERE mealdate < @inDate
	
	RETURN 
	END






GO


USE [JusticeServices]
GO

/****** Object:  StoredProcedure [dbo].[spTempMealsForJuvenileAndStaffReport]    Script Date: 03/11/2016 13:30:39 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


/****** Object:  Stored Procedure dbo.spTempMealsForJuvenileAndStaffReport    Script Date: 12/7/2005 1:14:54 PM ******/
CREATE PROCEDURE [dbo].[spTempMealsForJuvenileAndStaffReport]
(
@m_MealDate_par datetime ,
--
-- parameters for B-Breakfast
@par_b11  int  output,
@par_b21  int  output,
@par_b31  int  output,
@par_b41  int  output,
@par_b51  int  output,
@par_b61  int  output,
-- parameters for B-Lunch
@par_b12  int  output,
@par_b22  int  output,
@par_b32 int  output,
@par_b42  int  output,
@par_b52  int  output,
@par_b62  int  output,
-- parameters for B-Dinner
@par_b13 int  output,
@par_b23 int  output,
@par_b33 int  output,
@par_b43 int  output,
@par_b53  int  output,
@par_b63  int  output,
-- parameters for B-Snack
@par_b14 int  output,
@par_b24 int  output,
@par_b34 int  output,
@par_b44 int  output,
@par_b54  int  output,
@par_b64  int  output,
--
-- parameters for C-Breakfast
@par_c11  int  output,
@par_c21  int  output,
@par_c31  int  output,
@par_c41  int  output,
@par_c51  int  output,
@par_c61  int  output,
-- parameters for C- Lunch
@par_c12  int  output,
@par_c22  int  output,
@par_c32 int  output,
@par_c42 int  output,
@par_c52 int  output,
@par_c62  int  output,
-- parameters for C- Dinner
@par_c13  int  output,
@par_c23  int  output,
@par_c33 int  output,
@par_c43 int  output,
@par_c53 int  output,
@par_c63  int  output,
-- parameters for C- Snack
@par_c14 int  output,
@par_c24  int  output,
@par_c34 int  output,
@par_c44 int  output,
@par_c54 int  output,
@par_c64  int  output,
--
-- parameters for D-Breakfast
@par_d11  int  output,
@par_d21  int  output,
@par_d31  int  output,
@par_d41  int  output,
@par_d51  int  output,
@par_d61  int  output,
-- parameters for D-Lunch
@par_d12  int  output,
@par_d22  int  output,
@par_d32 int  output,
@par_d42  int  output,
@par_d52  int  output,
@par_d62  int  output,
-- parameters for D- Dinner
@par_d13  int  output,
@par_d23  int  output,
@par_d33 int  output,
@par_d43 int  output,
@par_d53 int  output,
@par_d63  int  output,
-- parameters for D-Snack
@par_d14 int  output,
@par_d24 int  output,
@par_d34 int  output,
@par_d44 int  output,
@par_d54  int  output,
@par_d64  int  output,
--
-- parameters for E-Breakfast
@par_e11  int  output,
@par_e21  int  output,
@par_e31  int  output,
@par_e41  int  output,
@par_e51  int  output,
@par_e61  int  output,
-- parameters for E-Lunch
@par_e12  int  output,
@par_e22 int  output,
@par_e32  int  output,
@par_e42  int  output,
@par_e52  int  output,
@par_e62  int  output,
-- parameters for E-Dinner
@par_e13  int  output,
@par_e23 int  output,
@par_e33  int  output,
@par_e43 int  output,
@par_e53 int  output,
@par_e63 int  output,
-- parameters for E-Snack
@par_e14 int  output,
@par_e24 int  output,
@par_e34  int  output,
@par_e44 int  output,
@par_e54 int  output,
@par_e64 int  output,
--
-- parameters for F-Breakfast
@par_f11  int  output,
@par_f21  int  output,
@par_f31  int  output,
@par_f41  int  output,
@par_f51  int  output,
@par_f61  int  output,
-- parameters for F-Lunch
@par_f12  int  output,
@par_f22  int  output,
@par_f32  int  output,
@par_f42  int  output,
@par_f52  int  output,
@par_f62 int  output,
-- parameters for F-Dinner
@par_f13 int  output,
@par_f23 int  output,
@par_f33  int  output,
@par_f43  int  output,
@par_f53  int  output,
@par_f63  int  output,
-- parameters for F-Snack
@par_f14  int  output,
@par_f24  int  output,
@par_f34 int  output,
@par_f44 int  output,
@par_f54 int  output,
@par_f64  int  output,
--
-- parameters for G-Breakfast
@par_g11  int  output,
@par_g21  int  output,
@par_g31  int  output,
@par_g41  int  output,
@par_g51  int  output,
@par_g61  int  output,
-- parameters for G-Lunch
@par_g12  int  output,
@par_g22  int  output,
@par_g32  int  output,
@par_g42  int  output,
@par_g52  int  output,
@par_g62 int  output,
-- parameters for G -Dinner
@par_g13 int  output,
@par_g23 int  output,
@par_g33  int  output,
@par_g43  int  output,
@par_g53  int  output,
@par_g63  int  output,
-- parameters for G-Snack
@par_g14  int  output,
@par_g24  int  output,
@par_g34 int  output,
@par_g44 int  output,
@par_g54 int  output,
@par_g64  int  output,
--

-- parameters for Total-Breakfast
@par_t11 int  output,
@par_t21 int  output,
@par_t31 int  output,
@par_t41 int  output,
@par_t51 int  output,
@par_t61 int  output,

-- parameters for Total-Lunch
@par_t12 int  output,
@par_t22 int  output,
@par_t32 int  output,
@par_t42 int  output,
@par_t52 int  output,
@par_t62 int  output,

-- parameters for Total-Dinner
@par_t13 int  output,
@par_t23 int  output,
@par_t33 int  output,
@par_t43 int  output,
@par_t53 int  output,
@par_t63 int  output,

-- parameters for Total-Snack
@par_t14 int  output,
@par_t24 int  output,
@par_t34 int  output,
@par_t44 int  output,
@par_t54 int  output,
@par_t64 int  output

)
AS
declare 
@m_MealDate datetime ,
@m_PodRoom varchar(20),
@m_Breakfast int,
@m_Lunch int,
@m_Dinner int,
@m_Snack int,
@m_indJuv varchar(20),
--
@w_Pod varchar(1)
--@w_Staff_Pod varchar(7)

CREATE TABLE  #tmpMeals
 (
	numrec int identity not null,
	MealDate datetime ,
	PodRoom varchar(20),
	Breakfast int,
	Lunch int,
	Dinner int,
	Snack int,
 	indJuv VARCHAR(8)
)


INSERT INTO #tmpMeals
	SELECT MealDate, StafPodRoom as PodRoom,Breakfast, Lunch, Dinner, Snack, indJuv='Staff'
	FROM  tblDetMeals
	WHERE (MealDate=@m_MealDate_par) and (StaffId IS NOT NULL)
	UNION
	SELECT dbo.tblDetMeals.MealDate, dbo.tblDetentionSupp.PodRoom,dbo.tblDetMeals.Breakfast,dbo.tblDetMeals.Lunch,dbo.tblDetMeals.Dinner,dbo.tblDetMeals.Snack,indJuv='Juvenile'
FROM dbo.tblDetMeals INNER JOIN dbo.tblDetentionSupp ON dbo.tblDetMeals.RefServID=dbo.tblDetentionSupp.RefServID
WHERE (dbo.tblDetMeals.MealDate=@m_MealDate_par)
ORDER BY indJuv,PodRoom
 Select * from #tmpMeals

-- Create a Cursor 

BEGIN    


DECLARE MealsJuvenileAndStaffReport_cursor
	CURSOR FOR
	SELECT MealDate, PodRoom, Breakfast, Lunch, Dinner, Snack, indJuv
	FROM #tmpMeals
	ORDER BY indJuv,PodRoom
	
-- Open Cursor
	OPEN MealsJuvenileAndStaffReport_cursor
	FETCH NEXT FROM MealsJuvenileAndStaffReport_cursor
	INTO
		@m_MealDate  ,
		@m_PodRoom ,
		@m_Breakfast,
		@m_Lunch ,
		@m_Dinner,
		@m_Snack ,
		@m_indJuv
-- set parameters for B- Breakfast
	set @par_b11 = 0
	set @par_b21 = 0
	set @par_b31 = 0
	set @par_b41 = 0
	set @par_b51 = 0
	set @par_b61 = 0
--set parameters for B- Lunch
	set @par_b12 = 0
	set @par_b22 = 0
	set @par_b32 = 0
	set @par_b42 = 0
	set @par_b52 = 0
	set @par_b62 = 0
--set parameters for B- Dinner
	set @par_b13= 0
	set @par_b23 = 0
	set @par_b33 = 0
	set @par_b43 = 0
	set @par_b53 = 0
	set @par_b63 = 0
--set parameters for B-Snack
	set @par_b14= 0
	set @par_b24 = 0
	set @par_b34 = 0
	set @par_b44= 0
	set @par_b54 = 0
	set @par_b64 = 0


-- set parameters for C- Breakfast
	set @par_c11 = 0
	set @par_c21 = 0
	set @par_c31 = 0
	set @par_c41 = 0
	set @par_c51 = 0
	set @par_c61 = 0
-- set parameters for C- Lunch
	set @par_c12= 0
	set @par_c22 = 0
	set @par_c32 = 0
	set @par_c42 = 0
	set @par_c52 = 0
	set @par_c62 = 0
-- set parameters for C-Dinner
	set @par_c13= 0
	set @par_c23 = 0
	set @par_c33 = 0
	set @par_c43 = 0
	set @par_c53 = 0
	set @par_c63 = 0
-- set parameters for C-Snack
	set @par_c14= 0
	set @par_c24 = 0
	set @par_c34 = 0
	set @par_c44 = 0
	set @par_c54 = 0
	set @par_c64 = 0

-- set parameters for D- Breakfast
	set @par_d11 = 0
	set @par_d21 = 0
	set @par_d31 = 0
	set @par_d41 = 0
	set @par_d51 = 0
	set @par_d61 = 0
--set parameters for B- Lunch
	set @par_d12 = 0
	set @par_d22 = 0
	set @par_d32 = 0
	set @par_d42 = 0
	set @par_d52 = 0
	set @par_d62 = 0
-- set parameters for D-Dinner
	set @par_d13 = 0
	set @par_d23 = 0
	set @par_d33 = 0
	set @par_d43 = 0
	set @par_d53 = 0
	set @par_d63 = 0
-- set parameters for D-Snack
	set @par_d14 = 0
	set @par_d24 = 0
	set @par_d34 = 0
	set @par_d44 = 0
	set @par_d54 = 0
	set @par_d64 = 0
--
-- set parameters for E- Breakfast
	set @par_e11 = 0
	set @par_e21 = 0
	set @par_e31 = 0
	set @par_e41 = 0
	set @par_e51 = 0
	set @par_e61 = 0
-- set parameters for E- Lunch
	set @par_e12 = 0
	set @par_e22 = 0
	set @par_e32 = 0
	set @par_e42 = 0
	set @par_e52 = 0
	set @par_e62 = 0
-- set parameters for E- Dinner
	set @par_e13= 0
	set @par_e23 = 0
	set @par_e33 = 0
	set @par_e43 = 0
	set @par_e53 = 0
	set @par_e63 = 0
-- set parameters for E- Snack
	set @par_e14= 0
	set @par_e24 = 0
	set @par_e34 = 0
	set @par_e44 = 0
	set @par_e54 = 0
	set @par_e64 = 0
--
-- set parameters for F- Breakfast
	set @par_f11 = 0
	set @par_f21 = 0
	set @par_f31 = 0
	set @par_f41 = 0
	set @par_f51 = 0
	set @par_f61 = 0
--set parameters for F-Lunch
	set @par_f12 = 0
	set @par_f22 = 0
	set @par_f32 = 0
	set @par_f42 = 0
	set @par_f52 = 0
	set @par_f62 = 0
--set parameters for F- Dinner
	set @par_f13 = 0
	set @par_f23 = 0
	set @par_f33 = 0
	set @par_f43 = 0
	set @par_f53 = 0
	set @par_f63 = 0
--set parameters for F- Snack
	set @par_f14 = 0
	set @par_f24 = 0
	set @par_f34 = 0
	set @par_f44 = 0
	set @par_f54 = 0
	set @par_f64 = 0

--
-- set parameters for G- Breakfast
	set @par_g11 = 0
	set @par_g21 = 0
	set @par_g31 = 0
	set @par_g41 = 0
	set @par_g51 = 0
	set @par_g61 = 0
--set parameters for G-Lunch
	set @par_g12 = 0
	set @par_g22 = 0
	set @par_g32 = 0
	set @par_g42 = 0
	set @par_g52 = 0
	set @par_g62 = 0
--set parameters for G- Dinner
	set @par_g13 = 0
	set @par_g23 = 0
	set @par_g33 = 0
	set @par_g43 = 0
	set @par_g53 = 0
	set @par_g63 = 0
--set parameters for G- Snack
	set @par_g14 = 0
	set @par_g24 = 0
	set @par_g34 = 0
	set @par_g44 = 0
	set @par_g54 = 0
	set @par_g64 = 0

-- set parameters for Total - Breakfast
	set @par_t11= 0
	set @par_t21= 0
	set @par_t31 = 0
	set @par_t41= 0
	set @par_t51 = 0
	set @par_t61 = 0

-- set parameters for Total -Lunch
	set @par_t12 = 0
	set @par_t22 = 0
	set @par_t32 = 0
	set @par_t42 = 0
	set @par_t52 = 0
	set @par_t62 = 0

-- set parameters for Total -Dinner
	set @par_t13 = 0
	set @par_t23 = 0
	set @par_t33 = 0
	set @par_t43 = 0
	set @par_t53 = 0
	set @par_t63 = 0

-- set parameters for Total -Snack
	set @par_t14 = 0
	set @par_t24 = 0
	set @par_t34 = 0
	set @par_t44 = 0
	set @par_t54 = 0
	set @par_t64 = 0
--
	WHILE @@FETCH_STATUS = 0      -- While loop
	BEGIN

	if (@m_PodRoom is null)
	begin
		GoTo GetNext
	end
	
	
	set @w_Pod = substring(rtrim(ltrim(@m_PodRoom)),1,1) -- check first letter for PodRoom C-1,C12,C1.....will be Pod C
		

	-- Pod B Juvenile and Staff ---------------------------------------------------------------------------  beg
	
	if  ( @w_Pod  ='B' and  @m_indJuv='Juvenile')
			begin
				--BREAKFAST
				if @m_Breakfast = 1 
					begin
					set @par_b11=@par_b11 + 1 -- B-Dinning Hall
					set @par_b51=@par_b51 + 1 -- B -Total Youth
					set @par_t41=@par_t41 + 1   -- Total - Grand Total Youth
					set @par_t61=@par_t61 + 1   -- Total - TOTAL
					end
				if @m_Breakfast = 2
					begin
					set @par_b21=@par_b21 + 1
					set @par_b51=@par_b51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1

					end
				if @m_Breakfast = 3
					begin
					set @par_b31=@par_b31 + 1
					set @par_b51=@par_b51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				if @m_Breakfast = 4
					begin
					set @par_b41=@par_b41 + 1
					set @par_b51=@par_b51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end

				--LUNCH
				if @m_Lunch= 1 
					begin
					set @par_b12=@par_b12 + 1
					set @par_b52=@par_b52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 2
					begin
					set @par_b22=@par_b22 + 1
					set @par_b52=@par_b52 + 1
					set @par_t42=@par_t42 + 1

					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 3
					begin
					set @par_b32=@par_b32 + 1
					set @par_b52=@par_b52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 4
					begin
					set @par_b42=@par_b42 + 1
					set @par_b52=@par_b52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end

				--DINNER
				if @m_Dinner= 1 
					begin
					set @par_b13=@par_b13 + 1
					set @par_b53=@par_b53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 2
					begin
					set @par_b23=@par_b23 + 1
					set @par_b53=@par_b53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 3
					begin
					set @par_b33=@par_b33 + 1
					set @par_b53=@par_b53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 4
					begin
					set @par_b43=@par_b43 + 1
					set @par_b53=@par_b53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end

				--SNACK
				if @m_Snack= 1 
					begin
					set @par_b14=@par_b14 + 1
					set @par_b54=@par_b54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 2
					begin
					set @par_b24=@par_b24 + 1
					set @par_b54=@par_b54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack= 3
					begin
					set @par_b34=@par_b34 + 1
					set @par_b54=@par_b54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 4
					begin
					set @par_b44=@par_b44 + 1
					set @par_b54=@par_b54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
			end

		if  ( @w_Pod  ='B' and  @m_indJuv='Staff')
			begin
				if ( @m_Breakfast = 1 or @m_Breakfast = 2 or @m_Breakfast = 3 or @m_Breakfast = 4)
					begin
					set @par_b61=@par_b61 + 1
					set @par_t51=@par_t51 + 1
					set @par_t61=@par_t61 + 1
					end
				if ( @m_Lunch = 1 or @m_Lunch = 2 or @m_Lunch = 3 or @m_Lunch = 4)
					begin
					set @par_b62=@par_b62 + 1
					set @par_t52=@par_t52 + 1
					set @par_t62=@par_t62 + 1
					end
				if ( @m_Dinner = 1 or @m_Dinner  = 2 or @m_Dinner  = 3 or @m_Dinner  = 4)
					begin
					set @par_b63=@par_b63 + 1
					set @par_t53=@par_t53+ 1
					set @par_t63=@par_t63 + 1
					end

				if ( @m_Snack = 1 or @m_Snack  = 2 or @m_Snack  = 3 or @m_Snack  = 4)
					begin
					set @par_b64=@par_b64 + 1
					set @par_t54=@par_t54+ 1
					set @par_t64=@par_t64 + 1
					end
				


			end
				
	-- Pod B Juvenile and Staff ---------------------------------------------------------------------------  End


	-- Pod C Juvenile and Staff ---------------------------------------------------------------------------  Beg

		if  ( @w_Pod  ='C' and  @m_indJuv='Juvenile')
		begin
			--BREAKFAST
				if @m_Breakfast = 1 
					begin
					set @par_c11=@par_c11 + 1 -- C-Dinning Hall
					set @par_c51=@par_c51 + 1 -- C -Total Youth
					set @par_t41=@par_t41 + 1   -- Total - Grand Total Youth
					set @par_t61=@par_t61 + 1   -- Total - TOTAL
					end
				if @m_Breakfast = 2
					begin
					set @par_c21=@par_c21 + 1
					set @par_c51=@par_c51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				if @m_Breakfast = 3
					begin
					set @par_c31=@par_c31 + 1
					set @par_c51=@par_c51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				if @m_Breakfast = 4
					begin
					set @par_c41=@par_c41 + 1
					set @par_c51=@par_c51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end

				--LUNCH
				if @m_Lunch= 1 
					begin
					set @par_c12=@par_c12 + 1
					set @par_c52=@par_c52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 2
					begin

					set @par_c22=@par_c22 + 1
					set @par_c52=@par_c52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 3
					begin
					set @par_c32=@par_c32 + 1
					set @par_c52=@par_c52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 4
					begin
					set @par_c42=@par_c42 + 1
					set @par_c52=@par_c52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				--DINNER
				if @m_Dinner= 1 
					begin
					set @par_c13=@par_c13 + 1
					set @par_c53=@par_c53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 2
					begin
					set @par_c23=@par_c23 + 1
					set @par_c53=@par_c53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 3
					begin
					set @par_c33=@par_c33 + 1
					set @par_c53=@par_c53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 4
					begin
					set @par_c43=@par_c43 + 1
					set @par_c53=@par_c53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				--SNACK
				if @m_Snack= 1 
					begin
					set @par_c14=@par_c14 + 1
					set @par_c54=@par_c54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 2
					begin
					set @par_c24=@par_c24 + 1
					set @par_c54=@par_c54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack= 3
					begin
					set @par_c34=@par_c34 + 1
					set @par_c54=@par_c54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 4
					begin
					set @par_c44=@par_c44 + 1
					set @par_c54=@par_c54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end



		end




		if  ( @w_Pod  ='C' and  @m_indJuv='Staff')
		begin

			if ( @m_Breakfast = 1 or @m_Breakfast = 2 or @m_Breakfast = 3 or @m_Breakfast = 4)
					begin
					set @par_c61=@par_c61 + 1
					set @par_t51=@par_t51 + 1
					set @par_t61=@par_t61 + 1
					end
			if ( @m_Lunch = 1 or @m_Lunch = 2 or @m_Lunch = 3 or @m_Lunch = 4)
					begin
					set @par_c62=@par_c62 + 1
					set @par_t52=@par_t52 + 1
					set @par_t62=@par_t62 + 1
					end
			if ( @m_Dinner = 1 or @m_Dinner  = 2 or @m_Dinner  = 3 or @m_Dinner  = 4)
					begin
					set @par_c63=@par_c63 + 1
					set @par_t53=@par_t53+ 1
					set @par_t63=@par_t63 + 1
					end
			
			if ( @m_Snack = 1 or @m_Snack  = 2 or @m_Snack  = 3 or @m_Snack  = 4)
					begin
					set @par_c64=@par_c64 + 1
					set @par_t54=@par_t54+ 1
					set @par_t64=@par_t64 + 1
					end

			

		end
		
	-- Pod C Juvenile and Staff ---------------------------------------------------------------------------  End


	-- Pod D Juvenile and Staff ---------------------------------------------------------------------------  Beg
			if  ( @w_Pod  ='D' and  @m_indJuv='Juvenile')
			begin
				--BREAKFAST
				if @m_Breakfast = 1 
					begin
					set @par_d11=@par_d11 + 1 -- D-Dinning Hall
					set @par_d51=@par_d51 + 1 -- D -Total Youth
					set @par_t41=@par_t41 + 1   -- Total - Grand Total Youth
					set @par_t61=@par_t61 + 1   -- Total - TOTAL
					end
				if @m_Breakfast = 2
					begin
					set @par_d21=@par_d21 + 1
					set @par_d51=@par_d51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				if @m_Breakfast = 3
					begin
					set @par_d31=@par_d31 + 1
					set @par_d51=@par_d51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				if @m_Breakfast = 4
					begin
					set @par_d41=@par_d41 + 1
					set @par_d51=@par_d51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end

				--LUNCH
				if @m_Lunch= 1 
					begin

					set @par_d12=@par_d12 + 1
					set @par_d52=@par_d52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 2
					begin
					set @par_d22=@par_d22 + 1
					set @par_d52=@par_d52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 3
					begin
					set @par_d32=@par_d32 + 1
					set @par_d52=@par_d52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 4
					begin
					set @par_d42=@par_d42 + 1
					set @par_d52=@par_d52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				--DINNER
				if @m_Dinner= 1 
					begin
					set @par_d13=@par_d13 + 1
					set @par_d53=@par_d53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 2
					begin
					set @par_d23=@par_d23 + 1
					set @par_d53=@par_d53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 3
					begin
					set @par_d33=@par_d33 + 1
					set @par_d53=@par_d53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 4
					begin
					set @par_d43=@par_d43 + 1
					set @par_d53=@par_d53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				--SNACK
				if @m_Snack= 1 
					begin
					set @par_d14=@par_d14 + 1
					set @par_d54=@par_d54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 2
					begin
					set @par_d24=@par_d24 + 1
					set @par_d54=@par_d54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack= 3
					begin
					set @par_d34=@par_d34 + 1
					set @par_d54=@par_d54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 4
					begin
					set @par_d44=@par_d44 + 1
					set @par_d54=@par_d54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end

			end

			if  ( @w_Pod  ='D' and  @m_indJuv='Staff')
			begin
				if ( @m_Breakfast = 1 or @m_Breakfast = 2 or @m_Breakfast = 3 or @m_Breakfast = 4)
					begin
					set @par_d61=@par_d61 + 1
					set @par_t51=@par_t51 + 1
					set @par_t61=@par_t61 + 1
					end
				if ( @m_Lunch = 1 or @m_Lunch = 2 or @m_Lunch = 3 or @m_Lunch = 4)
					begin
					set @par_d62=@par_d62 + 1
					set @par_t52=@par_t52 + 1
					set @par_t62=@par_t62 + 1
					end
				if ( @m_Dinner = 1 or @m_Dinner  = 2 or @m_Dinner  = 3 or @m_Dinner  = 4)
					begin
					set @par_d63=@par_d63 + 1
					set @par_t53=@par_t53+ 1
					set @par_t63=@par_t63 + 1
					end
				if ( @m_Snack = 1 or @m_Snack  = 2 or @m_Snack  = 3 or @m_Snack  = 4)
					begin
					set @par_d64=@par_d64 + 1

					set @par_t54=@par_t54+ 1
					set @par_t64=@par_t64 + 1
					end

			end
	-- Pod D Juvenile and Staff ---------------------------------------------------------------------------  End
	
	-- Pod E Juvenile and Staff ---------------------------------------------------------------------------  Begin

			if  ( @w_Pod  ='E' and  @m_indJuv='Juvenile')
			begin
				--BREAKFAST
				if @m_Breakfast = 1 
					begin
					set @par_e11=@par_e11 + 1 -- E-Dinning Hall
					set @par_e51=@par_e51 + 1 -- E -Total Youth
					set @par_t41=@par_t41 + 1   -- Total - Grand Total Youth
					set @par_t61=@par_t61 + 1   -- Total - TOTAL
					end
				if @m_Breakfast = 2
					begin
					set @par_e21=@par_e21 + 1
					set @par_e51=@par_e51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				if @m_Breakfast = 3
					begin
					set @par_e31=@par_e31 + 1
					set @par_e51=@par_e51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				if @m_Breakfast = 4
					begin
					set @par_e41=@par_e41 + 1
					set @par_e51=@par_e51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				--LUNCH
				if @m_Lunch= 1 
					begin
					set @par_e12=@par_e12 + 1
					set @par_e52=@par_e52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 2
					begin
					set @par_e22=@par_e22 + 1
					set @par_e52=@par_e52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 3
					begin
					set @par_e32=@par_e32 + 1
					set @par_e52=@par_e52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 4
					begin
					set @par_e42=@par_e42 + 1
					set @par_e52=@par_e52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end

				--DINNER
				if @m_Dinner= 1 
					begin
					set @par_e13=@par_e13 + 1
					set @par_e53=@par_e53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 2
					begin
					set @par_e23=@par_e23 + 1
					set @par_e53=@par_e53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 3
					begin
					set @par_e33=@par_e33 + 1
					set @par_e53=@par_e53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 4
					begin
					set @par_e43=@par_e43 + 1
					set @par_e53=@par_e53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end

					
				--SNACK
				if @m_Snack= 1 
					begin
					set @par_e14=@par_e14 + 1
					set @par_e54=@par_e54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 2
					begin
					set @par_e24=@par_e24 + 1
					set @par_e54=@par_e54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack= 3
					begin
					set @par_e34=@par_e34 + 1
					set @par_e54=@par_e54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 4
					begin
					set @par_e44=@par_e44 + 1
					set @par_e54=@par_e54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end

			end


			if  ( @w_Pod  ='E' and  @m_indJuv='Staff')
			begin
				if ( @m_Breakfast = 1 or @m_Breakfast = 2 or @m_Breakfast = 3 or @m_Breakfast = 4)
					begin
					set @par_e61=@par_e61 + 1
					set @par_t51=@par_t51 + 1
					set @par_t61=@par_t61 + 1
					end
				if ( @m_Lunch = 1 or @m_Lunch = 2 or @m_Lunch = 3 or @m_Lunch = 4)
					begin
					set @par_e62=@par_e62 + 1
					set @par_t52=@par_t52 + 1
					set @par_t62=@par_t62 + 1
					end
				if ( @m_Dinner = 1 or @m_Dinner  = 2 or @m_Dinner  = 3 or @m_Dinner  = 4)
					begin
					set @par_e63=@par_e63 + 1
					set @par_t53=@par_t53+ 1
					set @par_t63=@par_t63 + 1
					end
				if ( @m_Snack = 1 or @m_Snack  = 2 or @m_Snack  = 3 or @m_Snack  = 4)
					begin
					set @par_e64=@par_e64 + 1
					set @par_t54=@par_t54+ 1
					set @par_t64=@par_t64 + 1
					end

			end


	-- Pod E Juvenile and Staff ---------------------------------------------------------------------------  End	

	-- Pod F Juvenile and Staff ---------------------------------------------------------------------------  Beg

			if  ( @w_Pod  ='F' and  @m_indJuv='Juvenile')
			begin
				--BREAKFAST
				if @m_Breakfast = 1 
					begin
					set @par_f11=@par_f11 + 1 -- E-Dinning Hall
					set @par_f51=@par_f51 + 1 -- E -Total Youth
					set @par_t41=@par_t41 + 1   -- Total - Grand Total Youth
					set @par_t61=@par_t61 + 1   -- Total - TOTAL
					end
				if @m_Breakfast = 2
					begin
					set @par_f21=@par_f21 + 1
					set @par_f51=@par_f51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				if @m_Breakfast = 3
					begin
					set @par_f31=@par_f31 + 1
					set @par_f51=@par_f51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				if @m_Breakfast = 4
					begin
					set @par_f41=@par_f41 + 1
					set @par_f51=@par_f51 + 1

					set @par_t41=@par_t41 + 1

					set @par_t61=@par_t61 + 1
					end
				--LUNCH
				if @m_Lunch= 1 
					begin
					set @par_f12=@par_f12 + 1
					set @par_f52=@par_f52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 2
					begin
					set @par_f22=@par_f22 + 1
					set @par_f52=@par_f52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 3
					begin
					set @par_f32=@par_f32 + 1
					set @par_f52=@par_f52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 4
					begin
					set @par_f42=@par_f42 + 1
					set @par_f52=@par_f52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end

				--DINNER
				if @m_Dinner= 1 
					begin
					set @par_f13=@par_f13 + 1
					set @par_f53=@par_f53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 2
					begin
					set @par_f23=@par_f23 + 1
					set @par_f53=@par_f53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 3
					begin
					set @par_f33=@par_f33 + 1
					set @par_f53=@par_f53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 4
					begin
					set @par_f43=@par_f43 + 1
					set @par_f53=@par_f53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end

					
				--SNACK
				if @m_Snack= 1 
					begin
					set @par_f14=@par_f14 + 1
					set @par_f54=@par_f54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 2
					begin
					set @par_f24=@par_f24 + 1
					set @par_f54=@par_f54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack= 3
					begin
					set @par_f34=@par_f34 + 1
					set @par_f54=@par_f54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 4
					begin
					set @par_f44=@par_f44 + 1
					set @par_f54=@par_f54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end

			end

			



			if  ( @w_Pod  ='F' and  @m_indJuv='Staff')
			begin
				if ( @m_Breakfast = 1 or @m_Breakfast = 2 or @m_Breakfast = 3 or @m_Breakfast = 4)
					begin
					set @par_f61=@par_f61 + 1
					set @par_t51=@par_t51 + 1
					set @par_t61=@par_t61 + 1
					end
				if ( @m_Lunch = 1 or @m_Lunch = 2 or @m_Lunch = 3 or @m_Lunch = 4)
					begin
					set @par_f62=@par_f62 + 1
					set @par_t52=@par_t52 + 1
					set @par_t62=@par_t62 + 1
					end
				if ( @m_Dinner = 1 or @m_Dinner  = 2 or @m_Dinner  = 3 or @m_Dinner  = 4)
					begin
					set @par_f63=@par_f63 + 1
					set @par_t53=@par_t53+ 1
					set @par_t63=@par_t63 + 1
					end
				if ( @m_Snack = 1 or @m_Snack  = 2 or @m_Snack  = 3 or @m_Snack  = 4)
					begin
					set @par_f64=@par_f64 + 1
					set @par_t54=@par_t54+ 1
					set @par_t64=@par_t64 + 1
					end

			end


	-- Pod F Juvenile and Staff ---------------------------------------------------------------------------  End	

	-- Pod G Juvenile and Staff ---------------------------------------------------------------------------  Beg

			if  ( @w_Pod  ='G' and  @m_indJuv='Juvenile')
			begin
				--BREAKFAST
				if @m_Breakfast = 1 
					begin
					set @par_g11=@par_g11 + 1 -- E-Dinning Hall
					set @par_g51=@par_g51 + 1 -- E -Total Youth
					set @par_t41=@par_t41 + 1   -- Total - Grand Total Youth
					set @par_t61=@par_t61 + 1   -- Total - TOTAL
					end
				if @m_Breakfast = 2
					begin
					set @par_g21=@par_g21 + 1
					set @par_g51=@par_g51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				if @m_Breakfast = 3
					begin
					set @par_g31=@par_g31 + 1
					set @par_g51=@par_g51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				if @m_Breakfast = 4

					begin
					set @par_g41=@par_g41 + 1
					set @par_g51=@par_g51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				--LUNCH
				if @m_Lunch= 1 
					begin
					set @par_g12=@par_g12 + 1
					set @par_g52=@par_g52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 2
					begin
					set @par_g22=@par_g22 + 1
					set @par_g52=@par_g52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 3
					begin
					set @par_g32=@par_g32 + 1
					set @par_g52=@par_g52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 4
					begin
					set @par_g42=@par_g42 + 1
					set @par_g52=@par_g52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end

				--DINNER
				if @m_Dinner= 1 
					begin
					set @par_g13=@par_g13 + 1
					set @par_g53=@par_g53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 2
					begin
					set @par_g23=@par_g23 + 1
					set @par_g53=@par_g53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 3
					begin
					set @par_g33=@par_g33 + 1
					set @par_g53=@par_g53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 4
					begin
					set @par_g43=@par_g43 + 1
					set @par_g53=@par_g53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end

					
				--SNACK
				if @m_Snack= 1 
					begin
					set @par_g14=@par_g14 + 1
					set @par_g54=@par_g54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 2
					begin
					set @par_g24=@par_g24 + 1
					set @par_g54=@par_g54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack= 3
					begin
					set @par_g34=@par_g34 + 1
					set @par_g54=@par_g54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 4
					begin
					set @par_g44=@par_g44 + 1
					set @par_g54=@par_g54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end

			end


			if  ( @w_Pod  ='G' and  @m_indJuv='Staff')
			begin
				if ( @m_Breakfast = 1 or @m_Breakfast = 2 or @m_Breakfast = 3 or @m_Breakfast = 4)
					begin
					set @par_g61=@par_g61 + 1
					set @par_t51=@par_t51 + 1
					set @par_t61=@par_t61 + 1
					end
				if ( @m_Lunch = 1 or @m_Lunch = 2 or @m_Lunch = 3 or @m_Lunch = 4)
					begin
					set @par_g62=@par_g62 + 1
					set @par_t52=@par_t52 + 1
					set @par_t62=@par_t62 + 1
					end
				if ( @m_Dinner = 1 or @m_Dinner  = 2 or @m_Dinner  = 3 or @m_Dinner  = 4)
					begin
					set @par_g63=@par_g63 + 1
					set @par_t53=@par_t53+ 1
					set @par_t63=@par_t63 + 1
					end
				if ( @m_Snack = 1 or @m_Snack  = 2 or @m_Snack  = 3 or @m_Snack  = 4)
					begin
					set @par_g64=@par_g64 + 1
					set @par_t54=@par_t54+ 1
					set @par_t64=@par_t64 + 1
					end

			end


	-- Pod G Juvenile and Staff ---------------------------------------------------------------------------  End	

	-- Pod Control Room  and Staff ---------------------------------------------------------------------------  Beg

			--if (substring(ltrim(rtrim(@m_PodRoom)),1,3) ='Con'    and  @m_indJuv='Staff')
	
			if (cast(@m_PodRoom as varchar) ='Control Room'  and  @m_indJuv='Staff')
			begin

				--print ' return par:  ' + cast(@par_b11 as varchar)
				if ( @m_Breakfast = 1 or @m_Breakfast = 2 or @m_Breakfast = 3 or @m_Breakfast = 4)
					begin
					set @par_t11=@par_t11 + 1
					set @par_t51=@par_t51 + 1
					set @par_t61=@par_t61 + 1
					end
				if ( @m_Lunch = 1 or @m_Lunch = 2 or @m_Lunch = 3 or @m_Lunch = 4)
					begin
					set @par_t12=@par_t12 + 1
					set @par_t52=@par_t52 + 1
					set @par_t62=@par_t62 + 1
					end
				if ( @m_Dinner = 1 or @m_Dinner  = 2 or @m_Dinner  = 3 or @m_Dinner  = 4)
					begin
					set @par_t13=@par_t13 + 1
					set @par_t53=@par_t53+ 1
					set @par_t63=@par_t63 + 1
					end
				if ( @m_Snack = 1 or @m_Snack  = 2 or @m_Snack  = 3 or @m_Snack  = 4)
					begin
					set @par_t14=@par_t14 + 1
					set @par_t54=@par_t54+ 1
					set @par_t64=@par_t64 + 1
					end
			end
	-- Pod Control Roomand Staff ---------------------------------------------------------------------------  End	
	-- Pod Intake Staff  ---------------------------------------------------------------------------  Beg

			if  ( rtrim(ltrim(@m_PodRoom))  ='Intake Staff' and  @m_indJuv='Staff')
			begin

				if ( @m_Breakfast = 1 or @m_Breakfast = 2 or @m_Breakfast = 3 or @m_Breakfast = 4)
					begin
					set @par_t21=@par_t21 + 1
					set @par_t51=@par_t51 + 1
					set @par_t61=@par_t61 + 1
					end
				if ( @m_Lunch = 1 or @m_Lunch = 2 or @m_Lunch = 3 or @m_Lunch = 4)
					begin
					set @par_t22=@par_t22 + 1
					set @par_t52=@par_t52 + 1
					set @par_t62=@par_t62 + 1
					end
				if ( @m_Dinner = 1 or @m_Dinner  = 2 or @m_Dinner  = 3 or @m_Dinner  = 4)
					begin
					set @par_t23=@par_t23 + 1
					set @par_t53=@par_t53+ 1
					set @par_t63=@par_t63 + 1
					end
				if ( @m_Snack = 1 or @m_Snack  = 2 or @m_Snack  = 3 or @m_Snack  = 4)
					begin
					set @par_t24=@par_t24 + 1
					set @par_t54=@par_t54+ 1
					set @par_t64=@par_t64 + 1
					end
			end
		-- Pod Intake  Staff ---------------------------------------------------------------------------  End	
		-- Pod Medical Staff  ---------------------------------------------------------------------------  Beg

			if  ( rtrim(ltrim(@m_PodRoom))  ='Medical' and  @m_indJuv='Staff')
			begin

				if ( @m_Breakfast = 1 or @m_Breakfast = 2 or @m_Breakfast = 3 or @m_Breakfast = 4)
					begin
					set @par_t31=@par_t31 + 1
					set @par_t51=@par_t51 + 1
					set @par_t61=@par_t61 + 1
					end
				if ( @m_Lunch = 1 or @m_Lunch = 2 or @m_Lunch = 3 or @m_Lunch = 4)
					begin
					set @par_t32=@par_t32 + 1
					set @par_t52=@par_t52 + 1
					set @par_t62=@par_t62 + 1
					end
				if ( @m_Dinner = 1 or @m_Dinner  = 2 or @m_Dinner  = 3 or @m_Dinner  = 4)
					begin
					set @par_t33=@par_t33 + 1
					set @par_t53=@par_t53+ 1
					set @par_t63=@par_t63 + 1
					end
				if ( @m_Snack = 1 or @m_Snack  = 2 or @m_Snack  = 3 or @m_Snack  = 4)
					begin
					set @par_t34=@par_t34 + 1
					set @par_t54=@par_t54+ 1
					set @par_t64=@par_t64 + 1
					end
			end
	-- Pod Medical Staff ---------------------------------------------------------------------------  End	
	
	--		GoTo GetNext
		GetNext:
			FETCH NEXT FROM MealsJuvenileAndStaffReport_cursor
			INTO
				@m_MealDate  ,
				@m_PodRoom ,
				@m_Breakfast,
				@m_Lunch ,
				@m_Dinner,
				@m_Snack ,
				@m_indJuv
	END ------------------------------------------------- End While loop
	

END 


Close MealsJuvenileAndStaffReport_cursor
Deallocate MealsJuvenileAndStaffReport_cursor






GO


USE [JusticeServices]
GO

/****** Object:  StoredProcedure [dbo].[sp_BreakfastCombo]    Script Date: 05/18/2016 12:40:11 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO



/****** Object:  Stored Procedure dbo.sp_BreakfastCombo    Script Date: 12/7/2005 1:14:52 PM ******/
/**
This procedure will use to select all item from Meals Identity table tblMealsIdentity and
fill combo box on Staff and Juvenile Meal pages

**/

CREATE PROCEDURE [dbo].[sp_BreakfastCombo]
 AS

BEGIN


SELECT	ItemId, item
FROM	tblMealsIdentity
Order By ItemId


END
GO

USE [JusticeServices]
GO

/****** Object:  StoredProcedure [dbo].[spInsert_CreateNewMeal]    Script Date: 05/18/2016 12:41:20 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


/****** Object:  Stored Procedure dbo.spInsert_CreateNewMeal    Script Date: 12/7/2005 1:14:53 PM ******/
/*
Name:  usp_Insert_CreateNewMeal
Description:  Add new records to the tblMeals for new Date 
; there are not recocrds for selected date.
Author:  J.Skoro
Modification Date : 
Modification Description:      
Created procedure            05/20/2005    
*/
 
CREATE PROCEDURE [dbo].[spInsert_CreateNewMeal]

@m_MealDate datetime,
@m_CreatedBy varchar(50),
@m_CreatedDate datetime


AS

Insert  dbo.tblDetMeals (RefServID,JuvenileID,MealDate,Breakfast,Lunch,Dinner,Snack,Comment,CreatedBy,CreatedDate,UpdtBy,UpdtDate)
select dbo.vwDetentions.RefServID, dbo.vwDetentions.JuvenileID ,@m_MealDate,0,0,0,0,'',@m_CreatedBy,@m_CreatedDate,'',Null
from  dbo.vwDetentions
where ( ( @m_MealDate  between dbo.vwDetentions.BeginDt and dbo.vwDetentions.EndDt ) or (BeginDt <= @m_MealDate and EndDt is Null  )  or (  BeginDt <= @m_MealDate and EndDt = ' 1/ 1/1900 ')  )






GO


USE [JusticeServices]
GO

/****** Object:  StoredProcedure [dbo].[spSelectMealforALL]    Script Date: 05/18/2016 12:51:14 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


/****** Object:  Stored Procedure dbo.spSelectMealforALL    Script Date: 12/7/2005 1:14:53 PM ******/
CREATE PROCEDURE [dbo].[spSelectMealforALL]
@m_MealDate datetime  
AS
BEGIN


SELECT	dbo.vwDetentions.RefServID, dbo.vwDetentions.PodRoom,  dbo.vwDetentions.BeginDt,  dbo.vwDetentions.EndDt,   dbo.vwDetentions.JuvenileID, dbo.vwDetentions.LName, dbo.vwDetentions.FName, substring(dbo.vwDetentions.MName,1,1) as MName, 
		dbo.vwDetentions.SufName, dbo.vwDetentions.Gender, dbo.tblDetMeals.RefServID,dbo.tblDetMeals.JuvenileID, dbo.tblDetMeals.DetMealsID, dbo.tblDetMeals.MealDate,
		dbo.tblDetMeals.Breakfast,dbo.tblDetMeals.Lunch,dbo.tblDetMeals.Dinner,dbo.tblDetMeals.Snack,dbo.tblDetMeals.Comment
FROM	dbo.vwDetentions LEFT OUTER JOIN dbo.tblDetMeals  ON dbo.vwDetentions.JuvenileID = dbo.tblDetMeals.JuvenileID
WHERE	(dbo.vwDetentions.RefServID = dbo.tblDetMeals.RefServID ) 
		and (dbo.tblDetMeals.MealDate =@m_MealDate ) and
		 ( ( @m_MealDate  between dbo.vwDetentions.BeginDt and dbo.vwDetentions.EndDt ) or (BeginDt <= @m_MealDate and EndDt is Null  )  or (  BeginDt <= @m_MealDate and EndDt = ' 1/ 1/1900 ')  )
ORDER by dbo.vwDetentions.PodRoom,dbo.vwDetentions.LName,dbo.vwDetentions.FName


END
GO


USE [JusticeServices]
GO

/****** Object:  StoredProcedure [dbo].[spSelectMealforALLCombo]    Script Date: 05/18/2016 12:52:30 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO


/****** Object:  Stored Procedure dbo.spSelectMealforALLCombo    Script Date: 12/7/2005 1:14:54 PM ******/
CREATE PROCEDURE [dbo].[spSelectMealforALLCombo]
@m_MealDate datetime  
AS
BEGIN


SELECT	dbo.vwDetentions.RefServID, dbo.vwDetentions.PodRoom,  dbo.vwDetentions.BeginDt,  dbo.vwDetentions.EndDt,   dbo.vwDetentions.JuvenileID, dbo.vwDetentions.LName,
	    dbo.vwDetentions.FName, substring(dbo.vwDetentions.MName,1,1) as MName, 
		dbo.vwDetentions.SufName, dbo.vwDetentions.Gender, dbo.tblDetMeals.RefServID,dbo.tblDetMeals.JuvenileID, dbo.tblDetMeals.DetMealsID, dbo.tblDetMeals.MealDate,
		dbo.tblDetMeals.Breakfast,dbo.tblDetMeals.Lunch,dbo.tblDetMeals.Dinner,dbo.tblDetMeals.Snack,dbo.tblDetMeals.Comment
FROM	dbo.vwDetentions LEFT OUTER JOIN dbo.tblDetMeals  ON dbo.vwDetentions.JuvenileID = dbo.tblDetMeals.JuvenileID
WHERE	(dbo.vwDetentions.RefServID = dbo.tblDetMeals.RefServID ) 
		and (dbo.tblDetMeals.MealDate =@m_MealDate ) and
		 ( ( @m_MealDate  between dbo.vwDetentions.BeginDt and dbo.vwDetentions.EndDt ) or (BeginDt <= @m_MealDate and EndDt is Null  )  or (  BeginDt <= @m_MealDate and EndDt = ' 1/ 1/1900 ')  )
ORDER by dbo.vwDetentions.PodRoom,dbo.vwDetentions.LName,dbo.vwDetentions.FName


END

GO


USE [JusticeServices]
GO

/****** Object:  StoredProcedure [dbo].[spChekforNewJuvenileMeal]    Script Date: 05/18/2016 12:53:33 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


/****** Object:  Stored Procedure dbo.spChekforNewJuvenileMeal    Script Date: 12/7/2005 1:14:52 PM ******/
CREATE PROCEDURE [dbo].[spChekforNewJuvenileMeal]
@m_MealDate datetime  
AS
BEGIN

select dbo.vwDetentions.RefServID,dbo.vwDetentions.JuvenileID
From dbo.vwDetentions
WHERE ( ( @m_MealDate  between dbo.vwDetentions.BeginDt and dbo.vwDetentions.EndDt ) or (BeginDt <= @m_MealDate and EndDt is Null  )  
		or (  BeginDt <= @m_MealDate and EndDt = ' 1/ 1/1900 ')  ) 
		and JuvenileID Not in (select juvenileid from tblDetMeals  where MealDate=@m_MealDate)



END

GO


USE [JusticeServices]
GO

/****** Object:  StoredProcedure [dbo].[spInsertNewJuvenileToMeal]    Script Date: 05/18/2016 12:54:40 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


/****** Object:  Stored Procedure dbo.spInsertNewJuvenileToMeal    Script Date: 12/7/2005 1:14:53 PM ******/
CREATE PROCEDURE [dbo].[spInsertNewJuvenileToMeal]

@m_RefServID int,
@m_JuvenileID int,
@m_MealDate datetime,
@m_Breakfast int,
@m_Lunch int,
@m_Dinner int,
@m_Snack int,
@m_Comment varchar(100),
@m_CreatedBy varchar(50),
@m_CreatedDate datetime


AS
BEGIN

Insert  into  dbo.tblDetMeals (RefServID,JuvenileID,MealDate, Comment,CreatedBy,CreatedDate,UpdtBy,UpdtDate, StaffID,StafPodRoom,Breakfast,Lunch,Dinner,Snack)
Values(@m_RefServID,  @m_JuvenileID, @m_MealDate,@m_Comment ,@m_CreatedBy, @m_CreatedDate,Null,Null,Null,Null, @m_Breakfast, @m_Lunch, @m_Dinner,  @m_Snack)

END

GO


USE [JusticeServices]
GO

/****** Object:  StoredProcedure [dbo].[spInsert_CreateNewMeal]    Script Date: 05/18/2016 12:55:37 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


/****** Object:  Stored Procedure dbo.spInsert_CreateNewMeal    Script Date: 12/7/2005 1:14:53 PM ******/
/*
Name:  usp_Insert_CreateNewMeal
Description:  Add new records to the tblMeals for new Date 
; there are not recocrds for selected date.
Author:  J.Skoro
Modification Date : 
Modification Description:      
Created procedure            05/20/2005    
*/
 
CREATE PROCEDURE [dbo].[spInsert_CreateNewMeal]

@m_MealDate datetime,
@m_CreatedBy varchar(50),
@m_CreatedDate datetime


AS

Insert  dbo.tblDetMeals (RefServID,JuvenileID,MealDate,Breakfast,Lunch,Dinner,Snack,Comment,CreatedBy,CreatedDate,UpdtBy,UpdtDate)
select dbo.vwDetentions.RefServID, dbo.vwDetentions.JuvenileID ,@m_MealDate,0,0,0,0,'',@m_CreatedBy,@m_CreatedDate,'',Null
from  dbo.vwDetentions
where ( ( @m_MealDate  between dbo.vwDetentions.BeginDt and dbo.vwDetentions.EndDt ) or (BeginDt <= @m_MealDate and EndDt is Null  )  or (  BeginDt <= @m_MealDate and EndDt = ' 1/ 1/1900 ')  )

GO


USE [JusticeServices]
GO

/****** Object:  StoredProcedure [dbo].[spUpdateMealforALL]    Script Date: 05/18/2016 12:56:17 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


/****** Object:  Stored Procedure dbo.spUpdateMealforALL    Script Date: 12/7/2005 1:14:54 PM ******/
CREATE PROCEDURE [dbo].[spUpdateMealforALL]
@m_DetMealsID int,
@m_Breakfast int,
@m_Lunch int,
@m_Dinner int,
@m_Snack int,
@m_Comment varchar(100),
@m_UpdtBy varchar(50),
@m_UpdtDate datetime

AS
BEGIN

UPDATE tblDetMeals 
SET Breakfast=@m_Breakfast, Lunch=@m_Lunch, Dinner=@m_Dinner, Snack=@m_Snack, Comment=@m_Comment,UpdtBy=@m_UpdtBy, UpdtDate=@m_UpdtDate
WHERE DetMealsID=@m_DetMealsID


END

GO


USE [JusticeServices]
GO

/****** Object:  View [dbo].[vwStaffNameforMeal]    Script Date: 05/18/2016 13:19:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/****** Object:  View dbo.vwStaffNameforMeal    Script Date: 12/6/2005 2:46:53 PM ******/
CREATE VIEW [dbo].[vwStaffNameforMeal]
AS
SELECT    ID as StaffID, Department as Agency, LastName as LName, FirstName as FName, RTRIM(LastName) + ', ' + RTRIM(FirstName) AS FullName
FROM      dbo.Staff
WHERE     (Department = 'DIT') OR
          (Department = 'RDJJS')



GO


USE [JusticeServices]
GO

/****** Object:  StoredProcedure [dbo].[spselectStaffIDFullNameforCombo]    Script Date: 05/18/2016 13:35:40 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


/****** Object:  Stored Procedure dbo.spselectStaffIDFullNameforCombo    Script Date: 12/7/2005 1:14:54 PM ******/
/**
this procedure will use to create field FullName, which involve both last and first name 
using view vwStaffNameforMeal
**/



CREATE Procedure [dbo].[spselectStaffIDFullNameforCombo]
AS

BEGIN
SELECT     StaffID,  FullName
FROM         dbo.vwStaffNameforMeal

END

GO


GRANT EXEC ON [spselectStaffIDFullNameforCombo] TO JusticeServicesAppID
GO
USE [JusticeServices]
GO

/****** Object:  StoredProcedure [dbo].[spDeleteStaffMealRecord]    Script Date: 05/18/2016 13:38:40 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


/****** Object:  Stored Procedure dbo.spDeleteStaffMealRecord    Script Date: 12/7/2005 1:14:53 PM ******/
/**
this procedure delete a record from Detention Meal Table for selected Staff

**/



CREATE PROCEDURE [dbo].[spDeleteStaffMealRecord]
@m_DefMealsID int
AS
BEGIN


DELETE
FROM	tblDetMeals
WHERE	tblDetMeals.DetMealsID = @m_DefMealsID 


END






GO


USE [JusticeServices]
GO

/****** Object:  StoredProcedure [dbo].[spCheckDuplicateStaffMeal]    Script Date: 05/18/2016 13:55:02 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO



/****** Object:  Stored Procedure dbo.spCheckDuplicateStaffMeal    Script Date: 12/7/2005 1:14:52 PM ******/
/**
This procedure  will check if Staff alredy has meal (can not be added twice)

**/



CREATE PROCEDURE [dbo].[spCheckDuplicateStaffMeal]

@m_StaffID int,
@m_MealDate datetime

AS
SELECT DetMealsID,StaffID,MealDate
FROM  tblDetMeals
WHERE (StaffID=@m_StaffID and MealDate=@m_MealDate)







GO


USE [JusticeServices]
GO

/****** Object:  StoredProcedure [dbo].[spInsertNewStaffMealRecord]    Script Date: 05/18/2016 13:55:52 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


/****** Object:  Stored Procedure dbo.spInsertNewStaffMealRecord    Script Date: 12/7/2005 1:14:53 PM ******/
CREATE PROCEDURE [dbo].[spInsertNewStaffMealRecord]

--null
--null
@m_MealDate datetime,
--null
@m_CreatedBy varchar(50),
@m_CreatedDate datetime,
--null
--null
@m_StaffID	 int,
@m_StafPodRoom varchar(12),
@m_BreakfastCombo int,
@m_LunchCombo int,
@m_DinnerCombo int,
@m_SnackCombo int



AS
BEGIN

Insert  into  dbo.tblDetMeals (RefServID,JuvenileID,MealDate,Comment,CreatedBy,CreatedDate,UpdtBy,UpdtDate,
		StaffId,StafPodRoom,Breakfast,Lunch,Dinner,Snack)
Values(Null,  Null, @m_MealDate,  Null , @m_CreatedBy, @m_CreatedDate,Null,Null,
	@m_StaffID,@m_StafPodRoom,@m_BreakfastCombo,@m_LunchCombo,@m_DinnerCombo,@m_SnackCombo)

END






GO


USE [JusticeServices]
GO

/****** Object:  StoredProcedure [dbo].[spMentalUpdt]    Script Date: 05/18/2016 13:56:29 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO



/****** Object:  Stored Procedure dbo.spMentalUpdt    Script Date: 12/7/2005 1:14:53 PM ******/
CREATE PROCEDURE [dbo].[spMentalUpdt] 
	@inMHKey int,
	@inAnswer char(5),
	@inComments char(200),
	@inUserID char(30),
	@inDt datetime
	
AS

--=============================================================================
--    Called from Mental.aspx.  Update tblMHInterview with juvenile's answers to questions.
--==============================================================================

--=================================================== convert text answer to int
	BEGIN	

			
		DECLARE @iAnswer int
	
		IF @inAnswer = "true"
			BEGIN
				SET @iAnswer = 1
			END
		ELSE
			BEGIN
				SET @iAnswer = 0
			END

--=================================================== Is this a 2st time update or not? 
			
		DECLARE @chk	 char(30)
		DECLARE Created	 Cursor
		FOR 
			SELECT 	CreatedBy
			FROM		tblMHInterview
			WHERE	(MHInterviewID = @inMHKey)

		OPEN Created
		FETCH NEXT FROM  Created
					INTO  @chk
		CLOSE Created
		DEALLOCATE Created

--=================================================== Update CREATED info if doesn't exist
		IF @chk is null
			BEGIN
				UPDATE 	tblMHInterview
				SET		Answer = @iAnswer,
						Comments = @inComments,
						CreatedBy = @inUserID,
						CreatedDt = @inDt
				WHERE 	MHInterviewID = @inMHKey
			END
	
--=================================================== Update UPDT info otherwise
		ELSE
			BEGIN
				UPDATE 	tblMHInterview
				SET		Answer = @iAnswer,
						Comments = @inComments,
						UpdtBy = @inUserID,
						UpdtDt = @inDt
				WHERE 	MHInterviewID = @inMHKey
			END


	END

RETURN


GO


USE [JusticeServices]
GO

/****** Object:  StoredProcedure [dbo].[spMHInitialAdd]    Script Date: 05/18/2016 15:53:57 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO



/****** Object:  Stored Procedure dbo.spMHInitialAdd    Script Date: 12/7/2005 1:14:53 PM ******/
CREATE PROCEDURE [dbo].[spMHInitialAdd] 
	@inID int
AS

--=============================================================================
--    Called from Mental.aspx.  If new referral, this procedure generates 1 answer (tblMHInterview) 
--    record for each [current] question on tblMHQuestions.  Then Mental.aspx will update those
--    records as intake interviews the juvenile.
--==============================================================================

--=================================================== Check to see if records for answers for this juvenile exist already
	BEGIN	
		
		DECLARE @Acnt int

		DECLARE Answers	 Cursor
		FOR 
			SELECT 	COUNT(*)
			FROM		tblMHInterview
			WHERE	(RefServID = 	@inID)

		OPEN Answers
			

		FETCH NEXT FROM  Answers
					INTO  @Acnt


		CLOSE Answers
		DEALLOCATE Answers

		--PRINT @Acnt

		IF @Acnt > 0
			BEGIN	
				GOTO Finish
			END


--====================================================  Add default records for answers if none exist
--                                                                                                         (active is 0 if active; 1 if inactive)
--                                                                                                         (badly named column - think of active flag as 'inactive' flag)
	
		DECLARE	@ID int
		
		DECLARE Questions Cursor
	
		FOR
			SELECT    	MHQuestID  
			FROM 		tblMHQuestions q          
			WHERE       	active = 0 
		             ORDER BY   	q.MHQuestID
	          
	             OPEN Questions

	
--====================================================  insert all interview questions active for the service date for this juvenilte
		FETCH NEXT From Questions
			INTO @ID
	
		WHILE @@FETCH_STATUS = 0
			BEGIN
	
				INSERT INTO tblMHInterview 	(RefServid,	MHQuestionId,		Answer,		Comments) 
						VALUES   	(@inID,		@ID,			null,		null)
				FETCH NEXT FROM Questions
					INTO @ID
	
		            END

		CLOSE Questions
		DEALLOCATE Questions

FINISH:

RETURN
END


GO


USE [JusticeServices]
GO

/****** Object:  StoredProcedure [dbo].[spMonthlyMealsReport]    Script Date: 05/18/2016 15:54:51 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


/****** Object:  Stored Procedure dbo.spMonthlyMealsReport    Script Date: 12/7/2005 1:14:53 PM ******/
CREATE PROCEDURE [dbo].[spMonthlyMealsReport]
(
--@m_MealDate_par datetime ,
@m_MealMonth_par int,
@m_MealYear_par int,
--
-- parameters for B-Breakfast
@par_b11  int  output,
@par_b21  int  output,
@par_b31  int  output,
@par_b41  int  output,
@par_b51  int  output,
@par_b61  int  output,
-- parameters for B-Lunch
@par_b12  int  output,
@par_b22  int  output,
@par_b32 int  output,
@par_b42  int  output,
@par_b52  int  output,
@par_b62  int  output,
-- parameters for B-Dinner
@par_b13 int  output,
@par_b23 int  output,
@par_b33 int  output,
@par_b43 int  output,
@par_b53  int  output,
@par_b63  int  output,
-- parameters for B-Snack
@par_b14 int  output,
@par_b24 int  output,
@par_b34 int  output,
@par_b44 int  output,
@par_b54  int  output,
@par_b64  int  output,
--
-- parameters for C-Breakfast
@par_c11  int  output,
@par_c21  int  output,
@par_c31  int  output,
@par_c41  int  output,
@par_c51  int  output,
@par_c61  int  output,
-- parameters for C- Lunch
@par_c12  int  output,
@par_c22  int  output,
@par_c32 int  output,
@par_c42 int  output,
@par_c52 int  output,
@par_c62  int  output,
-- parameters for C- Dinner
@par_c13  int  output,
@par_c23  int  output,
@par_c33 int  output,
@par_c43 int  output,
@par_c53 int  output,
@par_c63  int  output,
-- parameters for C- Snack
@par_c14 int  output,
@par_c24  int  output,
@par_c34 int  output,
@par_c44 int  output,
@par_c54 int  output,
@par_c64  int  output,
--
-- parameters for D-Breakfast
@par_d11  int  output,
@par_d21  int  output,
@par_d31  int  output,
@par_d41  int  output,
@par_d51  int  output,
@par_d61  int  output,
-- parameters for D-Lunch
@par_d12  int  output,
@par_d22  int  output,
@par_d32 int  output,
@par_d42  int  output,
@par_d52  int  output,
@par_d62  int  output,
-- parameters for D- Dinner
@par_d13  int  output,
@par_d23  int  output,
@par_d33 int  output,
@par_d43 int  output,
@par_d53 int  output,
@par_d63  int  output,
-- parameters for D-Snack
@par_d14 int  output,
@par_d24 int  output,
@par_d34 int  output,
@par_d44 int  output,
@par_d54  int  output,
@par_d64  int  output,
--
-- parameters for E-Breakfast
@par_e11  int  output,
@par_e21  int  output,
@par_e31  int  output,
@par_e41  int  output,
@par_e51  int  output,
@par_e61  int  output,
-- parameters for E-Lunch
@par_e12  int  output,
@par_e22 int  output,
@par_e32  int  output,
@par_e42  int  output,
@par_e52  int  output,
@par_e62  int  output,
-- parameters for E-Dinner
@par_e13  int  output,
@par_e23 int  output,
@par_e33  int  output,
@par_e43 int  output,
@par_e53 int  output,
@par_e63 int  output,
-- parameters for E-Snack
@par_e14 int  output,
@par_e24 int  output,
@par_e34  int  output,
@par_e44 int  output,
@par_e54 int  output,
@par_e64 int  output,
--
-- parameters for F-Breakfast
@par_f11  int  output,
@par_f21  int  output,
@par_f31  int  output,
@par_f41  int  output,
@par_f51  int  output,
@par_f61  int  output,
-- parameters for F-Lunch
@par_f12  int  output,
@par_f22  int  output,
@par_f32  int  output,
@par_f42  int  output,
@par_f52  int  output,
@par_f62 int  output,
-- parameters for F-Dinner
@par_f13 int  output,
@par_f23 int  output,
@par_f33  int  output,
@par_f43  int  output,
@par_f53  int  output,
@par_f63  int  output,
-- parameters for F-Snack
@par_f14  int  output,
@par_f24  int  output,
@par_f34 int  output,
@par_f44 int  output,
@par_f54 int  output,
@par_f64  int  output,
--
-- parameters for G-Breakfast
@par_g11  int  output,
@par_g21  int  output,
@par_g31  int  output,
@par_g41  int  output,
@par_g51  int  output,
@par_g61  int  output,
-- parameters for G-Lunch
@par_g12  int  output,
@par_g22  int  output,
@par_g32  int  output,
@par_g42  int  output,
@par_g52  int  output,
@par_g62 int  output,
-- parameters for G -Dinner
@par_g13 int  output,
@par_g23 int  output,
@par_g33  int  output,
@par_g43  int  output,
@par_g53  int  output,
@par_g63  int  output,
-- parameters for G-Snack
@par_g14  int  output,
@par_g24  int  output,
@par_g34 int  output,
@par_g44 int  output,
@par_g54 int  output,
@par_g64  int  output,
--

-- parameters for Total-Breakfast
@par_t11 int  output,
@par_t21 int  output,
@par_t31 int  output,
@par_t41 int  output,
@par_t51 int  output,
@par_t61 int  output,

-- parameters for Total-Lunch
@par_t12 int  output,
@par_t22 int  output,
@par_t32 int  output,
@par_t42 int  output,
@par_t52 int  output,
@par_t62 int  output,

-- parameters for Total-Dinner
@par_t13 int  output,
@par_t23 int  output,
@par_t33 int  output,
@par_t43 int  output,
@par_t53 int  output,
@par_t63 int  output,

-- parameters for Total-Snack
@par_t14 int  output,
@par_t24 int  output,
@par_t34 int  output,
@par_t44 int  output,
@par_t54 int  output,
@par_t64 int  output

)
AS
declare 
@m_MealDate datetime ,
@m_PodRoom varchar(20),
@m_Breakfast int,
@m_Lunch int,
@m_Dinner int,
@m_Snack int,
@m_indJuv varchar(20),
--
@w_Pod varchar(1)
--@w_Staff_Pod varchar(7)

CREATE TABLE  #tmpMeals
 (
	numrec int identity not null,
	MealDate datetime ,
	PodRoom varchar(20),
	Breakfast int,
	Lunch int,
	Dinner int,
	Snack int,
 	indJuv VARCHAR(8)
)
--@m_MealMonth_par

INSERT INTO #tmpMeals
	SELECT MealDate, StafPodRoom as PodRoom,Breakfast, Lunch, Dinner, Snack, indJuv='Staff'
	FROM  tblDetMeals
--WHERE (MealDate=@m_MealDate_par) and (StaffId IS NOT NULL)
	WHERE (Month(MealDate)=@m_MealMonth_par) and Year(MealDate ) = @m_MealYear_par and (StaffId IS NOT NULL)
	UNION
	SELECT dbo.tblDetMeals.MealDate, dbo.tblDetentionSupp.PodRoom,dbo.tblDetMeals.Breakfast,dbo.tblDetMeals.Lunch,dbo.tblDetMeals.Dinner,dbo.tblDetMeals.Snack,indJuv='Juvenile'
FROM dbo.tblDetMeals INNER JOIN dbo.tblDetentionSupp ON dbo.tblDetMeals.RefServID=dbo.tblDetentionSupp.RefServID
--WHERE (dbo.tblDetMeals.MealDate=@m_MealDate_par)
WHERE (Month(dbo.tblDetMeals.MealDate)=@m_MealMonth_par) and Year(MealDate ) =@m_MealYear_par
ORDER BY indJuv,PodRoom
 Select * from #tmpMeals

-- Create a Cursor 

BEGIN    


DECLARE MealsJuvenileAndStaffReport_cursor
	CURSOR FOR
	SELECT MealDate, PodRoom, Breakfast, Lunch, Dinner, Snack, indJuv
	FROM #tmpMeals
	ORDER BY indJuv,PodRoom
	
-- Open Cursor
	OPEN MealsJuvenileAndStaffReport_cursor
	FETCH NEXT FROM MealsJuvenileAndStaffReport_cursor
	INTO
		@m_MealDate  ,
		@m_PodRoom ,
		@m_Breakfast,
		@m_Lunch ,
		@m_Dinner,
		@m_Snack ,
		@m_indJuv
-- set parameters for B- Breakfast
	set @par_b11 = 0
	set @par_b21 = 0
	set @par_b31 = 0
	set @par_b41 = 0
	set @par_b51 = 0
	set @par_b61 = 0
--set parameters for B- Lunch
	set @par_b12 = 0
	set @par_b22 = 0
	set @par_b32 = 0
	set @par_b42 = 0
	set @par_b52 = 0
	set @par_b62 = 0
--set parameters for B- Dinner
	set @par_b13= 0
	set @par_b23 = 0
	set @par_b33 = 0
	set @par_b43 = 0
	set @par_b53 = 0
	set @par_b63 = 0
--set parameters for B-Snack
	set @par_b14= 0
	set @par_b24 = 0
	set @par_b34 = 0
	set @par_b44= 0
	set @par_b54 = 0
	set @par_b64 = 0


-- set parameters for C- Breakfast
	set @par_c11 = 0
	set @par_c21 = 0
	set @par_c31 = 0
	set @par_c41 = 0
	set @par_c51 = 0
	set @par_c61 = 0
-- set parameters for C- Lunch
	set @par_c12= 0
	set @par_c22 = 0
	set @par_c32 = 0
	set @par_c42 = 0
	set @par_c52 = 0
	set @par_c62 = 0
-- set parameters for C-Dinner
	set @par_c13= 0
	set @par_c23 = 0
	set @par_c33 = 0
	set @par_c43 = 0
	set @par_c53 = 0
	set @par_c63 = 0
-- set parameters for C-Snack
	set @par_c14= 0
	set @par_c24 = 0
	set @par_c34 = 0
	set @par_c44 = 0
	set @par_c54 = 0
	set @par_c64 = 0

-- set parameters for D- Breakfast
	set @par_d11 = 0
	set @par_d21 = 0
	set @par_d31 = 0
	set @par_d41 = 0
	set @par_d51 = 0
	set @par_d61 = 0
--set parameters for B- Lunch
	set @par_d12 = 0
	set @par_d22 = 0
	set @par_d32 = 0
	set @par_d42 = 0
	set @par_d52 = 0
	set @par_d62 = 0
-- set parameters for D-Dinner
	set @par_d13 = 0
	set @par_d23 = 0
	set @par_d33 = 0
	set @par_d43 = 0
	set @par_d53 = 0

	set @par_d63 = 0
-- set parameters for D-Snack
	set @par_d14 = 0
	set @par_d24 = 0
	set @par_d34 = 0

	set @par_d44 = 0
	set @par_d54 = 0
	set @par_d64 = 0
--
-- set parameters for E- Breakfast
	set @par_e11 = 0
	set @par_e21 = 0
	set @par_e31 = 0
	set @par_e41 = 0
	set @par_e51 = 0
	set @par_e61 = 0
-- set parameters for E- Lunch
	set @par_e12 = 0
	set @par_e22 = 0
	set @par_e32 = 0
	set @par_e42 = 0
	set @par_e52 = 0
	set @par_e62 = 0
-- set parameters for E- Dinner
	set @par_e13= 0
	set @par_e23 = 0
	set @par_e33 = 0
	set @par_e43 = 0
	set @par_e53 = 0
	set @par_e63 = 0
-- set parameters for E- Snack
	set @par_e14= 0
	set @par_e24 = 0
	set @par_e34 = 0
	set @par_e44 = 0
	set @par_e54 = 0
	set @par_e64 = 0
--
-- set parameters for F- Breakfast
	set @par_f11 = 0
	set @par_f21 = 0
	set @par_f31 = 0
	set @par_f41 = 0
	set @par_f51 = 0
	set @par_f61 = 0
--set parameters for F-Lunch
	set @par_f12 = 0
	set @par_f22 = 0
	set @par_f32 = 0
	set @par_f42 = 0
	set @par_f52 = 0
	set @par_f62 = 0
--set parameters for F- Dinner
	set @par_f13 = 0
	set @par_f23 = 0
	set @par_f33 = 0
	set @par_f43 = 0
	set @par_f53 = 0
	set @par_f63 = 0
--set parameters for F- Snack
	set @par_f14 = 0
	set @par_f24 = 0
	set @par_f34 = 0
	set @par_f44 = 0
	set @par_f54 = 0
	set @par_f64 = 0

--
-- set parameters for G- Breakfast
	set @par_g11 = 0
	set @par_g21 = 0
	set @par_g31 = 0
	set @par_g41 = 0
	set @par_g51 = 0
	set @par_g61 = 0
--set parameters for G-Lunch
	set @par_g12 = 0
	set @par_g22 = 0
	set @par_g32 = 0
	set @par_g42 = 0
	set @par_g52 = 0
	set @par_g62 = 0
--set parameters for G- Dinner
	set @par_g13 = 0
	set @par_g23 = 0
	set @par_g33 = 0
	set @par_g43 = 0
	set @par_g53 = 0
	set @par_g63 = 0
--set parameters for G- Snack
	set @par_g14 = 0
	set @par_g24 = 0
	set @par_g34 = 0
	set @par_g44 = 0
	set @par_g54 = 0
	set @par_g64 = 0

-- set parameters for Total - Breakfast
	set @par_t11= 0
	set @par_t21= 0
	set @par_t31 = 0
	set @par_t41= 0
	set @par_t51 = 0
	set @par_t61 = 0

-- set parameters for Total -Lunch
	set @par_t12 = 0
	set @par_t22 = 0
	set @par_t32 = 0
	set @par_t42 = 0
	set @par_t52 = 0
	set @par_t62 = 0

-- set parameters for Total -Dinner
	set @par_t13 = 0
	set @par_t23 = 0
	set @par_t33 = 0
	set @par_t43 = 0
	set @par_t53 = 0
	set @par_t63 = 0

-- set parameters for Total -Snack
	set @par_t14 = 0
	set @par_t24 = 0
	set @par_t34 = 0
	set @par_t44 = 0
	set @par_t54 = 0
	set @par_t64 = 0
--
	WHILE @@FETCH_STATUS = 0      -- While loop
	BEGIN

	if (@m_PodRoom is null)
	begin
		GoTo GetNext
	end
	
	
	set @w_Pod = substring(rtrim(ltrim(@m_PodRoom)),1,1) -- check first letter for PodRoom C-1,C12,C1.....will be Pod C
		

	-- Pod B Juvenile and Staff ---------------------------------------------------------------------------  beg
	
	if  ( @w_Pod  ='B' and  @m_indJuv='Juvenile')
			begin
				--BREAKFAST
				if @m_Breakfast = 1 
					begin
					set @par_b11=@par_b11 + 1 -- B-Dinning Hall
					set @par_b51=@par_b51 + 1 -- B -Total Youth
					set @par_t41=@par_t41 + 1   -- Total - Grand Total Youth
					set @par_t61=@par_t61 + 1   -- Total - TOTAL
					end
				if @m_Breakfast = 2
					begin
					set @par_b21=@par_b21 + 1
					set @par_b51=@par_b51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1

					end
				if @m_Breakfast = 3
					begin
					set @par_b31=@par_b31 + 1
					set @par_b51=@par_b51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				if @m_Breakfast = 4
					begin
					set @par_b41=@par_b41 + 1
					set @par_b51=@par_b51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end

				--LUNCH
				if @m_Lunch= 1 
					begin
					set @par_b12=@par_b12 + 1
					set @par_b52=@par_b52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1

					end
				if @m_Lunch = 2
					begin
					set @par_b22=@par_b22 + 1
					set @par_b52=@par_b52 + 1
					set @par_t42=@par_t42 + 1

					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 3
					begin
					set @par_b32=@par_b32 + 1
					set @par_b52=@par_b52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 4
					begin
					set @par_b42=@par_b42 + 1
					set @par_b52=@par_b52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end

				--DINNER
				if @m_Dinner= 1 
					begin
					set @par_b13=@par_b13 + 1
					set @par_b53=@par_b53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 2
					begin
					set @par_b23=@par_b23 + 1
					set @par_b53=@par_b53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 3
					begin
					set @par_b33=@par_b33 + 1
					set @par_b53=@par_b53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 4
					begin
					set @par_b43=@par_b43 + 1
					set @par_b53=@par_b53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end

				--SNACK
				if @m_Snack= 1 
					begin
					set @par_b14=@par_b14 + 1
					set @par_b54=@par_b54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 2
					begin
					set @par_b24=@par_b24 + 1
					set @par_b54=@par_b54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack= 3
					begin
					set @par_b34=@par_b34 + 1
					set @par_b54=@par_b54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 4
					begin
					set @par_b44=@par_b44 + 1
					set @par_b54=@par_b54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
			end

		if  ( @w_Pod  ='B' and  @m_indJuv='Staff')
			begin
				if ( @m_Breakfast = 1 or @m_Breakfast = 2 or @m_Breakfast = 3 or @m_Breakfast = 4)
					begin
					set @par_b61=@par_b61 + 1
					set @par_t51=@par_t51 + 1
					set @par_t61=@par_t61 + 1
					end
				if ( @m_Lunch = 1 or @m_Lunch = 2 or @m_Lunch = 3 or @m_Lunch = 4)
					begin
					set @par_b62=@par_b62 + 1
					set @par_t52=@par_t52 + 1
					set @par_t62=@par_t62 + 1
					end
				if ( @m_Dinner = 1 or @m_Dinner  = 2 or @m_Dinner  = 3 or @m_Dinner  = 4)
					begin
					set @par_b63=@par_b63 + 1
					set @par_t53=@par_t53+ 1
					set @par_t63=@par_t63 + 1
					end

				if ( @m_Snack = 1 or @m_Snack  = 2 or @m_Snack  = 3 or @m_Snack  = 4)
					begin
					set @par_b64=@par_b64 + 1
					set @par_t54=@par_t54+ 1
					set @par_t64=@par_t64 + 1
					end
				


			end
				
	-- Pod B Juvenile and Staff ---------------------------------------------------------------------------  End


	-- Pod C Juvenile and Staff ---------------------------------------------------------------------------  Beg

		if  ( @w_Pod  ='C' and  @m_indJuv='Juvenile')
		begin
			--BREAKFAST
				if @m_Breakfast = 1 
					begin
					set @par_c11=@par_c11 + 1 -- C-Dinning Hall
					set @par_c51=@par_c51 + 1 -- C -Total Youth
					set @par_t41=@par_t41 + 1   -- Total - Grand Total Youth
					set @par_t61=@par_t61 + 1   -- Total - TOTAL
					end
				if @m_Breakfast = 2
					begin
					set @par_c21=@par_c21 + 1
					set @par_c51=@par_c51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				if @m_Breakfast = 3
					begin
					set @par_c31=@par_c31 + 1
					set @par_c51=@par_c51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				if @m_Breakfast = 4
					begin
					set @par_c41=@par_c41 + 1
					set @par_c51=@par_c51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end

				--LUNCH
				if @m_Lunch= 1 
					begin
					set @par_c12=@par_c12 + 1
					set @par_c52=@par_c52 + 1

					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 2
					begin

					set @par_c22=@par_c22 + 1
					set @par_c52=@par_c52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 3
					begin
					set @par_c32=@par_c32 + 1
					set @par_c52=@par_c52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 4
					begin
					set @par_c42=@par_c42 + 1
					set @par_c52=@par_c52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				--DINNER
				if @m_Dinner= 1 
					begin
					set @par_c13=@par_c13 + 1
					set @par_c53=@par_c53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 2
					begin
					set @par_c23=@par_c23 + 1
					set @par_c53=@par_c53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 3
					begin
					set @par_c33=@par_c33 + 1
					set @par_c53=@par_c53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 4
					begin
					set @par_c43=@par_c43 + 1
					set @par_c53=@par_c53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				--SNACK
				if @m_Snack= 1 
					begin
					set @par_c14=@par_c14 + 1
					set @par_c54=@par_c54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 2
					begin
					set @par_c24=@par_c24 + 1
					set @par_c54=@par_c54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack= 3
					begin
					set @par_c34=@par_c34 + 1
					set @par_c54=@par_c54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 4
					begin
					set @par_c44=@par_c44 + 1
					set @par_c54=@par_c54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end



		end




		if  ( @w_Pod  ='C' and  @m_indJuv='Staff')
		begin

			if ( @m_Breakfast = 1 or @m_Breakfast = 2 or @m_Breakfast = 3 or @m_Breakfast = 4)
					begin
					set @par_c61=@par_c61 + 1
					set @par_t51=@par_t51 + 1
					set @par_t61=@par_t61 + 1
					end
			if ( @m_Lunch = 1 or @m_Lunch = 2 or @m_Lunch = 3 or @m_Lunch = 4)
					begin
					set @par_c62=@par_c62 + 1
					set @par_t52=@par_t52 + 1
					set @par_t62=@par_t62 + 1
					end
			if ( @m_Dinner = 1 or @m_Dinner  = 2 or @m_Dinner  = 3 or @m_Dinner  = 4)
					begin
					set @par_c63=@par_c63 + 1
					set @par_t53=@par_t53+ 1
					set @par_t63=@par_t63 + 1
					end
			
			if ( @m_Snack = 1 or @m_Snack  = 2 or @m_Snack  = 3 or @m_Snack  = 4)
					begin
					set @par_c64=@par_c64 + 1
					set @par_t54=@par_t54+ 1
					set @par_t64=@par_t64 + 1
					end

			

		end
		
	-- Pod C Juvenile and Staff ---------------------------------------------------------------------------  End


	-- Pod D Juvenile and Staff ---------------------------------------------------------------------------  Beg
			if  ( @w_Pod  ='D' and  @m_indJuv='Juvenile')
			begin
				--BREAKFAST
				if @m_Breakfast = 1 
					begin
					set @par_d11=@par_d11 + 1 -- D-Dinning Hall
					set @par_d51=@par_d51 + 1 -- D -Total Youth
					set @par_t41=@par_t41 + 1   -- Total - Grand Total Youth
					set @par_t61=@par_t61 + 1   -- Total - TOTAL
					end
				if @m_Breakfast = 2
					begin
					set @par_d21=@par_d21 + 1
					set @par_d51=@par_d51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				if @m_Breakfast = 3
					begin
					set @par_d31=@par_d31 + 1
					set @par_d51=@par_d51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				if @m_Breakfast = 4
					begin
					set @par_d41=@par_d41 + 1
					set @par_d51=@par_d51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end

				--LUNCH
				if @m_Lunch= 1 


					begin

					set @par_d12=@par_d12 + 1
					set @par_d52=@par_d52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 2
					begin
					set @par_d22=@par_d22 + 1
					set @par_d52=@par_d52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 3
					begin
					set @par_d32=@par_d32 + 1
					set @par_d52=@par_d52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 4
					begin
					set @par_d42=@par_d42 + 1
					set @par_d52=@par_d52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				--DINNER
				if @m_Dinner= 1 
					begin
					set @par_d13=@par_d13 + 1
					set @par_d53=@par_d53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 2
					begin
					set @par_d23=@par_d23 + 1
					set @par_d53=@par_d53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 3
					begin
					set @par_d33=@par_d33 + 1
					set @par_d53=@par_d53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 4
					begin
					set @par_d43=@par_d43 + 1
					set @par_d53=@par_d53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				--SNACK
				if @m_Snack= 1 
					begin
					set @par_d14=@par_d14 + 1
					set @par_d54=@par_d54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 2
					begin
					set @par_d24=@par_d24 + 1
					set @par_d54=@par_d54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack= 3
					begin
					set @par_d34=@par_d34 + 1
					set @par_d54=@par_d54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 4
					begin
					set @par_d44=@par_d44 + 1
					set @par_d54=@par_d54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end

			end

			if  ( @w_Pod  ='D' and  @m_indJuv='Staff')
			begin
				if ( @m_Breakfast = 1 or @m_Breakfast = 2 or @m_Breakfast = 3 or @m_Breakfast = 4)
					begin
					set @par_d61=@par_d61 + 1
					set @par_t51=@par_t51 + 1
					set @par_t61=@par_t61 + 1
					end
				if ( @m_Lunch = 1 or @m_Lunch = 2 or @m_Lunch = 3 or @m_Lunch = 4)
					begin
					set @par_d62=@par_d62 + 1
					set @par_t52=@par_t52 + 1
					set @par_t62=@par_t62 + 1
					end
				if ( @m_Dinner = 1 or @m_Dinner  = 2 or @m_Dinner  = 3 or @m_Dinner  = 4)
					begin
					set @par_d63=@par_d63 + 1
					set @par_t53=@par_t53+ 1
					set @par_t63=@par_t63 + 1
					end
				if ( @m_Snack = 1 or @m_Snack  = 2 or @m_Snack  = 3 or @m_Snack  = 4)
					begin
					set @par_d64=@par_d64 + 1

					set @par_t54=@par_t54+ 1
					set @par_t64=@par_t64 + 1
					end

			end
	-- Pod D Juvenile and Staff ---------------------------------------------------------------------------  End
	
	-- Pod E Juvenile and Staff ---------------------------------------------------------------------------  Begin

			if  ( @w_Pod  ='E' and  @m_indJuv='Juvenile')
			begin
				--BREAKFAST
				if @m_Breakfast = 1 
					begin
					set @par_e11=@par_e11 + 1 -- E-Dinning Hall
					set @par_e51=@par_e51 + 1 -- E -Total Youth
					set @par_t41=@par_t41 + 1   -- Total - Grand Total Youth
					set @par_t61=@par_t61 + 1   -- Total - TOTAL
					end
				if @m_Breakfast = 2
					begin
					set @par_e21=@par_e21 + 1
					set @par_e51=@par_e51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				if @m_Breakfast = 3
					begin
					set @par_e31=@par_e31 + 1
					set @par_e51=@par_e51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				if @m_Breakfast = 4
					begin

					set @par_e41=@par_e41 + 1
					set @par_e51=@par_e51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				--LUNCH
				if @m_Lunch= 1 
					begin
					set @par_e12=@par_e12 + 1
					set @par_e52=@par_e52 + 1
					set @par_t42=@par_t42 + 1

					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 2
					begin
					set @par_e22=@par_e22 + 1
					set @par_e52=@par_e52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 3
					begin
					set @par_e32=@par_e32 + 1
					set @par_e52=@par_e52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 4
					begin
					set @par_e42=@par_e42 + 1
					set @par_e52=@par_e52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end

				--DINNER
				if @m_Dinner= 1 
					begin
					set @par_e13=@par_e13 + 1
					set @par_e53=@par_e53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 2
					begin
					set @par_e23=@par_e23 + 1
					set @par_e53=@par_e53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 3
					begin
					set @par_e33=@par_e33 + 1
					set @par_e53=@par_e53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 4
					begin
					set @par_e43=@par_e43 + 1
					set @par_e53=@par_e53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end

					
				--SNACK
				if @m_Snack= 1 
					begin
					set @par_e14=@par_e14 + 1
					set @par_e54=@par_e54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 2
					begin
					set @par_e24=@par_e24 + 1
					set @par_e54=@par_e54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack= 3
					begin
					set @par_e34=@par_e34 + 1
					set @par_e54=@par_e54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 4
					begin
					set @par_e44=@par_e44 + 1
					set @par_e54=@par_e54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end

			end


			if  ( @w_Pod  ='E' and  @m_indJuv='Staff')
			begin
				if ( @m_Breakfast = 1 or @m_Breakfast = 2 or @m_Breakfast = 3 or @m_Breakfast = 4)
					begin
					set @par_e61=@par_e61 + 1
					set @par_t51=@par_t51 + 1
					set @par_t61=@par_t61 + 1
					end
				if ( @m_Lunch = 1 or @m_Lunch = 2 or @m_Lunch = 3 or @m_Lunch = 4)
					begin
					set @par_e62=@par_e62 + 1
					set @par_t52=@par_t52 + 1
					set @par_t62=@par_t62 + 1
					end
				if ( @m_Dinner = 1 or @m_Dinner  = 2 or @m_Dinner  = 3 or @m_Dinner  = 4)
					begin
					set @par_e63=@par_e63 + 1
					set @par_t53=@par_t53+ 1
					set @par_t63=@par_t63 + 1
					end
				if ( @m_Snack = 1 or @m_Snack  = 2 or @m_Snack  = 3 or @m_Snack  = 4)
					begin
					set @par_e64=@par_e64 + 1
					set @par_t54=@par_t54+ 1
					set @par_t64=@par_t64 + 1
					end

			end


	-- Pod E Juvenile and Staff ---------------------------------------------------------------------------  End	

	-- Pod F Juvenile and Staff ---------------------------------------------------------------------------  Beg

			if  ( @w_Pod  ='F' and  @m_indJuv='Juvenile')
			begin
				--BREAKFAST
				if @m_Breakfast = 1 
					begin
					set @par_f11=@par_f11 + 1 -- E-Dinning Hall
					set @par_f51=@par_f51 + 1 -- E -Total Youth
					set @par_t41=@par_t41 + 1   -- Total - Grand Total Youth
					set @par_t61=@par_t61 + 1   -- Total - TOTAL
					end
				if @m_Breakfast = 2
					begin
					set @par_f21=@par_f21 + 1
					set @par_f51=@par_f51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				if @m_Breakfast = 3
					begin
					set @par_f31=@par_f31 + 1
					set @par_f51=@par_f51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				if @m_Breakfast = 4
					begin
					set @par_f41=@par_f41 + 1
					set @par_f51=@par_f51 + 1

					set @par_t41=@par_t41 + 1

					set @par_t61=@par_t61 + 1
					end
				--LUNCH
				if @m_Lunch= 1 
					begin
					set @par_f12=@par_f12 + 1
					set @par_f52=@par_f52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 2
					begin
					set @par_f22=@par_f22 + 1
					set @par_f52=@par_f52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 3
					begin
					set @par_f32=@par_f32 + 1
					set @par_f52=@par_f52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 4
					begin
					set @par_f42=@par_f42 + 1
					set @par_f52=@par_f52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end

				--DINNER
				if @m_Dinner= 1 
					begin
					set @par_f13=@par_f13 + 1
					set @par_f53=@par_f53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 2
					begin
					set @par_f23=@par_f23 + 1
					set @par_f53=@par_f53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 3
					begin
					set @par_f33=@par_f33 + 1
					set @par_f53=@par_f53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 4
					begin
					set @par_f43=@par_f43 + 1
					set @par_f53=@par_f53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end

					
				--SNACK
				if @m_Snack= 1 
					begin
					set @par_f14=@par_f14 + 1
					set @par_f54=@par_f54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 2
					begin
					set @par_f24=@par_f24 + 1
					set @par_f54=@par_f54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack= 3
					begin
					set @par_f34=@par_f34 + 1
					set @par_f54=@par_f54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 4
					begin
					set @par_f44=@par_f44 + 1
					set @par_f54=@par_f54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end

			end

			



			if  ( @w_Pod  ='F' and  @m_indJuv='Staff')
			begin
				if ( @m_Breakfast = 1 or @m_Breakfast = 2 or @m_Breakfast = 3 or @m_Breakfast = 4)
					begin
					set @par_f61=@par_f61 + 1
					set @par_t51=@par_t51 + 1
					set @par_t61=@par_t61 + 1
					end
				if ( @m_Lunch = 1 or @m_Lunch = 2 or @m_Lunch = 3 or @m_Lunch = 4)
					begin
					set @par_f62=@par_f62 + 1
					set @par_t52=@par_t52 + 1
					set @par_t62=@par_t62 + 1
					end
				if ( @m_Dinner = 1 or @m_Dinner  = 2 or @m_Dinner  = 3 or @m_Dinner  = 4)
					begin
					set @par_f63=@par_f63 + 1
					set @par_t53=@par_t53+ 1
					set @par_t63=@par_t63 + 1
					end
				if ( @m_Snack = 1 or @m_Snack  = 2 or @m_Snack  = 3 or @m_Snack  = 4)
					begin
					set @par_f64=@par_f64 + 1
					set @par_t54=@par_t54+ 1
					set @par_t64=@par_t64 + 1
					end

			end


	-- Pod F Juvenile and Staff ---------------------------------------------------------------------------  End	

	-- Pod G Juvenile and Staff ---------------------------------------------------------------------------  Beg

			if  ( @w_Pod  ='G' and  @m_indJuv='Juvenile')
			begin
				--BREAKFAST
				if @m_Breakfast = 1 
					begin
					set @par_g11=@par_g11 + 1 -- E-Dinning Hall
					set @par_g51=@par_g51 + 1 -- E -Total Youth
					set @par_t41=@par_t41 + 1   -- Total - Grand Total Youth
					set @par_t61=@par_t61 + 1   -- Total - TOTAL
					end
				if @m_Breakfast = 2
					begin
					set @par_g21=@par_g21 + 1
					set @par_g51=@par_g51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				if @m_Breakfast = 3
					begin
					set @par_g31=@par_g31 + 1
					set @par_g51=@par_g51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end
				if @m_Breakfast = 4

					begin
					set @par_g41=@par_g41 + 1
					set @par_g51=@par_g51 + 1
					set @par_t41=@par_t41 + 1
					set @par_t61=@par_t61 + 1
					end


				--LUNCH
				if @m_Lunch= 1 
					begin
					set @par_g12=@par_g12 + 1
					set @par_g52=@par_g52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 2
					begin
					set @par_g22=@par_g22 + 1
					set @par_g52=@par_g52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 3
					begin
					set @par_g32=@par_g32 + 1
					set @par_g52=@par_g52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end
				if @m_Lunch = 4
					begin
					set @par_g42=@par_g42 + 1
					set @par_g52=@par_g52 + 1
					set @par_t42=@par_t42 + 1
					set @par_t62=@par_t62 + 1
					end

				--DINNER
				if @m_Dinner= 1 
					begin
					set @par_g13=@par_g13 + 1
					set @par_g53=@par_g53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 2
					begin
					set @par_g23=@par_g23 + 1
					set @par_g53=@par_g53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 3
					begin
					set @par_g33=@par_g33 + 1
					set @par_g53=@par_g53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end
				if @m_Dinner = 4
					begin
					set @par_g43=@par_g43 + 1
					set @par_g53=@par_g53 + 1
					set @par_t43=@par_t43 + 1
					set @par_t63=@par_t63 + 1
					end

					
				--SNACK
				if @m_Snack= 1 
					begin
					set @par_g14=@par_g14 + 1
					set @par_g54=@par_g54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 2
					begin
					set @par_g24=@par_g24 + 1
					set @par_g54=@par_g54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack= 3
					begin
					set @par_g34=@par_g34 + 1
					set @par_g54=@par_g54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end
				if @m_Snack = 4
					begin
					set @par_g44=@par_g44 + 1
					set @par_g54=@par_g54 + 1
					set @par_t44=@par_t44 + 1
					set @par_t64=@par_t64 + 1
					end

			end


			if  ( @w_Pod  ='G' and  @m_indJuv='Staff')
			begin
				if ( @m_Breakfast = 1 or @m_Breakfast = 2 or @m_Breakfast = 3 or @m_Breakfast = 4)
					begin
					set @par_g61=@par_g61 + 1
					set @par_t51=@par_t51 + 1
					set @par_t61=@par_t61 + 1
					end
				if ( @m_Lunch = 1 or @m_Lunch = 2 or @m_Lunch = 3 or @m_Lunch = 4)
					begin
					set @par_g62=@par_g62 + 1
					set @par_t52=@par_t52 + 1
					set @par_t62=@par_t62 + 1
					end
				if ( @m_Dinner = 1 or @m_Dinner  = 2 or @m_Dinner  = 3 or @m_Dinner  = 4)
					begin
					set @par_g63=@par_g63 + 1
					set @par_t53=@par_t53+ 1
					set @par_t63=@par_t63 + 1
					end
				if ( @m_Snack = 1 or @m_Snack  = 2 or @m_Snack  = 3 or @m_Snack  = 4)
					begin
					set @par_g64=@par_g64 + 1
					set @par_t54=@par_t54+ 1
					set @par_t64=@par_t64 + 1
					end

			end


	-- Pod G Juvenile and Staff ---------------------------------------------------------------------------  End	

	-- Pod Control Room  and Staff ---------------------------------------------------------------------------  Beg

			--if (substring(ltrim(rtrim(@m_PodRoom)),1,3) ='Con'    and  @m_indJuv='Staff')
	
			if (cast(@m_PodRoom as varchar) ='Control Room'  and  @m_indJuv='Staff')
			begin

				--print ' return par:  ' + cast(@par_b11 as varchar)
				if ( @m_Breakfast = 1 or @m_Breakfast = 2 or @m_Breakfast = 3 or @m_Breakfast = 4)
					begin
					set @par_t11=@par_t11 + 1
					set @par_t51=@par_t51 + 1
					set @par_t61=@par_t61 + 1
					end
				if ( @m_Lunch = 1 or @m_Lunch = 2 or @m_Lunch = 3 or @m_Lunch = 4)

					begin
					set @par_t12=@par_t12 + 1
					set @par_t52=@par_t52 + 1
					set @par_t62=@par_t62 + 1
					end
				if ( @m_Dinner = 1 or @m_Dinner  = 2 or @m_Dinner  = 3 or @m_Dinner  = 4)
					begin
					set @par_t13=@par_t13 + 1
					set @par_t53=@par_t53+ 1
					set @par_t63=@par_t63 + 1
					end
				if ( @m_Snack = 1 or @m_Snack  = 2 or @m_Snack  = 3 or @m_Snack  = 4)
					begin
					set @par_t14=@par_t14 + 1
					set @par_t54=@par_t54+ 1
					set @par_t64=@par_t64 + 1
					end
			end
	-- Pod Control Roomand Staff ---------------------------------------------------------------------------  End	
	-- Pod Intake Staff  ---------------------------------------------------------------------------  Beg

			if  ( rtrim(ltrim(@m_PodRoom))  ='Intake Staff' and  @m_indJuv='Staff')
			begin

				if ( @m_Breakfast = 1 or @m_Breakfast = 2 or @m_Breakfast = 3 or @m_Breakfast = 4)
					begin
					set @par_t21=@par_t21 + 1
					set @par_t51=@par_t51 + 1
					set @par_t61=@par_t61 + 1
					end
				if ( @m_Lunch = 1 or @m_Lunch = 2 or @m_Lunch = 3 or @m_Lunch = 4)
					begin
					set @par_t22=@par_t22 + 1
					set @par_t52=@par_t52 + 1
					set @par_t62=@par_t62 + 1
					end
				if ( @m_Dinner = 1 or @m_Dinner  = 2 or @m_Dinner  = 3 or @m_Dinner  = 4)
					begin
					set @par_t23=@par_t23 + 1
					set @par_t53=@par_t53+ 1
					set @par_t63=@par_t63 + 1
					end
				if ( @m_Snack = 1 or @m_Snack  = 2 or @m_Snack  = 3 or @m_Snack  = 4)
					begin
					set @par_t24=@par_t24 + 1
					set @par_t54=@par_t54+ 1
					set @par_t64=@par_t64 + 1
					end
			end
		-- Pod Intake  Staff ---------------------------------------------------------------------------  End	
		-- Pod Medical Staff  ---------------------------------------------------------------------------  Beg

			if  ( rtrim(ltrim(@m_PodRoom))  ='Medical' and  @m_indJuv='Staff')
			begin

				if ( @m_Breakfast = 1 or @m_Breakfast = 2 or @m_Breakfast = 3 or @m_Breakfast = 4)
					begin
					set @par_t31=@par_t31 + 1
					set @par_t51=@par_t51 + 1
					set @par_t61=@par_t61 + 1
					end
				if ( @m_Lunch = 1 or @m_Lunch = 2 or @m_Lunch = 3 or @m_Lunch = 4)
					begin
					set @par_t32=@par_t32 + 1
					set @par_t52=@par_t52 + 1
					set @par_t62=@par_t62 + 1
					end
				if ( @m_Dinner = 1 or @m_Dinner  = 2 or @m_Dinner  = 3 or @m_Dinner  = 4)
					begin
					set @par_t33=@par_t33 + 1
					set @par_t53=@par_t53+ 1
					set @par_t63=@par_t63 + 1
					end
				if ( @m_Snack = 1 or @m_Snack  = 2 or @m_Snack  = 3 or @m_Snack  = 4)
					begin
					set @par_t34=@par_t34 + 1
					set @par_t54=@par_t54+ 1
					set @par_t64=@par_t64 + 1
					end
			end
	-- Pod Medical Staff ---------------------------------------------------------------------------  End	
	
	--		GoTo GetNext
		GetNext:
			FETCH NEXT FROM MealsJuvenileAndStaffReport_cursor
			INTO
				@m_MealDate  ,
				@m_PodRoom ,
				@m_Breakfast,
				@m_Lunch ,
				@m_Dinner,
				@m_Snack ,
				@m_indJuv
	END ------------------------------------------------- End While loop
	

END 


Close MealsJuvenileAndStaffReport_cursor
Deallocate MealsJuvenileAndStaffReport_cursor






GO


USE [JusticeServices]
GO

/****** Object:  StoredProcedure [dbo].[spSelectMealsForStaff]    Script Date: 05/18/2016 15:55:50 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


/****** Object:  Stored Procedure dbo.spSelectMealsForStaff    Script Date: 12/7/2005 1:14:54 PM ******/
CREATE PROCEDURE [dbo].[spSelectMealsForStaff]
@m_MealDate datetime
AS

BEGIN

SELECT distinct    TOP 100 PERCENT dbo.vwStaffNameforMeal.StaffID,
				 dbo.vwStaffNameforMeal.Agency, 
				dbo.vwStaffNameforMeal.LName, 
				dbo.vwStaffNameforMeal.FName, 
				dbo.vwStaffNameforMeal.FullName, 
				dbo.tblDetMeals.DetMealsID, 
                     			dbo.tblDetMeals.Comment, 
				dbo.tblDetMeals.CreatedBy, 
				dbo.tblDetMeals.CreatedDate, 
				dbo.tblDetMeals.UpdtBy, 
				dbo.tblDetMeals.UpdtDate, 
                      			dbo.tblDetMeals.StaffID AS Expr1, 
				dbo.tblDetMeals.StafPodRoom, 
				dbo.tblDetMeals.Breakfast,
				BreakfastS  =
					Case  dbo.tblDetMeals.Breakfast
						when 0 then '   '
						when 1 then 'Dinning Hall'
						when 2 then 'Intake'
						when 3 then 'Court'
						when 4 then 'Room Tray'			
					end 
				, 
				
				dbo.tblDetMeals.Lunch,
				LunchS= 
					Case  dbo.tblDetMeals.Lunch
						when 0 then '   '
						when 1 then 'Dinning Hall'
						when 2 then 'Intake'
						when 3 then 'Court'
						when 4 then 'Room Tray'	
					end 
				, 
				 dbo.tblDetMeals.Dinner,
                     		             DinnerS = 
				
					Case  dbo.tblDetMeals.Dinner
						when 0 then '   '
						when 1 then 'Dinning Hall'
						when 2 then 'Intake'
						when 3 then 'Court'
						when 4 then 'Room Tray'	
					end 
				, 
				dbo.tblDetMeals.Snack,
				SnackS =
					Case  dbo.tblDetMeals.Snack
						when 0 then '   '
						when 1 then 'Dinning Hall'
						when 2 then 'Intake'
						when 3 then 'Court'
						when 4 then 'Room Tray'	
					end 
				, 

				dbo.tblDetMeals.MealDate
FROM         dbo.tblDetMeals INNER JOIN dbo.vwStaffNameforMeal ON dbo.tblDetMeals.StaffID = dbo.vwStaffNameforMeal.StaffID
WHERE     ((dbo.vwStaffNameforMeal.Agency = 'DIT') OR
                      (dbo.vwStaffNameforMeal.Agency = 'RDJJS') AND (dbo.tblDetMeals.MealDate = @m_MealDate) )
ORDER BY dbo.tblDetMeals.StafPodRoom, dbo.vwStaffNameforMeal.LName

END






GO


USE [JusticeServices]
GO

/****** Object:  StoredProcedure [dbo].[spUpdateStaffMealRecord]    Script Date: 05/18/2016 15:56:56 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


/****** Object:  Stored Procedure dbo.spUpdateStaffMealRecord    Script Date: 12/7/2005 1:14:54 PM ******/
/**
This Procedure will update Detention Juvenile Meal Table tblDetMeals

**/




CREATE PROCEDURE [dbo].[spUpdateStaffMealRecord]
@currDetMealsID int,
@m_MealDate datetime,
@m_UpdtBy varchar(50),
@m_UpdtDate datetime,
@m_StaffID int,
@m_StafPodRoom varchar(20),
@m_BreakfastCombo int,
@m_LunchCombo int,
@m_DinnerCombo int,
@m_SnackCombo int

AS
BEGIN

UPDATE tblDetMeals
SET UpdtBy=@m_UpdtBy, UpdtDate=@m_UpdtDate, StaffID=@m_StaffID, StafPodRoom=@m_StafPodRoom,
Breakfast=@m_BreakfastCombo, Lunch=@m_LunchCombo, Dinner=@m_DinnerCombo,Snack=@m_SnackCombo
WHERE (DetMealsID=@currDetMealsID and MealDate=@m_MealDate)

END


GO


grant exec on spSelectMealforALLCombo to justiceservicesappid
go

grant exec on spInsert_CreateNewMeal to justiceservicesappid
go

grant exec on spSelectMealforALL to justiceservicesappid
go

grant exec on spChekforNewJuvenileMeal to justiceservicesappid
go

grant exec on sp_BreakfastCombo to justiceservicesappid
go

grant exec on spTempMealsForJuvenileAndStaffReport to justiceservicesappid
go

grant exec on spSelectMealsForStaff to justiceservicesappid
go

grant exec on spUpdateMealforALL to justiceservicesappid
go

grant exec on spUpdateStaffMealRecord to justiceservicesappid
go

grant exec on spselectStaffIDFullNameforCombo to justiceservicesappid
go

grant exec on spPurgeMeals to justiceservicesappid
go

grant exec on spMonthlyMealsReport to justiceservicesappid
go
