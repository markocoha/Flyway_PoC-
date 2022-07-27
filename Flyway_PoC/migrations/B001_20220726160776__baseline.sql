SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Creating [dbo].[Widgets]'
GO
CREATE TABLE [dbo].[Widgets]
(
[RecordID] [int] NOT NULL IDENTITY(1, 1),
[Description] [varchar] (50) NULL,
[SKU] [varchar] (20) NULL
)
GO
PRINT N'Creating primary key [PK_Widgets] on [dbo].[Widgets]'
GO
ALTER TABLE [dbo].[Widgets] ADD CONSTRAINT [PK_Widgets] PRIMARY KEY NONCLUSTERED ([RecordID])
GO
PRINT N'Creating [dbo].[WidgetPrices]'
GO
CREATE TABLE [dbo].[WidgetPrices]
(
[RecordID] [int] NOT NULL IDENTITY(1, 1),
[WidgetID] [int] NULL,
[Price] [money] NULL,
[DateValidFrom] [datetime] NULL CONSTRAINT [DF_WidgetPrices_DateValidFrom] DEFAULT (getdate()),
[DateValidTo] [datetime] NULL,
[Active] [char] (1) NULL CONSTRAINT [DF_WidgetPrices_Active] DEFAULT ('N')
)
GO
PRINT N'Creating primary key [PK_WidgetPrices] on [dbo].[WidgetPrices]'
GO
ALTER TABLE [dbo].[WidgetPrices] ADD CONSTRAINT [PK_WidgetPrices] PRIMARY KEY NONCLUSTERED ([RecordID])
GO
PRINT N'Creating index [IX_WidgetPrices_1] on [dbo].[WidgetPrices]'
GO
CREATE NONCLUSTERED INDEX [IX_WidgetPrices_1] ON [dbo].[WidgetPrices] ([DateValidFrom])
GO
PRINT N'Creating index [IX_WidgetPrices_2] on [dbo].[WidgetPrices]'
GO
CREATE NONCLUSTERED INDEX [IX_WidgetPrices_2] ON [dbo].[WidgetPrices] ([DateValidTo])
GO
PRINT N'Creating index [IX_WidgetPrices] on [dbo].[WidgetPrices]'
GO
CREATE NONCLUSTERED INDEX [IX_WidgetPrices] ON [dbo].[WidgetPrices] ([WidgetID])
GO
PRINT N'Creating [dbo].[CurrentPrices]'
GO
 
CREATE VIEW [dbo].[CurrentPrices]
AS
SELECT WidgetPrices.WidgetID, WidgetPrices.Price, 
    Widgets.Description
FROM dbo.Widgets INNER JOIN
    dbo.WidgetPrices ON 
    dbo.Widgets.RecordID = dbo.WidgetPrices.WidgetID
WHERE dbo.WidgetPrices.Active = 'Y'
 
GO
PRINT N'Creating [dbo].[prcActivatePrices]'
GO
 
CREATE PROCEDURE [dbo].[prcActivatePrices]  AS
 
UPDATE WidgetPrices SET Active='N' WHERE GetDate()<DateValidTo OR GetDate()>DateValidFrom
UPDATE WidgetPrices SET Active='Y' WHERE GetDate()>=DateValidFrom OR GetDate()<=DateValidFrom
 
 
GO
PRINT N'Creating [dbo].[WidgetDescriptions]'
GO
CREATE TABLE [dbo].[WidgetDescriptions]
(
[WidgetID] [int] NOT NULL IDENTITY(1, 1),
[Description] [varchar] (500) NULL,
[WidgetName] [varchar] (50) NULL
)
GO
PRINT N'Creating [dbo].[WidgetReferences]'
GO
CREATE TABLE [dbo].[WidgetReferences]
(
[WidgetID] [int] NOT NULL,
[Reference] [varchar] (50) NULL
)
GO
PRINT N'Creating primary key [PK_WidgetReferences] on [dbo].[WidgetReferences]'
GO
ALTER TABLE [dbo].[WidgetReferences] ADD CONSTRAINT [PK_WidgetReferences] PRIMARY KEY NONCLUSTERED ([WidgetID])
GO
PRINT N'Adding foreign keys to [dbo].[WidgetPrices]'
GO
ALTER TABLE [dbo].[WidgetPrices] ADD CONSTRAINT [FK_WidgetPrices_Widgets] FOREIGN KEY ([WidgetID]) REFERENCES [dbo].[Widgets] ([RecordID])
GO
PRINT N'Altering permissions on  [dbo].[WidgetPrices]'
GO
DENY DELETE ON  [dbo].[WidgetPrices] TO [public]
GO
DENY INSERT ON  [dbo].[WidgetPrices] TO [public]
GO
DENY REFERENCES ON  [dbo].[WidgetPrices] TO [public]
GO
GRANT SELECT ON  [dbo].[WidgetPrices] TO [public]
GO
DENY UPDATE ON  [dbo].[WidgetPrices] TO [public]
GO
PRINT N'Altering permissions on  [dbo].[Widgets]'
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
PRINT N'Altering permissions on  [dbo].[prcActivatePrices]'
GO
DENY EXECUTE ON  [dbo].[prcActivatePrices] TO [public]
GO
PRINT N'Altering permissions on  [dbo].[CurrentPrices]'
GO
DENY DELETE ON  [dbo].[CurrentPrices] TO [public]
GO
DENY INSERT ON  [dbo].[CurrentPrices] TO [public]
GO
GRANT SELECT ON  [dbo].[CurrentPrices] TO [public]
GO
DENY UPDATE ON  [dbo].[CurrentPrices] TO [public]
GO
