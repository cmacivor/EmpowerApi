USE [JusticeServices]
GO

/****** Object:  UserDefinedFunction [dbo].[fnAdmittedBy]    Script Date: 03/11/2016 11:08:28 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


/****** Object:  User Defined Function dbo.fnAdmittedBy    Script Date: 12/6/2005 2:17:25 PM ******/
CREATE FUNCTION [dbo].[fnAdmittedBy] 
	(@inRefSourceID       int,
	@outName  char(100))  

RETURNS char(100)
 AS  


BEGIN



	DECLARE csrName CURSOR
		FOR
			SELECT   LastName as LName, FirstName as FName
			FROM   Staff
			WHERE (Staff.ID = @inRefSourceID)

	DECLARE @LName char(25)
	DECLARE @FName char(25)

	OPEN csrName
	FETCH NEXT FROM csrName
 	 	INTO @LName, @FName

	SET @outName =rtrim(@LName) + ", " +rtrim(@FName)
	CLOSE csrName
	DEALLOCATE csrName					

RETURN @outName

END






GO


USE [JusticeServices]
GO
/****** Object:  UserDefinedFunction [dbo].[fnDateOnly]    Script Date: 2/18/2016 4:23:13 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Object:  User Defined Function dbo.fnDateOnly    Script Date: 12/6/2005 2:17:25 PM ******/
CREATE FUNCTION [dbo].[fnDateOnly] 
	(@inDateTime   datetime,
	 @outDate    nvarchar(10))  

RETURNS nvarchar(10)
 AS  


BEGIN
	-----------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Returns a Date WITHOUT leading zeros as a character string from a datetime field.
	-- Use CONVERT(nvarchar, inDateTime, 101) instead of this function,  if you want leading zeros, 		
	-----------------------------------------------------------------------------------------------------------------------------------------------------------

	SET @outDate = 	 (LTRIM(STR(MONTH(@inDateTime))) + '/' +  LTRIM(STR(DAY(@inDateTime))) + '/' +  LTRIM(STR(YEAR(@inDateTime))))



RETURN @outDate

END


GO
USE [JusticeServices]
GO

/****** Object:  UserDefinedFunction [dbo].[fnFamilyMember]    Script Date: 2/18/2016 4:23:13 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  User Defined Function dbo.fnFamilyMember    Script Date: 12/6/2005 2:17:25 PM ******/
CREATE FUNCTION [dbo].[fnFamilyMember] 
	(@inJuv       int,
	@inRole      char(2),
	@outDesc   char(100))  

RETURNS char(100)
 AS  


