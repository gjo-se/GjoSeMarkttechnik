//+------------------------------------------------------------------+
//|                                 TTHandleTrendDetectionAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void getTT3TrendDirection() {

   tt3trendDirection = TREND_DIRECTION_ROTATION;

   if(tt3p3ValueHigh != 0 && tt3p4ValueHigh != 0) {
      if(tt3p3ValueHigh < tt3p4ValueHigh) tt3trendDirection = TREND_DIRECTION_LONG;
      if(tt3p3ValueHigh > tt3p4ValueHigh) tt3trendDirection = TREND_DIRECTION_SHORT;
   }

   setTT3MovementAndRegressionLegth();
}

void setTT3MovementAndRegressionLegth() {

   if(tt3p1DateTime != 0 && tt3p6DateTime != 0) {

      if(tt3trendDirection == TREND_DIRECTION_LONG) {

         tt3movementLengthP1P2 = (tt3p2ValueHigh - tt3p1ValueLow) / Point();
         tt3movementLengthP3P4 = (tt3p4ValueHigh - tt3p3ValueLow) / Point();
         tt3movementLengthP5P6 = (tt3p6ValueHigh - tt3p5ValueLow) / Point();
         if(tt3movementLengthP1P2 != 0 && tt3movementLengthP3P4 != 0 && tt3movementLengthP5P6 != 0) {
            tt3movementLength = (tt3movementLengthP1P2 + tt3movementLengthP3P4 + tt3movementLengthP5P6) / 3;
         }

         tt3regressionLengthP2P3 = (tt3p2ValueHigh - tt3p3ValueLow) / Point();
         tt3regressionLengthP4P5 = (tt3p4ValueHigh - tt3p5ValueLow) / Point();

         if(tt3regressionLengthP2P3 != 0 && tt3regressionLengthP4P5 != 0) {
            tt3regressionLength = (tt3regressionLengthP2P3 + tt3regressionLengthP4P5) / 2;
         }

         if(tt3regressionLength != 0 && tt3movementLength != 0) {
            tt3movementLengthRegressionLengthRatio = tt3regressionLength / tt3movementLength * 100;
         }
      }
   }
}

void getTT4TrendDirection() {

   tt4trendDirection = TREND_DIRECTION_ROTATION;

   if(tt4p3ValueHigh != 0 && tt4p4ValueHigh != 0) {
      if(tt4p3ValueHigh < tt4p4ValueHigh) tt4trendDirection = TREND_DIRECTION_LONG;
      if(tt4p3ValueHigh > tt4p4ValueHigh) tt4trendDirection = TREND_DIRECTION_SHORT;
   }

   setTT4MovementAndRegressionLegth();
}

void setTT4MovementAndRegressionLegth() {

   if(tt4p1DateTime != 0 && tt4p6DateTime != 0) {

      if(tt4trendDirection == TREND_DIRECTION_LONG) {

         tt4movementLengthP1P2 = (tt4p2ValueHigh - tt4p1ValueLow) / Point();
         tt4movementLengthP3P4 = (tt4p4ValueHigh - tt4p3ValueLow) / Point();
         tt4movementLengthP5P6 = (tt4p6ValueHigh - tt4p5ValueLow) / Point();
         if(tt4movementLengthP1P2 != 0 && tt4movementLengthP3P4 != 0 && tt4movementLengthP5P6 != 0) {
            tt4movementLength = (tt4movementLengthP1P2 + tt4movementLengthP3P4 + tt4movementLengthP5P6) / 3;
         }

         tt4regressionLengthP2P3 = (tt4p2ValueHigh - tt4p3ValueLow) / Point();
         tt4regressionLengthP4P5 = (tt4p4ValueHigh - tt4p5ValueLow) / Point();

         if(tt4regressionLengthP2P3 != 0 && tt4regressionLengthP4P5 != 0) {
            tt4regressionLength = (tt4regressionLengthP2P3 + tt4regressionLengthP4P5) / 2;
         }

         if(tt4regressionLength != 0 && tt4movementLength != 0) {
            tt4movementLengthRegressionLengthRatio = tt4regressionLength / tt4movementLength * 100;
         }
      }
   }
}
//+------------------------------------------------------------------+
