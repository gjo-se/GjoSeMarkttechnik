//+------------------------------------------------------------------+
//|                                                 AlertActions.mqh |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

void handleScreenshotAction() {
//   if(buyT3PositionIsOpenState || sellT3PositionIsOpenState) createScreenshot();
//   if(allT3BuyPositionsAreClosedState || allT3SellPositionsAreClosedState) createScreenshot();
}
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void createScreenshot(string pScreenShotText = "") {
   string dateOnly = StringSubstr((string)TimeCurrent(), 0, StringLen((string)TimeCurrent()) - 9);
   string screenShotName = "Screenshots/" + Symbol() + "/" + pScreenShotText + "-" + dateOnly + ".png";
   int    width = 1000;
   int    heigth = 800;
   if(!ChartScreenShot(ChartID(), screenShotName, width, heigth)) {
      Alert("konnte Screenshot nicht erstellen" + screenShotName);
   }
}
//+------------------------------------------------------------------+
