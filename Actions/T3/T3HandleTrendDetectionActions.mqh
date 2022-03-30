//+------------------------------------------------------------------+
//|                                 T3HandleTrendDetectionAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void getT3TrendDirection() {

   if(t3p1ValueHigh != 0 && t3p2ValueHigh != 0) {
      if(t3p1ValueHigh < t3p2ValueHigh) t3SemiTrendDirection = TREND_DIRECTION_LONG;
      if(t3p1ValueHigh > t3p2ValueHigh) t3SemiTrendDirection = TREND_DIRECTION_SHORT;
   }

   if(t3p3ValueHigh != 0 && t3p4ValueHigh != 0) {
      if(t3p3ValueHigh < t3p4ValueHigh) t3trendDirection = TREND_DIRECTION_LONG;
      if(t3p3ValueHigh > t3p4ValueHigh) t3trendDirection = TREND_DIRECTION_SHORT;
   }
}

string getT3TrendDirectionString() {

   string trendDirectionString = "ROTATION";

   if(t3trendDirection == TREND_DIRECTION_LONG) trendDirectionString = "LONG";
   if(t3trendDirection == TREND_DIRECTION_SHORT) trendDirectionString = "SHORT";

   return trendDirectionString;
}

void setT3MovementLength() {

   double t3P1P2Movement = 0;
   double t3P3P4Movement = 0;
   if(t3p1DateTime != 0 && t3p2DateTime != 0) {
      double t3P1HighLowValue = getT3P1HighLowValueByTrendDirection();
      double t3P2HighLowValue = getT3P2HighLowValueByTrendDirection();
      t3P1P2Movement = MathMax(t3P1HighLowValue, t3P2HighLowValue) / Point() - MathMin(t3P1HighLowValue, t3P2HighLowValue) / Point();
   }

   if(t3p3DateTime != 0 && t3p4DateTime != 0) {
      double t3P3HighLowValue = getT3P3HighLowValueByTrendDirection();
      double t3P4HighLowValue = getT3P4HighLowValueByTrendDirection();
      t3P3P4Movement = MathMax(t3P3HighLowValue, t3P4HighLowValue) / Point() - MathMin(t3P3HighLowValue, t3P4HighLowValue) / Point();
   }

   if(t3P1P2Movement != 0 && t3P3P4Movement != 0) t3MovementLengthPoints = (int)((t3P1P2Movement + t3P3P4Movement) / 2);
}

void handleT3TrendDetectionAction() {

   if(t3trendDirection == TREND_DIRECTION_LONG) {
   }

   if(t3trendDirection == TREND_DIRECTION_SHORT) {
   }

}
//+------------------------------------------------------------------+
