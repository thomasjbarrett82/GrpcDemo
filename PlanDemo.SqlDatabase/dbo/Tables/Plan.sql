CREATE TABLE [dbo].[Plan] /* PlanDemo */
(
	[Id] BIGINT IDENTITY(1,1) NOT NULL, 
	[ClinicNumber] VARCHAR(16) NOT NULL,
	[FullData] VARCHAR(MAX) NOT NULL, /* full JSON data model */
	[CreatedBy] VARCHAR(100) NOT NULL,
	[CreatedOn] DATETIME2 NOT NULL,
	[EditedBy] VARCHAR(100) NOT NULL,
	[EditedOn] DATETIME2 NOT NULL,
	CONSTRAINT [PK_Plan] PRIMARY KEY CLUSTERED ([Id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


ALTER TABLE [dbo].[Plan] ADD  CONSTRAINT [DF_Plan_CreatedBy]  DEFAULT (stuff(suser_sname(),(1),charindex('\',suser_sname()),'')) FOR [CreatedBy]
GO

ALTER TABLE [dbo].[Plan] ADD  CONSTRAINT [DF_Plan_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO

ALTER TABLE [dbo].[Plan] ADD  CONSTRAINT [DF_Plan_EditedBy]  DEFAULT (stuff(suser_sname(),(1),charindex('\',suser_sname()),'')) FOR [EditedBy]
GO

ALTER TABLE [dbo].[Plan] ADD  CONSTRAINT [DF_Plan_EditedOn]  DEFAULT (getdate()) FOR [EditedOn]
GO


CREATE NONCLUSTERED INDEX [IDX_Plan_ClinicNumber] ON [dbo].[Plan]
(
	[ClinicNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
