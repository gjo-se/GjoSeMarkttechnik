//+------------------------------------------------------------------+
//|                                     T4HandleIndicatorsAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

void handleT4Indictaors() {

   ArraySetAsSeries(t4TrailingStopMABuffer, true);
   int bufferNumber = 0;
   int start = 0;
   int toCopy = 1;
   CopyBuffer(t4TrailingStopMAHandle, bufferNumber, start, toCopy, t4TrailingStopMABuffer);

}
//+------------------------------------------------------------------+
