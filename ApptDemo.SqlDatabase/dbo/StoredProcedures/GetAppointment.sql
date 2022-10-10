-- =============================================
-- Author:		Tom Barrett
-- Create date: 2022-10-09
-- Description:	Gets appointments for a given patient
-- =============================================
CREATE PROCEDURE GetAppointmentsByPatient
	@ClinicNumber VARCHAR(16)
AS
BEGIN
	
	SET NOCOUNT ON;

	IF (COALESCE(@ClinicNumber, '') = '') 
		THROW 70001, 'Clinic Number is required.', 1;

	SELECT a.[Id]
		, p.[ClinicNumber]
		, a.[FullData]
		, a.[CreatedBy]
		, a.[CreatedOn]
		, a.[EditedBy]
		, a.[EditedOn]
	FROM [dbo].[Patient] p
	JOIN [dbo].[Appointment] a on p.Id = a.PatientId
	WHERE p.[ClinicNumber] = @ClinicNumber;
			
END
GO