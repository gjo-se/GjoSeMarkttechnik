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
void t4AlertDisableTradeableButtonAction(string pReason) {
   string message = Symbol() + ": " + pReason;
   Alert(message);
   if(!SendNotification(message)) Alert("Cannot sendRegressionAlert Push", GetLastError());
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
      t4comment = "";
      t4comment += "\n\n";
      t4comment += "\n\n";
      t4comment += "T4: " + "\n";
      t4comment += "Tradabel Button State: " + IntegerToString(t4IsTradabelButtonState) + "\n";
      if(t4AlertRegressionChannelLevel != 0) t4comment += "Alert RegressionChannel: " + DoubleToString(t4AlertRegressionChannelLevel, 2) + "\n";
      if(t4AlertFiboRetracementLevel != 0) t4comment += "Alert FiboRetracement: " + DoubleToString(t4AlertFiboRetracementLevel, 2) + "\n";
      t4comment += "\n";
      if(getT4TrendDirectionString() == "LONG") {
         t4comment += "LONG: " + "\n";
         t4comment += "getT4LowestLowIsInSignalAreaState(): " + IntegerToString(getT4LowestLowIsInSignalAreaState()) + "\n";
         t4comment += "LowestLowVLineDateTime: " + TimeToString(t4LowestLowVLineDateTime) + "\n";
         t4comment += "LowestLowValue: " + TimeToString(t4LowestLowDateTime) + " - " + DoubleToString(t4LowestLowValue, Digits()) + "\n";
         t4comment += "LongEntryValue: " + TimeToString(t4LowestLowDateTime) + " - " + DoubleToString(t4LongEntryValue, Digits()) + "\n";
         t4comment += "t4LongIsTradable: " + IntegerToString(t4LongIsTradable) + "\n";
         t4comment += "\n";
         t4comment += "buyT4PositionIsOpenState: " + IntegerToString(buyT4PositionIsOpenState) + "\n";
         t4comment += "Bid() >= t4LongEntryValue: " + IntegerToString(Bid() >= t4LongEntryValue) + "\n";
         t4comment += "maxT4BuyPositionsAreOpenState: " + IntegerToString(maxT4BuyPositionsAreOpenState) + "\n";
      }
      if(getT4TrendDirectionString() == "SHORT") {
         t4comment += "SHORT: " + "\n";
         t4comment += "getT4HighestHighIsInSignalAreaState(): " + IntegerToString(getT4HighestHighIsInSignalAreaState()) + "\n";
         t4comment += "HihgestHighVLineDateTime: " + TimeToString(t4HighestHighVLineDateTime) + "\n";
         t4comment += "HihgestHighValue: " + TimeToString(t4HighestHighDateTime) + " - " + DoubleToString(iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4HighestHighDateTime)), Digits()) + "\n";
         t4comment += "ShortEntryValue: " + TimeToString(t4HighestHighDateTime) + " - " + DoubleToString(t4ShortEntryValue, Digits()) + "\n";
         t4comment += "t4ShortIsTradable: " + IntegerToString(t4ShortIsTradable) + "\n";
         t4comment += "\n";
         t4comment += "sellT4PositionIsOpenState: " + IntegerToString(sellT4PositionIsOpenState) + "\n";
         t4comment += "Bid() <= t4ShortEntryValue: " + IntegerToString(Bid() <= t4ShortEntryValue) + "\n";
         t4comment += "maxT4SellPositionsAreOpenState: " + IntegerToString(maxT4SellPositionsAreOpenState) + "\n";
      }
      t4comment += "\n";
      string t4CurrentBidMAOffset = "";
      if(t4trendDirection == TREND_DIRECTION_LONG) t4CurrentBidMAOffset = DoubleToString(Bid() / Point() - t4TrailingStopMALevel / Point(), 0);
      if(t4trendDirection == TREND_DIRECTION_SHORT) t4CurrentBidMAOffset = DoubleToString(t4TrailingStopMALevel / Point() - Bid() / Point(), 0);
      t4comment += "t4CurrentTrailingStopMAPeriod: " + IntegerToString(t4TrailingStopMAActive) + " CurrentOffset: " + t4CurrentBidMAOffset + "\n";;
      t4comment += "StopLossLineLevel: " + DoubleToString(t4StopLossLineLevel, Digits()) + "\n";
      if(outSideBarDateTime != 0) t4comment += "OutSideBar: " + TimeToString(outSideBarDateTime) + "\n";
   }
}
