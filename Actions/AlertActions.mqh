//+------------------------------------------------------------------+
//|                                                 AlertActions.mqh |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

void alertBuyRegressionAction() {

   if(InpT3AlertOn == true && isBuyRegressionAlertSendable == true && isBuyRegressionAlertSended == false) {
      string message = Symbol() + ": LONG-Regression ";
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot sendRegressionAlert Push", GetLastError());
      isBuyRegressionAlertSended = true;
   }
}

void alertSellRegressionAction() {

   if(InpT3AlertOn == true && isSellRegressionAlertSendable == true && isSellRegressionAlertSended == false) {
      string message = Symbol() + ": SHORT-Regression ";
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot sendRegressionAlert Push", GetLastError());
      isSellRegressionAlertSended = true;
   }
}

void commentAction(string pVersion) {

   string comment;

   comment += "\n\n";
   comment += "EA Version: " + pVersion + "\n";
   comment += "T3 Direction: " + getT3TrendDirectionString() + "\n";
   comment += "T3 Start: " + TimeToString(t3StartDateTime) + "\n";
   comment += "T3 P1: " + TimeToString(t3p1DateTime) + " - " + DoubleToString(getP1HighLowValueByTrendDirection(), 2) + "\n";
   comment += "T3 P2: " + TimeToString(t3p2DateTime) + " - " + DoubleToString(getP2HighLowValueByTrendDirection(), 2) + "\n";
   comment += "T3 P3: " + TimeToString(t3p3DateTime) + " - " + DoubleToString(getP3HighLowValueByTrendDirection(), 2) + "\n";
   comment += "T3 P4: " + TimeToString(t3p4DateTime) + " - " + DoubleToString(getP4HighLowValueByTrendDirection(), 2) + "\n";
   comment += "Alert ON: " + IntegerToString(InpT3AlertOn) + "\n";
   comment += "Alert RegressionChannel: " + DoubleToString(alertRegressionChannelLevel, 2) + "\n";
   comment += "Alert FiboRetracement: " + DoubleToString(alertFiboRetracementLevel, 2) + "\n";
   comment += "Alert isSellRegressionAlertSendable: " + (string)isSellRegressionAlertSendable + "\n";
   comment += "INSignalArea MIN: " + DoubleToString(inSignalAreaMinStartValue, 2) + " - " + DoubleToString(inSignalAreaMinEndValue, 2) + "\n";
   comment += "INSignalArea MAX: " + DoubleToString(inSignalAreaMaxStartValue, 2) + " - " + DoubleToString(inSignalAreaMaxEndValue, 2) + "\n";
   comment += "reEntryArea MIN: " + DoubleToString(reEntryAreaMinStartValue, 2) + " - " + DoubleToString(reEntryAreaMinEndValue, 2) + "\n";
   comment += "reEntryArea MAX: " + DoubleToString(reEntryAreaMaxStartValue, 2) + " - " + DoubleToString(reEntryAreaMaxEndValue, 2) + "\n";
   comment += "\n";
   comment += "SHORT: " + "\n";
   comment += "t3ShortIsTradable: " + IntegerToString(t3ShortIsTradable) + "\n";
   comment += "HihgestHighLine: " + TimeToString(t3HhDateTime) + "\n";
   comment += "HihgestHigh: " + TimeToString(t3HighestHighDateTime) + " - " + DoubleToString(iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3HighestHighDateTime)), 2) + "\n";
   comment += "ShortEntryLevel: " + TimeToString(t3HighestHighDateTime) + " - " + DoubleToString(t3ShortEntryValue, 2) + "\n";
   comment += "\n";
   comment += "LONG: " + "\n";
   comment += "t3LongIsTradable: " + IntegerToString(t3LongIsTradable) + "\n";
   comment += "LowestLowLine: " + TimeToString(t3LlDateTime) + "\n";
   comment += "LowestLow: " + TimeToString(t3LowestLowDateTime) + " - " + DoubleToString(iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3LowestLowDateTime)), 2) + "\n";
   comment += "LongEntryLevel: " + TimeToString(t3LowestLowDateTime) + " - " + DoubleToString(t3LongEntryValue, 2) + "\n";
   comment += "\n";
   comment += "TrailingStopLevel: " + DoubleToString(t3TrailingStopLevel, 2) + "\n";

   Comment(comment);
}

//+------------------------------------------------------------------+
