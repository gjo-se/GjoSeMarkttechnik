//+------------------------------------------------------------------+
//|                                          TTRegressionChannel.mqh |
//|                                       Copyright 2021, Gregory Jo |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void createTT2RegressionChannel() {

   bool isFilled = false;

   datetime startDateTime = tt2p1DateTime;
   if(tt2StartDateTime != 0) startDateTime = tt2StartDateTime;

   datetime endDateTime = tt2p3DateTime;
   if(tt2p4DateTime != 0) endDateTime = tt2p4DateTime;
   if(tt2p5DateTime != 0) endDateTime = tt2p5DateTime;
   if(tt2p6DateTime != 0) endDateTime = tt2p6DateTime;
   if(tt2EndDateTime != 0) endDateTime = tt2EndDateTime;

   if(startDateTime != 0 && endDateTime != 0 ) {
      createRegressionChannel(TT2_REGRESSION_CHANNEL, startDateTime, endDateTime, InpT2DefaultColor, isFilled, InpT2LineStyle, InpT2LineWidth);
      ObjectSetInteger(ChartID(), TT2_REGRESSION_CHANNEL, OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);
   }
}

void createTT3RegressionChannel() {

   bool isFilled = false;

   datetime startDateTime = tt3p1DateTime;
   if(tt3StartDateTime != 0) startDateTime = tt3StartDateTime;

   datetime endDateTime = tt3p3DateTime;
   if(tt3p4DateTime != 0) endDateTime = tt3p4DateTime;
   if(tt3p5DateTime != 0) endDateTime = tt3p5DateTime;
   if(tt3p6DateTime != 0) endDateTime = tt3p6DateTime;
   if(tt3EndDateTime != 0) endDateTime = tt3EndDateTime;
      
   if(startDateTime != 0 && endDateTime != 0 ) {
      createRegressionChannel(TT3_REGRESSION_CHANNEL, startDateTime, endDateTime, InpT3DefaultColor, isFilled, InpT3LineStyle, InpT3LineWidth);
      ObjectSetInteger(ChartID(), TT3_REGRESSION_CHANNEL, OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);
   }
}

void createTT4RegressionChannel() {

   bool isFilled = false;
   
   datetime startDateTime = tt4p1DateTime;
   if(tt4StartDateTime != 0) startDateTime = tt4StartDateTime;

   datetime endDateTime = tt4p3DateTime;
   if(tt4p4DateTime != 0) endDateTime = tt4p4DateTime;
   if(tt4p5DateTime != 0) endDateTime = tt4p5DateTime;
   if(tt4p6DateTime != 0) endDateTime = tt4p6DateTime;
   if(tt4EndDateTime != 0) endDateTime = tt4EndDateTime;   

   if(startDateTime != 0 && endDateTime != 0 ) {
      createRegressionChannel(TT4_REGRESSION_CHANNEL, startDateTime, endDateTime, InpT4DefaultColor, isFilled, InpT4LineStyle, InpT4LineWidth);
      ObjectSetInteger(ChartID(), TT4_REGRESSION_CHANNEL, OBJPROP_TIMEFRAMES, InpT4VisibleTimeframes);
   }
}
//+------------------------------------------------------------------+
