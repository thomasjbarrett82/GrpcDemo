-- =============================================
-- Author:		Tom Barrett
-- Create date: 2022-10-09
-- Description:	Upserts an appointment, returns Id
-- =============================================
CREATE PROCEDURE UpdateAppointment
	@Id INT,
	@ClinicNumber VARCHAR(16),
	@FullData VARCHAR(MAX)
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	IF (@Id IS NULL AND COALESCE(@ClinicNumber, '') = '') 
		THROW 70001, 'Appointment missing ID and Clinic Number.', 1;

	IF (COALESCE(@FullData, '') = '')
		THROW 70001, 'Appointment missing full data.', 1;

	DECLARE @ApptId BIGINT;

	BEGIN TRY

		IF (@Id IS NOT NULL)
			BEGIN
				BEGIN TRANSACTION

				UPDATE [dbo].[Appointment]
				SET [FullData] = @FullData, 
					[EditedBy] = stuff(suser_sname(),(1),charindex('\',suser_sname()),''), 
					[EditedOn] = GETDATE()
				WHERE [Id] = @Id;

				COMMIT TRANSACTION

				SET @ApptId = @Id;

			END 

		IF (@Id IS NULL) 
			BEGIN

				DECLARE @PatientId BIGINT = (SELECT TOP 1 [Id] FROM [dbo].[Patient] WHERE [ClinicNumber] = @ClinicNumber);

				IF (@PatientId IS NULL)
					BEGIN
						DECLARE @ErrorMessage VARCHAR(100) = (SELECT CONCAT('Patient ', @ClinicNumber, ' was not found.'));
						THROW 70001, @ErrorMessage, 1;
					END

				BEGIN TRANSACTION

				INSERT INTO [dbo].[Appointment] ([PatientId], [FullData])
				VALUES (@PatientId, @FullData);

				COMMIT TRANSACTION

				SET @ApptId = (SELECT SCOPE_IDENTITY());

			END

		SELECT @ApptId;

	END TRY

	BEGIN CATCH
		ROLLBACK;
		THROW 70001, 'Error updating Appointment, rolling back transaction.', 1;
	END CATCH

	IF @@TRANCOUNT > 0 ROLLBACK;
END
GO
