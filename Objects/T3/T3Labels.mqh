//+------------------------------------------------------------------+
//|                                                     T3Labels.mqh |
//|                                       Copyright 2022, Gregory Jo |
//+------------------------------------------------------------------+

void createErrorLabel(string pText) {

   int    xCord = 250;
   int    yCord = 100;

   int    fontSize = 20;
   color  fontColor = clrRed;

   createLabel(ERROR_LABEL + pText, xCord, yCord, pText, fontSize, fontColor);
}
//+------------------------------------------------------------------+