BEGIN

	DECLARE csrFamily CURSOR
		FOR
			select LName, FName, MName, SufName, HomePHone, WorkPhone, WorkPhoneExt, OtherPhone, OtherPhoneExt, MaritalStatus
			from vwDetFamily
			where JuvenileID = @inJuv and RoleID = @inRole

	DECLARE @LName char(25)
	DECLARE @FName char(25)
	DECLARE @MName char(25)
	DECLARE @SufName char(25)
	DECLARE @LongDesc char(100)
	DECLARE @HomePhone char(20)
	DECLARE @WorkPhone char(20)
	DECLARE @WorkPhoneExt char(20)
	DECLARE @OtherPhone char(20)
	DECLARE @OtherPhoneExt char(20)
	DECLARE @MaritalStatus char(15)

	OPEN csrFamily
	FETCH NEXT FROM csrFamily
 	 	INTO @LName, @FName, @MName, @SufName, @HomePhone, @WorkPhone, @WorkPhoneExt, @OtherPhone, @OtherPhoneExt, @MaritalStatus
	if @LName is null
		BEGIN
			SET @LName = ' '
		END
	if @FName is null
		BEGIN
			SET @FName = ' '
		END
	if @MName is null
		BEGIN
			SET @MName = ' '
		END
	if @SufName is null
		BEGIN
			SET @SufName = ' '
		END


	--SET @LongDesc = ltrim(rtrim(@FName)) + ' ' +  ltrim(rtrim(@MName)) + ' ' +  ltrim(rtrim(@LName)) + ' ' +  ltrim(rtrim(@SufName))  + ' (H) ' +  
	--						ltrim(rtrim(@HomePhone)) + ' (W) ' +  ltrim(rtrim(@WorkPhone)) + ' Ext: ' +  ltrim(rtrim(@WorkPhoneExt)) + ' (O) ' + 
	--						ltrim(rtrim(@OtherPhone)) + ' Ext: ' +  ltrim(rtrim(@OtherPhoneExt)) 

	DECLARE @Home char(25)
	DECLARE @Work char(25)
	DECLARE @Other char(25)

	IF (len(ltrim(rtrim(@HomePhone))) = 0)
		BEGIN
			SET @Home = ''
		END
	ELSE
		BEGIN
			SET @Home = ' (H) ' +  ltrim(rtrim(@HomePhone)) 
		END

	IF (len(ltrim(rtrim(@WorkPhone))) = 0)
		BEGIN
			SET @Work = ''
		END
	ELSE
		BEGIN
			SET @Work = ' (W) ' +  ltrim(rtrim(@WorkPhone)) 
			IF (len(ltrim(rtrim(@WorkPhoneExt))) > 0)
				BEGIN
					SET @Work = @Work + ' Ext: ' +  ltrim(rtrim(@WorkPhoneExt))
				END
		END

	IF (len(ltrim(rtrim(@OtherPhone))) = 0)
		BEGIN
			SET @Other = ''
		END
	ELSE
		BEGIN
			SET @Other = ' (W) ' +  ltrim(rtrim(@OtherPhone)) 
			IF (len(ltrim(rtrim(@OtherPhoneExt))) > 0)
				BEGIN
					SET @Other = @Other + ' Ext: ' +  ltrim(rtrim(@OtherPhoneExt))
				END
		END


	SET @LongDesc = ltrim(rtrim(@FName)) + ' ' +  ltrim(rtrim(@MName)) + ' ' +  ltrim(rtrim(@LName)) + ' ' +  ltrim(rtrim(@SufName))  + ltrim(rtrim(@Home)) + ltrim(rtrim(@Work)) + ltrim(rtrim(@Other))

	IF (substring(@WorkPhone,1,7) = '804-646')
		BEGIN
			SET @LongDesc = 'DSS -- ' + ltrim(rtrim( @LongDesc))
		END 



	IF (len(ltrim(rtrim(@MaritalStatus))) > 0)
		BEGIN
			SET @LongDesc =  ltrim(rtrim( @LongDesc)) + ' - ' + ltrim(rtrim(@MaritalStatus))
		END




	IF (len(@LongDesc)=0) or (@LongDesc is null)
		BEGIN
			SET @LongDesc = 'RNF'
		END


	CLOSE csrFamily
	DEALLOCATE csrFamily						

	
	SET @outDesc = rtrim(ltrim(@LongDesc)) 
	--print @outDesc



RETURN @outDesc

END
GO
USE [JusticeServices]
GO

/****** Object:  UserDefinedFunction [dbo].[fnFamilyMemberAddrID]    Script Date: 04/07/2016 10:21:11 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


/****** Object:  User Defined Function dbo.fnFamilyMemberAddrID    Script Date: 12/6/2005 2:17:25 PM ******/
CREATE FUNCTION [dbo].[fnFamilyMemberAddrID]
 (@inJuv	int,
  @inRole	varchar(2),
  @FMAddrId varchar(7))  

RETURNS varchar(7) 

AS  

BEGIN 

Declare csrFMAddrID Cursor

   FOR

	Select AddrID from vwDetFamilyDetail
              where roleId = @inRole
              and JuvenileId = @inJuv

     Declare @AddrId varchar(7)
     Declare @LongDesc varchar(15)

	Open csrFMAddrID
	Fetch Next From csrFMAddrID
		Into @AddrId

	If @AddrId is null
		Begin
			SET @AddrID = ' '
		End

	SET @LongDesc = @AddrID

	
	Close csrFMAddrID
	DealLocate csrFMAddrID

	Set @FMAddrID = rtrim(ltrim(@LongDesc))

RETURN @FMAddrID

End
GO
USE [JusticeServices]
GO

/****** Object:  UserDefinedFunction [dbo].[fnFamilyMemberMarital]    Script Date: 03/16/2016 13:58:43 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


/****** Object:  User Defined Function dbo.fnFamilyMemberMarital    Script Date: 12/6/2005 2:17:25 PM ******/
CREATE FUNCTION [dbo].[fnFamilyMemberMarital]
           (@inJuv                 int,
            @inRole                char(2),
            @FamilyMemberMarital char(15))

  
RETURNS char(15)

AS

