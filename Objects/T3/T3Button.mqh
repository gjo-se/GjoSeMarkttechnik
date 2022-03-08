//+------------------------------------------------------------------+
//|                                                       Button.mqh |
//|                                       Copyright 2022, Gregory Jo |
//+------------------------------------------------------------------+

void createT3IsTradeableButton() {

   int xCoord = 250;
   int yCoord = 25;
   int objWidth = 100;
   int objHeight = 24;
   ENUM_BASE_CORNER  chartCorner = CORNER_RIGHT_UPPER;
   color objColor = clrBlack;
   color backgroundColor = C'236,233,216';
   color borderColor = clrNONE;
   string objText = "T3 initial off";
   string fontFamily = "Arial";
   int fontSize = 14;
   bool objState = false;

   createButton(T3_IS_TRADEABLE_BUTTON, xCoord, yCoord, objWidth, objHeight, chartCorner, objColor, backgroundColor, borderColor, objText, fontFamily, fontSize, objState);

}

void handleT3IsTradeableButton() {

   t3IsTradabelButtonState = ObjectGetInteger(0, T3_IS_TRADEABLE_BUTTON, OBJPROP_STATE);
   if(t3IsTradabelButtonState == true) {
      ObjectSetString(0, T3_IS_TRADEABLE_BUTTON, OBJPROP_TEXT, "T3 ON");
      if(t3trendDirection == TREND_DIRECTION_LONG) ObjectSetInteger(0, T3_IS_TRADEABLE_BUTTON, OBJPROP_BGCOLOR, clrGreen);
      if(t3trendDirection == TREND_DIRECTION_SHORT) ObjectSetInteger(0, T3_IS_TRADEABLE_BUTTON, OBJPROP_BGCOLOR, clrRed);
      if(t3trendDirection == TREND_DIRECTION_ROTATION) ObjectSetInteger(0, T3_IS_TRADEABLE_BUTTON, OBJPROP_BGCOLOR, clrGray);
   } else {
      ObjectSetString(0, T3_IS_TRADEABLE_BUTTON, OBJPROP_TEXT, "T3 OFF");
      ObjectSetInteger(0, T3_IS_TRADEABLE_BUTTON, OBJPROP_BGCOLOR, clrGray);
   }
}

void setT3IsTradeableButtonFalse() {

   bool buttonState = false;

   ObjectSetInteger(0, T3_IS_TRADEABLE_BUTTON, OBJPROP_STATE, buttonState);
   t3IsTradabelButtonState = buttonState;
}
//+------------------------------------------------------------------+
