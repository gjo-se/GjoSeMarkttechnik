//+------------------------------------------------------------------+
//|                                                   TrendLines.mqh |
//|                                       Copyright 2022, Gregory Jo |
//+------------------------------------------------------------------+



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void createT4TrendLines() {
   if(t4p1DateTime != 0 && t4p2DateTime != 0) createTrendLine(T4_TRENDLINE + "P1-P2", t4p1DateTime, getT4P1HighLowValueByTrendDirection(), t4p2DateTime, getT4P2HighLowValueByTrendDirection(), InpT4TrendLineColor, 3);
   if(t4p2DateTime != 0 && t4p3DateTime != 0) createTrendLine(T4_TRENDLINE + "P2-P3", t4p2DateTime, getT4P2HighLowValueByTrendDirection(), t4p3DateTime, getT4P3HighLowValueByTrendDirection(), InpT4TrendLineColor, 3);
   if(t4p3DateTime != 0 && t4p4DateTime != 0) createTrendLine(T4_TRENDLINE + "P3-P4", t4p3DateTime, getT4P3HighLowValueByTrendDirection(), t4p4DateTime, getT4P4HighLowValueByTrendDirection(), InpT4TrendLineColor, 3);
}

// SHORT
void createT4HighestHighTrendLine() {
   createTrendLine(T4_HIGHEST_HIGH_TLINE, iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t4HighestHighDateTime) + 3), t4HighestHighValue, iTime(Symbol(), Period(), 0), t4HighestHighValue, InpT4TrendLineColor, 3, STYLE_SOLID, T4_HIGHEST_HIGH_TLINE);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void createT4ShortEntryTrendLine() {
   t4ShortEntryValue = t4HighestHighValue - InpT4StopLoss * Point();
   createTrendLine(T4_SHORT_ENTRY_TLINE, iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t4HighestHighDateTime) + 3), t4ShortEntryValue, iTime(Symbol(), Period(), 0), t4ShortEntryValue, InpT4TrendLineColor, 3, STYLE_SOLID, T4_SHORT_ENTRY_TLINE);
}

