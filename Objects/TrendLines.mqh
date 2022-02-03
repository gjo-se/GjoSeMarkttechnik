//+------------------------------------------------------------------+
//|                                                   TrendLines.mqh |
//|                                       Copyright 2022, Gregory Jo |
//+------------------------------------------------------------------+



void createT3TrendLines() {
    if(t3p1DateTime != 0 && t3p2DateTime != 0) createTrendLine(T3_TRENDLINE + "P1-P2", t3p1DateTime, getP1HighLowValueByTrendDirection(), t3p2DateTime, getP2HighLowValueByTrendDirection(), InpT3TrendLineColor, 3);
    if(t3p2DateTime != 0 && t3p3DateTime != 0) createTrendLine(T3_TRENDLINE + "P2-P3", t3p2DateTime, getP2HighLowValueByTrendDirection(), t3p3DateTime, getP3HighLowValueByTrendDirection(), InpT3TrendLineColor, 3);
    if(t3p3DateTime != 0 && t3p4DateTime != 0) createTrendLine(T3_TRENDLINE + "P3-P4", t3p3DateTime, getP3HighLowValueByTrendDirection(), t3p4DateTime, getP4HighLowValueByTrendDirection(), InpT3TrendLineColor, 3);
}

// SHORT
void createT3HighestHighTrendLine(){
    t3HighestHighValue = MathMin(iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3HighestHighDateTime)), inSignalAreaMaxEndValue);
    createTrendLine(T3_HIGHEST_HIGH_TLINE, iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t3HighestHighDateTime) + 3), t3HighestHighValue, iTime(Symbol(), Period(), 0), t3HighestHighValue, InpT3TrendLineColor, 3, STYLE_SOLID, T3_HIGHEST_HIGH_TLINE);
}

void createT3ShortEntryTrendLine(){
    t3ShortEntryValue = t3HighestHighValue - InpStopLoss * Point();
    createTrendLine(T3_SHORT_ENTRY_TLINE, iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t3HighestHighDateTime) + 3), t3ShortEntryValue, iTime(Symbol(), Period(), 0), t3ShortEntryValue, InpT3TrendLineColor, 3, STYLE_SOLID, T3_SHORT_ENTRY_TLINE);
}

// LONG
void createT3LowestLowTrendLine(){
    t3LowestLowValue = MathMax(iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3LowestLowDateTime)), inSignalAreaMinEndValue) ;
    createTrendLine(T3_LOWEST_LOW_TLINE, iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t3LowestLowDateTime) + 3), t3LowestLowValue, iTime(Symbol(), Period(), 0), t3LowestLowValue, InpT3TrendLineColor, 3, STYLE_SOLID, T3_LOWEST_LOW_TLINE);
}

void createT3LongEntryTrendLine(){
    t3LongEntryValue = t3LowestLowValue + InpStopLoss * Point();
    createTrendLine(T3_LONG_ENTRY_TLINE, iTime(Symbol(), Period(), iBarShift(Symbol(), Period(), t3LowestLowDateTime) + 3), t3LongEntryValue, iTime(Symbol(), Period(), 0), t3LongEntryValue, InpT3TrendLineColor, 3, STYLE_SOLID, T3_LONG_ENTRY_TLINE);
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
