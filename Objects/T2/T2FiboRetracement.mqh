//+------------------------------------------------------------------+
//|                                                   FiboLevels.mqh |
//|                                       Copyright 2022, Gregory Jo |
//+------------------------------------------------------------------+

void createT2FiboRetracement() {

   int lineWidth = InpT2LineWidth;
   int thinLineWidth = 1;
   ENUM_LINE_STYLE lineStyle = InpT2LineStyle;
   color lineColor = InpT2DefaultColor;
   string lineText = "";
   datetime startDateTime = 0;
   datetime endDateTime = 0;
   double   firstPointLevel = 0;
   double   secondPointLevel = 0;

   if(t2p1DateTime != 0 && t2p2DateTime != 0) {
      startDateTime = t2p1DateTime;
      firstPointLevel = getT2P1HighLowValueByTrendDirection();
      secondPointLevel = getT2P2HighLowValueByTrendDirection();
   }
   if(t2p3DateTime != 0 && t2p4DateTime != 0) {
      startDateTime = t2p3DateTime;
      firstPointLevel = getT2P3HighLowValueByTrendDirection();
      secondPointLevel = getT2P4HighLowValueByTrendDirection();
   }

   (t2EndDateTime != 0) ? endDateTime = t2EndDateTime : endDateTime = iTime(Symbol(), PERIOD_CURRENT, InpT2ChannelEndShift);

   if(startDateTime != 0 && startDateTime < TimeCurrent()
         && endDateTime != 0 && endDateTime < TimeCurrent()
     ) {

      deleteTrendLineLike(T2_FIBO_LEVELS);

      createTrendLine(T2_FIBO_LEVELS + "100", startDateTime, firstPointLevel, endDateTime, firstPointLevel, lineColor, lineWidth, lineStyle, "   100%");
      ObjectSetInteger(ChartID(), T2_FIBO_LEVELS + "100", OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);
      createTrendLine(T2_FIBO_LEVELS + "0", startDateTime, secondPointLevel, endDateTime, secondPointLevel, lineColor, lineWidth, lineStyle, "   0%");
      ObjectSetInteger(ChartID(), T2_FIBO_LEVELS + "0", OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);

      for( int t2FiboLevelsId = 0; t2FiboLevelsId < ArraySize(t2FiboLevelsArray); t2FiboLevelsId++) {
         double level = (double)t2FiboLevelsArray[t2FiboLevelsId];
         double t2FiboLevelValue = secondPointLevel + (firstPointLevel - secondPointLevel) / 100 * level  ;
         lineWidth = thinLineWidth;
         lineText         = "   " + DoubleToString(level, 1) + "%";

         if(level == tt2movementLengthRegressionLengthRatio) {
            lineWidth = InpT2LineWidth;
            lineText  = "   " + DoubleToString(level, 1) + "% - T2 MovementLengt Ratio";
         }

         if(level == (double)InpT2TrendBrokeOnFiboLevel) {
            lineWidth = InpT2LineWidth;
            lineText  = "   " + DoubleToString(level, 1) + "% - T2 Trend Broke";
            t2TrendBrokeOnFiboLevel = t2FiboLevelValue;
         }

         createTrendLine(T2_FIBO_LEVELS + DoubleToString(level, 1), startDateTime, t2FiboLevelValue, endDateTime, t2FiboLevelValue, lineColor, lineWidth, lineStyle, lineText);
         ObjectSetInteger(ChartID(), T2_FIBO_LEVELS + DoubleToString(level, 1), OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);
      }
   }
}
//+------------------------------------------------------------------+
