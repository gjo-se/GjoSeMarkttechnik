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

void commentAction(string pVersion){

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

    Comment(comment);
}

