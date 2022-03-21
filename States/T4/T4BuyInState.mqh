/*

   BuyInStates
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

   Beschreibung
   ===============

*/

bool getT4BuyInSignal() {

   bool signal = false;

   if(getT4BidGreaterLongEntryLevelSignal() == true) signal = true;
   if(getT4LowestLowIsInSignalAreaState() == false) signal = false;

   if(getT4BidTriggerLongGridLimitOrderSignal() == true) signal = true;
   if(getT4BidTriggerLongGridStopOrderSignal() == true) signal = true;

   if(!TerminalInfoInteger(TERMINAL_TRADE_ALLOWED) || !MQLInfoInteger(MQL_TRADE_ALLOWED)) signal = false;
   if(t4trendDirection != TREND_DIRECTION_LONG) signal = false;
   if(t4IsTradabelButtonState == false) signal = false;
   if(maxT4BuyPositionsAreOpenState == true) signal = false;


//   if(getT4BidGreaterLongReEntryAreaFilter() == true) return false;
//   if(t4LongIsTradable == false) return false;
//   if(spreadGreaterThanMaxSpreadBuyInFilter() == true) signal = false;

   return(signal);

}

bool getT4LowestLowIsInSignalAreaState() {

   bool state = false;

   if(t4LowestLowIsInSignalArea) state = true;

   if(t4UseReEntryArea == true) {
      if(t4ReEntryAreaMinEndValue != 0 && Bid() >= t4ReEntryAreaMinEndValue
            && t4ReEntryAreaMaxEndValue != 0 && Bid() <= t4ReEntryAreaMaxEndValue) {
         state = true;
      }
   }
   return state;
}

bool getT4BidGreaterLongEntryLevelSignal() {

   bool signal = false;

   if(buyT4PositionIsOpenState == false && t4LongEntryValue != 0 && Bid() >= t4LongEntryValue) {
      signal = true;
   }

   return signal;
}

bool getT4BidTriggerLongGridLimitOrderSignal() {

   bool signal = false;

   if(buyT4PositionIsOpenState) {
      for(int orderGridLimitOrderValueId = 0; orderGridLimitOrderValueId < ArraySize(t4OrderGridLimitOrderValuesArray); orderGridLimitOrderValueId++) {
         if(t4OrderGridLimitOrderValuesArray[orderGridLimitOrderValueId] != EMPTY_VALUE
               && Bid() < t4OrderGridLimitOrderValuesArray[orderGridLimitOrderValueId]) {
            signal = true;
            t4OrderGridLimitOrderValuesArray[orderGridLimitOrderValueId] = EMPTY_VALUE;
         }
      }
   }

   return signal;
}

bool getT4BidTriggerLongGridStopOrderSignal() {

   bool signal = false;

   if(buyT4PositionIsOpenState) {
      for(int orderGridStopOrderValueId = 0; orderGridStopOrderValueId < ArraySize(t4OrderGridStopOrderValuesArray); orderGridStopOrderValueId++) {
         if(t4OrderGridStopOrderValuesArray[orderGridStopOrderValueId] != EMPTY_VALUE
               && Bid() > t4OrderGridStopOrderValuesArray[orderGridStopOrderValueId]) {
            signal = true;
            t4OrderGridStopOrderValuesArray[orderGridStopOrderValueId] = EMPTY_VALUE;
         }
      }
   }

   return signal;
}

bool getT4BidGreaterLongReEntryAreaFilter() {

   bool filter = false;

   if(Bid() > t4ReEntryAreaMaxEndValue) {
      filter = true;
   }

   return filter;
}

//+------------------------------------------------------------------+
