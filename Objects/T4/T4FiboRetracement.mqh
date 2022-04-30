//+------------------------------------------------------------------+
//|                                                   FiboLevels.mqh |
//|                                       Copyright 2022, Gregory Jo |
//+------------------------------------------------------------------+

void createT4FiboRetracement() {

   int lineWidth = InpT4LineWidth;
   int thinLineWidth = 1;
   ENUM_LINE_STYLE lineStyle = InpT4LineStyle;
   color lineColor = InpT4DefaultColor;
   string lineText = "";

   if(t4p4DateTime != 0 && (int)t4p4DateTime < (int) TimeCurrent()) {

      datetime endDateTime;
      (t4EndDateTime != 0) ? endDateTime = t4EndDateTime : endDateTime = iTime(Symbol(), PERIOD_CURRENT, InpT4ChannelEndShift);

      createTrendLine(T4_FIBO_LEVELS + "100", t4p3DateTime, getT4P3HighLowValueByTrendDirection(), endDateTime, getT4P3HighLowValueByTrendDirection(), lineColor, lineWidth, lineStyle, "   100%");
      ObjectSetInteger(ChartID(), T4_FIBO_LEVELS + "100", OBJPROP_TIMEFRAMES, InpT4VisibleTimeframes);
      createTrendLine(T4_FIBO_LEVELS + "0", t4p3DateTime, getT4P4HighLowValueByTrendDirection(), endDateTime, getT4P4HighLowValueByTrendDirection(), lineColor, lineWidth, lineStyle, "   0%");
      ObjectSetInteger(ChartID(), T4_FIBO_LEVELS + "0", OBJPROP_TIMEFRAMES, InpT4VisibleTimeframes);

      for( int t4FiboLevelsId = 0; t4FiboLevelsId < ArraySize(t4FiboLevelsArray); t4FiboLevelsId++) {
         double level = (double)t4FiboLevelsArray[t4FiboLevelsId];
         double t4FiboLevelValue = getT4P4HighLowValueByTrendDirection() + (getT4P3HighLowValueByTrendDirection() - getT4P4HighLowValueByTrendDirection()) / 100 * level  ;
         lineWidth = thinLineWidth;
         lineText         = "   " + DoubleToString(level, 1) + "%";

         if(level == InpT4AlertOnFiboRetracmentLevel && (InpT4AlertOnRegressionChannelLevel != 0 || InpT4AlertOnFiboRetracmentLevel != 0 )) {
            t4AlertFiboRetracementLevel = t4FiboLevelValue;
         }

         if(level == tt4movementLengthRegressionLengthRatio) {
            lineWidth = InpT4LineWidth;
            lineText  = "   " + DoubleToString(level, 1) + "% - T4 MovementLengt Ratio";
         }

         createTrendLine(T4_FIBO_LEVELS + DoubleToString(level, 1), t4p3DateTime, t4FiboLevelValue, endDateTime, t4FiboLevelValue, lineColor, lineWidth, lineStyle, lineText);
         ObjectSetInteger(ChartID(), T4_FIBO_LEVELS + DoubleToString(level, 1), OBJPROP_TIMEFRAMES, InpT4VisibleTimeframes);
      }
   }
}
