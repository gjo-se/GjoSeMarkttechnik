//+------------------------------------------------------------------+
//|                                           HandleObjectAction.mqh |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
void handleT4ObjectsInitAction() {

   deleteTrendLineLike(T4_ZIGZAGLINE);
   deleteRegressionChannel(T4_REGRESSION_CHANNEL);
   deleteFiboLevelsObject(T4_FIBO_LEVELS);
   deleteChannelObject(T4_IN_SIGNAL_REGRESSION_CHANNEL_AREA);
   deleteChannelObject(T4_RE_ENTRY_AREA);

   createT4ZigZagTrendDetectionLines();
   createT4RegressionChannel();
   createT4RegressionChannelLevels();
   createT4FiboRetracement();
   createt4InSignalRegressionChannelArea();

   t4HandleObjectsAction();
}

void t4HandleObjectsAction() {

   if(ObjectFind(ChartID(), T4_AUTO_BUTTON) < 0) {
      createT4AutoButton();
   }
   if(ObjectFind(ChartID(), T4_IS_TRADEABLE_BUTTON) < 0) {
      createT4IsTradeableButton();
   }

   if(InpT4ObjectsShow == true) {

      if(isNewCurrentBar == true) {
         createT4ZigZagTrendDetectionLines();
         createT4RegressionChannel();
         createT4RegressionChannelLevels();
         createT4FiboRetracement();
         createt4InSignalRegressionChannelArea();
         createT4ReEntryArea();
      }

   } else {
      deleteTrendLineLike(T4_ZIGZAGLINE);
      deleteRegressionChannel(T4_REGRESSION_CHANNEL);
      deleteFiboLevelsObject(T4_FIBO_LEVELS);
      deleteChannelObject(T4_IN_SIGNAL_REGRESSION_CHANNEL_AREA);
      deleteChannelObject(T4_RE_ENTRY_AREA);
   }

   if(allT4BuyPositionsAreClosedState || allT4SellPositionsAreClosedState) {
      string t4DisableTradeableButtonReason = "allT4PositionsAreClosedState";
      if(InpT4DisableTradabelButtonStateAfterClose == true) t4DisableTradeableButton(t4DisableTradeableButtonReason);
      deleteTrendLine(T4_STOP_LOSS_TLINE);
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getT4P1HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(t4p1ValueLow != 0 && t4p2ValueLow != 0) {
      returnValue = (t4p1ValueLow < t4p2ValueLow) ? t4p1ValueLow : t4p1ValueHigh;
   }
   return returnValue;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getT4P2HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(t4p1ValueLow != 0 && t4p2ValueLow != 0) {
      returnValue = (t4p1ValueLow > t4p2ValueLow) ? t4p2ValueLow : t4p2ValueHigh;
   }
   return returnValue;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getT4P3HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(t4p1ValueLow != 0 && t4p2ValueLow != 0) {
      returnValue = (t4p1ValueLow < t4p2ValueLow) ? t4p3ValueLow : t4p3ValueHigh;
   }
   return returnValue;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getT4P4HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(t4p1ValueLow != 0 && t4p2ValueLow != 0) {
      returnValue = (t4p1ValueLow > t4p2ValueLow) ? t4p4ValueLow : t4p4ValueHigh;
   }
   return returnValue;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getT4P5HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(t4p1ValueLow != 0 && t4p2ValueLow != 0) {
      returnValue = (t4p1ValueLow < t4p2ValueLow) ? t4p5ValueLow : t4p5ValueHigh;
   }
   return returnValue;
}
//+------------------------------------------------------------------+
