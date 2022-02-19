//+------------------------------------------------------------------+
//|                                                 AlertActions.mqh |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

void alertBuyRegressionAction() {

   if((InpT3AlertOnRegressionChannelLevel != 0 || InpT3AlertOnFiboRetracmentLevel != 0 ) && isBuyRegressionAlertSendable == true && isBuyRegressionAlertSended == false) {
      string message = Symbol() + ": LONG-Regression ";
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot sendRegressionAlert Push", GetLastError());
      isBuyRegressionAlertSended = true;
   }
}

void alertSellRegressionAction() {

   if((InpT3AlertOnRegressionChannelLevel != 0 || InpT3AlertOnFiboRetracmentLevel != 0 ) && isSellRegressionAlertSendable == true && isSellRegressionAlertSended == false) {
      string message = Symbol() + ": SHORT-Regression ";
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot sendRegressionAlert Push", GetLastError());
      isSellRegressionAlertSended = true;
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void alertOnBidStopLossLineOffset() {

   if(t3StopLossLineLevel != 0 && InpT3AlertOnBidStopLossLineOffset != 0) {
      if(t3trendDirection == TREND_DIRECTION_LONG) {
         if(Bid() > t3StopLossLineLevel + InpT3AlertOnBidStopLossLineOffset * Point()) {
            if(isBidStopLossLineOffsetAlertSendable == true && isBidStopLossLineOffsetAlertSended == false) {
               string message = Symbol() + ": LONG-BidStopLossLineOffset ";
               Alert(message);
               if(!SendNotification(message)) Alert("Cannot BidStopLossLineOffset Push", GetLastError());
               isBidStopLossLineOffsetAlertSended = true;
            }
         } else {
            isBidStopLossLineOffsetAlertSendable = true;
         }
      }
      if(t3trendDirection == TREND_DIRECTION_SHORT) {
         if(Bid() < t3StopLossLineLevel - InpT3AlertOnBidStopLossLineOffset * Point()) {
            if(isBidStopLossLineOffsetAlertSendable == true && isBidStopLossLineOffsetAlertSended == false) {
               string message = Symbol() + ": SHORT-BidStopLossLineOffset ";
               Alert(message);
               if(!SendNotification(message)) Alert("Cannot BidStopLossLineOffset Push", GetLastError());
               isBidStopLossLineOffsetAlertSended = true;
            }
         } else {
            isBidStopLossLineOffsetAlertSendable = true;
         }
      }
   }
}

void commentAction(string pVersion) {

   string comment;

   comment += "\n\n";
   comment += "EA Version: " + pVersion + "\n";
   comment += "Tradabel Button State: " + IntegerToString(isTradabelButtonState) + "\n";
   if(!TerminalInfoInteger(TERMINAL_TRADE_ALLOWED)) comment += "TERMINAL_TRADE_ALLOWED: OFF" + "\n";
   if(!MQLInfoInteger(MQL_TRADE_ALLOWED)) comment += "MQL_TRADE_ALLOWED: OFF" + "\n";
   comment += "T3 Direction: " + getT3TrendDirectionString() + "\n";
   comment += "T3 Start: " + TimeToString(t3StartDateTime) + "\n";
   comment += "T3 P1: " + TimeToString(t3p1DateTime) + " - " + DoubleToString(getP1HighLowValueByTrendDirection(), Digits()) + "\n";
   comment += "T3 P2: " + TimeToString(t3p2DateTime) + " - " + DoubleToString(getP2HighLowValueByTrendDirection(), Digits()) + "\n";
   comment += "T3 P3: " + TimeToString(t3p3DateTime) + " - " + DoubleToString(getP3HighLowValueByTrendDirection(), Digits()) + "\n";
   comment += "T3 P4: " + TimeToString(t3p4DateTime) + " - " + DoubleToString(getP4HighLowValueByTrendDirection(), Digits()) + "\n";
   comment += "Alert RegressionChannel: " + DoubleToString(alertRegressionChannelLevel, 2) + "\n";
   comment += "Alert FiboRetracement: " + DoubleToString(alertFiboRetracementLevel, 2) + "\n";
   comment += "Alert isSellRegressionAlertSendable: " + (string)isSellRegressionAlertSendable + "\n";
   comment += "INSignalArea MIN: " + DoubleToString(inSignalAreaMinStartValue, Digits()) + " - " + DoubleToString(inSignalAreaMinEndValue, Digits()) + "\n";
   comment += "INSignalArea MAX: " + DoubleToString(inSignalAreaMaxStartValue, Digits()) + " - " + DoubleToString(inSignalAreaMaxEndValue, Digits()) + "\n";
   comment += "reEntryArea MIN: " + DoubleToString(reEntryAreaMinStartValue, Digits()) + " - " + DoubleToString(reEntryAreaMinEndValue, Digits()) + "\n";
   comment += "reEntryArea MAX: " + DoubleToString(reEntryAreaMaxStartValue, Digits()) + " - " + DoubleToString(reEntryAreaMaxEndValue, Digits()) + "\n";
   comment += "\n";
   comment += "SHORT: " + "\n";
   comment += "isBidGreaterInSignalAreaMinEndValue : " + IntegerToString(isBidGreaterInSignalAreaMinEndValue) + "\n";
   comment += "t3ShortIsTradable: " + IntegerToString(t3ShortIsTradable) + "\n";
   comment += "HihgestHighVLineDateTime: " + TimeToString(t3HighestHighVLineDateTime) + "\n";
   comment += "HihgestHigh: " + TimeToString(t3HighestHighDateTime) + " - " + DoubleToString(iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3HighestHighDateTime)), Digits()) + "\n";
   comment += "ShortEntry: " + TimeToString(t3HighestHighDateTime) + " - " + DoubleToString(t3ShortEntryValue, Digits()) + "\n";
   comment += "\n";
   comment += "LONG: " + "\n";
   comment += "isBidLowerInSignalAreaMaxEndValue : " + IntegerToString(isBidLowerInSignalAreaMaxEndValue) + "\n";
   comment += "t3LongIsTradable: " + IntegerToString(t3LongIsTradable) + "\n";
   comment += "LowestLowVLineDateTime: " + TimeToString(t3LowestLowVLineDateTime) + "\n";
   comment += "LowestLow: " + TimeToString(t3LowestLowDateTime) + " - " + DoubleToString(t3LowestLowValue, Digits()) + "\n";
   comment += "LongEntry: " + TimeToString(t3LowestLowDateTime) + " - " + DoubleToString(t3LongEntryValue, Digits()) + "\n";
   comment += "\n";
   comment += "OutSideBar: " + TimeToString(outSideBarDateTime) + "\n";
   comment += "StopLossLineLevel: " + DoubleToString(t3StopLossLineLevel, Digits()) + "\n";
   comment += "TrailingStopLevel: " + DoubleToString(t3TrailingStopLevel, Digits()) + "\n";
   comment += "t4RegressionChannelStopLossLineLevel: " + DoubleToString(t4RegressionChannelStopLossLineLevel, Digits()) + "\n";

   Comment(comment);
}

//+------------------------------------------------------------------+
