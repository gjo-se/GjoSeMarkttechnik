//+------------------------------------------------------------------+
//|                                                 AlertActions.mqh |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

void t4AlertBuyRegressionAction() {

   if((InpT4AlertOnRegressionChannelLevel != 0 || InpT4AlertOnFiboRetracmentLevel != 0 ) && t4IsBuyRegressionAlertSendable == true && t4IsBuyRegressionAlertSended == false) {
      string message = Symbol() + ": LONG-Regression ";
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot sendRegressionAlert Push", GetLastError());
      t4IsBuyRegressionAlertSended = true;
   }
}

void t4AlertSellRegressionAction() {

   if((InpT4AlertOnRegressionChannelLevel != 0 || InpT4AlertOnFiboRetracmentLevel != 0 ) && t4IsSellRegressionAlertSendable == true && t4IsSellRegressionAlertSended == false) {
      string message = Symbol() + ": SHORT-Regression ";
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot sendRegressionAlert Push", GetLastError());
      t4IsSellRegressionAlertSended = true;
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void t4AlertOnBidStopLossLineOffset() {

   if(t4StopLossLineLevel != 0 && InpT4AlertOnBidStopLossLineOffset != 0) {
      if(t4trendDirection == TREND_DIRECTION_LONG) {
         if(Bid() > t4StopLossLineLevel + InpT4AlertOnBidStopLossLineOffset * Point()) {
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
         if(Bid() < t4StopLossLineLevel - InpT4AlertOnBidStopLossLineOffset * Point()) {
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

   comment += "\n\n";
   comment += "\n\n";
   comment += "T4: " + "\n";
   comment += "Tradabel Button State: " + IntegerToString(t4IsTradabelButtonState) + "\n";
   comment += "T4 Direction: " + getT4TrendDirectionString() + "\n";
   comment += "T4 Start: " + TimeToString(t4StartDateTime) + "\n";
   comment += "T4 P1: " + TimeToString(t4p1DateTime) + " - " + DoubleToString(getT4P1HighLowValueByTrendDirection(), Digits()) + "\n";
   comment += "T4 P2: " + TimeToString(t4p2DateTime) + " - " + DoubleToString(getT4P2HighLowValueByTrendDirection(), Digits()) + "\n";
   comment += "T4 P3: " + TimeToString(t4p3DateTime) + " - " + DoubleToString(getT4P3HighLowValueByTrendDirection(), Digits()) + "\n";
   comment += "T4 P4: " + TimeToString(t4p4DateTime) + " - " + DoubleToString(getT4P4HighLowValueByTrendDirection(), Digits()) + "\n";
   comment += "Alert RegressionChannel: " + DoubleToString(t4AlertRegressionChannelLevel, 2) + "\n";
   comment += "Alert FiboRetracement: " + DoubleToString(t4AlertFiboRetracementLevel, 2) + "\n";
   comment += "Alert t4IsSellRegressionAlertSendable: " + (string)t4IsSellRegressionAlertSendable + "\n";
   comment += "\n";
   comment += "INSignalArea MIN: " + DoubleToString(t4InSignalFiboLevelAreaMinEndValue, Digits()) + " - "+ DoubleToString(t4InSignalRegressionChannelAreaMinEndValue, Digits()) + " - " + DoubleToString(t4InSignalAreaMinEndValue, Digits()) + "\n";
   comment += "INSignalArea MAX: " + DoubleToString(t4InSignalFiboLevelAreaMaxEndValue, Digits()) + " - "+ DoubleToString(t4InSignalRegressionChannelAreaMaxEndValue, Digits()) + " - " + DoubleToString(t4InSignalAreaMaxEndValue, Digits()) + "\n";
//   comment += "reEntryArea MIN: " + DoubleToString(t4ReEntryAreaMinStartValue, Digits()) + " - " + DoubleToString(t4ReEntryAreaMinEndValue, Digits()) + "\n";
//   comment += "reEntryArea MAX: " + DoubleToString(t4ReEntryAreaMaxStartValue, Digits()) + " - " + DoubleToString(t4ReEntryAreaMaxEndValue, Digits()) + "\n";
   comment += "\n";
   comment += "SHORT: " + "\n";
   comment += "t4HighestHighIsInSignalArea : " + IntegerToString(t4HighestHighIsInSignalArea) + "\n";
   comment += "t4ShortIsTradable: " + IntegerToString(t4ShortIsTradable) + "\n";
   comment += "HihgestHighVLineDateTime: " + TimeToString(t4HighestHighVLineDateTime) + "\n";
   comment += "HihgestHigh: " + TimeToString(t4HighestHighDateTime) + " - " + DoubleToString(iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4HighestHighDateTime)), Digits()) + "\n";
   comment += "ShortEntry: " + TimeToString(t4HighestHighDateTime) + " - " + DoubleToString(t4ShortEntryValue, Digits()) + "\n";
   comment += "\n";
   comment += "LONG: " + "\n";
   comment += "t4LowestLowIsInSignalArea : " + IntegerToString(t4LowestLowIsInSignalArea) + "\n";
   comment += "t4LongIsTradable: " + IntegerToString(t4LongIsTradable) + "\n";
   comment += "LowestLowVLineDateTime: " + TimeToString(t4LowestLowVLineDateTime) + "\n";
   comment += "LowestLow: " + TimeToString(t4LowestLowDateTime) + " - " + DoubleToString(t4LowestLowValue, Digits()) + "\n";
   comment += "LongEntry: " + TimeToString(t4LowestLowDateTime) + " - " + DoubleToString(t4LongEntryValue, Digits()) + "\n";
   comment += "\n";
   comment += "OutSideBar: " + TimeToString(outSideBarDateTime) + "\n";
   comment += "StopLossLineLevel: " + DoubleToString(t4StopLossLineLevel, Digits()) + "\n";
   comment += "TrailingStopLevel: " + DoubleToString(t4TrailingStopLevel, Digits()) + "\n";
   comment += "t4RegressionChannelStopLossLineLevel: " + DoubleToString(t4RegressionChannelStopLossLineLevel, Digits()) + "\n";

   Comment(comment);
}

//+------------------------------------------------------------------+
