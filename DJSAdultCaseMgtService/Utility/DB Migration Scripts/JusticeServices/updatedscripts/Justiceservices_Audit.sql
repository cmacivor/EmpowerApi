USE [JusticeServices]
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[GenerateTriggers]
		@Schemaname = dbo,
		@Tablename = Person,
		@GenerateScriptOnly = 0

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[GenerateTriggers]
		@Schemaname = dbo,
		@Tablename = PersonSupplemental,
		@GenerateScriptOnly = 0

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[GenerateTriggers]
		@Schemaname = dbo,
		@Tablename = PersonAddress,
		@GenerateScriptOnly = 0

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[GenerateTriggers]
		@Schemaname = dbo,
		@Tablename = ClientProfile,
		@GenerateScriptOnly = 0

SELECT	'Return Value' = @return_value

GO
DECLARE	@return_value int

EXEC	@return_value = [dbo].[GenerateTriggers]
		@Schemaname = dbo,
		@Tablename = Placement,
		@GenerateScriptOnly = 0

SELECT	'Return Value' = @return_value

GO
DECLARE	@return_value int

EXEC	@return_value = [dbo].[GenerateTriggers]
		@Schemaname = dbo,
		@Tablename = Enrollment,
		@GenerateScriptOnly = 0

SELECT	'Return Value' = @return_value

GO
DECLARE	@return_value int

EXEC	@return_value = [dbo].[GenerateTriggers]
		@Schemaname = dbo,
		@Tablename = Assessment,
		@GenerateScriptOnly = 0

SELECT	'Return Value' = @return_value

GO
DECLARE	@return_value int

EXEC	@return_value = [dbo].[GenerateTriggers]
		@Schemaname = dbo,
		@Tablename = FamilyProfile,
		@GenerateScriptOnly = 0

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[GenerateTriggers]
		@Schemaname = dbo,
		@Tablename = ProgressNote,
		@GenerateScriptOnly = 0

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[GenerateTriggers]
		@Schemaname = dbo,
		@Tablename = ServiceUnit,
		@GenerateScriptOnly = 0

SELECT	'Return Value' = @return_value

GO
