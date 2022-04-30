//+------------------------------------------------------------------+
//|                                           HandleObjectAction.mqh |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
void handleT3ObjectsInitAction() {

   deleteTrendLineLike(T3_ZIGZAGLINE);
   deleteRegressionChannel(T3_REGRESSION_CHANNEL);
   deleteFiboLevelsObject(T3_FIBO_LEVELS);
   deleteChannelObject(T3_IN_SIGNAL_FIBO_LEVEL_AREA);
   deleteChannelObject(T3_IN_SIGNAL_REGRESSION_CHANNEL_AREA);
   deleteChannelObject(T3_RE_ENTRY_AREA);

   createT3ZigZagTrendDetectionLines();
   createT3RegressionChannel();
   createT3RegressionChannelLevels();
   createT3FiboRetracement();
   createT3InSignalFiboLevelChannelArea();
   createt3InSignalRegressionChannelArea();

   t3HandleObjectsAction();
}


void t3HandleObjectsAction() {

   if(ObjectFind(ChartID(), T3_AUTO_BUTTON) < 0) {
      createT3AutoButton();
   }

   if(InpT3ObjectsShow == true) {

      if(isNewCurrentBar == true) {
         createT3ZigZagTrendDetectionLines();
         createT3RegressionChannel();
         createT3RegressionChannelLevels();
         createT3FiboRetracement();
         createT3InSignalFiboLevelChannelArea();
         createt3InSignalRegressionChannelArea();
         createT3ReEntryArea();
      }

      double t3StopLossValueLocal = ObjectGetValueByTime(0, T3_STOP_LOSS_TLINE, iTime(Symbol(), Period(), 0));
      if(t3StopLossValueLocal != 0) t3StopLossValue = t3StopLossValueLocal;

   } else {
      deleteTrendLineLike(T3_ZIGZAGLINE);
      deleteRegressionChannel(T3_REGRESSION_CHANNEL);
      deleteFiboLevelsObject(T3_FIBO_LEVELS);
      deleteChannelObject(T3_IN_SIGNAL_FIBO_LEVEL_AREA);
      deleteChannelObject(T3_IN_SIGNAL_REGRESSION_CHANNEL_AREA);
      deleteChannelObject(T3_RE_ENTRY_AREA);
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

