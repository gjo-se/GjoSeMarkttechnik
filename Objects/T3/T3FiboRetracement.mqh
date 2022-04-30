//+------------------------------------------------------------------+
//|                                                   FiboLevels.mqh |
//|                                       Copyright 2022, Gregory Jo |
//+------------------------------------------------------------------+

void createT3FiboRetracement() {

   int lineWidth = InpT3LineWidth;
   int thinLineWidth = 1;
   ENUM_LINE_STYLE lineStyle = InpT3LineStyle;
   color lineColor = InpT3DefaultColor;
   string lineText = "";

   if(t3p4DateTime != 0 && (int)t3p4DateTime < (int) TimeCurrent()) {

      datetime endDateTime;
      (t3EndDateTime != 0) ? endDateTime = t3EndDateTime : endDateTime = iTime(Symbol(), PERIOD_CURRENT, InpT3ChannelEndShift);

      createTrendLine(T3_FIBO_LEVELS + "100", t3p3DateTime, getT3P3HighLowValueByTrendDirection(), endDateTime, getT3P3HighLowValueByTrendDirection(), lineColor, lineWidth, lineStyle, "   100%");
      ObjectSetInteger(ChartID(), T3_FIBO_LEVELS + "100", OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);
      createTrendLine(T3_FIBO_LEVELS + "0", t3p3DateTime, getT3P4HighLowValueByTrendDirection(), endDateTime, getT3P4HighLowValueByTrendDirection(), lineColor, lineWidth, lineStyle, "   0%");
      ObjectSetInteger(ChartID(), T3_FIBO_LEVELS + "0", OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);

      for( int t3FiboLevelsId = 0; t3FiboLevelsId < ArraySize(t3FiboLevelsArray); t3FiboLevelsId++) {
         double level = (double)t3FiboLevelsArray[t3FiboLevelsId];
         double t3FiboLevelValue = getT3P4HighLowValueByTrendDirection() + (getT3P3HighLowValueByTrendDirection() - getT3P4HighLowValueByTrendDirection()) / 100 * level  ;
         lineWidth = thinLineWidth;
         lineText         = "   " + DoubleToString(level, 1) + "%";

         if(level == InpT3AlertOnFiboRetracmentLevel && (InpT3AlertOnRegressionChannelLevel != 0 || InpT3AlertOnFiboRetracmentLevel != 0 )) {
            t3AlertFiboRetracementLevel = t3FiboLevelValue;
         }

         if(level == InpT3MinFiboRetracmentLevel) {
            if(t3trendDirection == TREND_DIRECTION_LONG) {
               t3InSignalFiboLevelAreaMaxStartValue = t3FiboLevelValue;
               t3InSignalFiboLevelAreaMaxEndValue = t3FiboLevelValue;
            } else {
               t3InSignalFiboLevelAreaMinStartValue = t3FiboLevelValue;
               t3InSignalFiboLevelAreaMinEndValue = t3FiboLevelValue;
            }
         }

         if(level == InpT3MaxFiboRetracmentLevel) {
            if(t3trendDirection == TREND_DIRECTION_LONG) {
               t3InSignalFiboLevelAreaMinStartValue = t3FiboLevelValue;
               t3InSignalFiboLevelAreaMinEndValue = t3FiboLevelValue;
            } else {
               t3InSignalFiboLevelAreaMaxStartValue = t3FiboLevelValue;
               t3InSignalFiboLevelAreaMaxEndValue = t3FiboLevelValue;
            }
         }

         if(level == tt3movementLengthRegressionLengthRatio) {
            lineWidth = InpT3LineWidth;
            lineText  = "   " + DoubleToString(level, 1) + "% - T3 MovementLengt Ratio";
         }

         createTrendLine(T3_FIBO_LEVELS + DoubleToString(level, 1), t3p3DateTime, t3FiboLevelValue, endDateTime, t3FiboLevelValue, lineColor, lineWidth, lineStyle, lineText);
         ObjectSetInteger(ChartID(), T3_FIBO_LEVELS + DoubleToString(level, 1), OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);
      }
   }
}
