//+------------------------------------------------------------------+
//|                                                   FiboLevels.mqh |
//|                                       Copyright 2022, Gregory Jo |
//+------------------------------------------------------------------+

void createT3FiboRetracement() {

   if(t3p4DateTime != 0 && (int)t3p4DateTime < (int) TimeCurrent()) {

      datetime t3EndDatetime = 0;
      if(t3EndDateTime == 0) t3EndDatetime = iTime(Symbol(), PERIOD_CURRENT, InpT3ChannelEndShift);

      createTrendLine(T3_FIBO_LEVELS + "100", t3p3DateTime, getT3P3HighLowValueByTrendDirection(), iTime(Symbol(), PERIOD_CURRENT, 0), getT3P3HighLowValueByTrendDirection(), InpT3TrendLineColor, 1, STYLE_SOLID, " 100%");
      createTrendLine(T3_FIBO_LEVELS + "0", t3p3DateTime, getT3P4HighLowValueByTrendDirection(), iTime(Symbol(), PERIOD_CURRENT, 0), getT3P4HighLowValueByTrendDirection(), InpT3TrendLineColor, 1, STYLE_SOLID, " 0%");

      for( int t3FiboLevelsId = 0; t3FiboLevelsId < ArraySize(t3FiboLevelsArray); t3FiboLevelsId++) {
         double level = (double)t3FiboLevelsArray[t3FiboLevelsId];
         double t3FiboLevelValue = getT3P4HighLowValueByTrendDirection() + (getT3P3HighLowValueByTrendDirection() - getT3P4HighLowValueByTrendDirection()) / 100 * level  ;
         int    lineWidth = 1;
         color  levelColor = InpT3TrendLineColor;
         ENUM_LINE_STYLE style = STYLE_SOLID;

         if(level == InpT3AlertOnFiboRetracmentLevel && (InpT3AlertOnRegressionChannelLevel != 0 || InpT3AlertOnFiboRetracmentLevel != 0 )) {
            lineWidth = 1;
            style = STYLE_DASH;
            levelColor = InpT3TrendLineColor;
            t3AlertFiboRetracementLevel = t3FiboLevelValue;
         }

         if(level == InpT3MinFiboRetracmentLevel) {

            lineWidth = 2;
            levelColor = clrMaroon;
            
            if(t3trendDirection == TREND_DIRECTION_LONG) {
               t3InSignalFiboLevelAreaMaxStartValue = t3FiboLevelValue;
               t3InSignalFiboLevelAreaMaxEndValue = t3FiboLevelValue;
            } else {
               t3InSignalFiboLevelAreaMinStartValue = t3FiboLevelValue;
               t3InSignalFiboLevelAreaMinEndValue = t3FiboLevelValue;
            }
         }

         if(level == InpT3MaxFiboRetracmentLevel) {

            lineWidth = 2;
            levelColor = clrMaroon;

            if(t3trendDirection == TREND_DIRECTION_LONG) {
               t3InSignalFiboLevelAreaMinStartValue = t3FiboLevelValue;
               t3InSignalFiboLevelAreaMinEndValue = t3FiboLevelValue;
            } else {
               t3InSignalFiboLevelAreaMaxStartValue = t3FiboLevelValue;
               t3InSignalFiboLevelAreaMaxEndValue = t3FiboLevelValue;
            }
         }

         if(InpT3MinReEntryFiboRetracmentLevel != 0 && level == InpT3MinReEntryFiboRetracmentLevel) {

            lineWidth = 2;
            levelColor = InpT3ReEntryMinRegressionColor;

            if(t3trendDirection == TREND_DIRECTION_LONG) {
               t3ReEntryAreaMinStartValue = t3InSignalFiboLevelAreaMinStartValue;
               t3ReEntryAreaMinEndValue = t3InSignalFiboLevelAreaMinEndValue;
               t3ReEntryAreaMaxStartValue = t3FiboLevelValue;
               t3ReEntryAreaMaxEndValue = t3FiboLevelValue;
            } else {
               t3ReEntryAreaMinStartValue = t3FiboLevelValue;
               t3ReEntryAreaMinEndValue = t3FiboLevelValue;
               t3ReEntryAreaMaxStartValue = t3InSignalFiboLevelAreaMaxStartValue;
               t3ReEntryAreaMaxEndValue = t3InSignalFiboLevelAreaMaxEndValue;
            }
         }

          if(level == InpT3MinProfitFiboRetracmentLevel) {
             lineWidth = 2;
             levelColor = clrRed;
             t3MinProfitFiboRetracmentLevel = t3FiboLevelValue;
          }

         createTrendLine(T3_FIBO_LEVELS + DoubleToString(level, 1), t3p3DateTime, t3FiboLevelValue, iTime(Symbol(), PERIOD_CURRENT, 0), t3FiboLevelValue, levelColor, lineWidth, style, " " + DoubleToString(level, 1) + "%");
      }

       if(InpT3MinHighVolumeAreaLevel != 0 && InpT3MaxHighVolumeAreaLevel != 0) {

          int lineWidth = 2;
          color levelColor = clrMaroon;
          ENUM_LINE_STYLE style = STYLE_SOLID;

          if(t3trendDirection == TREND_DIRECTION_LONG) {
             t3LongEntryValue = InpT3MaxHighVolumeAreaLevel;
          }
          if(t3trendDirection == TREND_DIRECTION_SHORT) {
             t3ShortEntryValue = InpT3MinHighVolumeAreaLevel;
          }

          createTrendLine(T3_FIBO_LEVELS + DoubleToString(InpT3MinHighVolumeAreaLevel, Digits()), t3p3DateTime, InpT3MinHighVolumeAreaLevel, iTime(Symbol(), PERIOD_CURRENT, 0), InpT3MinHighVolumeAreaLevel, levelColor, lineWidth, style, " " + "MINHighVolumeArea: " + DoubleToString(InpT3MinHighVolumeAreaLevel, Digits()));
          createTrendLine(T3_FIBO_LEVELS + DoubleToString(InpT3MaxHighVolumeAreaLevel, Digits()), t3p3DateTime, InpT3MaxHighVolumeAreaLevel, iTime(Symbol(), PERIOD_CURRENT, 0), InpT3MaxHighVolumeAreaLevel, levelColor, lineWidth, style, " " + "MAXHighVolumeArea: " + DoubleToString(InpT3MaxHighVolumeAreaLevel, Digits()));
       }
       if(InpT3POCLevel) {

          int lineWidth = 2;
          color levelColor = clrRed;
          ENUM_LINE_STYLE style = STYLE_SOLID;

          createTrendLine(T3_FIBO_LEVELS + DoubleToString(InpT3POCLevel, Digits()), t3p3DateTime, InpT3POCLevel, iTime(Symbol(), PERIOD_CURRENT, 0), InpT3POCLevel, levelColor, lineWidth, style, " " + "POC");
       }
   }
}

void deleteFiboLevelsObject(const string pDimension) {

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
