//+------------------------------------------------------------------+
//|                                            RegressionChannel.mqh |
//|                                       Copyright 2021, Gregory Jo |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

void createT4RegressionChannel() {

    if(t4p4DateTime != 0 && t4p4DateTime < (int) TimeCurrent()){
           if(t4StartDateTime == 0) t4StartDateTime = t4p1DateTime;
           datetime endDateTime;
           (t4EndDateTime != 0) ? endDateTime = t4EndDateTime : (endDateTime = iTime(Symbol(), PERIOD_CURRENT, InpT4ChannelEndShift));

            createRegressionChannel(T4_REGRESSION_CHANNEL, t4StartDateTime, endDateTime, InpT4RegressionChannelColor, false);
    }

}

void createT4RegressionChannelLevels() {

    if(t4p4DateTime != 0 && t4p4DateTime < (int) TimeCurrent()){
           if(t4StartDateTime == 0) t4StartDateTime = t4p1DateTime;
           datetime endDateTime;
           (t4EndDateTime != 0) ? endDateTime = t4EndDateTime : endDateTime = iTime(Symbol(), PERIOD_CURRENT, InpT4ChannelEndShift);

           double   t4RegressionChannel0StartValue   = ObjectGetValueByTime(ChartID(), T4_REGRESSION_CHANNEL, t4StartDateTime, (t4trendDirection == TREND_DIRECTION_LONG) ? 1 : 2);
           int      t4RegressionChannel0StartCandle = iBarShift(Symbol(), PERIOD_M1, t4StartDateTime);
           double   t4RegressionChannel0EndValue = ObjectGetValueByTime(ChartID(), T4_REGRESSION_CHANNEL, endDateTime, (t4trendDirection == TREND_DIRECTION_LONG) ? 1 : 2);
           int      t4RegressionChannel0EndCandle = iBarShift(Symbol(), PERIOD_M1, endDateTime);
           double   t4RegressionChannel0EndTrendlineLevel = t4RegressionChannel0StartValue + ((t4RegressionChannel0EndValue - t4RegressionChannel0StartValue) / (t4RegressionChannel0StartCandle - t4RegressionChannel0EndCandle) * (t4RegressionChannel0StartCandle));
           createTrendLine(T4_REGRESSION_CHANNEL + "0", t4StartDateTime, t4RegressionChannel0StartValue, iTime(Symbol(), PERIOD_CURRENT, 0), t4RegressionChannel0EndTrendlineLevel, InpT4TrendLineColor, 2, STYLE_SOLID, " 0%");

           double   t4RegressionChannel100StartValue   = ObjectGetValueByTime(ChartID(), T4_REGRESSION_CHANNEL, t4StartDateTime, (t4trendDirection == TREND_DIRECTION_LONG) ? 2 : 1);
           int      t4RegressionChannel100StartCandle = iBarShift(Symbol(), PERIOD_M1, t4StartDateTime);
           double   t4RegressionChannel100EndValue = ObjectGetValueByTime(ChartID(), T4_REGRESSION_CHANNEL, endDateTime, (t4trendDirection == TREND_DIRECTION_LONG) ? 2 : 1);
           int      t4RegressionChannel100EndCandle = iBarShift(Symbol(), PERIOD_M1, endDateTime);
           double   t4RegressionChannel100EndTrendlineLevel = t4RegressionChannel100StartValue + ((t4RegressionChannel100EndValue - t4RegressionChannel100StartValue) / (t4RegressionChannel100StartCandle - t4RegressionChannel100EndCandle) * (t4RegressionChannel100StartCandle));
           createTrendLine(T4_REGRESSION_CHANNEL + "100", t4StartDateTime, t4RegressionChannel100StartValue, iTime(Symbol(), PERIOD_CURRENT, 0), t4RegressionChannel100EndTrendlineLevel, InpT4TrendLineColor, 2, STYLE_SOLID, " 100%");

    }


}

//void createT4RegressionChannel() {
//
//   bool isFilled = true;
//   datetime endDateTime = iTime(Symbol(), InpT4RegressionChannelTimeframe, InpT4RegressionChannelEndShift);
//
//   createRegressionChannel(T4_REGRESSION_CHANNEL, t4StartDateTime, endDateTime, InpT4RegressionChannelColor, isFilled);
//}

