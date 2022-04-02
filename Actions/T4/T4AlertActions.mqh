//+------------------------------------------------------------------+
//|                                                 AlertActions.mqh |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void t4AlertT4TrendBrokenAction() {
   if(sendAlerts == true) {
      string message = Symbol() + ": " + "T4 Bid Crossed T4P3 - T4 brocken";
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot Push " + message, GetLastError());
      t4AlertT4TrendBrokenSended = true;
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void t4AlertT4BuildNewTrendAction() {
   if(sendAlerts == true) {
      string message = Symbol() + ": " + "T4 Bid Crossed T4P4 - T4 Build New Trend";
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot Push " + message, GetLastError());
      t4AlertT4BuildNewTrendSended = true;
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void t4AlertT4P2CreatedAction() {
   if(sendAlerts == true) {
      string message = Symbol() + ": " + "T4 T4P2 Created";
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot Push " + message, GetLastError());
      t4AlertT4P2CreatedSended = true;
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void t4AlertT4P3CreatedAction() {
   if(sendAlerts == true) {
      string message = Symbol() + ": " + "T4 T4P3 Created";
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot Push " + message, GetLastError());
      t4AlertT4P3CreatedSended = true;
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void t4AlertT4P4CreatedAction() {
   if(sendAlerts == true) {
      string message = Symbol() + ": " + "T4 T4P4 Created";
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot Push " + message, GetLastError());
      t4AlertT4P4CreatedSended = true;
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void t4AlertT4P5CreatedAction() {
   if(sendAlerts == true) {
      string message = Symbol() + ": " + "T4 T4P5 Created";
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot Push " + message, GetLastError());
      t4AlertT4P5CreatedSended = true;
   }
}

void t4AlertBuyRegressionAction() {

   if(sendAlerts == true && (InpT4AlertOnRegressionChannelLevel != 0 || InpT4AlertOnFiboRetracmentLevel != 0 ) && t4IsBuyRegressionAlertSendable == true && t4IsBuyRegressionAlertSended == false) {
      string message = Symbol() + ": LONG-Regression ";
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot sendRegressionAlert Push", GetLastError());
      t4IsBuyRegressionAlertSended = true;
   }
}

void t4AlertSellRegressionAction() {

   if(sendAlerts == true && (InpT4AlertOnRegressionChannelLevel != 0 || InpT4AlertOnFiboRetracmentLevel != 0 ) && t4IsSellRegressionAlertSendable == true && t4IsSellRegressionAlertSended == false) {
      string message = Symbol() + ": SHORT-Regression ";
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot sendRegressionAlert Push", GetLastError());
      t4IsSellRegressionAlertSended = true;
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void t4AlertDisableTradeableButtonAction(string pReason) {
   if(sendAlerts == true) {
      string message = Symbol() + ": " + pReason;
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot t4AlertDisableTradeableButtonAction Push", GetLastError());
      t4AlertDisableTradeableButtonSended = true;
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void t4AlertMAChangedAction() {
   if(sendAlerts == true) {
      string message = Symbol() + ": " + "T4 MA TrailingStop Changed to " + IntegerToString(t4TrailingStopMAActive);
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot Push " + message + " Error: ", GetLastError());
      t4alertMAChangedSended = true;
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void t4AlertOnBidStopLossLineOffset() {

   if(sendAlerts == true && t4StopLossValue != 0 && InpT4AlertOnBidStopLossLineOffset != 0) {
      if(t4trendDirection == TREND_DIRECTION_LONG) {
         if(Bid() > t4StopLossValue + InpT4AlertOnBidStopLossLineOffset * Point()) {
            if(t4IsBidStopLossLineOffsetAlertSendable == true && t4IsBidStopLossLineOffsetAlertSended == false) {
               string message = Symbol() + ": LONG-BidStopLossLineOffset ";
               Alert(message);
               if(!SendNotification(message)) Alert("Cannot BidStopLossLineOffset Push", GetLastError());
               t4IsBidStopLossLineOffsetAlertSended = true;
            }
         } else {
            t4IsBidStopLossLineOffsetAlertSendable = true;
         }
      }
      if(t4trendDirection == TREND_DIRECTION_SHORT) {
         if(Bid() < t4StopLossValue - InpT4AlertOnBidStopLossLineOffset * Point()) {
            if(t4IsBidStopLossLineOffsetAlertSendable == true && t4IsBidStopLossLineOffsetAlertSended == false) {
               string message = Symbol() + ": SHORT-BidStopLossLineOffset ";
               Alert(message);
               if(!SendNotification(message)) Alert("Cannot BidStopLossLineOffset Push", GetLastError());
               t4IsBidStopLossLineOffsetAlertSended = true;
            }
         } else {
            t4IsBidStopLossLineOffsetAlertSendable = true;
         }
      }
   }
}

void t4CommentAction(string pVersion) {

   if(t4p1DateTime) {
      t4comment = "";
      t4comment += "\n\n";
      t4comment += "\n\n";
      t4comment += "T4: " + "\n";
      t4comment += "t4MinRegressionForTrendDetectionLevel: " + DoubleToString(t4MinRegressionForTrendDetectionLevel) + " State: " + IntegerToString(t4MinRegressionForTrendDetectionState) + "\n";
      t4comment += "Tradabel Button State: " + IntegerToString(t4IsTradabelButtonState) + "\n";
      if(t4AlertRegressionChannelLevel != 0) t4comment += "Alert RegressionChannel: " + DoubleToString(t4AlertRegressionChannelLevel, 2) + "\n";
      if(t4AlertFiboRetracementLevel != 0) t4comment += "Alert FiboRetracement: " + DoubleToString(t4AlertFiboRetracementLevel, 2) + "\n";
      t4comment += "\n";
      if(t4trendDirection == TREND_DIRECTION_LONG || t4SemiTrendDirection == TREND_DIRECTION_LONG) {
         t4comment += "LONG: " + "\n";
         t4comment += "getT4LowestLowIsInSignalAreaState(): " + IntegerToString(getT4LowestLowIsInSignalAreaState()) + "\n";
         t4comment += "LowestLowVLineDateTime: " + TimeToString(t4LowestLowVLineDateTime) + "\n";
         t4comment += "LowestLowValue: " + TimeToString(t4LowestLowDateTime) + " - " + DoubleToString(t4LowestLowValue, Digits()) + "\n";
         t4comment += "LongEntryValue: " + DoubleToString(t4LongEntryValue, Digits()) + "\n";
         t4comment += "\n";
         t4comment += "buyT4PositionIsOpenState: " + IntegerToString(buyT4PositionIsOpenState) + "\n";
         t4comment += "Bid() >= t4LongEntryValue: " + IntegerToString(Bid() >= t4LongEntryValue) + "\n";
         t4comment += "maxT4BuyPositionsAreOpenState: " + IntegerToString(maxT4BuyPositionsAreOpenState) + "\n";
      }
      if(t4trendDirection == TREND_DIRECTION_SHORT || t4SemiTrendDirection == TREND_DIRECTION_SHORT) {
         t4comment += "SHORT: " + "\n";
         t4comment += "getT4HighestHighIsInSignalAreaState(): " + IntegerToString(getT4HighestHighIsInSignalAreaState()) + "\n";
         t4comment += "HihgestHighVLineDateTime: " + TimeToString(t4HighestHighVLineDateTime) + "\n";
         t4comment += "HihgestHighValue: " + TimeToString(t4HighestHighDateTime) + " - " + DoubleToString(iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4HighestHighDateTime)), Digits()) + "\n";
         t4comment += "ShortEntryValue: " + DoubleToString(t4ShortEntryValue, Digits()) + "\n";
         t4comment += "\n";
         t4comment += "sellT4PositionIsOpenState: " + IntegerToString(sellT4PositionIsOpenState) + "\n";
         t4comment += "Bid() <= t4ShortEntryValue: " + IntegerToString(Bid() <= t4ShortEntryValue) + "\n";
         t4comment += "maxT4SellPositionsAreOpenState: " + IntegerToString(maxT4SellPositionsAreOpenState) + "\n";
      }
      t4comment += "\n";
      t4comment += "t4 Trailing isActive: " + IntegerToString(t4ProfitLevelGreaterMinProfitFiboRetracmentLevel) + "\n";
      t4comment += "t4CurrentTrailingStopMAPeriod: " + IntegerToString(t4TrailingStopMAActive) + "\n";
      if(t4CurrentBidMAOffset > 0) t4comment += " CurrentOffset: " + DoubleToString(t4CurrentBidMAOffset, 0) + "\n";
      t4comment += "\n";
      t4comment += "t4StopLossValue: " + DoubleToString(t4StopLossValue, Digits()) + "\n";
      t4comment += "t4LotSize: " + DoubleToString(t4LotSize, 2) + "\n";
      if(outSideBarDateTime != 0) t4comment += "OutSideBar: " + TimeToString(outSideBarDateTime) + "\n";
      t4comment += "\n";
      t4comment += "T4-P1: " + TimeToString(t4p1DateTime) + " HIGH: " + DoubleToString(t4p1ValueHigh, Digits()) +  " LOW: " + DoubleToString(t4p1ValueLow, Digits()) + "\n";
      t4comment += "T4-P2: " + TimeToString(t4p2DateTime) + " HIGH: " + DoubleToString(t4p2ValueHigh, Digits()) +  " LOW: " + DoubleToString(t4p2ValueLow, Digits()) + "\n";
      t4comment += "T4-P3: " + TimeToString(t4p3DateTime) + " HIGH: " + DoubleToString(t4p3ValueHigh, Digits()) +  " LOW: " + DoubleToString(t4p3ValueLow, Digits()) + "\n";
      t4comment += "T4-P4: " + TimeToString(t4p4DateTime) + " HIGH: " + DoubleToString(t4p4ValueHigh, Digits()) +  " LOW: " + DoubleToString(t4p4ValueLow, Digits()) + "\n";
      t4comment += "T4-P5: " + TimeToString(t4p5DateTime) + " HIGH: " + DoubleToString(t4p5ValueHigh, Digits()) +  " LOW: " + DoubleToString(t4p5ValueLow, Digits()) + "\n";
   }
}
//+------------------------------------------------------------------+
