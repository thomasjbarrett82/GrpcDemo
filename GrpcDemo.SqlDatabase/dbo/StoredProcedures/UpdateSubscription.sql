-- =============================================
-- Author:		Tom Barrett
-- Create date: 2022-10-07
-- Description:	Updates a subscription.
-- =============================================
CREATE PROCEDURE UpdateSubscription
	@Name VARCHAR(100),
	@Topic VARCHAR(100),
	@IsActive BIT = 1
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

    IF (coalesce(@Name, '') = '') 
		THROW 70001, '@Name can not be null or empty', 1;

    IF (coalesce(@Topic, '') = '') 
		THROW 70001, '@@Topic can not be null or empty', 1;

	BEGIN TRY
		BEGIN TRANSACTION

			UPDATE s
			SET s.IsActive = @IsActive, 
				EditedBy = stuff(suser_sname(),(1),charindex('\',suser_sname()),''), 
				EditedOn = GETDATE()
			FROM dbo.Subscription s
			JOIN dbo.Topic t ON s.TopicId = t.Id 
			JOIN dbo.Subscriber sr ON s.SubscriberId = sr.Id 
			WHERE t.[Name] = @Topic
			AND sr.[Name] = @Name;

			IF @@ROWCOUNT = 0
				INSERT INTO [dbo].[Subscription] ([TopicId], [SubscriberId])
				SELECT Topic.Id
					, Subscriber.Id
				FROM dbo.Subscriber
					, dbo.Topic
				WHERE Subscriber.[Name] = @Name
					AND Topic.[Name] = @Topic;

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		ROLLBACK;
		THROW 70001, 'Error updating subscription, rolling back transaction.', 1;
	END CATCH

	IF @@TRANCOUNT > 0 ROLLBACK;
END
GO