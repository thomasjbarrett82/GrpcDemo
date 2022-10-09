CREATE TABLE [dbo].[Patient] /* PatientDemo */
(
	[Id] BIGINT IDENTITY(1,1) NOT NULL, 
	[ClinicNumber] VARCHAR(16) NOT NULL,
	[FullData] VARCHAR(MAX) NOT NULL, /* full JSON data model */
	[CreatedBy] VARCHAR(100) NOT NULL,
	[CreatedOn] DATETIME2 NOT NULL,
	[EditedBy] VARCHAR(100) NOT NULL,
	[EditedOn] DATETIME2 NOT NULL,
	CONSTRAINT [PK_Patient] PRIMARY KEY CLUSTERED ([Id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


ALTER TABLE [dbo].[Patient] ADD  CONSTRAINT [DF_Patient_CreatedBy]  DEFAULT (stuff(suser_sname(),(1),charindex('\',suser_sname()),'')) FOR [CreatedBy]
GO

ALTER TABLE [dbo].[Patient] ADD  CONSTRAINT [DF_Patient_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO

ALTER TABLE [dbo].[Patient] ADD  CONSTRAINT [DF_Patient_EditedBy]  DEFAULT (stuff(suser_sname(),(1),charindex('\',suser_sname()),'')) FOR [EditedBy]
GO

ALTER TABLE [dbo].[Patient] ADD  CONSTRAINT [DF_Patient_EditedOn]  DEFAULT (getdate()) FOR [EditedOn]
GO


CREATE NONCLUSTERED INDEX [IDX_Patient_ClinicNumber] ON [dbo].[Patient]
(
	[ClinicNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
