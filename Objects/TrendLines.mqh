//+------------------------------------------------------------------+
//|                                                   TrendLines.mqh |
//|                                       Copyright 2022, Gregory Jo |
//+------------------------------------------------------------------+



void createT3TrendLines() {
    if(t3p1DateTime != 0 && t3p2DateTime != 0) createTrendLine(T3_TRENDLINE + "P1-P2", t3p1DateTime, getP1HighLowValueByTrendDirection(), t3p2DateTime, getP2HighLowValueByTrendDirection(), InpT3TrendLineColor, 3);
    if(t3p2DateTime != 0 && t3p3DateTime != 0) createTrendLine(T3_TRENDLINE + "P2-P3", t3p2DateTime, getP2HighLowValueByTrendDirection(), t3p3DateTime, getP3HighLowValueByTrendDirection(), InpT3TrendLineColor, 3);
    if(t3p3DateTime != 0 && t3p4DateTime != 0) createTrendLine(T3_TRENDLINE + "P3-P4", t3p3DateTime, getP3HighLowValueByTrendDirection(), t3p4DateTime, getP4HighLowValueByTrendDirection(), InpT3TrendLineColor, 3);
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
