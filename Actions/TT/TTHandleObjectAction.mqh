//+------------------------------------------------------------------+
//|                                         TTHandleObjectAction.mqh |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

void handleTT2ObjectsInitAction() {

   deleteTrendLineLike(TT2_ZIGZAGLINE);
   deleteRegressionChannel(TT2_REGRESSION_CHANNEL);
   deleteChannelObject(TT2_IN_SIGNAL_FIBO_LEVEL_AREA);

   createTT2ZigZagTemplateLines();
   createTT2RegressionChannel();
   createTT2HighVolumeAreaTrendLines();
   createTT2InSignalFiboLevelChannelArea();

}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getTT2P1HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(tt2p1ValueLow != 0 && tt2p2ValueLow != 0) {
      returnValue = (tt2p1ValueLow < tt2p2ValueLow) ? tt2p1ValueLow : tt2p1ValueHigh;
   }
   return returnValue;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getTT2P2HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(tt2p1ValueLow != 0 && tt2p2ValueLow != 0) {
      returnValue = (tt2p1ValueLow > tt2p2ValueLow) ? tt2p2ValueLow : tt2p2ValueHigh;
   }
   return returnValue;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getTT2P3HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(tt2p1ValueLow != 0 && tt2p2ValueLow != 0) {
      returnValue = (tt2p1ValueLow < tt2p2ValueLow) ? tt2p3ValueLow : tt2p3ValueHigh;
   }
   return returnValue;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getTT2P4HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(tt2p1ValueLow != 0 && tt2p2ValueLow != 0) {
      returnValue = (tt2p1ValueLow > tt2p2ValueLow) ? tt2p4ValueLow : tt2p4ValueHigh;
   }
   return returnValue;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getTT2P5HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(tt2p1ValueLow != 0 && tt2p2ValueLow != 0) {
      returnValue = (tt2p1ValueLow < tt2p2ValueLow) ? tt2p5ValueLow : tt2p5ValueHigh;
   }
   return returnValue;
}

double getTT2P6HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(tt2p1ValueLow != 0 && tt2p2ValueLow != 0) {
      returnValue = (tt2p1ValueLow > tt2p2ValueLow) ? tt2p6ValueLow : tt2p6ValueHigh;
   }
   return returnValue;
}

void handleTT3ObjectsInitAction() {

   deleteTrendLineLike(TT3_ZIGZAGLINE);
   deleteRegressionChannel(TT3_REGRESSION_CHANNEL);

   createTT3ZigZagTemplateLines();
   createTT3RegressionChannel();
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getTT3P1HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(tt3p1ValueLow != 0 && tt3p2ValueLow != 0) {
      returnValue = (tt3p1ValueLow < tt3p2ValueLow) ? tt3p1ValueLow : tt3p1ValueHigh;
   }
   return returnValue;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getTT3P2HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(tt3p1ValueLow != 0 && tt3p2ValueLow != 0) {
      returnValue = (tt3p1ValueLow > tt3p2ValueLow) ? tt3p2ValueLow : tt3p2ValueHigh;
   }
   return returnValue;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getTT3P3HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(tt3p1ValueLow != 0 && tt3p2ValueLow != 0) {
      returnValue = (tt3p1ValueLow < tt3p2ValueLow) ? tt3p3ValueLow : tt3p3ValueHigh;
   }
   return returnValue;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getTT3P4HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(tt3p1ValueLow != 0 && tt3p2ValueLow != 0) {
      returnValue = (tt3p1ValueLow > tt3p2ValueLow) ? tt3p4ValueLow : tt3p4ValueHigh;
   }
   return returnValue;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getTT3P5HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(tt3p1ValueLow != 0 && tt3p2ValueLow != 0) {
      returnValue = (tt3p1ValueLow < tt3p2ValueLow) ? tt3p5ValueLow : tt3p5ValueHigh;
   }
   return returnValue;
}

double getTT3P6HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(tt3p1ValueLow != 0 && tt3p2ValueLow != 0) {
      returnValue = (tt3p1ValueLow > tt3p2ValueLow) ? tt3p6ValueLow : tt3p6ValueHigh;
   }
   return returnValue;
}

void handleTT4ObjectsInitAction() {

   deleteTrendLineLike(TT4_ZIGZAGLINE);
   deleteRegressionChannel(TT4_REGRESSION_CHANNEL);

   createTT4ZigZagTemplateLines();
   createTT4RegressionChannel();
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getTT4P1HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(tt4p1ValueLow != 0 && tt4p2ValueLow != 0) {
      returnValue = (tt4p1ValueLow < tt4p2ValueLow) ? tt4p1ValueLow : tt4p1ValueHigh;
   }
   return returnValue;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getTT4P2HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(tt4p1ValueLow != 0 && tt4p2ValueLow != 0) {
      returnValue = (tt4p1ValueLow > tt4p2ValueLow) ? tt4p2ValueLow : tt4p2ValueHigh;
   }
   return returnValue;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getTT4P3HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(tt4p1ValueLow != 0 && tt4p2ValueLow != 0) {
      returnValue = (tt4p1ValueLow < tt4p2ValueLow) ? tt4p3ValueLow : tt4p3ValueHigh;
   }
   return returnValue;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getTT4P4HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(tt4p1ValueLow != 0 && tt4p2ValueLow != 0) {
      returnValue = (tt4p1ValueLow > tt4p2ValueLow) ? tt4p4ValueLow : tt4p4ValueHigh;
   }
   return returnValue;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getTT4P5HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(tt4p1ValueLow != 0 && tt4p2ValueLow != 0) {
      returnValue = (tt4p1ValueLow < tt4p2ValueLow) ? tt4p5ValueLow : tt4p5ValueHigh;
   }
   return returnValue;
}

double getTT4P6HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(tt4p1ValueLow != 0 && tt4p2ValueLow != 0) {
      returnValue = (tt4p1ValueLow > tt4p2ValueLow) ? tt4p6ValueLow : tt4p6ValueHigh;
   }
   return returnValue;
}
