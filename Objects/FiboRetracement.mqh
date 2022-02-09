//+------------------------------------------------------------------+
//|                                                   FiboLevels.mqh |
//|                                       Copyright 2022, Gregory Jo |
//+------------------------------------------------------------------+

void createT3FiboRetracement() {

   if(t3p4DateTime != 0) {

      datetime t3EndDatetime = 0;
      if(t3EndDateTime == 0) t3EndDatetime = iTime(Symbol(), PERIOD_CURRENT, InpT3ChannelEndShift);

      createTrendLine(T3_FIBO_LEVELS + "100", t3p3DateTime, getP3HighLowValueByTrendDirection(), iTime(Symbol(), PERIOD_CURRENT, 0), getP3HighLowValueByTrendDirection(), InpT3FiboLevelsColor, 2, STYLE_SOLID, " 100%");
      createTrendLine(T3_FIBO_LEVELS + "0", t3p3DateTime, getP4HighLowValueByTrendDirection(), iTime(Symbol(), PERIOD_CURRENT, 0), getP4HighLowValueByTrendDirection(), InpT3FiboLevelsColor, 2, STYLE_SOLID, " 0%");

      for( int t3FiboLevelsId = 0; t3FiboLevelsId < ArraySize(t3FiboLevelsArray); t3FiboLevelsId++) {
         double level = (double)t3FiboLevelsArray[t3FiboLevelsId];
         double t3FiboLevelValue = getP4HighLowValueByTrendDirection() + (getP3HighLowValueByTrendDirection() - getP4HighLowValueByTrendDirection()) / 100 * level  ;
         int    lineWidth = 1;
         color  levelColor = InpT3FiboLevelsColor;
         ENUM_LINE_STYLE style = STYLE_SOLID;

         if(level == InpT3AlertOnFiboRetracmentLevel && (InpT3AlertOnRegressionChannelLevel != 0 || InpT3AlertOnFiboRetracmentLevel != 0 )) {
            lineWidth = 1;
            style = STYLE_DASH;
            levelColor = InpT3MinMaxRegressionColor;
            alertFiboRetracementLevel = t3FiboLevelValue;
         }

         if(level == InpT3MinFiboRetracmentLevel) {

            lineWidth = 2;
            levelColor = InpT3MinMaxRegressionColor;

            if(t3trendDirection == TREND_DIRECTION_LONG) {
               inSignalAreaMaxStartValue = t3FiboLevelValue;
               inSignalAreaMaxEndValue = t3FiboLevelValue;
            } else {
               inSignalAreaMinStartValue = t3FiboLevelValue;
               inSignalAreaMinEndValue = t3FiboLevelValue;
            }
         }

         if(level == InpT3MaxFiboRetracmentLevel) {

            lineWidth = 2;
            levelColor = InpT3MinMaxRegressionColor;

            if(t3trendDirection == TREND_DIRECTION_LONG) {
               inSignalAreaMinStartValue = t3FiboLevelValue;
               inSignalAreaMinEndValue = t3FiboLevelValue;
            } else {
               inSignalAreaMaxStartValue = t3FiboLevelValue;
               inSignalAreaMaxEndValue = t3FiboLevelValue;
            }
         }

         if(level == InpT3MinReEntryFiboRetracmentLevel) {

            lineWidth = 2;
            levelColor = InpT3ReEntryMinRegressionColor;

            if(t3trendDirection == TREND_DIRECTION_LONG) {
               reEntryAreaMinStartValue = inSignalAreaMinStartValue;
               reEntryAreaMinEndValue = inSignalAreaMinEndValue;
               reEntryAreaMaxStartValue = t3FiboLevelValue;
               reEntryAreaMaxEndValue = t3FiboLevelValue;
            } else {
               reEntryAreaMinStartValue = t3FiboLevelValue;
               reEntryAreaMinEndValue = t3FiboLevelValue;
               reEntryAreaMaxStartValue = inSignalAreaMaxStartValue;
               reEntryAreaMaxEndValue = inSignalAreaMaxEndValue;
            }
         }
         createTrendLine(T3_FIBO_LEVELS + DoubleToString(level, 1), t3p3DateTime, t3FiboLevelValue, iTime(Symbol(), PERIOD_CURRENT, 0), t3FiboLevelValue, levelColor, lineWidth, style, " " + DoubleToString(level, 1) + "%");
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
