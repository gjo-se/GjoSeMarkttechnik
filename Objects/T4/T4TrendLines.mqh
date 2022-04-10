//+------------------------------------------------------------------+
//|                                                   TrendLines.mqh |
//|                                       Copyright 2022, Gregory Jo |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void createT4ZigZagTrendDetectionLines() {

   color lineColor = InpT4DefaultColor;
   if(t4SemiTrendDirection == TREND_DIRECTION_LONG) lineColor = InpT4TLineZigZagTrendLongColor;
   if(t4SemiTrendDirection == TREND_DIRECTION_SHORT) lineColor = InpT4TLineZigZagTrendShortColor;

   if(t4p1DateTime != 0 && t4p2DateTime != 0) {
      createTrendLine(T4_ZIGZAGLINE + "P1-P2", t4p1DateTime, getT4P1HighLowValueByTrendDirection(), t4p2DateTime, getT4P2HighLowValueByTrendDirection(), lineColor, InpT4LineWidth, InpT4LineStyle);
      ObjectSetInteger(ChartID(), T4_ZIGZAGLINE + "P1-P2", OBJPROP_TIMEFRAMES, InpT4VisibleTimeframes);
   }
   if(t4p2DateTime != 0 && t4p3DateTime != 0) {
      createTrendLine(T4_ZIGZAGLINE + "P2-P3", t4p2DateTime, getT4P2HighLowValueByTrendDirection(), t4p3DateTime, getT4P3HighLowValueByTrendDirection(), lineColor, InpT4LineWidth, InpT4LineStyle);
      ObjectSetInteger(ChartID(), T4_ZIGZAGLINE + "P2-P3", OBJPROP_TIMEFRAMES, InpT4VisibleTimeframes);
   }
   if(t4p3DateTime != 0 && t4p4DateTime != 0) {
      createTrendLine(T4_ZIGZAGLINE + "P3-P4", t4p3DateTime, getT4P3HighLowValueByTrendDirection(), t4p4DateTime, getT4P4HighLowValueByTrendDirection(), lineColor, InpT4LineWidth, InpT4LineStyle);
      ObjectSetInteger(ChartID(), T4_ZIGZAGLINE + "P3-P4", OBJPROP_TIMEFRAMES, InpT4VisibleTimeframes);
   }
   if(t4p4DateTime != 0 && t4p5DateTime != 0) {
      createTrendLine(T4_ZIGZAGLINE + "P4-P5", t4p4DateTime, getT4P4HighLowValueByTrendDirection(), t4p5DateTime, getT4P5HighLowValueByTrendDirection(), lineColor, InpT4LineWidth, InpT4LineStyle);
      ObjectSetInteger(ChartID(), T4_ZIGZAGLINE + "P4-P5", OBJPROP_TIMEFRAMES, InpT4VisibleTimeframes);
   }
}

// SHORT
void createT4HighestHighTrendLine() {
   createTrendLine(T4_HIGHEST_HIGH_TLINE, iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t4HighestHighDateTime) + 3), t4HighestHighValue, iTime(Symbol(), Period(), 0), t4HighestHighValue, InpT4TrendLineColor, 3, STYLE_SOLID, T4_HIGHEST_HIGH_TLINE);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void createT4ShortEntryTrendLine(double pT4ShortEntryLevel) {
   int lineWidth = 1;
   color lineColor = clrCrimson;
   ENUM_LINE_STYLE lineStyle = STYLE_DASHDOT;
   bool rayLeft = false;
   bool rayRight = true;
   long zOrder = 0;
   bool isBackground = true;
   bool isSelected = false;
   bool isSelectable = true;

   string realVolume = DoubleToString(getT4SellVolume(), 2);
   string verifiedVolume = DoubleToString(VerifyVolume(Symbol(), getT4SellVolume()), 2);
   string lineText = T4_SHORT_ENTRY_TLINE + ": " + DoubleToString(pT4ShortEntryLevel, Digits()) + " Vol: " + realVolume + " (" + verifiedVolume + ")";

   createTrendLine(T4_SHORT_ENTRY_TLINE, iTime(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t3p3DateTime)), pT4ShortEntryLevel, iTime(Symbol(), PERIOD_M1, 0), pT4ShortEntryLevel, lineColor, lineWidth, lineStyle, lineText, rayLeft, rayRight, zOrder, isBackground, isSelected, isSelectable);
}

