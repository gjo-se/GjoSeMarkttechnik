//+------------------------------------------------------------------+
//|                                           HandleObjectAction.mqh |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
void handleObjectsAction() {

   if(InpT3ObjectsShow == true) {
      if(NewCurrentBar() == true || objectChanged() == true) {
         setLineValues();

         getT3TrendDirection();

         if(Period() <= InpT3MaxTimeframe) {
            createT3TrendLines();
            createT3RegressionChannel();
            createT3RegressionChannelLevels();
            createT3FiboRetracement();

         } else {
            deleteTrendLineObject(T3_TRENDLINE);
            deleteRegressionChannelObject(T3_REGRESSION_CHANNEL);
            deleteFiboLevelsObject(T3_FIBO_LEVELS);
         }
      }
   } else {
      deleteTrendLineObject(T3_TRENDLINE);
      deleteRegressionChannelObject(T3_REGRESSION_CHANNEL);
      deleteFiboLevelsObject(T3_FIBO_LEVELS);
   }

}


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool objectChanged() {
   bool objectHasChanged = false;

   if(MQLInfoInteger(MQL_TESTER) == 1) return false;

   if(
      t3p1DateTime != getVlineDatetimeByText(T3_P1_VLINE)
      || t3p2DateTime != getVlineDatetimeByText(T3_P2_VLINE)
      || t3p3DateTime != getVlineDatetimeByText(T3_P3_VLINE)
      || t3p4DateTime != getVlineDatetimeByText(T3_P4_VLINE)
      || t3StartDateTime != getVlineDatetimeByText(T3_START_VLINE)
      || t3EndDateTime != getVlineDatetimeByText(T3_END_VLINE)
   ) {
      objectHasChanged = true;
   }

   return objectHasChanged;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void getT3TrendDirection() {
   if(t3p1ValueHigh != 0 && t3p2ValueHigh != 0) {
      if(t3p1ValueHigh < t3p2ValueHigh) t3trendDirection = TREND_DIRECTION_LONG;
      if(t3p1ValueHigh > t3p2ValueHigh) t3trendDirection = TREND_DIRECTION_SHORT;
   }
}

string getT3TrendDirectionString() {

   string trendDirectionString = "ROTATION";

   if(t3trendDirection == TREND_DIRECTION_LONG) trendDirectionString = "LONG";
   if(t3trendDirection == TREND_DIRECTION_SHORT) trendDirectionString = "SHORT";

   return trendDirectionString;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getP1HighLowValueByTrendDirection() {
   return (t3trendDirection == TREND_DIRECTION_LONG) ? t3p1ValueLow : t3p1ValueHigh;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getP2HighLowValueByTrendDirection() {
   return (t3trendDirection == TREND_DIRECTION_LONG) ? t3p2ValueHigh : t3p2ValueLow;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getP3HighLowValueByTrendDirection() {
   return (t3trendDirection == TREND_DIRECTION_LONG) ? t3p3ValueLow : t3p3ValueHigh;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getP4HighLowValueByTrendDirection() {
   return (t3trendDirection == TREND_DIRECTION_LONG) ? t3p4ValueHigh : t3p4ValueLow;
}
//+------------------------------------------------------------------+
