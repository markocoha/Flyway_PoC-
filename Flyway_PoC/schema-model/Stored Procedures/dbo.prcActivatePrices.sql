SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
CREATE PROCEDURE [dbo].[prcActivatePrices]  AS
 
UPDATE WidgetPrices SET Active='N' WHERE GetDate()<DateValidTo OR GetDate()>DateValidFrom
UPDATE WidgetPrices SET Active='Y' WHERE GetDate()>=DateValidFrom OR GetDate()<=DateValidFrom
 
 
GO
DENY EXECUTE ON  [dbo].[prcActivatePrices] TO [public]
GO
