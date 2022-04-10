//+------------------------------------------------------------------+
//|                                          TTRegressionChannel.mqh |
//|                                       Copyright 2021, Gregory Jo |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void createTT2RegressionChannel() {

   bool isFilled = false;

   datetime endDateTime = TimeCurrent();
   if(tt2p3DateTime != 0) endDateTime = tt2p3DateTime;
   if(tt2p4DateTime != 0) endDateTime = tt2p4DateTime;
   if(tt2p5DateTime != 0) endDateTime = tt2p5DateTime;
   if(tt2p6DateTime != 0) endDateTime = tt2p6DateTime;

   if(tt2p1DateTime != 0 && tt2p3DateTime != 0 ) {
      createRegressionChannel(TT2_REGRESSION_CHANNEL, tt2p1DateTime, endDateTime, InpT2DefaultColor, isFilled, InpT2LineStyle, InpT2LineWidth);
      ObjectSetInteger(ChartID(), TT2_REGRESSION_CHANNEL, OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);
   }
}

void createTT3RegressionChannel() {

   bool isFilled = false;

   if(tt3p1DateTime != 0 && tt3p6DateTime != 0 ) {
      createRegressionChannel(TT3_REGRESSION_CHANNEL, tt3p1DateTime, tt3p6DateTime, InpT3DefaultColor, isFilled, InpT3LineStyle, InpT3LineWidth);
      ObjectSetInteger(ChartID(), TT3_REGRESSION_CHANNEL, OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);
   }
}

void createTT4RegressionChannel() {

   bool isFilled = false;

   if(tt4p1DateTime != 0 && tt4p6DateTime != 0 ) {
      createRegressionChannel(TT4_REGRESSION_CHANNEL, tt4p1DateTime, tt4p6DateTime, InpT4DefaultColor, isFilled, InpT4LineStyle, InpT4LineWidth);
      ObjectSetInteger(ChartID(), TT4_REGRESSION_CHANNEL, OBJPROP_TIMEFRAMES, InpT4VisibleTimeframes);
   }
}
//+------------------------------------------------------------------+
