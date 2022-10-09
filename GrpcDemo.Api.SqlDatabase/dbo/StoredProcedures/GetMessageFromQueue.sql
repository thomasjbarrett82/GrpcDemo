-- =============================================
-- Author:		Tom Barrett
-- Create date: 2022-10-07
-- Description:	Gets message from the queue.
-- 2022-10-08 (Tom Barrett) Moved to shared SSDT project.
-- =============================================
CREATE PROCEDURE GetMessageFromQueue
	@Id BIGINT
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

    IF (@Id IS NULL) 
		THROW 70001, '@Id can not be null', 1;

	SELECT [Id]
		,[Topic]
		,[DTO]
		,[Source]
		,[CreatedBy]
		,[CreatedOn]
	FROM [dbo].[MessageQueue]
	WHERE [Id] = @Id;

END
GO