BEGIN

   Declare csrFamily CURSOR	
      FOR


        select LName, FName, MName, SufName,SSN,MaritalStatus
         from vwDetFamilyDetail
         where JuvenileId= @inJuv and RoleId= @inRole

             DECLARE @LName char(25)
	DECLARE @FName char(25)
	DECLARE @MName char(25)
	DECLARE @SufName char(25)
             DECLARE @SSN        char(15)
             DECLARE @MaritalStatus char(15)
             DECLARE @Name     char(50)
      	DECLARE @LongDesc char(100)
	

	OPEN csrFamily
	FETCH NEXT FROM csrFamily
 	 	INTO @LName, @FName, @MName, @SufName, @SSN, @MaritalStatus
       

                
             
	 IF @MaritalStatus is null 
		BEGIN
			SET @MaritalStatus = '  '

		END
	
	

           SET @LongDesc =  @MaritalStatus 

	

	CLOSE csrFamily
	DEALLOCATE csrFamily						

	
	SET @FamilyMemberMarital = rtrim(ltrim(@LongDesc)) 
	



RETURN @FamilyMemberMarital 


END










GO


USE [JusticeServices]
GO

/****** Object:  UserDefinedFunction [dbo].[fnFamilyMemberPhone]    Script Date: 03/16/2016 12:56:07 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


/****** Object:  User Defined Function dbo.fnFamilyMemberPhone    Script Date: 12/6/2005 2:17:25 PM ******/
CREATE FUNCTION [dbo].[fnFamilyMemberPhone]
           (@inJuv               int,
            @inRole             char(2),
            @FamilyPhone        char(100))

RETURNS char(100)
AS
BEGIN

   Declare csrFamily CURSOR	
      FOR
        select LName, FName, MName, SufName,SSN,MaritalStatus,HomePhone,WorkPhone,WorkPhoneExt
         from vwDetFamilyDetail
         where JuvenileId= @inJuv and RoleId= @inRole

             DECLARE @LName char(25)
	DECLARE @FName char(25)
	DECLARE @MName char(25)
	DECLARE @SufName char(25)
             DECLARE @SSN        char(15)
             DECLARE @MaritalStatus char(15)
             DECLARE @Name     char(50)
      	DECLARE @LongDesc char(100)
	DECLARE @HomePhone char(20)
	DECLARE @WorkPhone char(20)
	DECLARE @WorkPhoneExt char(20)
	DECLARE @OtherPhone char(20)
	DECLARE @OtherPhoneExt char(20)

	OPEN csrFamily
	FETCH NEXT FROM csrFamily
 	 	INTO @LName, @FName, @MName, @SufName, @SSN, @MaritalStatus, @HomePhone, @WorkPhone,
                           @WorkPhoneExt

     	 IF len(@HomePhone) > 0
		BEGIN
			SET @HomePhone=' (H)' + ltrim(rtrim(@HomePhone))
		END
	IF len(@WorkPhone)>0
		BEGIN
			SET @WorkPhone=' (W)' + ltrim(rtrim(@WorkPhone))
		END
	IF len(@WorkPhoneExt)>0
		BEGIN
			SET @WorkPhoneExt=' (Ext)' + ltrim(rtrim(@WorkPhoneExt))
		END
             SET @LongDesc =   ltrim(rtrim(@HomePhone))  +  ltrim(rtrim(@WorkPhone)) + ltrim(rtrim(@WorkPhoneExt)) 

	IF len(ltrim(rtrim(@LongDesc))) = 0
		BEGIN
			SET @LongDesc = 'Unknown'
		END

	CLOSE csrFamily
	DEALLOCATE csrFamily						

	SET @FamilyPhone = rtrim(ltrim(@LongDesc)) 
	

RETURN @FamilyPhone

END
























GO


USE [JusticeServices]
GO

/****** Object:  UserDefinedFunction [dbo].[fnFamilyMemberSSN]    Script Date: 03/16/2016 13:28:38 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


/****** Object:  User Defined Function dbo.fnFamilyMemberSSN    Script Date: 12/6/2005 2:17:25 PM ******/
CREATE FUNCTION [dbo].[fnFamilyMemberSSN]
           (@inJuv              int,
            @inRole             char(2),
            @FamilyMemberSSN    char(15))

  
RETURNS char(100)

AS

BEGIN

   Declare csrFamily CURSOR	
      FOR

        select LName, FName, MName, SufName,SSN,MaritalStatus
         from vwDetFamilyDetail
         where JuvenileId= @inJuv and RoleId= @inRole

             DECLARE @LName char(25)
	DECLARE @FName char(25)
	DECLARE @MName char(25)
	DECLARE @SufName char(25)
             DECLARE @SSN        char(15)
             DECLARE @MaritalStatus char(15)
             DECLARE @Name     char(50)
      	DECLARE @LongDesc char(100)
	

	OPEN csrFamily
	FETCH NEXT FROM csrFamily
 	 	INTO @LName, @FName, @MName, @SufName, @SSN, @MaritalStatus
       

                
             
	 IF @SSN is null 
		BEGIN
			SET @SSN = '  '

		END
	
	

           SET @LongDesc =  @SSN 

	

	CLOSE csrFamily
	DEALLOCATE csrFamily						

	
	SET @FamilyMemberSSN = rtrim(ltrim(@LongDesc)) 
	