// LONG
void createT4LowestLowTrendLine() {
   t4LowestLowValue = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4LowestLowDateTime));
   createTrendLine(T4_LOWEST_LOW_TLINE, iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t4LowestLowDateTime) + 3), t4LowestLowValue, iTime(Symbol(), Period(), 0), t4LowestLowValue, InpT4TrendLineColor, 3, STYLE_SOLID, T4_LOWEST_LOW_TLINE);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void createT4LongEntryTrendLine() {
   createTrendLine(T4_LONG_ENTRY_TLINE, iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t4LowestLowDateTime) + 3), t4LongEntryValue, iTime(Symbol(), Period(), 0), t4LongEntryValue, InpT4TrendLineColor, 3, STYLE_SOLID, T4_LONG_ENTRY_TLINE);
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
   double offsetTrendline = (t4trendDirection == TREND_DIRECTION_LONG) ? -(InpT4StopLoss * 0.1) : (InpT4StopLoss * 0.1);

   createTrendLine(T4_STOP_LOSS_TLINE, iTime(Symbol(), Period(), barShift), pStopLossLevel + (offsetTrendline * Point()), iTime(Symbol(), Period(), 0), pStopLossLevel + (offsetTrendline * Point()), InpT4TrendLineColor, 2, STYLE_SOLID, T4_STOP_LOSS_TLINE, rayLeft, rayRight, zOrder, isBackground, isSelected, isSelectable);
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
   deleteTrendLineObject(T4_ORDER_GRID_LIMIT_TLINE);
   ArrayResize(t4OrderGridStopOrderValuesArray, 0);
   deleteTrendLineObject(T4_ORDER_GRID_STOP_TLINE);

   if(t4trendDirection == TREND_DIRECTION_LONG) {

      // orderGridStopOrder
      for(int orderGridId = 1; orderGridId < InpT4OrderGridCount; orderGridId++)  {
         orderGridStopOrderValue = t4LongEntryValue + (InpT4StopLoss / InpT4OrderGridCount * orderGridId * Point());
         string realVolume = DoubleToString(getT4BuyVolume(orderGridStopOrderValue), 2);
         string verifiedVolume = DoubleToString(VerifyVolume(Symbol(), getT4BuyVolume(orderGridStopOrderValue)), 2);
         createTrendLine(T4_ORDER_GRID_STOP_TLINE + "_" + IntegerToString(orderGridId), iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t4LowestLowDateTime) + barShift), orderGridStopOrderValue, iTime(Symbol(), Period(), 0), orderGridStopOrderValue, InpT4TrendLineColor, 1, STYLE_SOLID, T4_ORDER_GRID_STOP_TLINE + "_" + IntegerToString(orderGridId) + " V: " + realVolume + " (" + verifiedVolume + ")");
         ArrayResize(t4OrderGridStopOrderValuesArray, ArraySize(t4OrderGridStopOrderValuesArray) + 1);
         t4OrderGridStopOrderValuesArray[ArraySize(t4OrderGridStopOrderValuesArray) - 1] = orderGridStopOrderValue;
      }

      // orderGridLimitOrder
      for(int orderGridId = 1; orderGridId < InpT4OrderGridCount; orderGridId++) {
         orderGridLimitOrderValue = t4LongEntryValue - (InpT4StopLoss / InpT4OrderGridCount * orderGridId * Point());
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
         orderGridStopOrderValue = t4ShortEntryValue - (InpT4StopLoss / InpT4OrderGridCount * orderGridId * Point());
         string realVolume = DoubleToString(getT4SellVolume(orderGridStopOrderValue), 2);
         string verifiedVolume = DoubleToString(VerifyVolume(Symbol(), getT4SellVolume(orderGridStopOrderValue)), 2);
         createTrendLine(T4_ORDER_GRID_STOP_TLINE + "_" + IntegerToString(orderGridId), iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t4HighestHighDateTime) + barShift), orderGridStopOrderValue, iTime(Symbol(), Period(), 0), orderGridStopOrderValue, InpT4TrendLineColor, 1, STYLE_SOLID, T4_ORDER_GRID_STOP_TLINE + "_" + IntegerToString(orderGridId) + " V: " + realVolume + " (" + verifiedVolume + ")");
         ArrayResize(t4OrderGridStopOrderValuesArray, ArraySize(t4OrderGridStopOrderValuesArray) + 1);
         t4OrderGridStopOrderValuesArray[ArraySize(t4OrderGridStopOrderValuesArray) - 1] = orderGridStopOrderValue;
      }

      // orderGridLimitOrder
      for(int orderGridId = 1; orderGridId < InpT4OrderGridCount; orderGridId++) {
         orderGridLimitOrderValue = t4ShortEntryValue + (InpT4StopLoss / InpT4OrderGridCount * orderGridId * Point());
         string realVolume = DoubleToString(getT4SellVolume(orderGridLimitOrderValue), 2);
         string verifiedVolume = DoubleToString(VerifyVolume(Symbol(), getT4SellVolume(orderGridLimitOrderValue)), 2);
         createTrendLine(T4_ORDER_GRID_LIMIT_TLINE + "_" + IntegerToString(orderGridId), iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t4HighestHighDateTime) + barShift), orderGridLimitOrderValue, iTime(Symbol(), Period(), 0), orderGridLimitOrderValue, InpT4TrendLineColor, 1, STYLE_SOLID, T4_ORDER_GRID_LIMIT_TLINE + "_" + IntegerToString(orderGridId) + " V: " + realVolume + " (" + verifiedVolume + ")");

         ArrayResize(t4OrderGridLimitOrderValuesArray, ArraySize(t4OrderGridLimitOrderValuesArray) + 1);
         t4OrderGridLimitOrderValuesArray[ArraySize(t4OrderGridLimitOrderValuesArray) - 1] = orderGridLimitOrderValue;
      }
   }
}
