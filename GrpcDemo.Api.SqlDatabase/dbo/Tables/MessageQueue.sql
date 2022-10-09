CREATE TABLE [dbo].[MessageQueue]
(
	[Id] BIGINT IDENTITY(1,1) NOT NULL,
	[Topic] VARCHAR(100) NOT NULL,
	[DTO] VARCHAR(MAX) NOT NULL,
	[Source] VARCHAR(100) NOT NULL,
	[CreatedBy] VARCHAR(100) NOT NULL,
	[CreatedOn] DATETIME2 NOT NULL,
	CONSTRAINT [PK_MessageQueue] PRIMARY KEY CLUSTERED ([Id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MessageQueue] ADD  CONSTRAINT [DF_MessageQueue_CreatedBy]  DEFAULT (stuff(suser_sname(),(1),charindex('\',suser_sname()),'')) FOR [CreatedBy]
GO

ALTER TABLE [dbo].[MessageQueue] ADD  CONSTRAINT [DF_MessageQueue_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