RETURN @FamilyMemberSSN

END
GO
USE [JusticeServices]
GO

/****** Object:  UserDefinedFunction [dbo].[fnFixEmpty]    Script Date: 03/04/2016 10:40:11 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


/****** Object:  User Defined Function dbo.fnFixEmpty    Script Date: 12/6/2005 2:17:25 PM ******/
CREATE FUNCTION [dbo].[fnFixEmpty] 
	(@inText    char(100),
	@outText  char(100))  

RETURNS char(100)
 AS  


BEGIN

	IF (@inText = ",")
		BEGIN
			SET @outText = ""
		END
	ELSE
		BEGIN
			SET @outText = @inText
		END

RETURN @outText

END

GO


USE [JusticeServices]
GO

/****** Object:  UserDefinedFunction [dbo].[fnGetPersonAddress]    Script Date: 02/24/2016 14:52:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/****** Object:  User Defined Function dbo.fnGetPersonAddress    Script Date: 2/22/2016 2:17:26 PM ******/
CREATE FUNCTION [dbo].[fnGetPersonAddress] 
	(@inPersonID       int,
	@intAddrTypeID int,
	@intFieldNum int,
	@outName  char(100))  

RETURNS char(100)
 AS  

BEGIN
	DECLARE csrName CURSOR
		FOR
			SELECT   GISCode, AddressLineOne, AddressLineTwo, City, State, Zip, POBox
			FROM   PersonAddress
			WHERE (PersonID = @inPersonID AND AddressTypeID = @intAddrTypeID) 

	DECLARE @GISCode nvarchar(max)
	DECLARE @AddrLine1 nvarchar(max)
	DECLARE @AddrLine2 nvarchar(max)
	DECLARE @City nvarchar(max)
	DECLARE @State nvarchar(max)
	DECLARE @Zip nvarchar(max)
	DECLARE @POBox nvarchar(max)

	OPEN csrName
	FETCH NEXT FROM csrName
 	 	INTO @GISCode, @AddrLine1, @AddrLine2, @City, @State, @Zip, @POBox

	IF (@intFieldNum = 1)
		SET @outName = @GISCode
	ELSE IF (@intFieldNum = 2)
		SET @outName = @AddrLine1
	ELSE IF (@intFieldNum = 3)
		SET @outName = @AddrLine2
	ELSE IF (@intFieldNum = 4)
		SET @outName = @City
	ELSE IF (@intFieldNum = 5)
		SET @outName = @State
	ELSE IF (@intFieldNum = 6)
		SET @outName = @Zip
	ELSE IF (@intFieldNum = 7)
		SET @outName = @POBox
		
	CLOSE csrName
	DEALLOCATE csrName					

RETURN @outName

END

GO


USE [JusticeServices]
GO

/****** Object:  UserDefinedFunction [dbo].[fnOffenseList]    Script Date: 02/25/2016 13:17:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/****** Object:  User Defined Function dbo.fnStaffName    Script Date: 2/22/2016 2:17:26 PM ******/
CREATE FUNCTION [dbo].[fnOffenseList] 
	(@inPlacementID       int,
	@outName  varchar(100))  

RETURNS varchar(100)
 AS  

BEGIN


	DECLARE csrName CURSOR
		FOR
			SELECT   VCCCode
			FROM   Offense
			WHERE (ID IN (SELECT OffenseID FROM PlacementOffense where PlacementID = @inPlacementID)) 

	DECLARE @VCCCode varchar(100)
	DECLARE @Temp varchar(100)
	SET @Temp = ''

	OPEN csrName
	
	FETCH NEXT FROM csrName INTO @VCCCode
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @Temp = '' OR @Temp is null
		BEGIN
			SET @Temp = @VCCCode
		END
		ELSE
		BEGIN
 	 		SET @Temp = @Temp + ' || ' + @VCCCode
		END
		FETCH NEXT FROM csrName INTO @VCCCode
	END
	
	CLOSE csrName
	DEALLOCATE csrName

	SET @outName = @Temp

RETURN @outName

END



GO


USE [JusticeServices]
GO