// LONG
void createT4LowestLowTrendLine() {
   createTrendLine(T4_LOWEST_LOW_TLINE, iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t4LowestLowDateTime) + 3), t4LowestLowValue, iTime(Symbol(), Period(), 0), t4LowestLowValue, InpT4TrendLineColor, 3, STYLE_SOLID, T4_LOWEST_LOW_TLINE);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void createT4LongEntryTrendLine(double pT4LongEntryLevel) {
   int lineWidth = 1;
   color lineColor = clrCrimson;
   ENUM_LINE_STYLE lineStyle = STYLE_DASHDOT;
   bool rayLeft = false;
   bool rayRight = true;
   long zOrder = 0;
   bool isBackground = true;
   bool isSelected = false;
   bool isSelectable = true;

   string realVolume = DoubleToString(getT4BuyVolume(), 2);
   string verifiedVolume = DoubleToString(VerifyVolume(Symbol(), getT4BuyVolume()), 2);
   string lineText = T4_LONG_ENTRY_TLINE + ": " + DoubleToString(pT4LongEntryLevel, Digits()) + " Vol: " + realVolume + " (" + verifiedVolume + ")";

   createTrendLine(T4_LONG_ENTRY_TLINE, iTime(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t3p3DateTime)), pT4LongEntryLevel, iTime(Symbol(), PERIOD_M1, 0), pT4LongEntryLevel, lineColor, lineWidth, lineStyle, lineText, rayLeft, rayRight, zOrder, isBackground, isSelected, isSelectable);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void createT4StopLossTrendline(double pStopLossLevel) {
   int lineWidth = 1;
   color lineColor = clrIndianRed;
   ENUM_LINE_STYLE lineStyle = STYLE_DASHDOT;
   int barShift = 10;
   bool rayLeft = false;
   bool rayRight = true;
   long zOrder = 0;
   bool isBackground = true;
   bool isSelected = false;
   bool isSelectable = true;

   createTrendLine(T4_STOP_LOSS_TLINE, iTime(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t3p3DateTime)), pStopLossLevel, iTime(Symbol(), PERIOD_M1, 0), pStopLossLevel, lineColor, lineWidth, lineStyle, T4_STOP_LOSS_TLINE + ": " + DoubleToString(pStopLossLevel, Digits()), rayLeft, rayRight, zOrder, isBackground, isSelected, isSelectable);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void createT4TrailingStopTrendLine() {
   int barShift = 3;
   createTrendLine(T4_TRAILING_STOP_TLINE, iTime(Symbol(), Period(), barShift), t4TrailingStopLevel, iTime(Symbol(), Period(), 0), t4TrailingStopLevel, InpT4TailingStopLineColor, 3, STYLE_SOLID, T4_TRAILING_STOP_TLINE);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void createT4InsideBarTrendLines() {
   int barShift = 3;
   double topValue = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, outSideBarDateTime));
   double buttomValue = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, outSideBarDateTime));

   createTrendLine(T4_INSIDEBAR_TOP_TLINE, outSideBarDateTime, topValue, iTime(Symbol(), Period(), 0), topValue, InpInsideBarLineColor, 3, STYLE_SOLID, T4_INSIDEBAR_TOP_TLINE);
   createTrendLine(T4_INSIDEBAR_BUTTOM_TLINE, outSideBarDateTime, buttomValue, iTime(Symbol(), Period(), 0), buttomValue, InpInsideBarLineColor, 3, STYLE_SOLID, T4_INSIDEBAR_BUTTOM_TLINE);
}

