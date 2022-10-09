CREATE TABLE [dbo].[Subscriber] /* GrpcDemo */
(
	[Id] INT IDENTITY(1,1) NOT NULL,
	[Name] VARCHAR(100) NOT NULL,
	[Host] VARCHAR(1000) NULL,
	[IsActive] BIT NOT NULL,
	[CreatedBy] VARCHAR(100) NOT NULL,
	[CreatedOn] DATETIME2 NOT NULL,
	[EditedBy] VARCHAR(100) NOT NULL,
	[EditedOn] DATETIME2 NOT NULL,
	CONSTRAINT [PK_Subscriber] PRIMARY KEY CLUSTERED ([Id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO



ALTER TABLE [dbo].[Subscriber] ADD  CONSTRAINT [DF_Subscriber_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dbo].[Subscriber] ADD  CONSTRAINT [DF_Subscriber_CreatedBy]  DEFAULT (stuff(suser_sname(),(1),charindex('\',suser_sname()),'')) FOR [CreatedBy]
GO

ALTER TABLE [dbo].[Subscriber] ADD  CONSTRAINT [DF_Subscriber_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO

ALTER TABLE [dbo].[Subscriber] ADD  CONSTRAINT [DF_Subscriber_EditedBy]  DEFAULT (stuff(suser_sname(),(1),charindex('\',suser_sname()),'')) FOR [EditedBy]
GO

ALTER TABLE [dbo].[Subscriber] ADD  CONSTRAINT [DF_Subscriber_EditedOn]  DEFAULT (getdate()) FOR [EditedOn]
GO


CREATE NONCLUSTERED INDEX [IDX_Subscriber_Name] ON [dbo].[Subscriber]
(
	[Name] ASC,
	[IsActive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO