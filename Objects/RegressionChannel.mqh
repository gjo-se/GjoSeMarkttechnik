//+------------------------------------------------------------------+
//|                                            RegressionChannel.mqh |
//|                                       Copyright 2021, Gregory Jo |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

void createT3RegressionChannel() {

    if(t3StartDateTime == 0) t3StartDateTime = t3p1DateTime;
    if(t3EndDateTime == 0) t3EndDateTime = iTime(Symbol(), PERIOD_CURRENT, InpT3ChannelEndShift);

    createRegressionChannel(T3_REGRESSION_CHANNEL, t3StartDateTime, t3EndDateTime, InpT3RegressionChannelColor, true);
}

void createT3RegressionChannelLevels() {

    if(t3StartDateTime == 0) t3StartDateTime = t3p1DateTime;
    if(t3EndDateTime == 0) t3EndDateTime = iTime(Symbol(), PERIOD_CURRENT, InpT3ChannelEndShift);

    double   t3RegressionChannel0StartValue   = ObjectGetValueByTime(ChartID(), T3_REGRESSION_CHANNEL, t3StartDateTime, (t3trendDirection == TREND_DIRECTION_LONG) ? 1 : 2);
    int      t3RegressionChannel0StartCandle = iBarShift(Symbol(), Period(), t3StartDateTime);
    double   t3RegressionChannel0EndValue = ObjectGetValueByTime(ChartID(), T3_REGRESSION_CHANNEL, t3EndDateTime, (t3trendDirection == TREND_DIRECTION_LONG) ? 1 : 2);
    int      t3RegressionChannel0EndCandle = iBarShift(Symbol(), Period(), t3EndDateTime);
    double   t3RegressionChannel0EndTrendlineLevel = t3RegressionChannel0StartValue + ((t3RegressionChannel0EndValue - t3RegressionChannel0StartValue) / (t3RegressionChannel0StartCandle - t3RegressionChannel0EndCandle) * (t3RegressionChannel0StartCandle));
    createTrendLine(T3_REGRESSION_CHANNEL + "0", t3StartDateTime, t3RegressionChannel0StartValue, iTime(Symbol(), PERIOD_CURRENT, 0), t3RegressionChannel0EndTrendlineLevel, InpT3FiboLevelsColor, 2, STYLE_SOLID, " 0%");

    double   t3RegressionChannel100StartValue   = ObjectGetValueByTime(ChartID(), T3_REGRESSION_CHANNEL, t3StartDateTime, (t3trendDirection == TREND_DIRECTION_LONG) ? 2 : 1);
    int      t3RegressionChannel100StartCandle = iBarShift(Symbol(), Period(), t3StartDateTime);
    double   t3RegressionChannel100EndValue = ObjectGetValueByTime(ChartID(), T3_REGRESSION_CHANNEL, t3EndDateTime, (t3trendDirection == TREND_DIRECTION_LONG) ? 2 : 1);
    int      t3RegressionChannel100EndCandle = iBarShift(Symbol(), Period(), t3EndDateTime);
    double   t3RegressionChannel100EndTrendlineLevel = t3RegressionChannel100StartValue + ((t3RegressionChannel100EndValue - t3RegressionChannel100StartValue) / (t3RegressionChannel100StartCandle - t3RegressionChannel100EndCandle) * (t3RegressionChannel100StartCandle));
    createTrendLine(T3_REGRESSION_CHANNEL + "100", t3StartDateTime, t3RegressionChannel100StartValue, iTime(Symbol(), PERIOD_CURRENT, 0), t3RegressionChannel100EndTrendlineLevel, InpT3FiboLevelsColor, 2, STYLE_SOLID, " 100%");

   for( int t3FiboLevelsId = 0; t3FiboLevelsId < ArraySize(t3FiboLevelsArray); t3FiboLevelsId++) {
      double level = (double)t3FiboLevelsArray[t3FiboLevelsId];
      double t3TrendlineStartValue = t3RegressionChannel0StartValue + (t3RegressionChannel100StartValue - t3RegressionChannel0StartValue) / 100 * level  ;
      double t3TrendlineEndValue   = t3RegressionChannel0EndTrendlineLevel + (t3RegressionChannel100EndTrendlineLevel - t3RegressionChannel0EndTrendlineLevel) / 100 * level;
      int    lineWidth = 1;
      color  levelColor = InpT3FiboLevelsColor;
      ENUM_LINE_STYLE style = STYLE_SOLID;

      if(level == InpT3AlertOnRegressionChannelLevel && InpT3AlertOn == true) {
        lineWidth = 1;
        style = STYLE_DASH;
        levelColor = InpT3MinMaxRegressionColor;
        alertRegressionChannelLevel = t3TrendlineEndValue;
      }

      if(level == InpT3MinRegressionChannelLevel || level == InpT3MaxRegressionChannelLevel) {
        lineWidth = 2;
        levelColor = InpT3MinMaxRegressionColor;
      }

      createTrendLine(T3_REGRESSION_CHANNEL + DoubleToString(level, 1), t3StartDateTime, t3TrendlineStartValue, iTime(Symbol(), PERIOD_CURRENT, 0), t3TrendlineEndValue, levelColor, lineWidth, style, " " + DoubleToString(level, 1) + "%");
   }
}

void deleteRegressionChannelObject(const string pDimension) {

   long chartId = ChartID();
   int objectsTotal = ObjectsTotal(chartId, 0, -1);

   string objectName;
   for(int i = objectsTotal; i >= 0; i--) {
      objectName = ObjectName(chartId, i);
      if ( StringFind(objectName, pDimension) != -1 ) {
         ObjectDelete(chartId, objectName);
      }
   }
}
//+------------------------------------------------------------------+
