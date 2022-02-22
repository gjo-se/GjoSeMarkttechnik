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
   comment += "T3: " + "\n";
   comment += "Tradabel Button State: " + IntegerToString(t3IsTradabelButtonState) + "\n";
   if(!TerminalInfoInteger(TERMINAL_TRADE_ALLOWED)) comment += "TERMINAL_TRADE_ALLOWED: OFF" + "\n";
   if(!MQLInfoInteger(MQL_TRADE_ALLOWED)) comment += "MQL_TRADE_ALLOWED: OFF" + "\n";
   comment += "T3 Direction: " + getT3TrendDirectionString() + "\n";
   comment += "T3 Start: " + TimeToString(t3StartDateTime) + "\n";
   comment += "T3 P1: " + TimeToString(t3p1DateTime) + " - " + DoubleToString(getT3P1HighLowValueByTrendDirection(), Digits()) + "\n";
   comment += "T3 P2: " + TimeToString(t3p2DateTime) + " - " + DoubleToString(getT3P2HighLowValueByTrendDirection(), Digits()) + "\n";
   comment += "T3 P3: " + TimeToString(t3p3DateTime) + " - " + DoubleToString(getT3P3HighLowValueByTrendDirection(), Digits()) + "\n";
   comment += "T3 P4: " + TimeToString(t3p4DateTime) + " - " + DoubleToString(getT3P4HighLowValueByTrendDirection(), Digits()) + "\n";
   comment += "Alert RegressionChannel: " + DoubleToString(t3AlertRegressionChannelLevel, 2) + "\n";
   comment += "Alert FiboRetracement: " + DoubleToString(t3AlertFiboRetracementLevel, 2) + "\n";
   comment += "Alert t3IsSellRegressionAlertSendable: " + (string)t3IsSellRegressionAlertSendable + "\n";
   comment += "\n";
   comment += "INSignalArea MIN: " + DoubleToString(t3InSignalFiboLevelAreaMinEndValue, Digits()) + " - " + DoubleToString(t3InSignalRegressionChannelAreaMinEndValue, Digits()) + " - " + DoubleToString(t3InSignalAreaMinEndValue, Digits()) + "\n";
   comment += "INSignalArea MAX: " + DoubleToString(t3InSignalFiboLevelAreaMaxEndValue, Digits()) + " - " + DoubleToString(t3InSignalRegressionChannelAreaMaxEndValue, Digits()) + " - " + DoubleToString(t3InSignalAreaMaxEndValue, Digits()) + "\n";
//   comment += "reEntryArea MIN: " + DoubleToString(t3ReEntryAreaMinStartValue, Digits()) + " - " + DoubleToString(t3ReEntryAreaMinEndValue, Digits()) + "\n";
//   comment += "reEntryArea MAX: " + DoubleToString(t3ReEntryAreaMaxStartValue, Digits()) + " - " + DoubleToString(t3ReEntryAreaMaxEndValue, Digits()) + "\n";
   comment += "\n";
   comment += "SHORT: " + "\n";
   comment += "t3HighestHighIsInSignalArea : " + IntegerToString(t3HighestHighIsInSignalArea) + "\n";
   comment += "t3ShortIsTradable: " + IntegerToString(t3ShortIsTradable) + "\n";
   comment += "HihgestHighVLineDateTime: " + TimeToString(t3HighestHighVLineDateTime) + "\n";
   comment += "HihgestHigh: " + TimeToString(t3HighestHighDateTime) + " - " + DoubleToString(iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3HighestHighDateTime)), Digits()) + "\n";
   comment += "ShortEntry: " + TimeToString(t3HighestHighDateTime) + " - " + DoubleToString(t3ShortEntryValue, Digits()) + "\n";
   comment += "\n";
   comment += "LONG: " + "\n";
   comment += "t3LowestLowIsInSignalArea : " + IntegerToString(t3LowestLowIsInSignalArea) + "\n";
   comment += "t3LongIsTradable: " + IntegerToString(t3LongIsTradable) + "\n";
   comment += "LowestLowVLineDateTime: " + TimeToString(t3LowestLowVLineDateTime) + "\n";
   comment += "LowestLow: " + TimeToString(t3LowestLowDateTime) + " - " + DoubleToString(t3LowestLowValue, Digits()) + "\n";
   comment += "LongEntry: " + TimeToString(t3LowestLowDateTime) + " - " + DoubleToString(t3LongEntryValue, Digits()) + "\n";
   comment += "\n";
   comment += "OutSideBar: " + TimeToString(outSideBarDateTime) + "\n";
   comment += "StopLossLineLevel: " + DoubleToString(t3StopLossLineLevel, Digits()) + "\n";
   comment += "TrailingStopLevel: " + DoubleToString(t3TrailingStopLevel, Digits()) + "\n";

//   Comment(comment);
}

//+------------------------------------------------------------------+
