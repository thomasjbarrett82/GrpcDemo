-- =============================================
-- Author:		Tom Barrett
-- Create date: 2022-10-07
-- Description:	Gets the registered subscribers for one or all subscriptions
-- =============================================
CREATE PROCEDURE [dbo].[GetSubscriptionRegistry]
	/* if @IsActive = 0, get all active and inactive records */
	@IsActive BIT, 
	/* if @Topic is empty, get all topics */
	@Topic VARCHAR(100)
AS
BEGIN
	
	SET NOCOUNT ON;

    IF (@IsActive IS NULL)
        THROW 70001, '@IsActive can not be null', 1;

    IF (COALESCE(@Topic, '') = '')
        THROW 70001, '@Topic can not be empty or null', 1;

	SELECT s.TopicId
		, t.[Name] AS TopicName
		, s.SubscriberId
		, sr.[Name] AS SubscriberName
		, sr.Host
	FROM dbo.Subscription s
	JOIN dbo.Subscriber sr ON s.SubscriberId = sr.Id
	JOIN dbo.Topic t ON s.TopicId = t.Id
	WHERE s.IsActive = @IsActive
	and t.[Name] = @Topic;
			
END
GO