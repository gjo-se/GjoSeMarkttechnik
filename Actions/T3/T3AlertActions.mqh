//+------------------------------------------------------------------+
//|                                                 AlertActions.mqh |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void t3AlertT3TrendBrokenAction() {
   if(sendAlerts == true) {
      string prio = "C";
      string text = "T3 Broken";
      string message = prio + ": " + text + " - " + Symbol();
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot Push " + message + " Error: ", GetLastError());
      t3AlertT3TrendBrokenSended = true;
   }
}

void t3AlertT3P5CreatedTT4MissingAction() {
   if(sendAlerts == true) {
      string prio = "ERROR";
      string text = "T3 P5 + TT4 Missing";
      string message = prio + ": " + text + " - " + Symbol();
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot Push " + message + " Error: ", GetLastError());
      t3AlertT3P5CreatedTT4MissingSended = true;
   }
}

void t3AlertT3VLineOn0Action() {
   if(sendAlerts == true) {
      string message = Symbol() + ": " + "T3 VLINE on 0 ";
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot Push " + message, GetLastError());
      t3AlertT3VLineOn0Sended = true;
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void t3AlertBuyRegressionAction() {
   if(sendAlerts == true && (InpT3AlertOnRegressionChannelLevel != 0 || InpT3AlertOnFiboRetracmentLevel != 0 ) && t3IsBuyRegressionAlertSendable == true && t3IsBuyRegressionAlertSended == false) {
      string message = Symbol() + ": LONG-Regression ";
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot sendRegressionAlert Push", GetLastError());
      t3IsBuyRegressionAlertSended = true;
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void t3AlertSellRegressionAction() {
   if(sendAlerts == true && (InpT3AlertOnRegressionChannelLevel != 0 || InpT3AlertOnFiboRetracmentLevel != 0 ) && t3IsSellRegressionAlertSendable == true && t3IsSellRegressionAlertSended == false) {
      string message = Symbol() + ": SHORT-Regression ";
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot sendRegressionAlert Push", GetLastError());
      t3IsSellRegressionAlertSended = true;
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void t3AlertDisableTradeableButtonAction(string pReason) {
   if(sendAlerts == true) {
      string message = Symbol() + ": " + pReason;
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot t3AlertDisableTradeableButtonAction Push", GetLastError());
      t3AlertDisableTradeableButtonSended = true;
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void t3AlertBidIsInSignalAreaAction() {
   if(sendAlerts == true) {
      string message = Symbol() + ": " + "T3 Bid Is In HighVolumeArea";
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot Push " + message, GetLastError());
      t3alertBidIsInSignalAreaSended = true;
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void t3alertBidAgainInHighVolumeAreaAction() {
   if(sendAlerts == true) {
      string message = Symbol() + ": " + "T3 Bid Is AGAIN in HighVolumeArea";
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot Push " + message, GetLastError());
      t3alertBidAgainInHighVolumeAreaSended = true;
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void t3AlertMAChangedAction() {
   if(sendAlerts == true) {
      string message = Symbol() + ": " + "T3 MA TrailingStop Changed to " + IntegerToString(t3TrailingStopMAActive);
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot Push " + message + " Error: ", GetLastError());
      t3alertMAChangedSended = true;
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void t3AlertOnBidStopLossLineOffset() {

   if(t3StopLossValue != 0 && InpT3AlertOnBidStopLossLineOffset != 0) {
      if(t3trendDirection == TREND_DIRECTION_LONG) {
         if(Bid() > t3StopLossValue + InpT3AlertOnBidStopLossLineOffset * Point()) {
            if(t3IsBidStopLossLineOffsetAlertSendable == true && t3IsBidStopLossLineOffsetAlertSended == false) {
               string message = Symbol() + ": LONG-BidStopLossLineOffset ";
               Alert(message);
               if(!SendNotification(message)) Alert("Cannot BidStopLossLineOffset Push", GetLastError());
               t3IsBidStopLossLineOffsetAlertSended = true;
            }
         } else {
            t3IsBidStopLossLineOffsetAlertSendable = true;
         }
      }
      if(t3trendDirection == TREND_DIRECTION_SHORT) {
         if(Bid() < t3StopLossValue - InpT3AlertOnBidStopLossLineOffset * Point()) {
            if(t3IsBidStopLossLineOffsetAlertSendable == true && t3IsBidStopLossLineOffsetAlertSended == false) {
               string message = Symbol() + ": SHORT-BidStopLossLineOffset ";
               Alert(message);
               if(!SendNotification(message)) Alert("Cannot BidStopLossLineOffset Push", GetLastError());
               t3IsBidStopLossLineOffsetAlertSended = true;
            }
         } else {
            t3IsBidStopLossLineOffsetAlertSendable = true;
         }
      }
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void handleCommentAction(string pVersion) {
   t3CommentAction(pVersion);
   t4CommentAction(pVersion);
   if(InpT3ShowCommentDashboard && InpT4ShowCommentDashboard) Comment(t3comment + t4comment);
   if(InpT3ShowCommentDashboard && !InpT4ShowCommentDashboard) Comment(t3comment);
   if(!InpT3ShowCommentDashboard && InpT4ShowCommentDashboard) Comment(t4comment);
}

void t3CommentAction(string pVersion) {

   t3comment = "\n\n";
   t3comment += "EA Version: " + pVersion + "\n";
   if(!TerminalInfoInteger(TERMINAL_TRADE_ALLOWED)) t3comment += "TERMINAL_TRADE_ALLOWED: OFF" + "\n";
   if(!MQLInfoInteger(MQL_TRADE_ALLOWED)) t3comment += "MQL_TRADE_ALLOWED: OFF" + "\n";
   if(sendAlerts == false) t3comment += "SEND PUSH: OFF" + "\n";
   t3comment += "\n";
   t3comment += "T2: " + "\n\n";
   if(tt2movementLengthRegressionLengthRatio != 0) {
      t3comment += "tt2movementLength: " + DoubleToString(tt2movementLength, 0) + " (" + DoubleToString(tt2movementLengthP1P2, 0) + " / " +  DoubleToString(tt2movementLengthP3P4, 0) + " / " + DoubleToString(tt2movementLengthP5P6, 0) + ") Points" + "\n";
      t3comment += "tt2regressionLength: " + DoubleToString(tt2regressionLength, 0) + " (" + DoubleToString(tt2regressionLengthP2P3, 0) + " / " +  DoubleToString(tt2regressionLengthP4P5, 0) + ") Points" + "\n";
      t3comment += "tt2movementRegressionLengthRatio: " + DoubleToString(tt2movementLengthRegressionLengthRatio, 0) + " %" + "\n";
   }
   t3comment += "\n";
   t3comment += "T3: " + "\n\n";
   if(tt3movementLengthRegressionLengthRatio != 0) {
      t3comment += "tt3movementLength: " + DoubleToString(tt3movementLength, 0) + " (" + DoubleToString(tt3movementLengthP1P2, 0) + " / " +  DoubleToString(tt3movementLengthP3P4, 0) + " / " + DoubleToString(tt3movementLengthP5P6, 0) + ") Points" + "\n";
      t3comment += "tt3regressionLength: " + DoubleToString(tt3regressionLength, 0) + " (" + DoubleToString(tt3regressionLengthP2P3, 0) + " / " +  DoubleToString(tt3regressionLengthP4P5, 0) + ") Points" + "\n";
      t3comment += "tt3movementRegressionLengthRatio: " + DoubleToString(tt3movementLengthRegressionLengthRatio, 0) + " %" + "\n";
   }
   t3comment += "\n";
   if(t3p1DateTime) {
      t3comment += "Tradabel Button State: " + IntegerToString(t3IsTradabelButtonState) + "\n";
      if(t3AlertRegressionChannelLevel != 0) t3comment += "Alert RegressionChannel: " + DoubleToString(t3AlertRegressionChannelLevel, 2) + "\n";
      if(t3AlertFiboRetracementLevel != 0) t3comment += "Alert FiboRetracement: " + DoubleToString(t3AlertFiboRetracementLevel, 2) + "\n";
      t3comment += "\n";
      if(t3trendDirection == TREND_DIRECTION_LONG || t3SemiTrendDirection == TREND_DIRECTION_LONG) {
         t3comment += "LONG: " + "\n";
         t3comment += "getT3LowestLowIsInSignalAreaState(): " + IntegerToString(getT3LowestLowIsInSignalAreaState()) + "\n";
         t3comment += "LowestLowVLineDateTime: " + TimeToString(t3LowestLowVLineDateTime) + "\n";
         t3comment += "LowestLowValue: " + DoubleToString(t3LowestLowValue, Digits()) + "\n";
         t3comment += "LongEntryValue: " + DoubleToString(t3LongEntryValue, Digits()) + "\n";
         t3comment += "\n";
         t3comment += "buyT3PositionIsOpenState: " + IntegerToString(buyT3PositionIsOpenState) + "\n";
         t3comment += "Bid() >= t3LongEntryValue: " + IntegerToString(Bid() >= t3LongEntryValue) + "\n";
         t3comment += "maxT3BuyPositionsAreOpenState: " + IntegerToString(maxT3BuyPositionsAreOpenState) + "\n";
      }
      if(t3trendDirection == TREND_DIRECTION_SHORT || t3SemiTrendDirection == TREND_DIRECTION_SHORT) {
         t3comment += "SHORT: " + "\n";
         t3comment += "getT3HighestHighIsInSignalAreaState(): " + IntegerToString(getT3HighestHighIsInSignalAreaState()) + "\n";
         t3comment += "HihgestHighVLineDateTime: " + TimeToString(t3HighestHighVLineDateTime) + "\n";
         t3comment += "HihgestHighValue: " + DoubleToString(iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3HighestHighDateTime)), Digits()) + "\n";
         t3comment += "ShortEntryValue: " + DoubleToString(t3ShortEntryValue, Digits()) + "\n";
         t3comment += "\n";
         t3comment += "sellT3PositionIsOpenState: " + IntegerToString(sellT3PositionIsOpenState) + "\n";
         t3comment += "Bid() <= t3ShortEntryValue: " + IntegerToString(Bid() <= t3ShortEntryValue) + "\n";
         t3comment += "maxT3SellPositionsAreOpenState: " + IntegerToString(maxT3SellPositionsAreOpenState) + "\n";
      }
      t3comment += "\n";
      t3comment += "t3 Trailing isActive: " + IntegerToString(t3ProfitLevelGreaterMinProfitFiboRetracmentLevel) + "\n";
      t3comment += "t3CurrentTrailingStopMAPeriod: " + IntegerToString(t3TrailingStopMAActive) + "\n";
      if(t3CurrentBidMAOffset > 0) t3comment += " CurrentOffset: " + DoubleToString(t3CurrentBidMAOffset, 0) + "\n";
      t3comment += "\n";
      t3comment += "t3StopLossValue: " + DoubleToString(t3StopLossValue, Digits()) + "\n";
      if(outSideBarDateTime != 0) t3comment += "OutSideBar: " + TimeToString(outSideBarDateTime) + "\n";
   }
}
//+------------------------------------------------------------------+
