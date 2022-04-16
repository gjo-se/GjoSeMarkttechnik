//+------------------------------------------------------------------+
//|                                           HandleObjectAction.mqh |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
void handleT2ObjectsInitAction() {

   deleteTrendLineLike(T2_ZIGZAGLINE);
   deleteRegressionChannel(T2_REGRESSION_CHANNEL);
   deleteFiboLevelsObject(T2_FIBO_LEVELS);

   createT2ZigZagTrendDetectionLines();
   createT2HighVolumeAreaTrendLines();
   createT2HighVolumeAreaChannel();
   createT2RegressionChannel();
   createT2RegressionChannelLevels();
   createT2FiboRetracement();

   t2HandleObjectsAction();
}


void t2HandleObjectsAction() {

   if(isNewCurrentBar == true) {
      createT2ZigZagTrendDetectionLines();
      createT2RegressionChannel();
      createT2RegressionChannelLevels();
      createT2FiboRetracement();
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getT2P1HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(t2p1ValueLow != 0 && t2p2ValueLow != 0) {
      returnValue = (t2p1ValueLow < t2p2ValueLow) ? t2p1ValueLow : t2p1ValueHigh;
   }
   return returnValue;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getT2P2HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(t2p1ValueLow != 0 && t2p2ValueLow != 0) {
      returnValue = (t2p1ValueLow > t2p2ValueLow) ? t2p2ValueLow : t2p2ValueHigh;
   }
   return returnValue;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getT2P3HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(t2p1ValueLow != 0 && t2p2ValueLow != 0) {
      returnValue = (t2p1ValueLow < t2p2ValueLow) ? t2p3ValueLow : t2p3ValueHigh;
   }
   return returnValue;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getT2P4HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(t2p1ValueLow != 0 && t2p2ValueLow != 0) {
      returnValue = (t2p1ValueLow > t2p2ValueLow) ? t2p4ValueLow : t2p4ValueHigh;
   }
   return returnValue;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getT2P5HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(t2p1ValueLow != 0 && t2p2ValueLow != 0) {
      returnValue = (t2p1ValueLow < t2p2ValueLow) ? t2p5ValueLow : t2p5ValueHigh;
   }
   return returnValue;
}

//+------------------------------------------------------------------+
