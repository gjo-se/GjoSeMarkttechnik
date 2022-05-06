//+------------------------------------------------------------------+
//|                                                       Button.mqh |
//|                                       Copyright 2022, Gregory Jo |
//+------------------------------------------------------------------+

void createT4IsTradeableButton() {

   int xCoord = 125;
   int yCoord = 120;
   int objWidth = 100;
   int objHeight = 24;
   ENUM_BASE_CORNER  chartCorner = CORNER_RIGHT_UPPER;
   color objColor = clrBlack;
   color backgroundColor = C'236,233,216';
   color borderColor = clrNONE;
   string objText = "T4 Trade off";
   string fontFamily = "Arial";
   int fontSize = 14;
   bool objState = false;

   createButton(T4_IS_TRADEABLE_BUTTON, xCoord, yCoord, objWidth, objHeight, chartCorner, objColor, backgroundColor, borderColor, objText, fontFamily, fontSize, objState);

}

void handleT4IsTradeableButton() {

   t4IsTradabelButtonState = ObjectGetInteger(0, T4_IS_TRADEABLE_BUTTON, OBJPROP_STATE);
   if(t4IsTradabelButtonState == true) {
      ObjectSetString(0, T4_IS_TRADEABLE_BUTTON, OBJPROP_TEXT, "T4 Trade ON");
      if(t4trendDirection == TREND_DIRECTION_LONG) ObjectSetInteger(0, T4_IS_TRADEABLE_BUTTON, OBJPROP_BGCOLOR, clrGreen);
      if(t4trendDirection == TREND_DIRECTION_SHORT) ObjectSetInteger(0, T4_IS_TRADEABLE_BUTTON, OBJPROP_BGCOLOR, clrRed);
      if(t4trendDirection == TREND_DIRECTION_ROTATION) ObjectSetInteger(0, T4_IS_TRADEABLE_BUTTON, OBJPROP_BGCOLOR, clrGray);
   } else {
      ObjectSetString(0, T4_IS_TRADEABLE_BUTTON, OBJPROP_TEXT, "T4 Trade OFF");
      ObjectSetInteger(0, T4_IS_TRADEABLE_BUTTON, OBJPROP_BGCOLOR, clrGray);
   }
}

void t4DisableTradeableButton(string pReason) {

   bool buttonState = false;

   ObjectSetInteger(0, T4_IS_TRADEABLE_BUTTON, OBJPROP_STATE, buttonState);
   t4IsTradabelButtonState = buttonState;
   handleT4IsTradeableButton();
   if(t4AlertDisableTradeableButtonSended == false) t4AlertDisableTradeableButtonAction(pReason);
}
//+------------------------------------------------------------------+

void createT4AutoButton() {

   int xCoord = 125;
   int yCoord = 90;
   int objWidth = 100;
   int objHeight = 24;
   ENUM_BASE_CORNER  chartCorner = CORNER_RIGHT_UPPER;
   color objColor = clrBlack;
   color backgroundColor = C'236,233,216';
   color borderColor = clrNONE;
   string objText = "T4 Auto off";
   string fontFamily = "Arial";
   int fontSize = 14;
   bool objState = false;

   createButton(T4_AUTO_BUTTON, xCoord, yCoord, objWidth, objHeight, chartCorner, objColor, backgroundColor, borderColor, objText, fontFamily, fontSize, objState);

}

void handleT4AutoButton() {

   t4AutoButtonState = ObjectGetInteger(ChartID(), T4_AUTO_BUTTON, OBJPROP_STATE);
   if(t4AutoButtonState == true) {
      ObjectSetString(0, T4_AUTO_BUTTON, OBJPROP_TEXT, "T4 Auto ON");
      ObjectSetInteger(0, T4_AUTO_BUTTON, OBJPROP_BGCOLOR, clrGreen);
   } else {
      ObjectSetString(0, T4_AUTO_BUTTON, OBJPROP_TEXT, "T4 Auto OFF");
      ObjectSetInteger(0, T4_AUTO_BUTTON, OBJPROP_BGCOLOR, clrGray);
   }
}