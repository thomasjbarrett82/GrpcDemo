-- =============================================
-- Author:		Tom Barrett
-- Create date: 2022-10-07
-- Description:	Gets one or more patients
-- =============================================
CREATE PROCEDURE GetPatient
	/* if @ClinicNumber is empty, get all patients */
	@ClinicNumber VARCHAR(16)
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT [Id]
		, [ClinicNumber]
		, [FullData]
		, [CreatedBy]
		, [CreatedOn]
		, [EditedBy]
		, [EditedOn]
	FROM [dbo].[Patient]
	WHERE (COALESCE(@ClinicNumber, '') = '' OR [ClinicNumber] = @ClinicNumber);
			
END
GO