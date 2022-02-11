//+------------------------------------------------------------------+
//|                                                 AlertActions.mqh |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

void handleScreenshotAction() {

   string screenShotName = Symbol() + "-" + (string)(int)TimeCurrent() + ".png";
   int    width = 1000;
   int    heigth = 800;
   if(!ChartScreenShot(ChartID(), screenShotName, width, heigth)) {
      Alert("konnte Screenshot nicht erstellen" + screenShotName);
   }

}
//+------------------------------------------------------------------+
