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

   setTT3MovementAndRegressionLength();
}

void setTT3MovementAndRegressionLength() {

   if(tt3p1DateTime != 0 && tt3p6DateTime != 0) {

      if(tt3trendDirection == TREND_DIRECTION_LONG) {
         tt3movementLengthP1P2 = (tt3p2ValueHigh - tt3p1ValueLow) / Point();
         tt3movementLengthP3P4 = (tt3p4ValueHigh - tt3p3ValueLow) / Point();
         tt3movementLengthP5P6 = (tt3p6ValueHigh - tt3p5ValueLow) / Point();

         tt3regressionLengthP2P3 = (tt3p2ValueHigh - tt3p3ValueLow) / Point();
         tt3regressionLengthP4P5 = (tt3p4ValueHigh - tt3p5ValueLow) / Point();
      }

      if(tt3trendDirection == TREND_DIRECTION_SHORT) {
         tt3movementLengthP1P2 = (tt3p1ValueHigh - tt3p2ValueLow) / Point();
         tt3movementLengthP3P4 = (tt3p3ValueHigh - tt3p4ValueLow) / Point();
         tt3movementLengthP5P6 = (tt3p5ValueHigh - tt3p6ValueLow) / Point();

         tt3regressionLengthP2P3 = (tt3p3ValueHigh - tt3p2ValueLow) / Point();
         tt3regressionLengthP4P5 = (tt3p5ValueHigh - tt3p4ValueLow) / Point();
      }

      if(tt3movementLengthP1P2 != 0 && tt3movementLengthP3P4 != 0 && tt3movementLengthP5P6 != 0) {
         tt3movementLength = (tt3movementLengthP1P2 + tt3movementLengthP3P4 + tt3movementLengthP5P6) / 3;
      }

      if(tt3regressionLengthP2P3 != 0 && tt3regressionLengthP4P5 != 0) {
         tt3regressionLength = (tt3regressionLengthP2P3 + tt3regressionLengthP4P5) / 2;
      }

      if(tt3regressionLength != 0 && tt3movementLength != 0) {
         tt3movementLengthRegressionLengthRatio = tt3regressionLength / tt3movementLength * 100;
      }

      if(tt3movementLengthRegressionLengthRatio != 0) {
         ArrayResize(t3FiboLevelsArray, ArraySize(t3FiboLevelsArray) + 1);
         t3FiboLevelsArray[ArraySize(t3FiboLevelsArray) - 1] = (string)tt3movementLengthRegressionLengthRatio;
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

         tt4regressionLengthP2P3 = (tt4p2ValueHigh - tt4p3ValueLow) / Point();
         tt4regressionLengthP4P5 = (tt4p4ValueHigh - tt4p5ValueLow) / Point();
      }

      if(tt4trendDirection == TREND_DIRECTION_SHORT) {
         tt4movementLengthP1P2 = (tt4p1ValueHigh - tt4p2ValueLow) / Point();
         tt4movementLengthP3P4 = (tt4p3ValueHigh - tt4p4ValueLow) / Point();
         tt4movementLengthP5P6 = (tt4p5ValueHigh - tt4p6ValueLow) / Point();

         tt4regressionLengthP2P3 = (tt4p3ValueHigh - tt4p2ValueLow) / Point();
         tt4regressionLengthP4P5 = (tt4p5ValueHigh - tt4p4ValueLow) / Point();
      }

      if(tt4movementLengthP1P2 != 0 && tt4movementLengthP3P4 != 0 && tt4movementLengthP5P6 != 0) {
         tt4movementLength = (tt4movementLengthP1P2 + tt4movementLengthP3P4 + tt4movementLengthP5P6) / 3;
      }

      if(tt4regressionLengthP2P3 != 0 && tt4regressionLengthP4P5 != 0) {
         tt4regressionLength = (tt4regressionLengthP2P3 + tt4regressionLengthP4P5) / 2;
      }

      if(tt4regressionLength != 0 && tt4movementLength != 0) {
         tt4movementLengthRegressionLengthRatio = tt4regressionLength / tt4movementLength * 100;
      }

      if(tt4movementLengthRegressionLengthRatio != 0) {
         ArrayResize(t4FiboLevelsArray, ArraySize(t4FiboLevelsArray) + 1);
         t4FiboLevelsArray[ArraySize(t4FiboLevelsArray) - 1] = (string)tt4movementLengthRegressionLengthRatio;
      }
   }
}
//+------------------------------------------------------------------+
