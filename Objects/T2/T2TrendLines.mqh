//+------------------------------------------------------------------+
//|                                                   TrendLines.mqh |
//|                                       Copyright 2022, Gregory Jo |
//+------------------------------------------------------------------+



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void createT2ZigZagTrendDetectionLines() {

   color lineColor = InpT2DefaultColor;
   if(t2SemiTrendDirection == TREND_DIRECTION_LONG) lineColor = InpT2TLineZigZagTrendLongColor;
   if(t2SemiTrendDirection == TREND_DIRECTION_SHORT) lineColor = InpT2TLineZigZagTrendShortColor;

   deleteTrendLineLike(T2_ZIGZAGLINE);

   if(t2p1DateTime != 0 && t2p2DateTime != 0) {
      createTrendLine(T2_ZIGZAGLINE + "P1-P2", t2p1DateTime, getT2P1HighLowValueByTrendDirection(), t2p2DateTime, getT2P2HighLowValueByTrendDirection(), lineColor, InpT2LineWidth, InpT2LineStyle);
      ObjectSetInteger(ChartID(), T2_ZIGZAGLINE + "P1-P2", OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);
   }
   if(t2p2DateTime != 0 && t2p3DateTime != 0) {
      createTrendLine(T2_ZIGZAGLINE + "P2-P3", t2p2DateTime, getT2P2HighLowValueByTrendDirection(), t2p3DateTime, getT2P3HighLowValueByTrendDirection(), lineColor, InpT2LineWidth, InpT2LineStyle);
      ObjectSetInteger(ChartID(), T2_ZIGZAGLINE + "P2-P3", OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);
   }
   if(t2p3DateTime != 0 && t2p4DateTime != 0) {
      createTrendLine(T2_ZIGZAGLINE + "P3-P4", t2p3DateTime, getT2P3HighLowValueByTrendDirection(), t2p4DateTime, getT2P4HighLowValueByTrendDirection(), lineColor, InpT2LineWidth, InpT2LineStyle);
      ObjectSetInteger(ChartID(), T2_ZIGZAGLINE + "P3-P4", OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);
   }
   if(t2p4DateTime != 0 && t2p5DateTime != 0) {
      createTrendLine(T2_ZIGZAGLINE + "P4-P5", t2p4DateTime, getT2P4HighLowValueByTrendDirection(), t2p5DateTime, getT2P5HighLowValueByTrendDirection(), lineColor, InpT2LineWidth, InpT2LineStyle);
      ObjectSetInteger(ChartID(), T2_ZIGZAGLINE + "P4-P5", OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void createT2HighVolumeAreaTrendLines() {
   int lineWidth = 2;
   color levelColor = clrMaroon;
   ENUM_LINE_STYLE style = STYLE_SOLID;
   bool rayLeft = false;
   bool rayRight = true;
   long zOrder = 0;
   bool isBackground = true;
   bool isSelected = false;
   bool isSelectable = true;

   if(ObjectFind(ChartID(), T2_MAX_HIGH_VOL_AREA) >= 0) {
      deleteTrendLine(T2_MAX_HIGH_VOL_AREA, ChartID());
      t2MaxHighVolumeAreaLevel = 0;
   }
   if(ObjectFind(ChartID(), T2_MIN_HIGH_VOL_AREA) >= 0) {
      deleteTrendLine(T2_MIN_HIGH_VOL_AREA, ChartID());
      t2MinHighVolumeAreaLevel = 0;
   }
   if(ObjectFind(ChartID(), T2_HIGH_VOL_CHANNEL) >= 0) {
      deleteChannel(ChartID(), T2_HIGH_VOL_CHANNEL);
   }

   t2MaxHighVolumeAreaLevel = ObjectGetDouble(ChartID(), T2_MAX_HIGH_VOL_AREA, OBJPROP_PRICE, 0);
   if(t2MaxHighVolumeAreaLevel == 0) t2MaxHighVolumeAreaLevel = InpT2MaxHighVolumeAreaLevel;

   t2MinHighVolumeAreaLevel = ObjectGetDouble(ChartID(), T2_MIN_HIGH_VOL_AREA, OBJPROP_PRICE, 0);
   if(t2MinHighVolumeAreaLevel == 0) t2MinHighVolumeAreaLevel = InpT2MinHighVolumeAreaLevel;

   if(t2MinHighVolumeAreaLevel != 0 && t2MaxHighVolumeAreaLevel != 0) {
      if(ObjectFind(ChartID(), T2_MAX_HIGH_VOL_AREA) < 0) {
         createTrendLine(T2_MAX_HIGH_VOL_AREA, t2p3DateTime, t2MaxHighVolumeAreaLevel, iTime(Symbol(), PERIOD_CURRENT, 0), t2MaxHighVolumeAreaLevel, levelColor, lineWidth, style, " " + T2_MAX_HIGH_VOL_AREA + ": " + DoubleToString(t2MaxHighVolumeAreaLevel, Digits()), rayLeft, rayRight, zOrder, isBackground, isSelected, isSelectable);
         ObjectSetInteger(ChartID(), T2_MAX_HIGH_VOL_AREA, OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);
      }
      if(ObjectFind(ChartID(), T2_MIN_HIGH_VOL_AREA) < 0) {
         createTrendLine(T2_MIN_HIGH_VOL_AREA, t2p3DateTime, t2MinHighVolumeAreaLevel, iTime(Symbol(), PERIOD_CURRENT, 0), t2MinHighVolumeAreaLevel, levelColor, lineWidth, style, " " + T2_MIN_HIGH_VOL_AREA + ": " + DoubleToString(t2MinHighVolumeAreaLevel, Digits()), rayLeft, rayRight, zOrder, isBackground, isSelected, isSelectable);
         ObjectSetInteger(ChartID(), T2_MIN_HIGH_VOL_AREA, OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);
      }
   }
}
//+------------------------------------------------------------------+
