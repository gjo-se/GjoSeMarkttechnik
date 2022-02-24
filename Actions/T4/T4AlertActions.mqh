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

   if(t4p1DateTime) {
      comment += "\n\n";
      comment += "\n\n";
      comment += "T4: " + "\n";
      comment += "Tradabel Button State: " + IntegerToString(t4IsTradabelButtonState) + "\n";
      if(t4AlertRegressionChannelLevel != 0) comment += "Alert RegressionChannel: " + DoubleToString(t4AlertRegressionChannelLevel, 2) + "\n";
      if(t4AlertFiboRetracementLevel != 0) comment += "Alert FiboRetracement: " + DoubleToString(t4AlertFiboRetracementLevel, 2) + "\n";
      comment += "\n";
      if(getT4TrendDirectionString() == "LONG") {
         comment += "LONG: " + "\n";
         comment += "t4LongIsTradable: " + IntegerToString(t4LongIsTradable) + "\n";
         comment += "LowestLowVLineDateTime: " + TimeToString(t4LowestLowVLineDateTime) + "\n";
         comment += "LowestLow: " + TimeToString(t4LowestLowDateTime) + " - " + DoubleToString(t4LowestLowValue, Digits()) + "\n";
         comment += "LongEntry: " + TimeToString(t4LowestLowDateTime) + " - " + DoubleToString(t4LongEntryValue, Digits()) + "\n";
      }
      if(getT4TrendDirectionString() == "SHORT") {
         comment += "SHORT: " + "\n";
         comment += "t4ShortIsTradable: " + IntegerToString(t4ShortIsTradable) + "\n";
         comment += "HihgestHighVLineDateTime: " + TimeToString(t4HighestHighVLineDateTime) + "\n";
         comment += "HihgestHigh: " + TimeToString(t4HighestHighDateTime) + " - " + DoubleToString(iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4HighestHighDateTime)), Digits()) + "\n";
         comment += "ShortEntry: " + TimeToString(t4HighestHighDateTime) + " - " + DoubleToString(t4ShortEntryValue, Digits()) + "\n";
      }
      comment += "\n";
      comment += "StopLossLineLevel: " + DoubleToString(t4StopLossLineLevel, Digits()) + "\n";
      if(outSideBarDateTime != 0) comment += "OutSideBar: " + TimeToString(outSideBarDateTime) + "\n";
   }

   Comment(comment);
}

//+------------------------------------------------------------------+
