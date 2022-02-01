/*

   EA GjoSeMarkttechnik.mq5
   Copyright 2022, Gregory Jo
   https://www.gjo-se.com

   Version History
   ===============

   1.0  Initial version
   1.1  GWL Features

   ===============

*/

//+------------------------------------------------------------------+
//| Includes                                                         |
//+------------------------------------------------------------------+
#include "Basics\\Includes.mqh"

//+------------------------------------------------------------------+
//| Headers                                                          |
//+------------------------------------------------------------------+
#property copyright   "2022, GjoSe"
#property link        "http://www.gjo-se.com"
#property description "GjoSe Markttechnik"
#define   VERSION "1.1"
#property version VERSION
#property strict

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit() {

   initializeEAAction();
   initializeGlobalsAction();
   initializeArraysAction();

   setLineValues();
   getT3TrendDirection();

   handleObjectsAction();

   commentAction();

   return(0);
}

void OnTick() {

   handleObjectsAction();

   commentAction();

   if(getBuyAlertRegressionSignal() == true) alertBuyRegressionAction();
   if(getSellAlertRegressionSignal() == true) alertSellRegressionAction();

//   if(getBuyInSignal() == true) openBuyOrderAction();
//   if(getSellInSignal() == true) openSellOrderAction();

//   if(InpUseBreakEven == true) setBreakevenAction();

}

//+------------------------------------------------------------------+
//| Expert deInitialization function                                   |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {

   Comment("");

   Print(__FUNCTION__, " UninitializeReason() = ", getUninitReasonText(UninitializeReason()));
}
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam) {

   if(id == CHARTEVENT_OBJECT_CLICK) {
      setLineValues();
      getT3TrendDirection();
      objectHasChanged = true;
   }

}
//+------------------------------------------------------------------+
