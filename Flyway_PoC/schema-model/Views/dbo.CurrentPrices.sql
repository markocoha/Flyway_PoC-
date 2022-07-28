SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
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
DENY DELETE ON  [dbo].[CurrentPrices] TO [public]
GO
DENY INSERT ON  [dbo].[CurrentPrices] TO [public]
GO
GRANT SELECT ON  [dbo].[CurrentPrices] TO [public]
GO
DENY UPDATE ON  [dbo].[CurrentPrices] TO [public]
GO
