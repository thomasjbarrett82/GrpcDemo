CREATE TABLE [dbo].[Topic] /* GrpcDemo */
(
	[Id] INT IDENTITY(1,1) NOT NULL,
	[Name] VARCHAR(100) NOT NULL,
	/* TODO include a Version property to handle changes over time */
	[Description] VARCHAR(1000) NULL,
	[IsActive] BIT NOT NULL,
	[CreatedBy] VARCHAR(100) NOT NULL,
	[CreatedOn] DATETIME2 NOT NULL,
	[EditedBy] VARCHAR(100) NOT NULL,
	[EditedOn] DATETIME2 NOT NULL,
	CONSTRAINT [PK_Topic] PRIMARY KEY CLUSTERED ([Id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


ALTER TABLE [dbo].[Topic] ADD  CONSTRAINT [DF_Topic_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dbo].[Topic] ADD  CONSTRAINT [DF_Topic_CreatedBy]  DEFAULT (stuff(suser_sname(),(1),charindex('\',suser_sname()),'')) FOR [CreatedBy]
GO

ALTER TABLE [dbo].[Topic] ADD  CONSTRAINT [DF_Topic_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO

ALTER TABLE [dbo].[Topic] ADD  CONSTRAINT [DF_Topic_EditedBy]  DEFAULT (stuff(suser_sname(),(1),charindex('\',suser_sname()),'')) FOR [EditedBy]
GO

ALTER TABLE [dbo].[Topic] ADD  CONSTRAINT [DF_Topic_EditedOn]  DEFAULT (getdate()) FOR [EditedOn]
GO


CREATE NONCLUSTERED INDEX [IDX_Topic_Name] ON [dbo].[Topic]
(
	[Name] ASC,
	[IsActive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
