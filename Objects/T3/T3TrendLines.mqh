//+------------------------------------------------------------------+
//|                                                   TrendLines.mqh |
//|                                       Copyright 2022, Gregory Jo |
//+------------------------------------------------------------------+



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void createT3TrendLines() {
   if(t3p1DateTime != 0 && t3p2DateTime != 0) createTrendLine(T3_TRENDLINE + "P1-P2", t3p1DateTime, getT3P1HighLowValueByTrendDirection(), t3p2DateTime, getT3P2HighLowValueByTrendDirection(), InpT3TrendLineColor, 3);
   if(t3p2DateTime != 0 && t3p3DateTime != 0) createTrendLine(T3_TRENDLINE + "P2-P3", t3p2DateTime, getT3P2HighLowValueByTrendDirection(), t3p3DateTime, getT3P3HighLowValueByTrendDirection(), InpT3TrendLineColor, 3);
   if(t3p3DateTime != 0 && t3p4DateTime != 0) createTrendLine(T3_TRENDLINE + "P3-P4", t3p3DateTime, getT3P3HighLowValueByTrendDirection(), t3p4DateTime, getT3P4HighLowValueByTrendDirection(), InpT3TrendLineColor, 3);
}

// SHORT
void createT3HighestHighTrendLine() {
   createTrendLine(T3_HIGHEST_HIGH_TLINE, iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t3HighestHighDateTime) + 3), t3HighestHighValue, iTime(Symbol(), Period(), 0), t3HighestHighValue, InpT3TrendLineColor, 3, STYLE_SOLID, T3_HIGHEST_HIGH_TLINE);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void createT3ShortEntryTrendLine() {
   t3ShortEntryValue = t3HighestHighValue - InpT3StopLoss * Point();
   createTrendLine(T3_SHORT_ENTRY_TLINE, iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t3HighestHighDateTime) + 3), t3ShortEntryValue, iTime(Symbol(), Period(), 0), t3ShortEntryValue, InpT3TrendLineColor, 3, STYLE_SOLID, T3_SHORT_ENTRY_TLINE);
}

