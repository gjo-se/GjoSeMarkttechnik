//+------------------------------------------------------------------+
//|                                                 AlertActions.mqh |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void t4AlertPositionCountAction(const string pAlertText) {
   if(sendAlerts == true) {
      string prio = "B";
      string message = prio + ": " + pAlertText + " - " + Symbol();
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot Push " + message + " Error: ", GetLastError());
   }
}

void t4AlertT4TrendBrokenAction() {
   if(sendAlerts == true) {
      string prio;
      if(buyT4PositionIsOpenState == true || sellT4PositionIsOpenState == true){
         prio = "A";
      }else{
         prio = "C";
      }
      string text = "T4 Broken";
      string message = prio + ": " + text + " - " + Symbol();
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot Push " + message + " Error: ", GetLastError());
      t4AlertT4TrendBrokenSended = true;
   }
}

void t4AlertT4P4CreatedAction() {
   if(sendAlerts == true) {
      string prio = "A";
      string text = "T3 != T4 P4";
      string message = prio + ": " + text + " - " + Symbol();
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot Push " + message + " Error: ", GetLastError());
      t4AlertT4P4CreatedSended = true;
   }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void t4AlertT4P5CreatedAction() {
   if(sendAlerts == true) {
      string prio = "A";
      string text = "T4 P5";
      string message = prio + ": " + text + " - " + Symbol();
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot Push " + message + " Error: ", GetLastError());
      t4AlertT4P5CreatedSended = true;
   }
}

void t4AlertT4VLineOn0Action() {
   if(sendAlerts == true) {
      string message = Symbol() + ": " + "T4 VLINE on 0 ";
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot Push " + message, GetLastError());
      t4AlertT4VLineOn0Sended = true;
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
      t4comment += "T4: " + "\n\n";
      if(tt4movementLengthRegressionLengthRatio != 0) {
         t4comment += "tt4movementLength: " + DoubleToString(tt4movementLength, 0) + " (" + DoubleToString(tt4movementLengthP1P2, 0) + " / " +  DoubleToString(tt4movementLengthP3P4, 0) + " / " + DoubleToString(tt4movementLengthP5P6, 0) + ") Points" + "\n";
         t4comment += "tt4regressionLength: " + DoubleToString(tt4regressionLength, 0) + " (" + DoubleToString(tt4regressionLengthP2P3, 0) + " / " +  DoubleToString(tt4regressionLengthP4P5, 0) + ") Points" + "\n";
         t4comment += "tt4movementRegressionLengthRation: " + DoubleToString(tt4movementLengthRegressionLengthRatio, 0) + " %" + "\n";
      }
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
