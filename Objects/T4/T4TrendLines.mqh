//+------------------------------------------------------------------+
//|                                                   TrendLines.mqh |
//|                                       Copyright 2022, Gregory Jo |
//+------------------------------------------------------------------+



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void createT4TrendLines() {

   color lineColor = InpT4TrendLineColor;
   if(t4SemiTrendDirection == TREND_DIRECTION_LONG) lineColor = clrLightGreen;
   if(t4SemiTrendDirection == TREND_DIRECTION_SHORT) lineColor = clrLightPink;
   if(t4trendDirection == TREND_DIRECTION_LONG) lineColor = clrGreen;
   if(t4trendDirection == TREND_DIRECTION_SHORT) lineColor = clrRed;

   if(t4p1DateTime != 0 && t4p2DateTime != 0) createTrendLine(T4_TRENDLINE + "P1-P2", t4p1DateTime, getT4P1HighLowValueByTrendDirection(), t4p2DateTime, getT4P2HighLowValueByTrendDirection(), lineColor, 3);
   if(t4p2DateTime != 0 && t4p3DateTime != 0) createTrendLine(T4_TRENDLINE + "P2-P3", t4p2DateTime, getT4P2HighLowValueByTrendDirection(), t4p3DateTime, getT4P3HighLowValueByTrendDirection(), lineColor, 3);
   if(t4p3DateTime != 0 && t4p4DateTime != 0) createTrendLine(T4_TRENDLINE + "P3-P4", t4p3DateTime, getT4P3HighLowValueByTrendDirection(), t4p4DateTime, getT4P4HighLowValueByTrendDirection(), lineColor, 3);
   if(t4p4DateTime != 0 && t4p5DateTime != 0) createTrendLine(T4_TRENDLINE + "P4-P5", t4p4DateTime, getT4P4HighLowValueByTrendDirection(), t4p5DateTime, getT4P5HighLowValueByTrendDirection(), lineColor, 3);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void createT4HighVolumeAreaTrendLines() {
   int lineWidth = 2;
   color levelColor = clrBlack;
   ENUM_LINE_STYLE style = STYLE_SOLID;
   bool rayLeft = false;
   bool rayRight = true;
   long zOrder = 0;
   bool isBackground = true;
   bool isSelected = false;
   bool isSelectable = true;

   t4MinHighVolumeAreaLevel = (getTrendlineLevelByText(T4_MIN_HIGH_VOL_AREA, PERIOD_CURRENT, Symbol(), ChartID(), true));
   if(t4MinHighVolumeAreaLevel == 0) t4MinHighVolumeAreaLevel = InpT4MinHighVolumeAreaLevel;

   t4MaxHighVolumeAreaLevel = (getTrendlineLevelByText(T4_MAX_HIGH_VOL_AREA, PERIOD_CURRENT, Symbol(), ChartID(), true));
   if(t4MaxHighVolumeAreaLevel == 0) t4MaxHighVolumeAreaLevel = InpT4MaxHighVolumeAreaLevel;

   if(t4MinHighVolumeAreaLevel != 0 && t4MaxHighVolumeAreaLevel != 0) {
      if(ObjectFind(ChartID(), T4_MIN_HIGH_VOL_AREA) < 0) createTrendLine(T4_MIN_HIGH_VOL_AREA, t4p3DateTime, t4MinHighVolumeAreaLevel, iTime(Symbol(), PERIOD_CURRENT, 0), t4MinHighVolumeAreaLevel, levelColor, lineWidth, style, " " + T4_MIN_HIGH_VOL_AREA + ": " + DoubleToString(t4MinHighVolumeAreaLevel, Digits()), rayLeft, rayRight, zOrder, isBackground, isSelected, isSelectable);
      if(ObjectFind(ChartID(), T4_MAX_HIGH_VOL_AREA) < 0) createTrendLine(T4_MAX_HIGH_VOL_AREA, t4p3DateTime, t4MaxHighVolumeAreaLevel, iTime(Symbol(), PERIOD_CURRENT, 0), t4MaxHighVolumeAreaLevel, levelColor, lineWidth, style, " " + T4_MAX_HIGH_VOL_AREA + ": " + DoubleToString(t4MaxHighVolumeAreaLevel, Digits()), rayLeft, rayRight, zOrder, isBackground, isSelected, isSelectable);
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
   bool rayLeft = false;
   bool rayRight = true;
   long zOrder = 0;
   bool isBackground = true;
   bool isSelected = false;
   bool isSelectable = true;

   createTrendLine(T4_SHORT_ENTRY_TLINE, iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t3p3DateTime)), pT4ShortEntryLevel, iTime(Symbol(), Period(), 0), pT4ShortEntryLevel, InpT4TrendLineColor, 2, STYLE_SOLID, T4_SHORT_ENTRY_TLINE + ": " + DoubleToString(pT4ShortEntryLevel, Digits()), rayLeft, rayRight, zOrder, isBackground, isSelected, isSelectable);
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

   createTrendLine(T4_LONG_ENTRY_TLINE, iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t3p3DateTime)), pT4LongEntryLevel, iTime(Symbol(), Period(), 0), pT4LongEntryLevel, lineColor, lineWidth, lineStyle, T4_LONG_ENTRY_TLINE + ": " + DoubleToString(pT4LongEntryLevel, Digits()), rayLeft, rayRight, zOrder, isBackground, isSelected, isSelectable);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void createT4StopLossTrendline(double pStopLossLevel) {
   int barShift = 10;
   bool rayLeft = false;
   bool rayRight = true;
   long zOrder = 0;
   bool isBackground = true;
   bool isSelected = false;
   bool isSelectable = true;

   createTrendLine(T4_STOP_LOSS_TLINE, iTime(Symbol(), Period(), barShift), pStopLossLevel, iTime(Symbol(), Period(), 0), pStopLossLevel, InpT4TrendLineColor, 2, STYLE_SOLID, T4_STOP_LOSS_TLINE, rayLeft, rayRight, zOrder, isBackground, isSelected, isSelectable);
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

   if(t4trendDirection == TREND_DIRECTION_LONG) {

      // orderGridStopOrder
      for(int orderGridId = 1; orderGridId < InpT4OrderGridCount; orderGridId++)  {
         double minRegressionPoints = (getT4P4HighLowValueByTrendDirection() / Point() - t4LowestLowValue / Point()) * InpT4MinRegressionPercent / 100;
         orderGridStopOrderValue = t4LongEntryValue + (minRegressionPoints / InpT4OrderGridCount * orderGridId * Point());
         string realVolume = DoubleToString(getT4BuyVolume(orderGridStopOrderValue), 2);
         string verifiedVolume = DoubleToString(VerifyVolume(Symbol(), getT4BuyVolume(orderGridStopOrderValue)), 2);
         createTrendLine(T4_ORDER_GRID_STOP_TLINE + "_" + IntegerToString(orderGridId), iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t4LowestLowDateTime) + barShift), orderGridStopOrderValue, iTime(Symbol(), Period(), 0), orderGridStopOrderValue, InpT4TrendLineColor, 1, STYLE_SOLID, T4_ORDER_GRID_STOP_TLINE + "_" + IntegerToString(orderGridId) + " V: " + realVolume + " (" + verifiedVolume + ")");
         ArrayResize(t4OrderGridStopOrderValuesArray, ArraySize(t4OrderGridStopOrderValuesArray) + 1);
         t4OrderGridStopOrderValuesArray[ArraySize(t4OrderGridStopOrderValuesArray) - 1] = orderGridStopOrderValue;
      }

      // orderGridLimitOrder
      for(int orderGridId = 1; orderGridId < InpT4OrderGridCount; orderGridId++) {
         double minRegressionPoints = (getT4P4HighLowValueByTrendDirection() / Point() - t4LowestLowValue / Point()) * InpT4MinRegressionPercent / 100;
         orderGridLimitOrderValue = t4LongEntryValue - (minRegressionPoints / InpT4OrderGridCount * orderGridId * Point());
         string realVolume = DoubleToString(getT4BuyVolume(orderGridLimitOrderValue), 2);
         string verifiedVolume = DoubleToString(VerifyVolume(Symbol(), getT4BuyVolume(orderGridLimitOrderValue)), 2);
         createTrendLine(T4_ORDER_GRID_LIMIT_TLINE + "_" + IntegerToString(orderGridId), iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t4LowestLowDateTime) + barShift), orderGridLimitOrderValue, iTime(Symbol(), Period(), 0), orderGridLimitOrderValue, InpT4TrendLineColor, 1, STYLE_SOLID, T4_ORDER_GRID_LIMIT_TLINE + "_" + IntegerToString(orderGridId) + " V: " + realVolume + " (" + verifiedVolume + ")");

         ArrayResize(t4OrderGridLimitOrderValuesArray, ArraySize(t4OrderGridLimitOrderValuesArray) + 1);
         t4OrderGridLimitOrderValuesArray[ArraySize(t4OrderGridLimitOrderValuesArray) - 1] = orderGridLimitOrderValue;
      }
   }

   if(t4trendDirection == TREND_DIRECTION_SHORT) {

      // orderGridStopOrder
      for(int orderGridId = 1; orderGridId < InpT4OrderGridCount; orderGridId++)  {
         double minRegressionPoints = (t4HighestHighValue / Point() - getT4P4HighLowValueByTrendDirection() / Point()) * InpT4MinRegressionPercent / 100;
         orderGridStopOrderValue = t4ShortEntryValue - (minRegressionPoints / InpT4OrderGridCount * orderGridId * Point());
         string realVolume = DoubleToString(getT4SellVolume(orderGridStopOrderValue), 2);
         string verifiedVolume = DoubleToString(VerifyVolume(Symbol(), getT4SellVolume(orderGridStopOrderValue)), 2);
         createTrendLine(T4_ORDER_GRID_STOP_TLINE + "_" + IntegerToString(orderGridId), iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t4HighestHighDateTime) + barShift), orderGridStopOrderValue, iTime(Symbol(), Period(), 0), orderGridStopOrderValue, InpT4TrendLineColor, 1, STYLE_SOLID, T4_ORDER_GRID_STOP_TLINE + "_" + IntegerToString(orderGridId) + " V: " + realVolume + " (" + verifiedVolume + ")");
         ArrayResize(t4OrderGridStopOrderValuesArray, ArraySize(t4OrderGridStopOrderValuesArray) + 1);
         t4OrderGridStopOrderValuesArray[ArraySize(t4OrderGridStopOrderValuesArray) - 1] = orderGridStopOrderValue;
      }

      // orderGridLimitOrder
      for(int orderGridId = 1; orderGridId < InpT4OrderGridCount; orderGridId++) {
         double minRegressionPoints = (t4HighestHighValue / Point() - getT4P4HighLowValueByTrendDirection() / Point()) * InpT4MinRegressionPercent / 100;
         orderGridLimitOrderValue = t4ShortEntryValue + (minRegressionPoints / InpT4OrderGridCount * orderGridId * Point());
         string realVolume = DoubleToString(getT4SellVolume(orderGridLimitOrderValue), 2);
         string verifiedVolume = DoubleToString(VerifyVolume(Symbol(), getT4SellVolume(orderGridLimitOrderValue)), 2);
         createTrendLine(T4_ORDER_GRID_LIMIT_TLINE + "_" + IntegerToString(orderGridId), iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t4HighestHighDateTime) + barShift), orderGridLimitOrderValue, iTime(Symbol(), Period(), 0), orderGridLimitOrderValue, InpT4TrendLineColor, 1, STYLE_SOLID, T4_ORDER_GRID_LIMIT_TLINE + "_" + IntegerToString(orderGridId) + " V: " + realVolume + " (" + verifiedVolume + ")");

         ArrayResize(t4OrderGridLimitOrderValuesArray, ArraySize(t4OrderGridLimitOrderValuesArray) + 1);
         t4OrderGridLimitOrderValuesArray[ArraySize(t4OrderGridLimitOrderValuesArray) - 1] = orderGridLimitOrderValue;
      }
   }
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