// LONG
void createT3LowestLowTrendLine() {
   t3LowestLowValue = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3LowestLowDateTime));
   createTrendLine(T3_LOWEST_LOW_TLINE, iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t3LowestLowDateTime) + 3), t3LowestLowValue, iTime(Symbol(), Period(), 0), t3LowestLowValue, InpT3TrendLineColor, 3, STYLE_SOLID, T3_LOWEST_LOW_TLINE);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void createT3LongEntryTrendLine() {
   createTrendLine(T3_LONG_ENTRY_TLINE, iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t3LowestLowDateTime) + 3), t3LongEntryValue, iTime(Symbol(), Period(), 0), t3LongEntryValue, InpT3TrendLineColor, 3, STYLE_SOLID, T3_LONG_ENTRY_TLINE);
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

   createTrendLine(T3_STOP_LOSS_TLINE, iTime(Symbol(), Period(), barShift), pStopLossLevel, iTime(Symbol(), Period(), 0), pStopLossLevel, InpT3TrendLineColor, 2, STYLE_SOLID, T3_STOP_LOSS_TLINE, rayLeft, rayRight, zOrder, isBackground, isSelected, isSelectable);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void createT3TrailingStopTrendLine() {
   int barShift = 3;
   createTrendLine(T3_TRAILING_STOP_TLINE, iTime(Symbol(), Period(), barShift), t3TrailingStopLevel, iTime(Symbol(), Period(), 0), t3TrailingStopLevel, InpT3TailingStopLineColor, 3, STYLE_SOLID, T3_TRAILING_STOP_TLINE);
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

      // orderGridStopOrder
      for(int orderGridId = 1; orderGridId < InpT3OrderGridCount; orderGridId++)  {
         orderGridStopOrderValue = t3LongEntryValue + (InpT3StopLoss / InpT3OrderGridCount * orderGridId * Point());
         string realVolume = DoubleToString(getT3BuyVolume(orderGridStopOrderValue), 2);
         string verifiedVolume = DoubleToString(VerifyVolume(Symbol(), getT3BuyVolume(orderGridStopOrderValue)), 2);
         createTrendLine(T3_ORDER_GRID_STOP_TLINE + "_" + IntegerToString(orderGridId), iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t3LowestLowDateTime) + barShift), orderGridStopOrderValue, iTime(Symbol(), Period(), 0), orderGridStopOrderValue, InpT3TrendLineColor, 1, STYLE_SOLID, T3_ORDER_GRID_STOP_TLINE + "_" + IntegerToString(orderGridId) + " V: " + realVolume + " (" + verifiedVolume + ")");
         ArrayResize(t3OrderGridStopOrderValuesArray, ArraySize(t3OrderGridStopOrderValuesArray) + 1);
         t3OrderGridStopOrderValuesArray[ArraySize(t3OrderGridStopOrderValuesArray) - 1] = orderGridStopOrderValue;
      }

      // orderGridLimitOrder
      for(int orderGridId = 1; orderGridId < InpT3OrderGridCount; orderGridId++) {
         orderGridLimitOrderValue = t3LongEntryValue - (InpT3StopLoss / InpT3OrderGridCount * orderGridId * Point());
         string realVolume = DoubleToString(getT3BuyVolume(orderGridLimitOrderValue), 2);
         string verifiedVolume = DoubleToString(VerifyVolume(Symbol(), getT3BuyVolume(orderGridLimitOrderValue)), 2);
         createTrendLine(T3_ORDER_GRID_LIMIT_TLINE + "_" + IntegerToString(orderGridId), iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t3LowestLowDateTime) + barShift), orderGridLimitOrderValue, iTime(Symbol(), Period(), 0), orderGridLimitOrderValue, InpT3TrendLineColor, 1, STYLE_SOLID, T3_ORDER_GRID_LIMIT_TLINE + "_" + IntegerToString(orderGridId) + " V: " + realVolume + " (" + verifiedVolume + ")");

         ArrayResize(t3OrderGridLimitOrderValuesArray, ArraySize(t3OrderGridLimitOrderValuesArray) + 1);
         t3OrderGridLimitOrderValuesArray[ArraySize(t3OrderGridLimitOrderValuesArray) - 1] = orderGridLimitOrderValue;
      }
   }

   if(t3trendDirection == TREND_DIRECTION_SHORT) {

      // orderGridStopOrder
      for(int orderGridId = 1; orderGridId < InpT3OrderGridCount; orderGridId++)  {
         orderGridStopOrderValue = t3ShortEntryValue - (InpT3StopLoss / InpT3OrderGridCount * orderGridId * Point());
         string realVolume = DoubleToString(getT3SellVolume(orderGridStopOrderValue), 2);
         string verifiedVolume = DoubleToString(VerifyVolume(Symbol(), getT3SellVolume(orderGridStopOrderValue)), 2);
         createTrendLine(T3_ORDER_GRID_STOP_TLINE + "_" + IntegerToString(orderGridId), iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t3HighestHighDateTime) + barShift), orderGridStopOrderValue, iTime(Symbol(), Period(), 0), orderGridStopOrderValue, InpT3TrendLineColor, 1, STYLE_SOLID, T3_ORDER_GRID_STOP_TLINE + "_" + IntegerToString(orderGridId) + " V: " + realVolume + " (" + verifiedVolume + ")");
         ArrayResize(t3OrderGridStopOrderValuesArray, ArraySize(t3OrderGridStopOrderValuesArray) + 1);
         t3OrderGridStopOrderValuesArray[ArraySize(t3OrderGridStopOrderValuesArray) - 1] = orderGridStopOrderValue;
      }

      // orderGridLimitOrder
      for(int orderGridId = 1; orderGridId < InpT3OrderGridCount; orderGridId++) {
         orderGridLimitOrderValue = t3ShortEntryValue + (InpT3StopLoss / InpT3OrderGridCount * orderGridId * Point());
         string realVolume = DoubleToString(getT3SellVolume(orderGridLimitOrderValue), 2);
         string verifiedVolume = DoubleToString(VerifyVolume(Symbol(), getT3SellVolume(orderGridLimitOrderValue)), 2);
         createTrendLine(T3_ORDER_GRID_LIMIT_TLINE + "_" + IntegerToString(orderGridId), iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t3HighestHighDateTime) + barShift), orderGridLimitOrderValue, iTime(Symbol(), Period(), 0), orderGridLimitOrderValue, InpT3TrendLineColor, 1, STYLE_SOLID, T3_ORDER_GRID_LIMIT_TLINE + "_" + IntegerToString(orderGridId) + " V: " + realVolume + " (" + verifiedVolume + ")");

         ArrayResize(t3OrderGridLimitOrderValuesArray, ArraySize(t3OrderGridLimitOrderValuesArray) + 1);
         t3OrderGridLimitOrderValuesArray[ArraySize(t3OrderGridLimitOrderValuesArray) - 1] = orderGridLimitOrderValue;
      }
   }
}

void deleteTrendLineLike(const string pObjectNamePart) {

   long chartId = ChartID();
   int objectsTotal = ObjectsTotal(chartId, 0, -1);

   string objectName;
   for(int i = objectsTotal; i >= 0; i--) {
      objectName = ObjectName(chartId, i);
      if ( StringFind(objectName, pObjectNamePart) != -1 ) {
         ObjectDelete(chartId, objectName);
      }
   }
}
//+------------------------------------------------------------------+
