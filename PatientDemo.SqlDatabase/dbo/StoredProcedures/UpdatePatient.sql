-- =============================================
-- Author:		Tom Barrett
-- Create date: 2022-10-07
-- Description:	Upserts a patient, returns Id
-- =============================================
CREATE PROCEDURE UpdatePatient
	@Id INT,
	@ClinicNumber VARCHAR(16),
	@FullData VARCHAR(MAX)
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

    IF (@Id IS NULL AND COALESCE(@ClinicNumber, '') = '') 
		THROW 70001, 'Patient missing ID and Clinic Number.', 1;

	IF (COALESCE(@FullData, '') = '')
		THROW 70001, 'Patient missing full data.', 1;

	DECLARE @OldPatient TABLE (
		[Id] INT NOT NULL
	);

	INSERT INTO @OldPatient ([Id])
	SELECT [Id]
	FROM [dbo].[Patient]
	WHERE [Id] = @Id OR [ClinicNumber] = @ClinicNumber;

	DECLARE @Count INT = (SELECT COUNT(*) FROM @OldPatient);

	IF (@Count > 1)
		BEGIN
			DECLARE @ErrorMessage NVARCHAR(100) = CONCAT('Duplicate patients with Id ', @Id, ' and/or Clinic Number ', @ClinicNumber);
			THROW 70001, @ErrorMessage, 1;

		END

	DECLARE @PatientId INT;

	BEGIN TRY
		BEGIN TRANSACTION
			
			IF (@Count = 1) 
				BEGIN

					DECLARE @EditedBy VARCHAR(100) = stuff(suser_sname(),(1),charindex('\',suser_sname()),'');
					DECLARE @EditedOn DATETIME2 = GETDATE();

					UPDATE [dbo].[Patient]
					SET [ClinicNumber] = @ClinicNumber,
						[FullData] = @FullData,
						[EditedBy] = @EditedBy,
						[EditedOn] = @EditedOn
					WHERE [Id] = (SELECT TOP 1 [Id] FROM @OldPatient);

					SET @PatientId = (SELECT TOP 1 [Id] FROM @OldPatient);

				 END

			IF (@Count = 0)
				BEGIN

					INSERT INTO [dbo].[Patient] ([ClinicNumber], [FullData])
					VALUES (@ClinicNumber, @FullData);

					SET @PatientId = (SELECT SCOPE_IDENTITY());

				END

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		ROLLBACK;
		THROW 70001, 'Error updating patient, rolling back transaction.', 1;
	END CATCH

	IF @@TRANCOUNT > 0 ROLLBACK;

	SELECT @PatientId;
END
GO
