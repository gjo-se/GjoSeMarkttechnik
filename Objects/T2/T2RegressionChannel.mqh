//+------------------------------------------------------------------+
//|                                            RegressionChannel.mqh |
//|                                       Copyright 2021, Gregory Jo |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

void createT2RegressionChannel() {

   bool isFilled = false;

   datetime startDateTime = t2p1DateTime;
   if(t2StartDateTime != 0) startDateTime = t2StartDateTime;

   datetime endDateTime = TimeCurrent();
   if(t2p3DateTime != 0) endDateTime = t2p3DateTime;
   if(t2p4DateTime != 0) endDateTime = t2p4DateTime;
   if(t2p5DateTime != 0) endDateTime = t2p5DateTime;
   if(t2EndDateTime != 0) endDateTime = t2EndDateTime;

   if(startDateTime != 0 && endDateTime != 0 ) {
      createRegressionChannel(T2_REGRESSION_CHANNEL, startDateTime, endDateTime, InpT2DefaultColor, isFilled, InpT2LineStyle, InpT2LineWidth);
      ObjectSetInteger(ChartID(), T2_REGRESSION_CHANNEL, OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);
   }else{
      deleteRegressionChannel(T2_REGRESSION_CHANNEL);
   }
}

void createT2RegressionChannelLevels() {

   int thinLineWidth = 1;

   if(t2p1DateTime != 0 && t2p3DateTime != 0) {

      datetime startDateTime = t2p1DateTime;
      if(t2StartDateTime != 0) startDateTime = t2StartDateTime;

      datetime endDateTime = iTime(Symbol(), PERIOD_CURRENT, InpT2ChannelEndShift);
      if(t2EndDateTime != 0) endDateTime = t2EndDateTime;

      double   t2RegressionChannel0StartValue   = ObjectGetValueByTime(ChartID(), T2_REGRESSION_CHANNEL, startDateTime, (t2trendDirection == TREND_DIRECTION_LONG) ? 1 : 2);
      double   t2RegressionChannel0EndValue = ObjectGetValueByTime(ChartID(), T2_REGRESSION_CHANNEL, endDateTime, (t2trendDirection == TREND_DIRECTION_LONG) ? 1 : 2);
      createTrendLine(T2_REGRESSION_CHANNEL + "0", startDateTime, t2RegressionChannel0StartValue, endDateTime, t2RegressionChannel0EndValue, InpT2DefaultColor, InpT2LineWidth, InpT2LineStyle, "   0%");
      ObjectSetInteger(ChartID(), T2_REGRESSION_CHANNEL + "0", OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);

      double   t2RegressionChannel100StartValue = ObjectGetValueByTime(ChartID(), T2_REGRESSION_CHANNEL, startDateTime, (t2trendDirection == TREND_DIRECTION_LONG) ? 2 : 1);
      double   t2RegressionChannel100EndValue = ObjectGetValueByTime(ChartID(), T2_REGRESSION_CHANNEL, endDateTime, (t2trendDirection == TREND_DIRECTION_LONG) ? 2 : 1);
      createTrendLine(T2_REGRESSION_CHANNEL + "100", startDateTime, t2RegressionChannel100StartValue, endDateTime, t2RegressionChannel100EndValue, InpT2DefaultColor, InpT2LineWidth, InpT2LineStyle, "   100%");
      ObjectSetInteger(ChartID(), T2_REGRESSION_CHANNEL + "100", OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);

      double t2RegressionChannel25StartValue = t2RegressionChannel0StartValue + (t2RegressionChannel100StartValue - t2RegressionChannel0StartValue) / 4;
      double t2RegressionChannel25EndValue   = t2RegressionChannel0EndValue + (t2RegressionChannel100EndValue - t2RegressionChannel0EndValue) / 4;
      createTrendLine(T2_REGRESSION_CHANNEL + "25", startDateTime, t2RegressionChannel25StartValue, endDateTime, t2RegressionChannel25EndValue, InpT2DefaultColor, thinLineWidth, InpT2LineStyle, "   25%");
      ObjectSetInteger(ChartID(), T2_REGRESSION_CHANNEL + "25", OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);

      double t2RegressionChannel50StartValue = t2RegressionChannel0StartValue + (t2RegressionChannel100StartValue - t2RegressionChannel0StartValue) / 2  ;
      double t2RegressionChannel50EndValue   = t2RegressionChannel0EndValue + (t2RegressionChannel100EndValue - t2RegressionChannel0EndValue) / 2;
      createTrendLine(T2_REGRESSION_CHANNEL + "50", startDateTime, t2RegressionChannel50StartValue, endDateTime, t2RegressionChannel50EndValue, InpT2DefaultColor, thinLineWidth, InpT2LineStyle, "   50%");
      ObjectSetInteger(ChartID(), T2_REGRESSION_CHANNEL + "50", OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);

      double t2RegressionChannel75StartValue = t2RegressionChannel0StartValue + (t2RegressionChannel100StartValue - t2RegressionChannel0StartValue) / 4 * 3;
      double t2RegressionChannel75EndValue   = t2RegressionChannel0EndValue + (t2RegressionChannel100EndValue - t2RegressionChannel0EndValue) / 4 * 3;
      createTrendLine(T2_REGRESSION_CHANNEL + "75", startDateTime, t2RegressionChannel75StartValue, endDateTime, t2RegressionChannel75EndValue, InpT2DefaultColor, thinLineWidth, InpT2LineStyle, "   75%");
      ObjectSetInteger(ChartID(), T2_REGRESSION_CHANNEL + "75", OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);
   }else{
      deleteTrendLineLike(T2_REGRESSION_CHANNEL);
   }
}
//+------------------------------------------------------------------+
