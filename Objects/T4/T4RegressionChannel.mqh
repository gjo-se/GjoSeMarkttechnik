//+------------------------------------------------------------------+
//|                                            RegressionChannel.mqh |
//|                                       Copyright 2021, Gregory Jo |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

void createT4RegressionChannel() {

   if(t4p4DateTime != 0 && t4p4DateTime < (int) TimeCurrent()) {
      bool isFilled = false;

      datetime startDateTime;
      (t4StartDateTime != 0) ? startDateTime = t4StartDateTime : startDateTime = t4p1DateTime;
      datetime endDateTime;
      (t4EndDateTime != 0) ? endDateTime = t4EndDateTime : (endDateTime = iTime(Symbol(), PERIOD_CURRENT, InpT4ChannelEndShift));

      createRegressionChannel(T4_REGRESSION_CHANNEL, startDateTime, endDateTime, InpT4RegressionChannelColor, isFilled, InpT4LineStyle, InpT4LineWidth);
      ObjectSetInteger(ChartID(), T4_REGRESSION_CHANNEL, OBJPROP_TIMEFRAMES, InpT4VisibleTimeframes);
   }
}

void createT4RegressionChannelLevels() {

   if(t4p4DateTime != 0 && t4p4DateTime < (int) TimeCurrent()) {
//           if(t4StartDateTime == 0) t4StartDateTime = t4p1DateTime;
      datetime endDateTime;
      (t4EndDateTime != 0) ? endDateTime = t4EndDateTime : endDateTime = iTime(Symbol(), PERIOD_CURRENT, InpT4ChannelEndShift);

      double   t4RegressionChannel0StartValue   = ObjectGetValueByTime(ChartID(), T4_REGRESSION_CHANNEL, t4StartDateTime, (t4trendDirection == TREND_DIRECTION_LONG) ? 1 : 2);
      int      t4RegressionChannel0StartCandle = iBarShift(Symbol(), PERIOD_M1, t4StartDateTime);
      double   t4RegressionChannel0EndValue = ObjectGetValueByTime(ChartID(), T4_REGRESSION_CHANNEL, endDateTime, (t4trendDirection == TREND_DIRECTION_LONG) ? 1 : 2);
      int      t4RegressionChannel0EndCandle = iBarShift(Symbol(), PERIOD_M1, endDateTime);
      double   t4RegressionChannel0EndTrendlineLevel = t4RegressionChannel0StartValue + ((t4RegressionChannel0EndValue - t4RegressionChannel0StartValue) / (t4RegressionChannel0StartCandle - t4RegressionChannel0EndCandle) * (t4RegressionChannel0StartCandle));
//           createTrendLine(T4_REGRESSION_CHANNEL + "0", t4StartDateTime, t4RegressionChannel0StartValue, iTime(Symbol(), PERIOD_CURRENT, 0), t4RegressionChannel0EndTrendlineLevel, InpT4TrendLineColor, 2, STYLE_SOLID, " 0%");

      double   t4RegressionChannel100StartValue   = ObjectGetValueByTime(ChartID(), T4_REGRESSION_CHANNEL, t4StartDateTime, (t4trendDirection == TREND_DIRECTION_LONG) ? 2 : 1);
      int      t4RegressionChannel100StartCandle = iBarShift(Symbol(), PERIOD_M1, t4StartDateTime);
      double   t4RegressionChannel100EndValue = ObjectGetValueByTime(ChartID(), T4_REGRESSION_CHANNEL, endDateTime, (t4trendDirection == TREND_DIRECTION_LONG) ? 2 : 1);
      int      t4RegressionChannel100EndCandle = iBarShift(Symbol(), PERIOD_M1, endDateTime);
      double   t4RegressionChannel100EndTrendlineLevel = t4RegressionChannel100StartValue + ((t4RegressionChannel100EndValue - t4RegressionChannel100StartValue) / (t4RegressionChannel100StartCandle - t4RegressionChannel100EndCandle) * (t4RegressionChannel100StartCandle));
//           createTrendLine(T4_REGRESSION_CHANNEL + "100", t4StartDateTime, t4RegressionChannel100StartValue, iTime(Symbol(), PERIOD_CURRENT, 0), t4RegressionChannel100EndTrendlineLevel, InpT4TrendLineColor, 2, STYLE_SOLID, " 100%");

   }
}
