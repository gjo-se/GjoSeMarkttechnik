//+------------------------------------------------------------------+
//|                                                   TrendLines.mqh |
//|                                       Copyright 2022, Gregory Jo |
//+------------------------------------------------------------------+


void createTT2ZigZagTemplateLines() {

   deleteTrendLineLike(TT2_ZIGZAGLINE);

   color lineColor = InpT2DefaultColor;
   if(tt2SemiTrendDirection == TREND_DIRECTION_LONG) lineColor = InpT2TLineZigZagTrendLongColor;
   if(tt2SemiTrendDirection == TREND_DIRECTION_SHORT) lineColor = InpT2TLineZigZagTrendShortColor;

   if(tt2p1DateTime != 0 && tt2p2DateTime != 0) {
      createTrendLine(TT2_ZIGZAGLINE + "P1-P2", tt2p1DateTime, getTT2P1HighLowValueByTrendDirection(), tt2p2DateTime, getTT2P2HighLowValueByTrendDirection(), lineColor, InpT2LineWidth, InpT2LineStyle);
      ObjectSetInteger(ChartID(), TT2_ZIGZAGLINE + "P1-P2", OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);
   }
   if(tt2p2DateTime != 0 && tt2p3DateTime != 0) {
      createTrendLine(TT2_ZIGZAGLINE + "P2-P3", tt2p2DateTime, getTT2P2HighLowValueByTrendDirection(), tt2p3DateTime, getTT2P3HighLowValueByTrendDirection(), lineColor, InpT2LineWidth, InpT2LineStyle);
      ObjectSetInteger(ChartID(), TT2_ZIGZAGLINE + "P2-P3", OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);
   }
   if(tt2p3DateTime != 0 && tt2p4DateTime != 0) {
      createTrendLine(TT2_ZIGZAGLINE + "P3-P4", tt2p3DateTime, getTT2P3HighLowValueByTrendDirection(), tt2p4DateTime, getTT2P4HighLowValueByTrendDirection(), lineColor, InpT2LineWidth, InpT2LineStyle);
      ObjectSetInteger(ChartID(), TT2_ZIGZAGLINE + "P3-P4", OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);
   }
   if(tt2p4DateTime != 0 && tt2p5DateTime != 0) {
      createTrendLine(TT2_ZIGZAGLINE + "P4-P5", tt2p4DateTime, getTT2P4HighLowValueByTrendDirection(), tt2p5DateTime, getTT2P5HighLowValueByTrendDirection(), lineColor, InpT2LineWidth, InpT2LineStyle);
      ObjectSetInteger(ChartID(), TT2_ZIGZAGLINE + "P4-P5", OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);
   }
   if(tt2p5DateTime != 0 && tt2p6DateTime != 0) {
      createTrendLine(TT2_ZIGZAGLINE + "P5-P6", tt2p5DateTime, getTT2P5HighLowValueByTrendDirection(), tt2p6DateTime, getTT2P6HighLowValueByTrendDirection(), lineColor, InpT2LineWidth, InpT2LineStyle);
      ObjectSetInteger(ChartID(), TT2_ZIGZAGLINE + "P5-P6", OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void createTT2HighVolumeAreaTrendLines() {
   int lineWidth = 2;
   color levelColor = clrBlack;
   ENUM_LINE_STYLE style = STYLE_SOLID;
   bool rayLeft = false;
   bool rayRight = true;
   long zOrder = 0;
   bool isBackground = true;
   bool isSelected = false;
   bool isSelectable = true;

   datetime startDateTime = TimeCurrent();
   if(tt2p1DateTime != 0) startDateTime = tt2p1DateTime;
   if(tt2p3DateTime != 0) startDateTime = tt2p3DateTime;
   if(tt2p5DateTime != 0) startDateTime = tt2p5DateTime;

   tt2MinHighVolumeAreaLevel = (getTrendlineLevelByText(TT2_MIN_HIGH_VOL_AREA, PERIOD_CURRENT, Symbol(), ChartID(), true));
   if(tt2MinHighVolumeAreaLevel == 0) tt2MinHighVolumeAreaLevel = InpTT2MinHighVolumeAreaLevel;

   tt2MaxHighVolumeAreaLevel = (getTrendlineLevelByText(TT2_MAX_HIGH_VOL_AREA, PERIOD_CURRENT, Symbol(), ChartID(), true));
   if(tt2MaxHighVolumeAreaLevel == 0) tt2MaxHighVolumeAreaLevel = InpTT2MaxHighVolumeAreaLevel;

   if(tt2MinHighVolumeAreaLevel != 0 && tt2MaxHighVolumeAreaLevel != 0) {
      if(ObjectFind(ChartID(), TT2_MIN_HIGH_VOL_AREA) < 0) createTrendLine(TT2_MIN_HIGH_VOL_AREA, startDateTime, tt2MinHighVolumeAreaLevel, iTime(Symbol(), PERIOD_CURRENT, 0), tt2MinHighVolumeAreaLevel, levelColor, lineWidth, style, " " + TT2_MIN_HIGH_VOL_AREA + ": " + DoubleToString(tt2MinHighVolumeAreaLevel, Digits()), rayLeft, rayRight, zOrder, isBackground, isSelected, isSelectable);
      if(ObjectFind(ChartID(), TT2_MAX_HIGH_VOL_AREA) < 0) createTrendLine(TT2_MAX_HIGH_VOL_AREA, startDateTime, tt2MaxHighVolumeAreaLevel, iTime(Symbol(), PERIOD_CURRENT, 0), tt2MaxHighVolumeAreaLevel, levelColor, lineWidth, style, " " + TT2_MAX_HIGH_VOL_AREA + ": " + DoubleToString(tt2MaxHighVolumeAreaLevel, Digits()), rayLeft, rayRight, zOrder, isBackground, isSelected, isSelectable);
   }
}

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
