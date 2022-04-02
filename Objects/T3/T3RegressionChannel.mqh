//+------------------------------------------------------------------+
//|                                            RegressionChannel.mqh |
//|                                       Copyright 2021, Gregory Jo |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

void createT3RegressionChannel() {

   if(t3StartDateTime == 0) t3StartDateTime = t3p1DateTime;
   datetime endDateTime;
   (t3EndDateTime != 0) ? endDateTime = t3EndDateTime : (endDateTime = iTime(Symbol(), PERIOD_CURRENT, InpT3ChannelEndShift));

   createRegressionChannel(T3_REGRESSION_CHANNEL, t3StartDateTime, endDateTime, InpT3RegressionChannelColor, false);
}

void createT3RegressionChannelLevels() {

   if(t3StartDateTime == 0) t3StartDateTime = t3p1DateTime;
   datetime endDateTime;
   (t3EndDateTime != 0) ? endDateTime = t3EndDateTime : endDateTime = iTime(Symbol(), PERIOD_CURRENT, InpT3ChannelEndShift);

   double   t3RegressionChannel0StartValue   = ObjectGetValueByTime(ChartID(), T3_REGRESSION_CHANNEL, t3StartDateTime, (t3trendDirection == TREND_DIRECTION_LONG) ? 1 : 2);
   int      t3RegressionChannel0StartCandle = iBarShift(Symbol(), Period(), t3StartDateTime);
   double   t3RegressionChannel0EndValue = ObjectGetValueByTime(ChartID(), T3_REGRESSION_CHANNEL, endDateTime, (t3trendDirection == TREND_DIRECTION_LONG) ? 1 : 2);
   int      t3RegressionChannel0EndCandle = iBarShift(Symbol(), Period(), endDateTime);
   double   t3RegressionChannel0EndTrendlineLevel = t3RegressionChannel0StartValue + ((t3RegressionChannel0EndValue - t3RegressionChannel0StartValue) / (t3RegressionChannel0StartCandle - t3RegressionChannel0EndCandle) * (t3RegressionChannel0StartCandle));
   createTrendLine(T3_REGRESSION_CHANNEL + "0", t3StartDateTime, t3RegressionChannel0StartValue, iTime(Symbol(), PERIOD_CURRENT, 0), t3RegressionChannel0EndTrendlineLevel, InpT3TrendLineColor, 2, STYLE_SOLID, " 0%");

   double   t3RegressionChannel100StartValue = ObjectGetValueByTime(ChartID(), T3_REGRESSION_CHANNEL, t3StartDateTime, (t3trendDirection == TREND_DIRECTION_LONG) ? 2 : 1);
   int      t3RegressionChannel100StartCandle = iBarShift(Symbol(), Period(), t3StartDateTime);
   double   t3RegressionChannel100EndValue = ObjectGetValueByTime(ChartID(), T3_REGRESSION_CHANNEL, endDateTime, (t3trendDirection == TREND_DIRECTION_LONG) ? 2 : 1);
   int      t3RegressionChannel100EndCandle = iBarShift(Symbol(), Period(), endDateTime);
   double   t3RegressionChannel100EndTrendlineLevel = t3RegressionChannel100StartValue + ((t3RegressionChannel100EndValue - t3RegressionChannel100StartValue) / (t3RegressionChannel100StartCandle - t3RegressionChannel100EndCandle) * (t3RegressionChannel100StartCandle));
   createTrendLine(T3_REGRESSION_CHANNEL + "100", t3StartDateTime, t3RegressionChannel100StartValue, iTime(Symbol(), PERIOD_CURRENT, 0), t3RegressionChannel100EndTrendlineLevel, InpT3TrendLineColor, 2, STYLE_SOLID, " 100%");

   double t3RegressionChannel50StartValue = t3RegressionChannel0StartValue + (t3RegressionChannel100StartValue - t3RegressionChannel0StartValue) / 2  ;
   double t3RegressionChannel50EndValue   = t3RegressionChannel0EndTrendlineLevel + (t3RegressionChannel100EndTrendlineLevel - t3RegressionChannel0EndTrendlineLevel) / 2;
   createTrendLine(T3_REGRESSION_CHANNEL + "50", t3StartDateTime, t3RegressionChannel50StartValue, iTime(Symbol(), PERIOD_CURRENT, 0), t3RegressionChannel50EndValue, InpT3TrendLineColor, 1, STYLE_SOLID, " 50%");
}