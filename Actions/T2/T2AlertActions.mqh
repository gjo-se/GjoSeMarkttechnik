//+------------------------------------------------------------------+
//|                                                 AlertActions.mqh |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

void t2AlertT2P4CreatedTT3MissingAction() {
   if(sendAlerts == true) {
      string prio = "ERROR";
      string text = "T2 P4 + TT3 Missing";
      string message = prio + ": " + text + " - " + Symbol();
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot Push " + message + " Error: ", GetLastError());
      t2AlertT2P4CreatedTT3MissingSended = true;
   }
}

void t2AlertT2P4CreatedHighVolumeAreaMissingAction() {
   if(sendAlerts == true) {
      string prio = "ERROR";
      string text = "T2 P4 + HighVolumeArea Missing";
      string message = prio + ": " + text + " - " + Symbol();
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot Push " + message + " Error: ", GetLastError());
      t2AlertT2P4CreatedHighVolumeAreaMissingSended = true;
   }
}

void t2AlertT2P4CreatedAction() {
   if(sendAlerts == true) {
      string prio = "B";
      string text = "T2 P4 Created";
      string message = prio + ": " + text + " - " + Symbol();
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot Push " + message + " Error: ", GetLastError());
      t2AlertT2P4CreatedSended = true;
   }
}

void t2AlertT2P5CreatedAction() {
   if(sendAlerts == true) {
      string prio = "B";
      string text = "T2 P5 Created";
      string message = prio + ": " + text + " - " + Symbol();
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot Push " + message + " Error: ", GetLastError());
      t2AlertT2P5CreatedSended = true;
   }
}

void t2AlertT2BuildNewTrendAction() {
   if(sendAlerts == true) {
      string prio = "B";
      string text = "T2 Build New Trend";
      string message = prio + ": " + text + " - " + Symbol();
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot Push " + message + " Error: ", GetLastError());
      t2AlertT2BuildNewTrendSended = true;
   }
}

void t2AlertT2TrendBrokenAction() {
   if(sendAlerts == true) {
      string prio = "B";
      string text = "T2 Trend Broken";
      string message = prio + ": " + text + " - " + Symbol();
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot Push " + message + " Error: ", GetLastError());
      t2AlertT2TrendBrokenSended = true;
   }
}

void t2AlertT2VLineOn0Action() {
   if(sendAlerts == true) {
      string message = Symbol() + ": " + "T2 VLINE on 0 ";
      Alert(message);
      if(!SendNotification(message)) Alert("Cannot Push " + message, GetLastError());
      t2AlertT2VLineOn0Sended = true;
   }
}
