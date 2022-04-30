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
}

// SHORT
void createT3HighestHighTrendLine() {
   createTrendLine(T3_HIGHEST_HIGH_TLINE, iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t3HighestHighDateTime) + 3), t3HighestHighValue, iTime(Symbol(), Period(), 0), t3HighestHighValue, InpT3TrendLineColor, 3, STYLE_SOLID, T3_HIGHEST_HIGH_TLINE);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void createT3ShortEntryTrendLine() {
   createTrendLine(T3_SHORT_ENTRY_TLINE, iTime(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t3HighestHighDateTime) + 3), t3ShortEntryValue, iTime(Symbol(), PERIOD_M1, 0), t3ShortEntryValue, InpT3TrendLineColor, 3, STYLE_SOLID, T3_SHORT_ENTRY_TLINE);
}

// LONG
void createT3LowestLowTrendLine() {
   createTrendLine(T3_LOWEST_LOW_TLINE, iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t3LowestLowDateTime) + 3), t3LowestLowValue, iTime(Symbol(), Period(), 0), t3LowestLowValue, InpT3TrendLineColor, 3, STYLE_SOLID, T3_LOWEST_LOW_TLINE);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void createT3LongEntryTrendLine() {
   createTrendLine(T3_LONG_ENTRY_TLINE, iTime(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t3LowestLowDateTime) + 3), t3LongEntryValue, iTime(Symbol(), PERIOD_M1, 0), t3LongEntryValue, InpT3TrendLineColor, 3, STYLE_SOLID, T3_LONG_ENTRY_TLINE);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void createT3StopLossTrendline(double pStopLossLevel) {
   int barShift = 10;
   bool rayLeft = false;
   bool rayRight = true;
   long zOrder = 0;
   bool isBackground = true;
   bool isSelected = false;
   bool isSelectable = true;

   createTrendLine(T3_STOP_LOSS_TLINE, iTime(Symbol(), PERIOD_M1, barShift), pStopLossLevel, iTime(Symbol(), PERIOD_M1, 0), pStopLossLevel, InpT3TrendLineColor, 2, STYLE_SOLID, T3_STOP_LOSS_TLINE, rayLeft, rayRight, zOrder, isBackground, isSelected, isSelectable);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void createT3TrailingStopTrendLine() {
   int barShift = 3;
   createTrendLine(T3_TRAILING_STOP_TLINE, iTime(Symbol(), PERIOD_M1, barShift), t3TrailingStopLevel, iTime(Symbol(), PERIOD_M1, 0), t3TrailingStopLevel, InpT3TailingStopLineColor, 3, STYLE_SOLID, T3_TRAILING_STOP_TLINE);
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

void createT3OrderGridTrendLines() {

   int barShift = 10;
   double orderGridLimitOrderValue = 0;
   double orderGridStopOrderValue = 0;

   initializeArray(t3OrderGridLimitOrderValuesArray);
   initializeArray(t3OrderGridStopOrderValuesArray);

   if(t3trendDirection == TREND_DIRECTION_LONG) {

      color  gridLineColor = clrMaroon;

      // orderGridStopOrder
      for(int orderGridId = 1; orderGridId < InpT3OrderGridCount; orderGridId++)  {
         double minRegressionPoints = t3LongEntryValue / Point() - t3LowestLowValue / Point();
         orderGridStopOrderValue = t3LongEntryValue + (minRegressionPoints / InpT3OrderGridCount * orderGridId * Point());
         string realVolume = DoubleToString(getT3BuyVolume(orderGridStopOrderValue), 2);
         string verifiedVolume = DoubleToString(VerifyVolume(Symbol(), getT3BuyVolume(orderGridStopOrderValue)), 2);
         createTrendLine(T3_ORDER_GRID_STOP_TLINE + "_" + IntegerToString(orderGridId), t3p4DateTime, orderGridStopOrderValue, iTime(Symbol(), Period(), 0), orderGridStopOrderValue, gridLineColor, 1, STYLE_DOT, T3_ORDER_GRID_STOP_TLINE + "_" + IntegerToString(orderGridId) + " V: " + realVolume + " (" + verifiedVolume + "): " +  DoubleToString(orderGridStopOrderValue, Digits()));
         ArrayResize(t3OrderGridStopOrderValuesArray, ArraySize(t3OrderGridStopOrderValuesArray) + 1);
         t3OrderGridStopOrderValuesArray[ArraySize(t3OrderGridStopOrderValuesArray) - 1] = orderGridStopOrderValue;
      }

      // orderGridLimitOrder
      for(int orderGridId = 1; orderGridId < InpT3OrderGridCount; orderGridId++) {
         double minRegressionPoints = t3LongEntryValue / Point() - t3LowestLowValue / Point();
         orderGridLimitOrderValue = t3LongEntryValue - (minRegressionPoints / InpT3OrderGridCount * orderGridId * Point());
         string realVolume = DoubleToString(getT3BuyVolume(orderGridLimitOrderValue), 2);
         string verifiedVolume = DoubleToString(VerifyVolume(Symbol(), getT3BuyVolume(orderGridLimitOrderValue)), 2);
         createTrendLine(T3_ORDER_GRID_LIMIT_TLINE + "_" + IntegerToString(orderGridId), t3p4DateTime, orderGridLimitOrderValue, iTime(Symbol(), Period(), 0), orderGridLimitOrderValue, gridLineColor, 1, STYLE_DOT, T3_ORDER_GRID_LIMIT_TLINE + "_" + IntegerToString(orderGridId) + " V: " + realVolume + " (" + verifiedVolume + "): " + DoubleToString(orderGridLimitOrderValue, Digits()));
         ArrayResize(t3OrderGridLimitOrderValuesArray, ArraySize(t3OrderGridLimitOrderValuesArray) + 1);
         t3OrderGridLimitOrderValuesArray[ArraySize(t3OrderGridLimitOrderValuesArray) - 1] = orderGridLimitOrderValue;
      }
   }

   if(t3trendDirection == TREND_DIRECTION_SHORT) {

      color  gridLineColor = clrMaroon;

      // orderGridStopOrder
      for(int orderGridId = 1; orderGridId < InpT3OrderGridCount; orderGridId++)  {
         double minRegressionPoints = t3HighestHighValue / Point() - t3ShortEntryValue / Point();
         orderGridStopOrderValue = t3ShortEntryValue - (minRegressionPoints / InpT3OrderGridCount * orderGridId * Point());
         string realVolume = DoubleToString(getT3SellVolume(orderGridStopOrderValue), 2);
         string verifiedVolume = DoubleToString(VerifyVolume(Symbol(), getT3SellVolume(orderGridStopOrderValue)), 2);
         createTrendLine(T3_ORDER_GRID_STOP_TLINE + "_" + IntegerToString(orderGridId), t3p4DateTime, orderGridStopOrderValue, iTime(Symbol(), Period(), 0), orderGridStopOrderValue, gridLineColor, 1, STYLE_DOT, T3_ORDER_GRID_STOP_TLINE + "_" + IntegerToString(orderGridId) + " V: " + realVolume + " (" + verifiedVolume + "): " +  DoubleToString(orderGridStopOrderValue, Digits()));
         ArrayResize(t3OrderGridStopOrderValuesArray, ArraySize(t3OrderGridStopOrderValuesArray) + 1);
         t3OrderGridStopOrderValuesArray[ArraySize(t3OrderGridStopOrderValuesArray) - 1] = orderGridStopOrderValue;
      }

      // orderGridLimitOrder
      for(int orderGridId = 1; orderGridId < InpT3OrderGridCount; orderGridId++) {
         double minRegressionPoints = t3HighestHighValue / Point() - t3ShortEntryValue / Point();
         orderGridLimitOrderValue = t3ShortEntryValue + (minRegressionPoints / InpT3OrderGridCount * orderGridId * Point());
         string realVolume = DoubleToString(getT3SellVolume(orderGridLimitOrderValue), 2);
         string verifiedVolume = DoubleToString(VerifyVolume(Symbol(), getT3SellVolume(orderGridLimitOrderValue)), 2);
         createTrendLine(T3_ORDER_GRID_LIMIT_TLINE + "_" + IntegerToString(orderGridId), t3p4DateTime, orderGridLimitOrderValue, iTime(Symbol(), Period(), 0), orderGridLimitOrderValue, gridLineColor, 1, STYLE_DOT, T3_ORDER_GRID_LIMIT_TLINE + "_" + IntegerToString(orderGridId) + " V: " + realVolume + " (" + verifiedVolume + "): " +  DoubleToString(orderGridLimitOrderValue, Digits()));
         ArrayResize(t3OrderGridLimitOrderValuesArray, ArraySize(t3OrderGridLimitOrderValuesArray) + 1);
         t3OrderGridLimitOrderValuesArray[ArraySize(t3OrderGridLimitOrderValuesArray) - 1] = orderGridLimitOrderValue;
      }
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void setT3TrendLineValues() {
   t3LongEntryValue = ObjectGetDouble(ChartID(), T3_LONG_ENTRY_TLINE, OBJPROP_PRICE, 1);
   t3ShortEntryValue = ObjectGetDouble(ChartID(), T3_SHORT_ENTRY_TLINE, OBJPROP_PRICE, 1);

   t3HighestHighValue = getTrendlineLevelByText(T3_HIGHEST_HIGH_TLINE, PERIOD_CURRENT, Symbol(), ChartID());
   t3LowestLowValue = getTrendlineLevelByText(T3_LOWEST_LOW_TLINE, PERIOD_CURRENT, Symbol(), ChartID());
}
//+------------------------------------------------------------------+
