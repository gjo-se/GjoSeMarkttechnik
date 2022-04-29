//+------------------------------------------------------------------+
//|                                            RegressionChannel.mqh |
//|                                       Copyright 2021, Gregory Jo |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

void createT4RegressionChannel() {

   bool isFilled = false;

   datetime startDateTime = t4p1DateTime;
   if(t4StartDateTime != 0) startDateTime = t4StartDateTime;
   datetime endDateTime = TimeCurrent();
   if(t4EndDateTime != 0) endDateTime = t4EndDateTime;

   if(startDateTime != 0 && endDateTime != 0 ) {
      createRegressionChannel(T4_REGRESSION_CHANNEL, startDateTime, endDateTime, InpT4DefaultColor, isFilled, InpT4LineStyle, InpT4LineWidth);
      ObjectSetInteger(ChartID(), T4_REGRESSION_CHANNEL, OBJPROP_TIMEFRAMES, InpT4VisibleTimeframes);
   }else{
      deleteRegressionChannel(T4_REGRESSION_CHANNEL);
   }
}

void createT4RegressionChannelLevels() {

   int thinLineWidth = 1;

   if(t4p1DateTime != 0 && t4p3DateTime != 0) {

      datetime startDateTime = t4p1DateTime;
      if(t4StartDateTime != 0) startDateTime = t4StartDateTime;
      datetime endDateTime = iTime(Symbol(), PERIOD_CURRENT, InpT4ChannelEndShift);
      if(t4EndDateTime != 0) endDateTime = t4EndDateTime;

      double   t4RegressionChannel0StartValue   = ObjectGetValueByTime(ChartID(), T4_REGRESSION_CHANNEL, startDateTime, (t4trendDirection == TREND_DIRECTION_LONG) ? 1 : 2);
      double   t4RegressionChannel0EndValue = ObjectGetValueByTime(ChartID(), T4_REGRESSION_CHANNEL, endDateTime, (t4trendDirection == TREND_DIRECTION_LONG) ? 1 : 2);
      createTrendLine(T4_REGRESSION_CHANNEL + "0", startDateTime, t4RegressionChannel0StartValue, endDateTime, t4RegressionChannel0EndValue, InpT4DefaultColor, InpT4LineWidth, InpT4LineStyle, "   0%");
      ObjectSetInteger(ChartID(), T4_REGRESSION_CHANNEL + "0", OBJPROP_TIMEFRAMES, InpT4VisibleTimeframes);

      double   t4RegressionChannel100StartValue = ObjectGetValueByTime(ChartID(), T4_REGRESSION_CHANNEL, startDateTime, (t4trendDirection == TREND_DIRECTION_LONG) ? 2 : 1);
      double   t4RegressionChannel100EndValue = ObjectGetValueByTime(ChartID(), T4_REGRESSION_CHANNEL, endDateTime, (t4trendDirection == TREND_DIRECTION_LONG) ? 2 : 1);
      createTrendLine(T4_REGRESSION_CHANNEL + "100", startDateTime, t4RegressionChannel100StartValue, endDateTime, t4RegressionChannel100EndValue, InpT4DefaultColor, InpT4LineWidth, InpT4LineStyle, "   100%");
      ObjectSetInteger(ChartID(), T4_REGRESSION_CHANNEL + "100", OBJPROP_TIMEFRAMES, InpT4VisibleTimeframes);

      double t4RegressionChannel25StartValue = t4RegressionChannel0StartValue + (t4RegressionChannel100StartValue - t4RegressionChannel0StartValue) / 4;
      double t4RegressionChannel25EndValue   = t4RegressionChannel0EndValue + (t4RegressionChannel100EndValue - t4RegressionChannel0EndValue) / 4;
      createTrendLine(T4_REGRESSION_CHANNEL + "25", startDateTime, t4RegressionChannel25StartValue, endDateTime, t4RegressionChannel25EndValue, InpT4DefaultColor, thinLineWidth, InpT4LineStyle, "   25%");
      ObjectSetInteger(ChartID(), T4_REGRESSION_CHANNEL + "25", OBJPROP_TIMEFRAMES, InpT4VisibleTimeframes);

      double t4RegressionChannel50StartValue = t4RegressionChannel0StartValue + (t4RegressionChannel100StartValue - t4RegressionChannel0StartValue) / 2  ;
      double t4RegressionChannel50EndValue   = t4RegressionChannel0EndValue + (t4RegressionChannel100EndValue - t4RegressionChannel0EndValue) / 2;
      createTrendLine(T4_REGRESSION_CHANNEL + "50", startDateTime, t4RegressionChannel50StartValue, endDateTime, t4RegressionChannel50EndValue, InpT4DefaultColor, thinLineWidth, InpT4LineStyle, "   50%");
      ObjectSetInteger(ChartID(), T4_REGRESSION_CHANNEL + "50", OBJPROP_TIMEFRAMES, InpT4VisibleTimeframes);

      double t4RegressionChannel75StartValue = t4RegressionChannel0StartValue + (t4RegressionChannel100StartValue - t4RegressionChannel0StartValue) / 4 * 3;
      double t4RegressionChannel75EndValue   = t4RegressionChannel0EndValue + (t4RegressionChannel100EndValue - t4RegressionChannel0EndValue) / 4 * 3;
      createTrendLine(T4_REGRESSION_CHANNEL + "75", startDateTime, t4RegressionChannel75StartValue, endDateTime, t4RegressionChannel75EndValue, InpT4DefaultColor, thinLineWidth, InpT4LineStyle, "   75%");
      ObjectSetInteger(ChartID(), T4_REGRESSION_CHANNEL + "75", OBJPROP_TIMEFRAMES, InpT4VisibleTimeframes);
   }else{
      deleteTrendLineLike(T4_REGRESSION_CHANNEL);
   }
}
//+------------------------------------------------------------------+
