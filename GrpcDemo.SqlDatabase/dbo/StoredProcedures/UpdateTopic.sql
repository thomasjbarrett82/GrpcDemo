-- =============================================
-- Author:		Tom Barrett
-- Create date: 2022-10-07
-- Description:	Updates a topic.
-- =============================================
CREATE PROCEDURE UpdateTopic
	@Name VARCHAR(100),
	@IsActive BIT = 1,
	@Description VARCHAR(1000) = ''
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

    IF (coalesce(@Name, '') = '') 
		THROW 70001, '@Name can not be null or empty', 1;

	BEGIN TRY
		BEGIN TRANSACTION

			UPDATE [dbo].[Topic]
			SET [Description] = @Description,
				[IsActive] = @IsActive
			WHERE [Name] = @Name;

			IF @@ROWCOUNT = 0
				INSERT INTO [dbo].[Topic] ([Name], [Description], [IsActive])
				VALUES (@Name, @Description, @IsActive);

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		ROLLBACK;
		THROW 70001, 'Error updating topic, rolling back transaction.', 1;
	END CATCH

	IF @@TRANCOUNT > 0 ROLLBACK;
END
GO
