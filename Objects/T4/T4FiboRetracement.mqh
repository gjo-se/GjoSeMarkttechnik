//+------------------------------------------------------------------+
//|                                                   FiboLevels.mqh |
//|                                       Copyright 2022, Gregory Jo |
//+------------------------------------------------------------------+

void createT4FiboRetracement() {

   if(t4p4DateTime != 0 && (int)t4p4DateTime < (int) TimeCurrent()) {

      datetime t4EndDatetime = 0;
      if(t4EndDateTime == 0) t4EndDatetime = iTime(Symbol(), PERIOD_CURRENT, InpT4ChannelEndShift);

      createTrendLine(T4_FIBO_LEVELS + "100", t4p3DateTime, getT4P3HighLowValueByTrendDirection(), iTime(Symbol(), PERIOD_CURRENT, 0), getT4P3HighLowValueByTrendDirection(), InpT4TrendLineColor, 2, STYLE_SOLID, " 100%");
      createTrendLine(T4_FIBO_LEVELS + "0", t4p3DateTime, getT4P4HighLowValueByTrendDirection(), iTime(Symbol(), PERIOD_CURRENT, 0), getT4P4HighLowValueByTrendDirection(), InpT4TrendLineColor, 2, STYLE_SOLID, " 0%");

      for( int t4FiboLevelsId = 0; t4FiboLevelsId < ArraySize(t4FiboLevelsArray); t4FiboLevelsId++) {
         double level = (double)t4FiboLevelsArray[t4FiboLevelsId];
         double t4FiboLevelValue = getT4P4HighLowValueByTrendDirection() + (getT4P3HighLowValueByTrendDirection() - getT4P4HighLowValueByTrendDirection()) / 100 * level  ;
         int    lineWidth = 1;
         color  levelColor = InpT4TrendLineColor;
         ENUM_LINE_STYLE style = STYLE_SOLID;

         if(level == InpT4AlertOnFiboRetracmentLevel && (InpT4AlertOnRegressionChannelLevel != 0 || InpT4AlertOnFiboRetracmentLevel != 0 )) {
            lineWidth = 1;
            style = STYLE_DASH;
            levelColor = InpT4TrendLineColor;
            t4AlertFiboRetracementLevel = t4FiboLevelValue;
         }

         if(level == InpT4MinFiboRetracmentLevel) {

            lineWidth = 2;
            levelColor = clrBlack;
            
            if(t4trendDirection == TREND_DIRECTION_LONG) {
               t4InSignalFiboLevelAreaMaxStartValue = t4FiboLevelValue;
               t4InSignalFiboLevelAreaMaxEndValue = t4FiboLevelValue;
               t3ShortEntryValue = t4FiboLevelValue;
            } else {
               t4InSignalFiboLevelAreaMinStartValue = t4FiboLevelValue;
               t4InSignalFiboLevelAreaMinEndValue = t4FiboLevelValue;
               t3LongEntryValue = t4FiboLevelValue;
            }
         }

         if(level == InpT4MaxFiboRetracmentLevel) {

            lineWidth = 2;
            levelColor = clrBlack;

            if(t4trendDirection == TREND_DIRECTION_LONG) {
               t4InSignalFiboLevelAreaMinStartValue = t4FiboLevelValue;
               t4InSignalFiboLevelAreaMinEndValue = t4FiboLevelValue;
            } else {
               t4InSignalFiboLevelAreaMaxStartValue = t4FiboLevelValue;
               t4InSignalFiboLevelAreaMaxEndValue = t4FiboLevelValue;
            }
         }

         if(InpT4MinReEntryFiboRetracmentLevel != 0 && level == InpT4MinReEntryFiboRetracmentLevel) {

            lineWidth = 2;
            levelColor = InpT4ReEntryMinRegressionColor;

            if(t4trendDirection == TREND_DIRECTION_LONG) {
               t4ReEntryAreaMinStartValue = t4InSignalFiboLevelAreaMinStartValue;
               t4ReEntryAreaMinEndValue = t4InSignalFiboLevelAreaMinEndValue;
               t4ReEntryAreaMaxStartValue = t4FiboLevelValue;
               t4ReEntryAreaMaxEndValue = t4FiboLevelValue;
            } else {
               t4ReEntryAreaMinStartValue = t4FiboLevelValue;
               t4ReEntryAreaMinEndValue = t4FiboLevelValue;
               t4ReEntryAreaMaxStartValue = t4InSignalFiboLevelAreaMaxStartValue;
               t4ReEntryAreaMaxEndValue = t4InSignalFiboLevelAreaMaxEndValue;
            }
         }
         
       if(level == InpT4MinProfitFiboRetracmentLevel) {
          lineWidth = 2;
          levelColor = clrRed;
          t4MinProfitFiboRetracmentLevel = t4FiboLevelValue;
       }
       
         createTrendLine(T4_FIBO_LEVELS + DoubleToString(level, 1), t4p3DateTime, t4FiboLevelValue, iTime(Symbol(), PERIOD_CURRENT, 0), t4FiboLevelValue, levelColor, lineWidth, style, " " + DoubleToString(level, 1) + "%");
      }
   }
}
