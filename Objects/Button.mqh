//+------------------------------------------------------------------+
//|                                                       Button.mqh |
//|                                       Copyright 2022, Gregory Jo |
//+------------------------------------------------------------------+

void createIsTradeableButton() {

   int xCoord = 125;
   int yCoord = 25;
   int objWidth = 100;
   int objHeight = 24;
   ENUM_BASE_CORNER  chartCorner = CORNER_RIGHT_UPPER;
   color objColor = clrBlack;
   color backgroundColor = C'236,233,216';
   color borderColor = clrNONE;
   string objText = "initial off";
   string fontFamily = "Arial";
   int fontSize = 14;
   bool objState = false;

   createButton(IS_TRADEABLE_BUTTON, xCoord, yCoord, objWidth, objHeight, chartCorner, objColor, backgroundColor, borderColor, objText, fontFamily, fontSize, objState);

}

void handleIsTradeableButton() {

   isTradabelButtonState = ObjectGetInteger(0, IS_TRADEABLE_BUTTON, OBJPROP_STATE);
   if(isTradabelButtonState == true) {
      ObjectSetString(0, IS_TRADEABLE_BUTTON, OBJPROP_TEXT, "ON");
      if(t3trendDirection == TREND_DIRECTION_LONG) ObjectSetInteger(0, IS_TRADEABLE_BUTTON, OBJPROP_COLOR, clrGreen);
      if(t3trendDirection == TREND_DIRECTION_SHORT) ObjectSetInteger(0, IS_TRADEABLE_BUTTON, OBJPROP_COLOR, clrRed);
      if(t3trendDirection == TREND_DIRECTION_ROTATION) ObjectSetInteger(0, IS_TRADEABLE_BUTTON, OBJPROP_COLOR, clrBlack);
   } else {
      ObjectSetString(0, IS_TRADEABLE_BUTTON, OBJPROP_TEXT, "OFF");
      ObjectSetInteger(0, IS_TRADEABLE_BUTTON, OBJPROP_COLOR, clrBlack);
   }
}

void setIsTradeableButtonFalse() {

   bool buttonState = false;

   ObjectSetInteger(0, IS_TRADEABLE_BUTTON, OBJPROP_STATE, buttonState);
   isTradabelButtonState = buttonState;
}
//+------------------------------------------------------------------+