void createT4OrderGridTrendLines() {

   int barShift = 10;
   double orderGridLimitOrderValue = 0;
   double orderGridStopOrderValue = 0;

   ArrayResize(t4OrderGridLimitOrderValuesArray, 0);
   ArrayResize(t4OrderGridStopOrderValuesArray, 0);

//   if(t4trendDirection == TREND_DIRECTION_LONG) {

// orderGridStopOrder
//      for(int orderGridId = 1; orderGridId < InpT4OrderGridCount; orderGridId++)  {
//         double minRegressionPoints = (getT4P4HighLowValueByTrendDirection() / Point() - t4LowestLowValue / Point()) * InpT4MinRegressionPercent / 100;
//         orderGridStopOrderValue = t4LongEntryValue + (minRegressionPoints / InpT4OrderGridCount * orderGridId * Point());
//         string realVolume = DoubleToString(getT4BuyVolume(orderGridStopOrderValue), 2);
//         string verifiedVolume = DoubleToString(VerifyVolume(Symbol(), getT4BuyVolume(orderGridStopOrderValue)), 2);
//         createTrendLine(T4_ORDER_GRID_STOP_TLINE + "_" + IntegerToString(orderGridId), iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t4LowestLowDateTime) + barShift), orderGridStopOrderValue, iTime(Symbol(), Period(), 0), orderGridStopOrderValue, InpT4TrendLineColor, 1, STYLE_SOLID, T4_ORDER_GRID_STOP_TLINE + "_" + IntegerToString(orderGridId) + " V: " + realVolume + " (" + verifiedVolume + ")");
//         ArrayResize(t4OrderGridStopOrderValuesArray, ArraySize(t4OrderGridStopOrderValuesArray) + 1);
//         t4OrderGridStopOrderValuesArray[ArraySize(t4OrderGridStopOrderValuesArray) - 1] = orderGridStopOrderValue;
//      }
//
//      // orderGridLimitOrder
//      for(int orderGridId = 1; orderGridId < InpT4OrderGridCount; orderGridId++) {
//         double minRegressionPoints = (getT4P4HighLowValueByTrendDirection() / Point() - t4LowestLowValue / Point()) * InpT4MinRegressionPercent / 100;
//         orderGridLimitOrderValue = t4LongEntryValue - (minRegressionPoints / InpT4OrderGridCount * orderGridId * Point());
//         string realVolume = DoubleToString(getT4BuyVolume(orderGridLimitOrderValue), 2);
//         string verifiedVolume = DoubleToString(VerifyVolume(Symbol(), getT4BuyVolume(orderGridLimitOrderValue)), 2);
//         createTrendLine(T4_ORDER_GRID_LIMIT_TLINE + "_" + IntegerToString(orderGridId), iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t4LowestLowDateTime) + barShift), orderGridLimitOrderValue, iTime(Symbol(), Period(), 0), orderGridLimitOrderValue, InpT4TrendLineColor, 1, STYLE_SOLID, T4_ORDER_GRID_LIMIT_TLINE + "_" + IntegerToString(orderGridId) + " V: " + realVolume + " (" + verifiedVolume + ")");
//
//         ArrayResize(t4OrderGridLimitOrderValuesArray, ArraySize(t4OrderGridLimitOrderValuesArray) + 1);
//         t4OrderGridLimitOrderValuesArray[ArraySize(t4OrderGridLimitOrderValuesArray) - 1] = orderGridLimitOrderValue;
//      }
//   }

//   if(t4trendDirection == TREND_DIRECTION_SHORT) {
//
//      // orderGridStopOrder
//      for(int orderGridId = 1; orderGridId < InpT4OrderGridCount; orderGridId++)  {
//         double minRegressionPoints = (t4HighestHighValue / Point() - getT4P4HighLowValueByTrendDirection() / Point()) * InpT4MinRegressionPercent / 100;
//         orderGridStopOrderValue = t4ShortEntryValue - (minRegressionPoints / InpT4OrderGridCount * orderGridId * Point());
//         string realVolume = DoubleToString(getT4SellVolume(orderGridStopOrderValue), 2);
//         string verifiedVolume = DoubleToString(VerifyVolume(Symbol(), getT4SellVolume(orderGridStopOrderValue)), 2);
//         createTrendLine(T4_ORDER_GRID_STOP_TLINE + "_" + IntegerToString(orderGridId), iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t4HighestHighDateTime) + barShift), orderGridStopOrderValue, iTime(Symbol(), Period(), 0), orderGridStopOrderValue, InpT4TrendLineColor, 1, STYLE_SOLID, T4_ORDER_GRID_STOP_TLINE + "_" + IntegerToString(orderGridId) + " V: " + realVolume + " (" + verifiedVolume + ")");
//         ArrayResize(t4OrderGridStopOrderValuesArray, ArraySize(t4OrderGridStopOrderValuesArray) + 1);
//         t4OrderGridStopOrderValuesArray[ArraySize(t4OrderGridStopOrderValuesArray) - 1] = orderGridStopOrderValue;
//      }
//
//      // orderGridLimitOrder
//      for(int orderGridId = 1; orderGridId < InpT4OrderGridCount; orderGridId++) {
//         double minRegressionPoints = (t4HighestHighValue / Point() - getT4P4HighLowValueByTrendDirection() / Point()) * InpT4MinRegressionPercent / 100;
//         orderGridLimitOrderValue = t4ShortEntryValue + (minRegressionPoints / InpT4OrderGridCount * orderGridId * Point());
//         string realVolume = DoubleToString(getT4SellVolume(orderGridLimitOrderValue), 2);
//         string verifiedVolume = DoubleToString(VerifyVolume(Symbol(), getT4SellVolume(orderGridLimitOrderValue)), 2);
//         createTrendLine(T4_ORDER_GRID_LIMIT_TLINE + "_" + IntegerToString(orderGridId), iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t4HighestHighDateTime) + barShift), orderGridLimitOrderValue, iTime(Symbol(), Period(), 0), orderGridLimitOrderValue, InpT4TrendLineColor, 1, STYLE_SOLID, T4_ORDER_GRID_LIMIT_TLINE + "_" + IntegerToString(orderGridId) + " V: " + realVolume + " (" + verifiedVolume + ")");
//
//         ArrayResize(t4OrderGridLimitOrderValuesArray, ArraySize(t4OrderGridLimitOrderValuesArray) + 1);
//         t4OrderGridLimitOrderValuesArray[ArraySize(t4OrderGridLimitOrderValuesArray) - 1] = orderGridLimitOrderValue;
//      }
//   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void setT4TrendLineValues() {
   t4LongEntryValue = ObjectGetDouble(ChartID(), T4_LONG_ENTRY_TLINE, OBJPROP_PRICE, 1);
   t4ShortEntryValue = ObjectGetDouble(ChartID(), T4_SHORT_ENTRY_TLINE, OBJPROP_PRICE, 1);

   t4HighestHighValue = getTrendlineLevelByText(T4_HIGHEST_HIGH_TLINE, PERIOD_CURRENT, Symbol(), ChartID());
   t4LowestLowValue = getTrendlineLevelByText(T4_LOWEST_LOW_TLINE, PERIOD_CURRENT, Symbol(), ChartID());
}
//+------------------------------------------------------------------+
