SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Altering [dbo].[Testing_table]'
GO
ALTER TABLE [dbo].[Testing_table] ADD
[Testing3] [nvarchar] (50) NULL
GO
