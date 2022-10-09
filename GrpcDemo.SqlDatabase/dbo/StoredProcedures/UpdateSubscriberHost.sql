-- =============================================
-- Author:		Tom Barrett
-- Create date: 2022-10-07
-- Description:	Updates a subscriber's host information.
-- =============================================
CREATE PROCEDURE UpdateSubscriberHost 
	@Name VARCHAR(100),
	@Host VARCHAR(1000)
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

    IF (coalesce(@Name, '') = '') 
		THROW 70001, '@Name can not be null or empty', 1;

    IF (coalesce(@Host, '') = '') 
		THROW 70001, '@Host can not be null or empty', 1;

	BEGIN TRY
		BEGIN TRANSACTION
		
			UPDATE dbo.Subscriber
			SET Host = @Host, 
				IsActive = 1, 
				EditedBy = stuff(suser_sname(),(1),charindex('\',suser_sname()),''), 
				EditedOn = GETDATE()
			WHERE [Name] = @Name;

			IF @@ROWCOUNT = 0
				INSERT INTO [dbo].[Subscriber] ([Name], [Host])
				VALUES (@Name, @Host)

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		ROLLBACK;
		THROW 70001, 'Error updating subscriber host, rolling back transaction.', 1;
	END CATCH

	IF @@TRANCOUNT > 0 ROLLBACK;
END
GO