//void createT4RegressionChannelLevels() {
//
//   ENUM_TIMEFRAMES period = InpT4RegressionChannelTimeframe;
//   datetime endDateTime = iTime(Symbol(), period, InpT4RegressionChannelEndShift);
//
//   double   t4RegressionChannel0StartValue   = ObjectGetValueByTime(ChartID(), T4_REGRESSION_CHANNEL, t4StartDateTime, (t4trendDirection == TREND_DIRECTION_LONG) ? 1 : 2);
//   int      t4RegressionChannel0StartCandle = iBarShift(Symbol(), period, t4StartDateTime);
//   double   t4RegressionChannel0EndValue = ObjectGetValueByTime(ChartID(), T4_REGRESSION_CHANNEL, endDateTime, (t4trendDirection == TREND_DIRECTION_LONG) ? 1 : 2);
//   int      t4RegressionChannel0EndCandle = iBarShift(Symbol(), period, endDateTime);
//   double   t4RegressionChannel0EndTrendlineLevel = t4RegressionChannel0StartValue + ((t4RegressionChannel0EndValue - t4RegressionChannel0StartValue) / (t4RegressionChannel0StartCandle - t4RegressionChannel0EndCandle) * (t4RegressionChannel0StartCandle));
//   createTrendLine(T4_REGRESSION_CHANNEL + "0", t4StartDateTime, t4RegressionChannel0StartValue, iTime(Symbol(), PERIOD_CURRENT, 0), t4RegressionChannel0EndTrendlineLevel, InpT4TrendLineColor, 2, STYLE_SOLID, " 0%");
//
//   double   t4RegressionChannel100StartValue   = ObjectGetValueByTime(ChartID(), T4_REGRESSION_CHANNEL, t4StartDateTime, (t4trendDirection == TREND_DIRECTION_LONG) ? 2 : 1);
//   int      t4RegressionChannel100StartCandle = iBarShift(Symbol(), period, t4StartDateTime);
//   double   t4RegressionChannel100EndValue = ObjectGetValueByTime(ChartID(), T4_REGRESSION_CHANNEL, endDateTime, (t4trendDirection == TREND_DIRECTION_LONG) ? 2 : 1);
//   int      t4RegressionChannel100EndCandle = iBarShift(Symbol(), period, endDateTime);
//   double   t4RegressionChannel100EndTrendlineLevel = t4RegressionChannel100StartValue + ((t4RegressionChannel100EndValue - t4RegressionChannel100StartValue) / (t4RegressionChannel100StartCandle - t4RegressionChannel100EndCandle) * (t4RegressionChannel100StartCandle));
//   createTrendLine(T4_REGRESSION_CHANNEL + "100", t4StartDateTime, t4RegressionChannel100StartValue, iTime(Symbol(), PERIOD_CURRENT, 0), t4RegressionChannel100EndTrendlineLevel, InpT4TrendLineColor, 2, STYLE_SOLID, " 100%");
//
//   double level = 50;
//   double t4TrendlineStartValue = t4RegressionChannel0StartValue + (t4RegressionChannel100StartValue - t4RegressionChannel0StartValue) / 100 * level  ;
//   double t4TrendlineEndValue   = t4RegressionChannel0EndTrendlineLevel + (t4RegressionChannel100EndTrendlineLevel - t4RegressionChannel0EndTrendlineLevel) / 100 * level;
//   int    lineWidth = 2;
//   color  levelColor = InpT4TrendLineColor;
//   ENUM_LINE_STYLE style = STYLE_SOLID;
//   createTrendLine(T4_REGRESSION_CHANNEL + DoubleToString(level, 1), t4StartDateTime, t4TrendlineStartValue, iTime(Symbol(), PERIOD_CURRENT, 0), t4TrendlineEndValue, levelColor, lineWidth, style, " " + DoubleToString(level, 1) + "%");
//
//   if(InpT4StopLossOnRegressionChannelLevel != 0) {
//      level = InpT4StopLossOnRegressionChannelLevel;
//      t4TrendlineStartValue = t4RegressionChannel0StartValue + (t4RegressionChannel100StartValue - t4RegressionChannel0StartValue) / 100 * level  ;
//      t4TrendlineEndValue   = t4RegressionChannel0EndTrendlineLevel + (t4RegressionChannel100EndTrendlineLevel - t4RegressionChannel0EndTrendlineLevel) / 100 * level;
//      lineWidth = 2;
//      levelColor = InpT4TrendLineColor;
//      style = STYLE_SOLID;
//      createTrendLine(T4_TRAILING_STOP_LINE, t4StartDateTime, t4TrendlineStartValue, iTime(Symbol(), PERIOD_CURRENT, 0), t4TrendlineEndValue, levelColor, lineWidth, style, " " + DoubleToString(level, 1) + "%" + T4_TRAILING_STOP_LINE);
//   }
//}
