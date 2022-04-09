//+------------------------------------------------------------------+
//|                                                   TrendLines.mqh |
//|                                       Copyright 2022, Gregory Jo |
//+------------------------------------------------------------------+



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void createTT3ZigZagTemplateLines() {

   if(tt3p1DateTime != 0 && tt3p2DateTime != 0) {
      createTrendLine(TT3_ZIGZAGLINE + "P1-P2", tt3p1DateTime, getTT3P1HighLowValueByTrendDirection(), tt3p2DateTime, getTT3P2HighLowValueByTrendDirection(), InpT3DefaultColor, InpT3LineWidth, InpT3LineStyle);
      ObjectSetInteger(ChartID(), TT3_ZIGZAGLINE + "P1-P2", OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);
   }
   if(tt3p2DateTime != 0 && tt3p3DateTime != 0) {
      createTrendLine(TT3_ZIGZAGLINE + "P2-P3", tt3p2DateTime, getTT3P2HighLowValueByTrendDirection(), tt3p3DateTime, getTT3P3HighLowValueByTrendDirection(), InpT3DefaultColor, InpT3LineWidth, InpT3LineStyle);
      ObjectSetInteger(ChartID(), TT3_ZIGZAGLINE + "P2-P3", OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);
   }
   if(tt3p3DateTime != 0 && tt3p4DateTime != 0) {
      createTrendLine(TT3_ZIGZAGLINE + "P3-P4", tt3p3DateTime, getTT3P3HighLowValueByTrendDirection(), tt3p4DateTime, getTT3P4HighLowValueByTrendDirection(), InpT3DefaultColor, InpT3LineWidth, InpT3LineStyle);
      ObjectSetInteger(ChartID(), TT3_ZIGZAGLINE + "P3-P4", OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);
   }
   if(tt3p4DateTime != 0 && tt3p5DateTime != 0) {
      createTrendLine(TT3_ZIGZAGLINE + "P4-P5", tt3p4DateTime, getTT3P4HighLowValueByTrendDirection(), tt3p5DateTime, getTT3P5HighLowValueByTrendDirection(), InpT3DefaultColor, InpT3LineWidth, InpT3LineStyle);
      ObjectSetInteger(ChartID(), TT3_ZIGZAGLINE + "P4-P5", OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);
   }
   if(tt3p5DateTime != 0 && tt3p6DateTime != 0) {
      createTrendLine(TT3_ZIGZAGLINE + "P5-P6", tt3p5DateTime, getTT3P5HighLowValueByTrendDirection(), tt3p6DateTime, getTT3P6HighLowValueByTrendDirection(), InpT3DefaultColor, InpT3LineWidth, InpT3LineStyle);
      ObjectSetInteger(ChartID(), TT3_ZIGZAGLINE + "P5-P6", OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);
   }
}

void createTT4ZigZagTemplateLines() {

   if(tt4p1DateTime != 0 && tt4p2DateTime != 0) {
      createTrendLine(TT4_ZIGZAGLINE + "P1-P2", tt4p1DateTime, getTT4P1HighLowValueByTrendDirection(), tt4p2DateTime, getTT4P2HighLowValueByTrendDirection(), InpT4DefaultColor, InpT4LineWidth, InpT4LineStyle);
      ObjectSetInteger(ChartID(), TT4_ZIGZAGLINE + "P1-P2", OBJPROP_TIMEFRAMES, InpT4VisibleTimeframes);
   }
   if(tt4p2DateTime != 0 && tt4p3DateTime != 0) {
      createTrendLine(TT4_ZIGZAGLINE + "P2-P3", tt4p2DateTime, getTT4P2HighLowValueByTrendDirection(), tt4p3DateTime, getTT4P3HighLowValueByTrendDirection(), InpT4DefaultColor, InpT4LineWidth, InpT4LineStyle);
      ObjectSetInteger(ChartID(), TT4_ZIGZAGLINE + "P2-P3", OBJPROP_TIMEFRAMES, InpT4VisibleTimeframes);
   }
   if(tt4p3DateTime != 0 && tt4p4DateTime != 0) {
      createTrendLine(TT4_ZIGZAGLINE + "P3-P4", tt4p3DateTime, getTT4P3HighLowValueByTrendDirection(), tt4p4DateTime, getTT4P4HighLowValueByTrendDirection(), InpT4DefaultColor, InpT4LineWidth, InpT4LineStyle);
      ObjectSetInteger(ChartID(), TT4_ZIGZAGLINE + "P3-P4", OBJPROP_TIMEFRAMES, InpT4VisibleTimeframes);
   }
   if(tt4p4DateTime != 0 && tt4p5DateTime != 0) {
      createTrendLine(TT4_ZIGZAGLINE + "P4-P5", tt4p4DateTime, getTT4P4HighLowValueByTrendDirection(), tt4p5DateTime, getTT4P5HighLowValueByTrendDirection(), InpT4DefaultColor, InpT4LineWidth, InpT4LineStyle);
      ObjectSetInteger(ChartID(), TT4_ZIGZAGLINE + "P4-P5", OBJPROP_TIMEFRAMES, InpT4VisibleTimeframes);
   }
   if(tt4p5DateTime != 0 && tt4p6DateTime != 0) {
      createTrendLine(TT4_ZIGZAGLINE + "P5-P6", tt4p5DateTime, getTT4P5HighLowValueByTrendDirection(), tt4p6DateTime, getTT4P6HighLowValueByTrendDirection(), InpT4DefaultColor, InpT4LineWidth, InpT4LineStyle);
      ObjectSetInteger(ChartID(), TT4_ZIGZAGLINE + "P5-P6", OBJPROP_TIMEFRAMES, InpT4VisibleTimeframes);
   }
}
//+------------------------------------------------------------------+
