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
   datetime startDateTime = 0;
   datetime endDateTime = 0;
   double   firstPointLevel = 0;
   double   secondPointLevel = 0;

   if(t3p1DateTime != 0 && t3p2DateTime != 0) {
      startDateTime = t3p1DateTime;
      firstPointLevel = getT3P1HighLowValueByTrendDirection();
      secondPointLevel = getT3P2HighLowValueByTrendDirection();
   }
   if(t3p3DateTime != 0 && t3p4DateTime != 0) {
      startDateTime = t3p3DateTime;
      firstPointLevel = getT3P3HighLowValueByTrendDirection();
      secondPointLevel = getT3P4HighLowValueByTrendDirection();
   }

   (t3EndDateTime != 0) ? endDateTime = t3EndDateTime : endDateTime = iTime(Symbol(), PERIOD_CURRENT, InpT3ChannelEndShift);

   if(startDateTime != 0 && startDateTime < TimeCurrent()
         && endDateTime != 0 && endDateTime < TimeCurrent()
     ) {

      deleteTrendLineLike(T3_FIBO_LEVELS);

      createTrendLine(T3_FIBO_LEVELS + "100", startDateTime, firstPointLevel, endDateTime, firstPointLevel, lineColor, lineWidth, lineStyle, "   100%");
      ObjectSetInteger(ChartID(), T3_FIBO_LEVELS + "100", OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);
      createTrendLine(T3_FIBO_LEVELS + "0", startDateTime, secondPointLevel, endDateTime, secondPointLevel, lineColor, lineWidth, lineStyle, "   0%");
      ObjectSetInteger(ChartID(), T3_FIBO_LEVELS + "0", OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);

      for( int t3FiboLevelsId = 0; t3FiboLevelsId < ArraySize(t3FiboLevelsArray); t3FiboLevelsId++) {
         double level = (double)t3FiboLevelsArray[t3FiboLevelsId];
         double t3FiboLevelValue = secondPointLevel + (firstPointLevel - secondPointLevel) / 100 * level  ;
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
         
         if(level == (double)InpT3TrendBrokeOnFiboLevel) {
            lineWidth = InpT3LineWidth;
            lineText  = "   " + DoubleToString(level, 1) + "% - T3 Trend Broke";
            t3TrendBrokeOnFiboLevel = t3FiboLevelValue;
         }         

         createTrendLine(T3_FIBO_LEVELS + DoubleToString(level, 1), startDateTime, t3FiboLevelValue, endDateTime, t3FiboLevelValue, lineColor, lineWidth, lineStyle, lineText);
         ObjectSetInteger(ChartID(), T3_FIBO_LEVELS + DoubleToString(level, 1), OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);
      }
   }
}
//+------------------------------------------------------------------+
