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

   if(t2p4DateTime != 0 && (int)t2p4DateTime < (int) TimeCurrent()) {

      datetime endDateTime;
      (t2EndDateTime != 0) ? endDateTime = t2EndDateTime : endDateTime = iTime(Symbol(), PERIOD_CURRENT, InpT2ChannelEndShift);

      createTrendLine(T2_FIBO_LEVELS + "100", t2p3DateTime, getT2P3HighLowValueByTrendDirection(), endDateTime, getT2P3HighLowValueByTrendDirection(), lineColor, lineWidth, lineStyle, "   100%");
      ObjectSetInteger(ChartID(), T2_FIBO_LEVELS + "100", OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);
      createTrendLine(T2_FIBO_LEVELS + "0", t2p3DateTime, getT2P4HighLowValueByTrendDirection(), endDateTime, getT2P4HighLowValueByTrendDirection(), lineColor, lineWidth, lineStyle, "   0%");
      ObjectSetInteger(ChartID(), T2_FIBO_LEVELS + "0", OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);

      for( int t2FiboLevelsId = 0; t2FiboLevelsId < ArraySize(t2FiboLevelsArray); t2FiboLevelsId++) {
         double level = (double)t2FiboLevelsArray[t2FiboLevelsId];
         double t2FiboLevelValue = getT2P4HighLowValueByTrendDirection() + (getT2P3HighLowValueByTrendDirection() - getT2P4HighLowValueByTrendDirection()) / 100 * level  ;
         lineWidth = thinLineWidth;
         lineText         = "   " + DoubleToString(level, 1) + "%";

         if(level == tt2movementLengthRegressionLengthRatio) {
            lineWidth = InpT2LineWidth;
            lineText  = "   " + DoubleToString(level, 1) + "% - T2 MovementLengt Ratio";
         }

         createTrendLine(T2_FIBO_LEVELS + DoubleToString(level, 1), t2p3DateTime, t2FiboLevelValue, endDateTime, t2FiboLevelValue, lineColor, lineWidth, lineStyle, lineText);
         ObjectSetInteger(ChartID(), T2_FIBO_LEVELS + DoubleToString(level, 1), OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);
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
