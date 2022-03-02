//+------------------------------------------------------------------+
//|                                       HandleIndicatorsAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

void handleT3Indictaors() {

   ArraySetAsSeries(trailingStopMABuffer, true);
   int bufferNumber = 0;
   int start = 0;
   int toCopy = 1;
   CopyBuffer(trailingStopMAHandle, bufferNumber, start, toCopy, trailingStopMABuffer);

}
//+------------------------------------------------------------------+
