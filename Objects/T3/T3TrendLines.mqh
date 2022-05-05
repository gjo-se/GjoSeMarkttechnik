//+------------------------------------------------------------------+
//|                                                   TrendLines.mqh |
//|                                       Copyright 2022, Gregory Jo |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void createT3ZigZagTrendDetectionLines() {

   color lineColor = InpT3DefaultColor;
   if(t3SemiTrendDirection == TREND_DIRECTION_LONG) lineColor = InpT3TLineZigZagTrendLongColor;
   if(t3SemiTrendDirection == TREND_DIRECTION_SHORT) lineColor = InpT3TLineZigZagTrendShortColor;

   deleteTrendLineLike(T3_ZIGZAGLINE);

   if(t3p1DateTime != 0 && t3p2DateTime != 0) {
      createTrendLine(T3_ZIGZAGLINE + "P1-P2", t3p1DateTime, getT3P1HighLowValueByTrendDirection(), t3p2DateTime, getT3P2HighLowValueByTrendDirection(), lineColor, InpT3LineWidth, InpT3LineStyle);
      ObjectSetInteger(ChartID(), T3_ZIGZAGLINE + "P1-P2", OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);
   }
   if(t3p2DateTime != 0 && t3p3DateTime != 0) {
      createTrendLine(T3_ZIGZAGLINE + "P2-P3", t3p2DateTime, getT3P2HighLowValueByTrendDirection(), t3p3DateTime, getT3P3HighLowValueByTrendDirection(), lineColor, InpT3LineWidth, InpT3LineStyle);
      ObjectSetInteger(ChartID(), T3_ZIGZAGLINE + "P2-P3", OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);
   }
   if(t3p3DateTime != 0 && t3p4DateTime != 0) {
      createTrendLine(T3_ZIGZAGLINE + "P3-P4", t3p3DateTime, getT3P3HighLowValueByTrendDirection(), t3p4DateTime, getT3P4HighLowValueByTrendDirection(), lineColor, InpT3LineWidth, InpT3LineStyle);
      ObjectSetInteger(ChartID(), T3_ZIGZAGLINE + "P3-P4", OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);
   }
   if(t3p4DateTime != 0 && t3p5DateTime != 0) {
      createTrendLine(T3_ZIGZAGLINE + "P4-P5", t3p4DateTime, getT3P4HighLowValueByTrendDirection(), t3p5DateTime, getT3P5HighLowValueByTrendDirection(), lineColor, InpT3LineWidth, InpT3LineStyle);
      ObjectSetInteger(ChartID(), T3_ZIGZAGLINE + "P4-P5", OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);
   }
   if(t3p5DateTime != 0 && t3p6DateTime != 0) {
      createTrendLine(T3_ZIGZAGLINE + "P5-P6", t3p5DateTime, getT3P5HighLowValueByTrendDirection(), t3p6DateTime, getT3P6HighLowValueByTrendDirection(), lineColor, InpT3LineWidth, InpT3LineStyle);
      ObjectSetInteger(ChartID(), T3_ZIGZAGLINE + "P5-P6", OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);
   }
   if(t3p6DateTime != 0 && t3p7DateTime != 0) {
      createTrendLine(T3_ZIGZAGLINE + "P6-P7", t3p6DateTime, getT3P6HighLowValueByTrendDirection(), t3p7DateTime, getT3P7HighLowValueByTrendDirection(), lineColor, InpT3LineWidth, InpT3LineStyle);
      ObjectSetInteger(ChartID(), T3_ZIGZAGLINE + "P6-P7", OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void createT3InsideBarTrendLines() {
   int barShift = 3;
   double topValue = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, outSideBarDateTime));
   double buttomValue = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, outSideBarDateTime));

   createTrendLine(T3_INSIDEBAR_TOP_TLINE, outSideBarDateTime, topValue, iTime(Symbol(), Period(), 0), topValue, InpInsideBarLineColor, 3, STYLE_SOLID, T3_INSIDEBAR_TOP_TLINE);
   createTrendLine(T3_INSIDEBAR_BUTTOM_TLINE, outSideBarDateTime, buttomValue, iTime(Symbol(), Period(), 0), buttomValue, InpInsideBarLineColor, 3, STYLE_SOLID, T3_INSIDEBAR_BUTTOM_TLINE);
}
