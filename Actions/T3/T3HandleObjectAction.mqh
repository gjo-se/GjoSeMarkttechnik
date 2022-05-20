//+------------------------------------------------------------------+
//|                                           HandleObjectAction.mqh |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
void handleT3ObjectsInitAction() {

   deleteTrendLineLike(T3_ZIGZAGLINE);
   deleteRegressionChannel(T3_REGRESSION_CHANNEL);
   deleteTrendLineLike(T3_FIBO_LEVELS);

   createT3ZigZagTrendDetectionLines();
   createT3RegressionChannel();
   createT3RegressionChannelLevels();
   createT3FiboRetracement();

   t3HandleObjectsAction();
}


void t3HandleObjectsAction() {

   if(ObjectFind(ChartID(), T3_AUTO_BUTTON) < 0) {
      createT3AutoButton();
   }

   if(ObjectFind(ChartID(), T3_TMP_BUTTON) < 0 && tt3p1DateTime != 0) {
      createT3TMPButton();
   }

   if(InpT3ObjectsShow == true) {

      if(isNewM1Bar == true) {
         createT3ZigZagTrendDetectionLines();
         createT3RegressionChannel();
         createT3RegressionChannelLevels();
         createT3FiboRetracement();
      }

   } else {
      deleteTrendLineLike(T3_ZIGZAGLINE);
      deleteRegressionChannel(T3_REGRESSION_CHANNEL);
      deleteTrendLineLike(T3_FIBO_LEVELS);
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getT3P1HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(t3p1ValueLow != 0 && t3p2ValueLow != 0) {
      returnValue = (t3p1ValueLow < t3p2ValueLow) ? t3p1ValueLow : t3p1ValueHigh;
   }
   return returnValue;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getT3P2HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(t3p1ValueLow != 0 && t3p2ValueLow != 0) {
      returnValue = (t3p1ValueLow > t3p2ValueLow) ? t3p2ValueLow : t3p2ValueHigh;
   }
   return returnValue;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getT3P3HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(t3p1ValueLow != 0 && t3p2ValueLow != 0) {
      returnValue = (t3p1ValueLow < t3p2ValueLow) ? t3p3ValueLow : t3p3ValueHigh;
   }
   return returnValue;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getT3P4HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(t3p1ValueLow != 0 && t3p2ValueLow != 0) {
      returnValue = (t3p1ValueLow > t3p2ValueLow) ? t3p4ValueLow : t3p4ValueHigh;
   }
   return returnValue;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getT3P5HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(t3p1ValueLow != 0 && t3p2ValueLow != 0) {
      returnValue = (t3p1ValueLow < t3p2ValueLow) ? t3p5ValueLow : t3p5ValueHigh;
   }
   return returnValue;
}
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getT3P6HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(t3p1ValueLow != 0 && t3p2ValueLow != 0) {
      returnValue = (t3p1ValueLow > t3p2ValueLow) ? t3p6ValueLow : t3p6ValueHigh;
   }
   return returnValue;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getT3P7HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(t3p1ValueLow != 0 && t3p2ValueLow != 0) {
      returnValue = (t3p1ValueLow < t3p2ValueLow) ? t3p7ValueLow : t3p7ValueHigh;
   }
   return returnValue;
}
//+------------------------------------------------------------------+