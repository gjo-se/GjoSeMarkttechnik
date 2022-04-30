/*

   SellInState
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

   Beschreibung
   ===============

*/

bool getT4SellInSignal() {

   bool signal = false;

   if(getT4BidLowerShortEntryLevelSignal() == true) signal = true;

//   if(getT4BidTriggerShortGridLimitOrderSignal() == true) signal = true;
//   if(getT4BidTriggerShortGridStopOrderSignal() == true) signal = true;

   if(!TerminalInfoInteger(TERMINAL_TRADE_ALLOWED) || !MQLInfoInteger(MQL_TRADE_ALLOWED)) signal = false;
   if(t4trendDirection != TREND_DIRECTION_SHORT) signal = false;
   if(t4IsTradabelButtonState == false) signal = false;
   if(maxT4SellPositionsAreOpenState == true) signal = false;

//   if(t4ShortIsTradable == false) return false;
//   if(spreadGreaterThanMaxSpreadSellInFilter() == true) signal = false;

   return(signal);

}

bool getT4BidLowerShortEntryLevelSignal() {

   bool signal = false;

//   if(Bid() > t4ShortEntryValue) t4ShortIsTradable = true;

//   if(sellT4PositionIsOpenState == false && t4ShortIsTradable == true && Bid() <= t4ShortEntryValue) {
   if(sellT4PositionIsOpenState == false && t4ShortEntryValue != 0 && Bid() <= t4ShortEntryValue) {
      signal = true;
//      t4ShortIsTradable = false;
   }

   return signal;
}

bool getT4BidTriggerShortGridLimitOrderSignal() {

   bool signal = false;

   if(sellT4PositionIsOpenState) {
      for(int orderGridLimitOrderValueId = 0; orderGridLimitOrderValueId < ArraySize(t4OrderGridLimitOrderValuesArray); orderGridLimitOrderValueId++) {
         if(t4OrderGridLimitOrderValuesArray[orderGridLimitOrderValueId] != EMPTY_VALUE
               && Bid() > t4OrderGridLimitOrderValuesArray[orderGridLimitOrderValueId]) {
            signal = true;
            t4OrderGridLimitOrderValuesArray[orderGridLimitOrderValueId] = EMPTY_VALUE;
         }
      }
   }

   return signal;
}

bool getT4BidTriggerShortGridStopOrderSignal() {

   bool signal = false;

   if(sellT4PositionIsOpenState) {
      for(int orderGridStopOrderValueId = 0; orderGridStopOrderValueId < ArraySize(t4OrderGridStopOrderValuesArray); orderGridStopOrderValueId++) {
         if(t4OrderGridStopOrderValuesArray[orderGridStopOrderValueId] != EMPTY_VALUE
               && Bid() < t4OrderGridStopOrderValuesArray[orderGridStopOrderValueId]) {
            signal = true;
            t4OrderGridStopOrderValuesArray[orderGridStopOrderValueId] = EMPTY_VALUE;
         }
      }
   }

   return signal;
}

