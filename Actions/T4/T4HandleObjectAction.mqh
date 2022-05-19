//+------------------------------------------------------------------+
//|                                           HandleObjectAction.mqh |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
void handleT4ObjectsInitAction() {

   deleteTrendLineLike(T4_ZIGZAGLINE);
   createT4ZigZagTrendDetectionLines();

   t4HandleObjectsAction();
}

void t4HandleObjectsAction() {

   if(ObjectFind(ChartID(), T4_AUTO_BUTTON) < 0) {
      createT4AutoButton();
   }
   if(ObjectFind(ChartID(), T4_TMP_BUTTON) < 0 && tt4p1DateTime != 0) {
      createT4TMPButton();
   }
   if(ObjectFind(ChartID(), T4_IS_TRADEABLE_BUTTON) < 0) {
      createT4IsTradeableButton();
   }

      if(t4AlertHigherHLineValue != 0 && Bid() > t4AlertHigherHLineValue && t4AlertHigherHLineSended == false) {
         string hLineText  = ObjectGetString(ChartID(), T4_ALERT_BID_HIGHER_HINE, OBJPROP_TEXT);
         t4AlertBIDHigherHLineAction(hLineText);
         ObjectSetString(ChartID(), T4_ALERT_BID_HIGHER_HINE, OBJPROP_TEXT, hLineText + T4_ALERT_HINE_TIGGERT);
         ObjectSetInteger(ChartID(), T4_ALERT_BID_HIGHER_HINE, OBJPROP_STYLE, STYLE_DASH);
         ObjectSetString(ChartID(), T4_ALERT_BID_HIGHER_HINE, OBJPROP_NAME, T4_ALERT_BID_HIGHER_HINE + T4_ALERT_HINE_TIGGERT);
      }

      if(t4AlertLowerHLineValue != 0 && Bid() < t4AlertLowerHLineValue && t4AlertLowerHLineSended == false) {
         string hLineText  = ObjectGetString(ChartID(), T4_ALERT_BID_LOWER_HINE, OBJPROP_TEXT);
         t4AlertBIDLowerHLineAction(hLineText);
         ObjectSetString(ChartID(), T4_ALERT_BID_LOWER_HINE, OBJPROP_TEXT, hLineText + T4_ALERT_HINE_TIGGERT);
         ObjectSetInteger(ChartID(), T4_ALERT_BID_LOWER_HINE, OBJPROP_STYLE, STYLE_DASH);
         ObjectSetString(ChartID(), T4_ALERT_BID_LOWER_HINE, OBJPROP_NAME, T4_ALERT_BID_LOWER_HINE + T4_ALERT_HINE_TIGGERT);
      }

   if(InpT4ObjectsShow == true) {

      if(isNewCurrentBar == true) {
         createT4ZigZagTrendDetectionLines();
      }

   } else {
      deleteTrendLineLike(T4_ZIGZAGLINE);
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
