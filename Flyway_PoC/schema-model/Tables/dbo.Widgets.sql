CREATE TABLE [dbo].[Widgets]
(
[RecordID] [int] NOT NULL IDENTITY(1, 1),
[Description] [varchar] (50) NULL,
[SKU] [varchar] (20) NULL
)
GO
ALTER TABLE [dbo].[Widgets] ADD CONSTRAINT [PK_Widgets] PRIMARY KEY NONCLUSTERED ([RecordID])
GO
DENY DELETE ON  [dbo].[Widgets] TO [public]
GO
DENY INSERT ON  [dbo].[Widgets] TO [public]
GO
DENY REFERENCES ON  [dbo].[Widgets] TO [public]
GO
GRANT SELECT ON  [dbo].[Widgets] TO [public]
GO
DENY UPDATE ON  [dbo].[Widgets] TO [public]
GO
