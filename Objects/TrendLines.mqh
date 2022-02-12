//+------------------------------------------------------------------+
//|                                                   TrendLines.mqh |
//|                                       Copyright 2022, Gregory Jo |
//+------------------------------------------------------------------+



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void createT3TrendLines() {
   if(t3p1DateTime != 0 && t3p2DateTime != 0) createTrendLine(T3_TRENDLINE + "P1-P2", t3p1DateTime, getP1HighLowValueByTrendDirection(), t3p2DateTime, getP2HighLowValueByTrendDirection(), InpT3TrendLineColor, 3);
   if(t3p2DateTime != 0 && t3p3DateTime != 0) createTrendLine(T3_TRENDLINE + "P2-P3", t3p2DateTime, getP2HighLowValueByTrendDirection(), t3p3DateTime, getP3HighLowValueByTrendDirection(), InpT3TrendLineColor, 3);
   if(t3p3DateTime != 0 && t3p4DateTime != 0) createTrendLine(T3_TRENDLINE + "P3-P4", t3p3DateTime, getP3HighLowValueByTrendDirection(), t3p4DateTime, getP4HighLowValueByTrendDirection(), InpT3TrendLineColor, 3);
}

// SHORT
void createT3HighestHighTrendLine() {
   t3HighestHighValue = MathMin(iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3HighestHighDateTime)), inSignalAreaMaxEndValue);
   createTrendLine(T3_HIGHEST_HIGH_TLINE, iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t3HighestHighDateTime) + 3), t3HighestHighValue, iTime(Symbol(), Period(), 0), t3HighestHighValue, InpT3TrendLineColor, 3, STYLE_SOLID, T3_HIGHEST_HIGH_TLINE);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void createT3ShortEntryTrendLine() {
   t3ShortEntryValue = t3HighestHighValue - InpStopLoss * Point();
   createTrendLine(T3_SHORT_ENTRY_TLINE, iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t3HighestHighDateTime) + 3), t3ShortEntryValue, iTime(Symbol(), Period(), 0), t3ShortEntryValue, InpT3TrendLineColor, 3, STYLE_SOLID, T3_SHORT_ENTRY_TLINE);
}

// LONG
void createT3LowestLowTrendLine() {
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
void createStopLossTrendline(double pStopLossLevel) {
   int barShift = 10;
   bool rayLeft = false;
   bool rayRight = true;
   long zOrder = 0;
   bool isBackground = true;
   bool isSelected = false;
   bool isSelectable = true;
   double offsetTrendline = (t3trendDirection == TREND_DIRECTION_LONG) ? -(InpStopLoss * 0.1) : (InpStopLoss * 0.1);

   createTrendLine(T3_STOP_LOSS_TLINE, iTime(Symbol(), Period(), barShift), pStopLossLevel + (offsetTrendline * Point()), iTime(Symbol(), Period(), 0), pStopLossLevel + (offsetTrendline * Point()), InpStopLossLineColor, 2, STYLE_SOLID, T3_STOP_LOSS_TLINE, rayLeft, rayRight, zOrder, isBackground, isSelected, isSelectable);
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

      ArrayResize(orderGridLimitOrderValuesArray, 0);
      ArrayResize(orderGridStopOrderValuesArray, 0);

    // orderGridStopOrder
      for(int orderGridId = 1; orderGridId < InpOrderGridCount; orderGridId++)  {
        orderGridStopOrderValue = t3LongEntryValue + (InpStopLoss / InpOrderGridCount * orderGridId * Point());
        string realVolume = DoubleToString(getBuyVolume(orderGridStopOrderValue), 2);
        string verifiedVolume = DoubleToString(VerifyVolume(Symbol(), getBuyVolume(orderGridStopOrderValue)), 2);
        createTrendLine(T3_ORDER_GRID_STOP_TLINE + "_" + orderGridId, iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t3LowestLowDateTime) + barShift), orderGridStopOrderValue, iTime(Symbol(), Period(), 0), orderGridStopOrderValue, InpT3TrendLineColor, 1, STYLE_SOLID, T3_ORDER_GRID_STOP_TLINE + "_" + orderGridId + " V: " + realVolume + " (" + verifiedVolume + ")");

        ArrayResize(orderGridStopOrderValuesArray, ArraySize(orderGridStopOrderValuesArray) + 1);
        orderGridStopOrderValuesArray[ArraySize(orderGridStopOrderValuesArray) - 1] = orderGridStopOrderValue;
      }

    // orderGridLimitOrder
      for(int orderGridId = 1; orderGridId < InpOrderGridCount; orderGridId++) {
        orderGridLimitOrderValue = t3LongEntryValue - (InpStopLoss / InpOrderGridCount * orderGridId * Point());
        string realVolume = DoubleToString(getBuyVolume(orderGridLimitOrderValue), 2);
        string verifiedVolume = DoubleToString(VerifyVolume(Symbol(), getBuyVolume(orderGridLimitOrderValue)), 2);
        createTrendLine(T3_ORDER_GRID_LIMIT_TLINE + "_" + orderGridId, iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t3LowestLowDateTime) + barShift), orderGridLimitOrderValue, iTime(Symbol(), Period(), 0), orderGridLimitOrderValue, InpT3TrendLineColor, 1, STYLE_SOLID, T3_ORDER_GRID_LIMIT_TLINE + "_" + orderGridId + " V: " + realVolume + " (" + verifiedVolume + ")");

        ArrayResize(orderGridLimitOrderValuesArray, ArraySize(orderGridLimitOrderValuesArray) + 1);
        orderGridLimitOrderValuesArray[ArraySize(orderGridLimitOrderValuesArray) - 1] = orderGridLimitOrderValue;
      }
}

void deleteTrendLineObject(const string pDimension) {

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
