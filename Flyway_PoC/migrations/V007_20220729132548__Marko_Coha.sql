﻿SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Altering [dbo].[Customers]'
GO
ALTER TABLE [dbo].[Customers] ADD
[Address] [nvarchar] (500) NULL
GO
EXEC sp_rename N'[dbo].[Customers].[D]', N'ID', N'COLUMN'
GO
