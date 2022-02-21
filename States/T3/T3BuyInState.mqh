/*

   BuyInStates
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

   Beschreibung
   ===============

*/

bool getT3BuyInSignal() {

   bool signal = false;

   if(getT3BidGreaterLongEntryLevelSignal() == true) signal = true;
   if(getT3LowestLowIsInSignalAreaState() == false) signal = false;

   if(getT3BidTriggerLongGridLimitOrderSignal() == true) signal = true;
   if(getT3BidTriggerLongGridStopOrderSignal() == true) signal = true;

   if(!TerminalInfoInteger(TERMINAL_TRADE_ALLOWED) || !MQLInfoInteger(MQL_TRADE_ALLOWED)) signal = false;
   if(t3trendDirection != TREND_DIRECTION_LONG) signal = false;
   if(t3IsTradabelButtonState == false) signal = false;
   if(maxBuyPositionsAreOpenState == true) signal = false;


//   if(getT3BidGreaterLongReEntryAreaFilter() == true) return false;
//   if(t3LongIsTradable == false) return false;
//   if(spreadGreaterThanMaxSpreadBuyInFilter() == true) signal = false;

   return(signal);

}

bool getT3LowestLowIsInSignalAreaState() {

   bool state = false;

   if(t3LowestLowIsInSignalArea) state = true;

   if(t3UseReEntryArea == true) {
      if(t3ReEntryAreaMinEndValue != 0 && Bid() >= t3ReEntryAreaMinEndValue
            && t3ReEntryAreaMaxEndValue != 0 && Bid() <= t3ReEntryAreaMaxEndValue) {
         state = true;
      }
   }
   return state;
}

bool getT3BidGreaterLongEntryLevelSignal() {

   bool signal = false;

   if(Bid() < t3LongEntryValue) t3LongIsTradable = true;

   if(buyPositionIsOpenState == false && t3LongIsTradable == true && Bid() >= t3LongEntryValue) {
      signal = true;
      t3LongIsTradable = false;
   }

   return signal;
}

bool getT3BidTriggerLongGridLimitOrderSignal() {

   bool signal = false;

   if(buyPositionIsOpenState) {
      for(int orderGridLimitOrderValueId = 0; orderGridLimitOrderValueId < ArraySize(t3OrderGridLimitOrderValuesArray); orderGridLimitOrderValueId++) {
         if(t3OrderGridLimitOrderValuesArray[orderGridLimitOrderValueId] != EMPTY_VALUE
               && Bid() < t3OrderGridLimitOrderValuesArray[orderGridLimitOrderValueId]) {
            signal = true;
            t3OrderGridLimitOrderValuesArray[orderGridLimitOrderValueId] = EMPTY_VALUE;
         }
      }
   }

   return signal;
}

bool getT3BidTriggerLongGridStopOrderSignal() {

   bool signal = false;

   if(buyPositionIsOpenState) {
      for(int orderGridStopOrderValueId = 0; orderGridStopOrderValueId < ArraySize(t3OrderGridStopOrderValuesArray); orderGridStopOrderValueId++) {
         if(t3OrderGridStopOrderValuesArray[orderGridStopOrderValueId] != EMPTY_VALUE
               && Bid() > t3OrderGridStopOrderValuesArray[orderGridStopOrderValueId]) {
            signal = true;
            t3OrderGridStopOrderValuesArray[orderGridStopOrderValueId] = EMPTY_VALUE;
         }
      }
   }

   return signal;
}

bool getT3BidGreaterLongReEntryAreaFilter() {

   bool filter = false;

   if(Bid() > t3ReEntryAreaMaxEndValue) {
      filter = true;
      t3LongIsTradable = false;
   }

   return filter;
}

bool spreadGreaterThanMaxSpreadBuyInFilter() {

   bool filter = true;

//   if(Spread() <= InpMaxSpread) Print("Spread: " + Spread());

   if(Spread() < InpMaxSpread) {
      filter = false;
   }

   return(filter);

}

//+------------------------------------------------------------------+
