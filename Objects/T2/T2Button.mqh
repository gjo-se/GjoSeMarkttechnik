//+------------------------------------------------------------------+
//|                                                       Button.mqh |
//|                                       Copyright 2022, Gregory Jo |
//+------------------------------------------------------------------+

void createT2AutoButton() {

   int xCoord = 125;
   int yCoord = 30;
   int objWidth = 100;
   int objHeight = 24;
   ENUM_BASE_CORNER  chartCorner = CORNER_RIGHT_UPPER;
   color objColor = clrBlack;
   color backgroundColor = C'236,233,216';
   color borderColor = clrNONE;
   string objText = "T2 Auto off";
   string fontFamily = "Arial";
   int fontSize = 12;
   bool objState = false;

   createButton(T2_AUTO_BUTTON, xCoord, yCoord, objWidth, objHeight, chartCorner, objColor, backgroundColor, borderColor, objText, fontFamily, fontSize, objState);

}

void handleT2AutoButton() {

   t2AutoButtonState = ObjectGetInteger(ChartID(), T2_AUTO_BUTTON, OBJPROP_STATE);
   if(t2AutoButtonState == true) {
      ObjectSetString(0, T2_AUTO_BUTTON, OBJPROP_TEXT, "T2 Auto ON");
      ObjectSetInteger(0, T2_AUTO_BUTTON, OBJPROP_BGCOLOR, clrGreen);
   } else {
      ObjectSetString(0, T2_AUTO_BUTTON, OBJPROP_TEXT, "T2 Auto OFF");
      ObjectSetInteger(0, T2_AUTO_BUTTON, OBJPROP_BGCOLOR, clrGray);
   }
}

void createT2TMPButton() {

   int xCoord = 230;
   int yCoord = 30;
   int objWidth = 100;
   int objHeight = 24;
   ENUM_BASE_CORNER  chartCorner = CORNER_RIGHT_UPPER;
   color objColor = clrBlack;
   color backgroundColor = C'236,233,216';
   color borderColor = clrNONE;
   string objText = "TMP-2";
   string fontFamily = "Arial";
   int fontSize = 12;
   bool objState = false;

   createButton(T2_TMP_BUTTON, xCoord, yCoord, objWidth, objHeight, chartCorner, objColor, backgroundColor, borderColor, objText, fontFamily, fontSize, objState);

}

void handleT2TMPButton() {

   t2TMPButtonState = ObjectGetInteger(ChartID(), T2_TMP_BUTTON, OBJPROP_STATE);
   if(t2TMPButtonState == true) {
      ObjectSetString(0, T2_TMP_BUTTON, OBJPROP_TEXT, "TMP-2 ON");
      ObjectSetInteger(0, T2_TMP_BUTTON, OBJPROP_BGCOLOR, clrGreen);
   } else {
      ObjectSetString(0, T2_TMP_BUTTON, OBJPROP_TEXT, "TMP-2 OFF");
      ObjectSetInteger(0, T2_TMP_BUTTON, OBJPROP_BGCOLOR, clrGray);
   }
}