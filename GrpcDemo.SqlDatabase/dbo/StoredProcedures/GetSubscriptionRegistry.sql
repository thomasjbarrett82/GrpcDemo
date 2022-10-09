-- =============================================
-- Author:		Tom Barrett
-- Create date: 2022-10-07
-- Description:	Gets the registered subscribers for one or all subscriptions
-- =============================================
CREATE PROCEDURE GetSubscriptionRegistry
	/* if @IsActive = 0, get all active and inactive records */
	@IsActive BIT = 1, 
	/* if @Topic is empty, get all topics */
	@Topic VARCHAR(100) = ''
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT s.TopicId
		, t.[Name] AS TopicName
		, s.SubscriberId
		, sr.[Name] AS SubscriberName
		, sr.Host
	FROM dbo.Subscription s
	JOIN dbo.Subscriber sr ON s.SubscriberId = sr.Id
	JOIN dbo.Topic t ON s.TopicId = t.Id
	WHERE (@IsActive = 0 OR s.IsActive = @IsActive)
	and (@Topic = '' OR t.[Name] = @Topic);
			
END
GO