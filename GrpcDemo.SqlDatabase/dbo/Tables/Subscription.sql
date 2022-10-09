CREATE TABLE [dbo].[Subscription] /* GrpcDemo */
(
	[Id] INT IDENTITY(1,1) NOT NULL,
	[TopicId] INT NOT NULL,
	[SubscriberId] INT NOT NULL,
	[IsActive] BIT NOT NULL,
	[CreatedBy] VARCHAR(100) NOT NULL,
	[CreatedOn] DATETIME2 NOT NULL,
	[EditedBy] VARCHAR(100) NOT NULL,
	[EditedOn] DATETIME2 NOT NULL,
	CONSTRAINT [PK_Subscription] PRIMARY KEY CLUSTERED ([Id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


ALTER TABLE [dbo].[Subscription] ADD  CONSTRAINT [DF_Subscription_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dbo].[Subscription] ADD  CONSTRAINT [DF_Subscription_CreatedBy]  DEFAULT (stuff(suser_sname(),(1),charindex('\',suser_sname()),'')) FOR [CreatedBy]
GO

ALTER TABLE [dbo].[Subscription] ADD  CONSTRAINT [DF_Subscription_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO

ALTER TABLE [dbo].[Subscription] ADD  CONSTRAINT [DF_Subscription_EditedBy]  DEFAULT (stuff(suser_sname(),(1),charindex('\',suser_sname()),'')) FOR [EditedBy]
GO

ALTER TABLE [dbo].[Subscription] ADD  CONSTRAINT [DF_Subscription_EditedOn]  DEFAULT (getdate()) FOR [EditedOn]
GO


ALTER TABLE [Subscription] ADD CONSTRAINT [FK_Subscription_Subscriber]
FOREIGN KEY ([SubscriberId]) REFERENCES [Subscriber]([Id])
GO

ALTER TABLE [Subscription] ADD CONSTRAINT [FK_Subscription_Topic]
FOREIGN KEY ([TopicId]) REFERENCES [Topic]([Id])
GO


CREATE NONCLUSTERED INDEX [IDX_Subscription_Topic] ON [dbo].[Subscription]
(
	[TopicId] ASC,
	[IsActive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IDX_Subscription_Subscriber] ON [dbo].[Subscription]
(
	[SubscriberId] ASC,
	[IsActive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO