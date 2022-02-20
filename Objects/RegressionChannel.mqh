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

   createRegressionChannel(T3_REGRESSION_CHANNEL, t3StartDateTime, endDateTime, InpT3RegressionChannelColor, true);
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
   createTrendLine(T3_REGRESSION_CHANNEL + "0", t3StartDateTime, t3RegressionChannel0StartValue, iTime(Symbol(), PERIOD_CURRENT, 0), t3RegressionChannel0EndTrendlineLevel, InpT3FiboLevelsColor, 2, STYLE_SOLID, " 0%");

   double   t3RegressionChannel100StartValue   = ObjectGetValueByTime(ChartID(), T3_REGRESSION_CHANNEL, t3StartDateTime, (t3trendDirection == TREND_DIRECTION_LONG) ? 2 : 1);
   int      t3RegressionChannel100StartCandle = iBarShift(Symbol(), Period(), t3StartDateTime);
   double   t3RegressionChannel100EndValue = ObjectGetValueByTime(ChartID(), T3_REGRESSION_CHANNEL, endDateTime, (t3trendDirection == TREND_DIRECTION_LONG) ? 2 : 1);
   int      t3RegressionChannel100EndCandle = iBarShift(Symbol(), Period(), endDateTime);
   double   t3RegressionChannel100EndTrendlineLevel = t3RegressionChannel100StartValue + ((t3RegressionChannel100EndValue - t3RegressionChannel100StartValue) / (t3RegressionChannel100StartCandle - t3RegressionChannel100EndCandle) * (t3RegressionChannel100StartCandle));
   createTrendLine(T3_REGRESSION_CHANNEL + "100", t3StartDateTime, t3RegressionChannel100StartValue, iTime(Symbol(), PERIOD_CURRENT, 0), t3RegressionChannel100EndTrendlineLevel, InpT3FiboLevelsColor, 2, STYLE_SOLID, " 100%");

   for( int t3FiboLevelsId = 0; t3FiboLevelsId < ArraySize(t3FiboLevelsArray); t3FiboLevelsId++) {
      double level = (double)t3FiboLevelsArray[t3FiboLevelsId];
      double t3TrendlineStartValue = t3RegressionChannel0StartValue + (t3RegressionChannel100StartValue - t3RegressionChannel0StartValue) / 100 * level  ;
      double t3TrendlineEndValue   = t3RegressionChannel0EndTrendlineLevel + (t3RegressionChannel100EndTrendlineLevel - t3RegressionChannel0EndTrendlineLevel) / 100 * level;
      int    lineWidth = 1;
      color  levelColor = InpT3FiboLevelsColor;
      ENUM_LINE_STYLE style = STYLE_SOLID;

      if(level == InpT3AlertOnRegressionChannelLevel && (InpT3AlertOnRegressionChannelLevel != 0 || InpT3AlertOnFiboRetracmentLevel != 0 )) {
         lineWidth = 1;
         style = STYLE_DASH;
         levelColor = InpT3MinMaxRegressionColor;
         alertRegressionChannelLevel = t3TrendlineEndValue;
      }

      if(level == InpT3MinRegressionChannelLevel) {

         lineWidth = 2;
         levelColor = InpT3MinMaxRegressionColor;

         if(t3trendDirection == TREND_DIRECTION_LONG) {
            t3InSignalRegressionChannelAreaMaxStartValue = ObjectGetValueByTime(ChartID(), T3_REGRESSION_CHANNEL + DoubleToString(level, 1), t3p4DateTime);
            t3InSignalRegressionChannelAreaMaxEndValue = t3TrendlineEndValue;
         } else {
            t3InSignalRegressionChannelAreaMinStartValue = ObjectGetValueByTime(ChartID(), T3_REGRESSION_CHANNEL + DoubleToString(level, 1), t3p4DateTime);
            t3InSignalRegressionChannelAreaMinEndValue = t3TrendlineEndValue;
         }
      }
      if(level == InpT3MaxRegressionChannelLevel) {

         lineWidth = 2;
         levelColor = InpT3MinMaxRegressionColor;

         if(t3trendDirection == TREND_DIRECTION_LONG) {
            t3InSignalRegressionChannelAreaMinStartValue = ObjectGetValueByTime(ChartID(), T3_REGRESSION_CHANNEL + DoubleToString(level, 1), t3p4DateTime);
            t3InSignalRegressionChannelAreaMinEndValue = t3TrendlineEndValue;
         } else {
            t3InSignalRegressionChannelAreaMaxStartValue = ObjectGetValueByTime(ChartID(), T3_REGRESSION_CHANNEL + DoubleToString(level, 1), t3p4DateTime);
            t3InSignalRegressionChannelAreaMaxEndValue = t3TrendlineEndValue;
         }
      }
      if(InpT3MinReEntryRegressionChannelLevel != 0 && level == InpT3MinReEntryRegressionChannelLevel) {

         lineWidth = 2;
         levelColor = InpT3ReEntryMinRegressionColor;

         if(t3trendDirection == TREND_DIRECTION_LONG) {
            reEntryAreaMinStartValue = t3InSignalRegressionChannelAreaMinStartValue;
            reEntryAreaMinEndValue = t3InSignalRegressionChannelAreaMinEndValue;
            reEntryAreaMaxStartValue = ObjectGetValueByTime(ChartID(), T3_REGRESSION_CHANNEL + DoubleToString(level, 1), t3p4DateTime);
            reEntryAreaMaxEndValue = t3TrendlineEndValue;
         } else {
            reEntryAreaMinStartValue = ObjectGetValueByTime(ChartID(), T3_REGRESSION_CHANNEL + DoubleToString(level, 1), t3p4DateTime);
            reEntryAreaMinEndValue = t3TrendlineEndValue;
            reEntryAreaMaxStartValue = t3InSignalRegressionChannelAreaMaxStartValue;
            reEntryAreaMaxEndValue = t3InSignalRegressionChannelAreaMaxEndValue;
         }
      }

      createTrendLine(T3_REGRESSION_CHANNEL + DoubleToString(level, 1), t3StartDateTime, t3TrendlineStartValue, iTime(Symbol(), PERIOD_CURRENT, 0), t3TrendlineEndValue, levelColor, lineWidth, style, " " + DoubleToString(level, 1) + "%");
   }
}

void createT4RegressionChannel() {

   bool isFilled = true;
   datetime endDateTime = iTime(Symbol(), InpT4RegressionChannelTimeframe, InpT4RegressionChannelEndShift);

   createRegressionChannel(T4_REGRESSION_CHANNEL, t4StartDateTime, endDateTime, InpT4RegressionChannelColor, isFilled);
}

void createT4RegressionChannelLevels() {

   ENUM_TIMEFRAMES period = InpT4RegressionChannelTimeframe;
   datetime endDateTime = iTime(Symbol(), period, InpT4RegressionChannelEndShift);

   double   t4RegressionChannel0StartValue   = ObjectGetValueByTime(ChartID(), T4_REGRESSION_CHANNEL, t4StartDateTime, (t3trendDirection == TREND_DIRECTION_LONG) ? 1 : 2);
   int      t4RegressionChannel0StartCandle = iBarShift(Symbol(), period, t4StartDateTime);
   double   t4RegressionChannel0EndValue = ObjectGetValueByTime(ChartID(), T4_REGRESSION_CHANNEL, endDateTime, (t3trendDirection == TREND_DIRECTION_LONG) ? 1 : 2);
   int      t4RegressionChannel0EndCandle = iBarShift(Symbol(), period, endDateTime);
   double   t4RegressionChannel0EndTrendlineLevel = t4RegressionChannel0StartValue + ((t4RegressionChannel0EndValue - t4RegressionChannel0StartValue) / (t4RegressionChannel0StartCandle - t4RegressionChannel0EndCandle) * (t4RegressionChannel0StartCandle));
   createTrendLine(T4_REGRESSION_CHANNEL + "0", t4StartDateTime, t4RegressionChannel0StartValue, iTime(Symbol(), PERIOD_CURRENT, 0), t4RegressionChannel0EndTrendlineLevel, InpT3FiboLevelsColor, 2, STYLE_SOLID, " 0%");

   double   t4RegressionChannel100StartValue   = ObjectGetValueByTime(ChartID(), T4_REGRESSION_CHANNEL, t4StartDateTime, (t3trendDirection == TREND_DIRECTION_LONG) ? 2 : 1);
   int      t4RegressionChannel100StartCandle = iBarShift(Symbol(), period, t4StartDateTime);
   double   t4RegressionChannel100EndValue = ObjectGetValueByTime(ChartID(), T4_REGRESSION_CHANNEL, endDateTime, (t3trendDirection == TREND_DIRECTION_LONG) ? 2 : 1);
   int      t4RegressionChannel100EndCandle = iBarShift(Symbol(), period, endDateTime);
   double   t4RegressionChannel100EndTrendlineLevel = t4RegressionChannel100StartValue + ((t4RegressionChannel100EndValue - t4RegressionChannel100StartValue) / (t4RegressionChannel100StartCandle - t4RegressionChannel100EndCandle) * (t4RegressionChannel100StartCandle));
   createTrendLine(T4_REGRESSION_CHANNEL + "100", t4StartDateTime, t4RegressionChannel100StartValue, iTime(Symbol(), PERIOD_CURRENT, 0), t4RegressionChannel100EndTrendlineLevel, InpT3FiboLevelsColor, 2, STYLE_SOLID, " 100%");

   double level = 50;
   double t4TrendlineStartValue = t4RegressionChannel0StartValue + (t4RegressionChannel100StartValue - t4RegressionChannel0StartValue) / 100 * level  ;
   double t4TrendlineEndValue   = t4RegressionChannel0EndTrendlineLevel + (t4RegressionChannel100EndTrendlineLevel - t4RegressionChannel0EndTrendlineLevel) / 100 * level;
   int    lineWidth = 2;
   color  levelColor = InpT3FiboLevelsColor;
   ENUM_LINE_STYLE style = STYLE_SOLID;
   createTrendLine(T4_REGRESSION_CHANNEL + DoubleToString(level, 1), t4StartDateTime, t4TrendlineStartValue, iTime(Symbol(), PERIOD_CURRENT, 0), t4TrendlineEndValue, levelColor, lineWidth, style, " " + DoubleToString(level, 1) + "%");

   if(InpT4StopLossOnRegressionChannelLevel != 0) {
      level = InpT4StopLossOnRegressionChannelLevel;
      t4TrendlineStartValue = t4RegressionChannel0StartValue + (t4RegressionChannel100StartValue - t4RegressionChannel0StartValue) / 100 * level  ;
      t4TrendlineEndValue   = t4RegressionChannel0EndTrendlineLevel + (t4RegressionChannel100EndTrendlineLevel - t4RegressionChannel0EndTrendlineLevel) / 100 * level;
      lineWidth = 2;
      levelColor = InpT3FiboLevelsColor;
      style = STYLE_SOLID;
      createTrendLine(T4_TRAILING_STOP_LINE, t4StartDateTime, t4TrendlineStartValue, iTime(Symbol(), PERIOD_CURRENT, 0), t4TrendlineEndValue, levelColor, lineWidth, style, " " + DoubleToString(level, 1) + "%" + T4_TRAILING_STOP_LINE);
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
//+------------------------------------------------------------------+
