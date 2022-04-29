//+------------------------------------------------------------------+
//|                                                       Button.mqh |
//|                                       Copyright 2022, Gregory Jo |
//+------------------------------------------------------------------+

void createT3AutoButton() {

   int xCoord = 125;
   int yCoord = 60;
   int objWidth = 100;
   int objHeight = 24;
   ENUM_BASE_CORNER  chartCorner = CORNER_RIGHT_UPPER;
   color objColor = clrBlack;
   color backgroundColor = C'236,233,216';
   color borderColor = clrNONE;
   string objText = "T3 Auto off";
   string fontFamily = "Arial";
   int fontSize = 14;
   bool objState = false;

   createButton(T3_AUTO_BUTTON, xCoord, yCoord, objWidth, objHeight, chartCorner, objColor, backgroundColor, borderColor, objText, fontFamily, fontSize, objState);

}

void handleT3AutoButton() {

   t3AutoButtonState = ObjectGetInteger(ChartID(), T3_AUTO_BUTTON, OBJPROP_STATE);
   if(t3AutoButtonState == true) {
      ObjectSetString(0, T3_AUTO_BUTTON, OBJPROP_TEXT, "T3 Auto ON");
      ObjectSetInteger(0, T3_AUTO_BUTTON, OBJPROP_BGCOLOR, clrGreen);
   } else {
      ObjectSetString(0, T3_AUTO_BUTTON, OBJPROP_TEXT, "T3 Auto OFF");
      ObjectSetInteger(0, T3_AUTO_BUTTON, OBJPROP_BGCOLOR, clrGray);
   }
}
