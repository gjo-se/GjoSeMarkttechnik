/*

   EA GjoSeMarkttechnik.mq5
   Copyright 2022, Gregory Jo
   https://www.gjo-se.com

   Version History
   ===============

   1.0   Initial version
   1.1   GWL Features
   1.2   solved PerformanceProblem
   1.3   first Testversion
   1.4   Trailing per Trendline
   1.5   isTradeableButton activeted
   1.6   fixed LotsSize Automatic

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
#define   VERSION "1.6"
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
   commentAction(VERSION);
   
   return(0);
}

void OnTick() {

   (NewCurrentBar()) ? isNewCurrentBar = true : isNewCurrentBar = false;

   closeActions();
   alertOnBidStopLossLineOffset();

   handleObjectsAction();
   commentAction(VERSION);

   if(getBuyAlertRegressionSignal() == true) alertBuyRegressionAction();
   if(getSellAlertRegressionSignal() == true) alertSellRegressionAction();

   if(getBuyInSignal() == true) openBuyOrderAction();
   if(getSellInSignal() == true) openSellOrderAction();

   //if(InpUseBreakEven == true) setBreakevenAction();
   //if(InpUseTrailing == true) setTrailingStopAction();

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

      if(sparam == IS_TRADEABLE_BUTTON) {
            handleIsTradeableButton();
      }
   }

}
//+------------------------------------------------------------------+
