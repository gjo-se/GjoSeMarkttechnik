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

void t3CommentAction(string pVersion) {

   comment = "\n\n";
   comment += "EA Version: " + pVersion + "\n";
   if(!TerminalInfoInteger(TERMINAL_TRADE_ALLOWED)) comment += "TERMINAL_TRADE_ALLOWED: OFF" + "\n";
   if(!MQLInfoInteger(MQL_TRADE_ALLOWED)) comment += "MQL_TRADE_ALLOWED: OFF" + "\n";
   comment = "\n";
   if(t3p1DateTime) {
      comment += "T3: " + "\n";
      comment += "Tradabel Button State: " + IntegerToString(t3IsTradabelButtonState) + "\n";
      if(t3AlertRegressionChannelLevel != 0) comment += "Alert RegressionChannel: " + DoubleToString(t3AlertRegressionChannelLevel, 2) + "\n";
      if(t3AlertFiboRetracementLevel != 0) comment += "Alert FiboRetracement: " + DoubleToString(t3AlertFiboRetracementLevel, 2) + "\n";
      comment += "\n";

      if(getT3TrendDirectionString() == "LONG") {
         comment += "LONG: " + "\n";
         comment += "t3LongIsTradable: " + IntegerToString(t3LongIsTradable) + "\n";
         comment += "LowestLowVLineDateTime: " + TimeToString(t3LowestLowVLineDateTime) + "\n";
         comment += "LowestLow: " + " - " + DoubleToString(t3LowestLowValue, Digits()) + "\n";
         comment += "LongEntry: " + " - " + DoubleToString(t3LongEntryValue, Digits()) + "\n";
      }
      if(getT3TrendDirectionString() == "SHORT") {
         comment += "SHORT: " + "\n";
         comment += "t3ShortIsTradable: " + IntegerToString(t3ShortIsTradable) + "\n";
         comment += "HihgestHighVLineDateTime: " + TimeToString(t3HighestHighVLineDateTime) + "\n";
         comment += "HihgestHigh: " + " - " + DoubleToString(iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3HighestHighDateTime)), Digits()) + "\n";
         comment += "ShortEntry: " + " - " + DoubleToString(t3ShortEntryValue, Digits()) + "\n";
      }
      comment += "\n";
      comment += "StopLossLineLevel: " + DoubleToString(t3StopLossLineLevel, Digits()) + "\n";
      if(outSideBarDateTime != 0) comment += "OutSideBar: " + TimeToString(outSideBarDateTime) + "\n";
   }
}

//+------------------------------------------------------------------+
