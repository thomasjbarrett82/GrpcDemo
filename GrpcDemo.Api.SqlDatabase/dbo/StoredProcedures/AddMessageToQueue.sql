-- =============================================
-- Author:		Tom Barrett
-- Create date: 2022-10-07
-- Description:	Adds a published message to the queue.
-- 2022-10-08 (Tom Barrett) Moved to shared SSDT project.
-- =============================================
CREATE PROCEDURE AddMessageToQueue
	@Topic VARCHAR(100),
	@DTO VARCHAR(MAX),
	@Source VARCHAR(100)
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

    IF (coalesce(@Topic, '') = '') 
		THROW 70001, '@Topic can not be null or empty', 1;

    IF (coalesce(@DTO, '') = '') 
		THROW 70001, '@DTO can not be null or empty', 1;

    IF (coalesce(@Source, '') = '') 
		THROW 70001, '@Source can not be null or empty', 1;

	BEGIN TRY
		BEGIN TRANSACTION

			INSERT INTO [dbo].[MessageQueue] ([Topic], [DTO], [Source])
			VALUES (@Topic, @DTO, @Source);

		COMMIT TRANSACTION

		SELECT SCOPE_IDENTITY();
	END TRY

	BEGIN CATCH
		ROLLBACK;
		THROW 70001, 'Error adding message to queue, rolling back transaction.', 1;
	END CATCH

	IF @@TRANCOUNT > 0 ROLLBACK;
END
GO