/****** Object:  UserDefinedFunction [dbo].[fnProbationOfficer]    Script Date: 2/18/2016 4:23:13 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Object:  User Defined Function dbo.fnProbationOfficer    Script Date: 12/6/2005 2:17:26 PM ******/
CREATE FUNCTION [dbo].[fnProbationOfficer]
          (@inStaffID  int,
           @outName char(100))
  

RETURNS char(100)


 AS  
BEGIN 

 Declare poName CURSOR
    For

     Select LastName as LName, FirstName as FName, Phone as Phone
     from Staff, tblDetentionSupp
     where (staff.id = po and Staff.Id = @inStaffID)

    Declare @LName char(25)
	Declare @FName char(25)
	Declare @Phone char(20)

Open poName
Fetch Next From poName
	Into @LName, @FName,@Phone

Set @outName = rtrim(@LName) + ', ' + rtrim(@FName) + '   ' + rtrim(@Phone)
Close poName
Deallocate poName

If   (@outName = ',')
         Begin
	 	Set @outName = ' '
        End


return @outName

   

END
GO


USE [JusticeServices]
GO

/****** Object:  User Defined Function dbo.fnStaffName    Script Date: 2/22/2016 2:17:26 PM ******/
CREATE FUNCTION [dbo].[fnStaffName] 
	(@inID       int,
	@outName  char(100))  

RETURNS char(100)
 AS  

BEGIN
	DECLARE csrName CURSOR
		FOR
			SELECT   LastName as LName , FirstName as FName
			FROM   Staff
			WHERE (Staff.ID = @inID) 

	DECLARE @LName char(25)
	DECLARE @FName char(25)

	OPEN csrName
	FETCH NEXT FROM csrName
 	 	INTO @LName, @FName

	SET @outName =rtrim(@LName) + ', ' +rtrim(@FName)
	CLOSE csrName
	DEALLOCATE csrName					

	IF (@outName = ',')
		BEGIN
			SET @outName = ''
		END

RETURN @outName

END


GO
USE [JusticeServices]
GO

/****** Object:  UserDefinedFunction [dbo].[fnTally]    Script Date: 03/04/2016 09:11:29 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


/****** Object:  User Defined Function dbo.fnTally    Script Date: 12/6/2005 2:17:26 PM ******/
CREATE FUNCTION [dbo].[fnTally] 
	(@inCount    int,
	 @outTally    int)  

RETURNS int
 AS  


BEGIN
	 IF @inCount > 0
		BEGIN
			SET @outTally = 1
		END
	ELSE	
		BEGIN
			SET @outTally = 0
		END

RETURN @outTally

END

GO


USE [JusticeServices]
GO
/****** Object:  UserDefinedFunction [dbo].[fnDetCount]    Script Date: 02/24/2016 17:18:00 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** Object:  User Defined Function dbo.fnDetCount    Script Date: 02/24/2016 17:03:33 ******/
CREATE FUNCTION [dbo].[fnDetCount] 
	(@inJuv     int,
	 @outCount  int)  

RETURNS int
 AS  

BEGIN

	DECLARE csrCount CURSOR
		FOR
			SELECT 	Count(ServiceProgramCategoryID) 
			FROM   
			    dbo.Placement  AS R, 
			    dbo.Enrollment AS E
			WHERE 	
			    (R.ClientProfileID = @inJuv) and 
				(R.ID = E.PlacementID)       and 
				(E.ServiceProgramCategoryID = 57)

	OPEN csrCount
	FETCH NEXT FROM csrCount
 	 	INTO @outCount

	CLOSE csrCount
	DEALLOCATE csrCount					

RETURN @outCount

END
GO

USE [JusticeServices]
GO
/****** Object:  UserDefinedFunction [dbo].[fnStaffPhone]    Script Date: 03/09/2016 17:46:59 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Object:  User Defined Function dbo.fnStaffPhone    Script Date: 12/6/2005 2:17:26 PM ******/
CREATE FUNCTION [dbo].[fnStaffPhone] 
	(@inID       int,
	 @outPhone  char(25))  

RETURNS char(25)
 AS  

BEGIN

	DECLARE csrName CURSOR
		FOR
			SELECT Phone
			FROM   dbo.Staff AS Y
			WHERE (Y.ID = @inID) 

	DECLARE @Phone char(25)

	OPEN csrName
	FETCH NEXT FROM csrName
 	 	INTO @Phone

	SET @outPhone=rtrim(@Phone) 
	CLOSE csrName
	DEALLOCATE csrName					

RETURN @outPhone

END
GO
