//+------------------------------------------------------------------+
//|                                                 AlertActions.mqh |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

void t3AlertBuyRegressionAction() {

   if((InpT3AlertOnRegressionChannelLevel != 0 || InpT3AlertOnFiboRetracmentLevel != 0 ) && t3IsBuyRegressionAlertSendable == true && t3IsBuyRegressionAlertSended == false) {
      string message = Symbol() + ": LONG-Regression ";
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot sendRegressionAlert Push", GetLastError());
      t3IsBuyRegressionAlertSended = true;
   }
}

void t3AlertSellRegressionAction() {

   if((InpT3AlertOnRegressionChannelLevel != 0 || InpT3AlertOnFiboRetracmentLevel != 0 ) && t3IsSellRegressionAlertSendable == true && t3IsSellRegressionAlertSended == false) {
      string message = Symbol() + ": SHORT-Regression ";
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot sendRegressionAlert Push", GetLastError());
      t3IsSellRegressionAlertSended = true;
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void t3AlertOnBidStopLossLineOffset() {

   if(t3StopLossLineLevel != 0 && InpT3AlertOnBidStopLossLineOffset != 0) {
      if(t3trendDirection == TREND_DIRECTION_LONG) {
         if(Bid() > t3StopLossLineLevel + InpT3AlertOnBidStopLossLineOffset * Point()) {
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
         if(Bid() < t3StopLossLineLevel - InpT3AlertOnBidStopLossLineOffset * Point()) {
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

void handleCommentAction(string pVersion){
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
   t3comment += "\n";
   if(t3p1DateTime) {
      t3comment += "T3: " + "\n";
      t3comment += "Tradabel Button State: " + IntegerToString(t3IsTradabelButtonState) + "\n";
      if(t3AlertRegressionChannelLevel != 0) t3comment += "Alert RegressionChannel: " + DoubleToString(t3AlertRegressionChannelLevel, 2) + "\n";
      if(t3AlertFiboRetracementLevel != 0) t3comment += "Alert FiboRetracement: " + DoubleToString(t3AlertFiboRetracementLevel, 2) + "\n";
      t3comment += "\n";

      if(getT3TrendDirectionString() == "LONG") {
         t3comment += "LONG: " + "\n";
         t3comment += "t3LongIsTradable: " + IntegerToString(t3LongIsTradable) + "\n";
         t3comment += "LowestLowVLineDateTime: " + TimeToString(t3LowestLowVLineDateTime) + "\n";
         t3comment += "LowestLow: " + " - " + DoubleToString(t3LowestLowValue, Digits()) + "\n";
         t3comment += "LongEntry: " + " - " + DoubleToString(t3LongEntryValue, Digits()) + "\n";
         t3comment += "t3CurrentTrailingStopMAPeriod: " + IntegerToString(t3TrailingStopMAActive) + " CurrentOffset: " + DoubleToString(Bid() / Point() - t3TrailingStopMALevel / Point(), 0) + "\n";;
      }
      if(getT3TrendDirectionString() == "SHORT") {
         t3comment += "SHORT: " + "\n";
         t3comment += "t3ShortIsTradable: " + IntegerToString(t3ShortIsTradable) + "\n";
         t3comment += "HihgestHighVLineDateTime: " + TimeToString(t3HighestHighVLineDateTime) + "\n";
         t3comment += "HihgestHigh: " + " - " + DoubleToString(iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3HighestHighDateTime)), Digits()) + "\n";
         t3comment += "ShortEntry: " + " - " + DoubleToString(t3ShortEntryValue, Digits()) + "\n";
         t3comment += "t3CurrentTrailingStopMAPeriod: " + IntegerToString(t3TrailingStopMAActive) + " CurrentOffset: " + DoubleToString(t3TrailingStopMALevel / Point() - Bid() / Point(), 0) + "\n";;
      }
      t3comment += "\n";
      t3comment += "StopLossLineLevel: " + DoubleToString(t3StopLossLineLevel, Digits()) + "\n";
      if(outSideBarDateTime != 0) t3comment += "OutSideBar: " + TimeToString(outSideBarDateTime) + "\n";
   }
}
