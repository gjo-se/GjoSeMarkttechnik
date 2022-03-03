//+------------------------------------------------------------------+
//|                                       HandleIndicatorsAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

void handleT3Indictaors() {

   ArraySetAsSeries(t3TrailingStopMABuffer, true);
   int bufferNumber = 0;
   int start = 0;
   int toCopy = 1;
   CopyBuffer(t3TrailingStopMAHandle, bufferNumber, start, toCopy, t3TrailingStopMABuffer);

}
//+------------------------------------------------------------------+
