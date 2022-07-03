//+------------------------------------------------------------------+
//|                                            RegressionChannel.mqh |
//|                                       Copyright 2021, Gregory Jo |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

void createT3RegressionChannel() {

   bool isFilled = false;
   int  visbility = 0;

   datetime startDateTime = t3p1DateTime;
   if(t3StartDateTime != 0) startDateTime = t3StartDateTime;

   datetime endDateTime = iTime(Symbol(), PERIOD_CURRENT, InpT3ChannelEndShift);
   if(t3EndDateTime != 0) endDateTime = t3EndDateTime;

   if(startDateTime != 0 && endDateTime != 0 ) {
      createRegressionChannel(T3_REGRESSION_CHANNEL, startDateTime, endDateTime, InpT3DefaultColor, isFilled, InpT3LineStyle, InpT3LineWidth);
      ObjectSetInteger(ChartID(), T3_REGRESSION_CHANNEL, OBJPROP_TIMEFRAMES, visbility);
   } else {
      deleteRegressionChannel(T3_REGRESSION_CHANNEL);
   }
}

void createT3RegressionChannelLevels() {

   int thinLineWidth = 1;

   if(t3p1DateTime != 0 && t3p3DateTime != 0) {

      datetime startDateTime = t3p1DateTime;
      if(t3StartDateTime != 0) startDateTime = t3StartDateTime;
      datetime endDateTime = iTime(Symbol(), PERIOD_CURRENT, InpT3ChannelEndShift);
      if(t3EndDateTime != 0) endDateTime = t3EndDateTime;

      double   t3RegressionChannel0StartValue   = ObjectGetValueByTime(ChartID(), T3_REGRESSION_CHANNEL, startDateTime, (t3trendDirection == TREND_DIRECTION_LONG) ? 1 : 2);
      double   t3RegressionChannel0EndValue = ObjectGetValueByTime(ChartID(), T3_REGRESSION_CHANNEL, endDateTime, (t3trendDirection == TREND_DIRECTION_LONG) ? 1 : 2);
      createTrendLine(T3_REGRESSION_CHANNEL + "0", startDateTime, t3RegressionChannel0StartValue, endDateTime, t3RegressionChannel0EndValue, InpT3DefaultColor, InpT3LineWidth, InpT3LineStyle, "   0%");
      ObjectSetInteger(ChartID(), T3_REGRESSION_CHANNEL + "0", OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);

      double   t3RegressionChannel100StartValue = ObjectGetValueByTime(ChartID(), T3_REGRESSION_CHANNEL, startDateTime, (t3trendDirection == TREND_DIRECTION_LONG) ? 2 : 1);
      double   t3RegressionChannel100EndValue = ObjectGetValueByTime(ChartID(), T3_REGRESSION_CHANNEL, endDateTime, (t3trendDirection == TREND_DIRECTION_LONG) ? 2 : 1);
      createTrendLine(T3_REGRESSION_CHANNEL + "100", startDateTime, t3RegressionChannel100StartValue, endDateTime, t3RegressionChannel100EndValue, InpT3DefaultColor, InpT3LineWidth, InpT3LineStyle, "   100%");
      ObjectSetInteger(ChartID(), T3_REGRESSION_CHANNEL + "100", OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);

      double t3RegressionChannel25StartValue = t3RegressionChannel0StartValue + (t3RegressionChannel100StartValue - t3RegressionChannel0StartValue) / 4;
      double t3RegressionChannel25EndValue   = t3RegressionChannel0EndValue + (t3RegressionChannel100EndValue - t3RegressionChannel0EndValue) / 4;
      createTrendLine(T3_REGRESSION_CHANNEL + "25", startDateTime, t3RegressionChannel25StartValue, endDateTime, t3RegressionChannel25EndValue, InpT3DefaultColor, thinLineWidth, InpT3LineStyle, "   25%");
      ObjectSetInteger(ChartID(), T3_REGRESSION_CHANNEL + "25", OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);

      double t3RegressionChannel50StartValue = t3RegressionChannel0StartValue + (t3RegressionChannel100StartValue - t3RegressionChannel0StartValue) / 2  ;
      double t3RegressionChannel50EndValue   = t3RegressionChannel0EndValue + (t3RegressionChannel100EndValue - t3RegressionChannel0EndValue) / 2;
      createTrendLine(T3_REGRESSION_CHANNEL + "50", startDateTime, t3RegressionChannel50StartValue, endDateTime, t3RegressionChannel50EndValue, InpT3DefaultColor, thinLineWidth, InpT3LineStyle, "   50%");
      ObjectSetInteger(ChartID(), T3_REGRESSION_CHANNEL + "50", OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);

      double t3RegressionChannel75StartValue = t3RegressionChannel0StartValue + (t3RegressionChannel100StartValue - t3RegressionChannel0StartValue) / 4 * 3;
      double t3RegressionChannel75EndValue   = t3RegressionChannel0EndValue + (t3RegressionChannel100EndValue - t3RegressionChannel0EndValue) / 4 * 3;
      createTrendLine(T3_REGRESSION_CHANNEL + "75", startDateTime, t3RegressionChannel75StartValue, endDateTime, t3RegressionChannel75EndValue, InpT3DefaultColor, thinLineWidth, InpT3LineStyle, "   75%");
      ObjectSetInteger(ChartID(), T3_REGRESSION_CHANNEL + "75", OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);

      double t3RegressionChannelMiddleStartValue   = ObjectGetValueByTime(ChartID(), T3_REGRESSION_CHANNEL, startDateTime, 0);
      double t3RegressionChannelMinAverageStartValue = t3RegressionChannelMiddleStartValue - (tt3RegressionChannelWidthAveragePoints * Point());
      double t3RegressionChannelMaxAverageStartValue = t3RegressionChannelMiddleStartValue + (tt3RegressionChannelWidthAveragePoints * Point());
      double t3RegressionChannelMiddleEndValue   = ObjectGetValueByTime(ChartID(), T3_REGRESSION_CHANNEL, endDateTime, 0);
      double t3RegressionChannelMinAverageEndValue = t3RegressionChannelMiddleEndValue - (tt3RegressionChannelWidthAveragePoints * Point());
      double t3RegressionChannelMaxAverageEndValue = t3RegressionChannelMiddleEndValue + (tt3RegressionChannelWidthAveragePoints * Point());
      createTrendLine(T3_REGRESSION_CHANNEL + "AverageMin", startDateTime, t3RegressionChannelMinAverageStartValue, endDateTime, t3RegressionChannelMinAverageEndValue, clrMaroon, InpT3LineWidth, InpT3LineStyle, "   AVG");
      ObjectSetInteger(ChartID(), T3_REGRESSION_CHANNEL + "AverageMin", OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);
      createTrendLine(T3_REGRESSION_CHANNEL + "AverageMax", startDateTime, t3RegressionChannelMaxAverageStartValue, endDateTime, t3RegressionChannelMaxAverageEndValue, clrMaroon, InpT3LineWidth, InpT3LineStyle, "   AVG");
      ObjectSetInteger(ChartID(), T3_REGRESSION_CHANNEL + "AverageMax", OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);

   } else {
      deleteTrendLineLike(T3_REGRESSION_CHANNEL);
   }
}
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
