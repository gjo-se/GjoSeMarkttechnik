/*

   SellInState
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

   Beschreibung
   ===============

*/

bool getSellInSignal() {

   bool signal = false;

   if(getBidLowerShortEntryLevelSignal() == true) signal = true;
   if(getT3HighestHighIsInSignalAreaState() == false) signal = false;

   if(getBidTriggerShortGridLimitOrderSignal() == true) signal = true;
   if(getBidTriggerShortGridStopOrderSignal() == true) signal = true;

   if(!TerminalInfoInteger(TERMINAL_TRADE_ALLOWED) || !MQLInfoInteger(MQL_TRADE_ALLOWED)) signal = false;
   if(t3trendDirection != TREND_DIRECTION_SHORT) signal = false;
   if(isTradabelButtonState == false) signal = false;
   if(maxSellPositionsAreOpenState == true) signal = false;

//   if(getBidLowerShortReEntryAreaFilter() == true) return false;
//   if(t3ShortIsTradable == false) return false;
//   if(spreadGreaterThanMaxSpreadSellInFilter() == true) signal = false;

   return(signal);

}

bool getT3HighestHighIsInSignalAreaState() {

   bool state = false;

   if(t3HighestHighIsInSignalArea) state = true;

   if(useReEntryArea == true) {
      if(reEntryAreaMinEndValue != 0 && Bid() >= reEntryAreaMinEndValue
            && reEntryAreaMaxEndValue != 0 && Bid() <= reEntryAreaMaxEndValue) {
         state = true;
      }
   }
   return state;
}

bool getBidLowerShortEntryLevelSignal() {

   bool signal = false;

   if(Bid() > t3ShortEntryValue) t3ShortIsTradable = true;

   if(sellPositionIsOpenState == false && t3ShortIsTradable == true && Bid() <= t3ShortEntryValue) {
      signal = true;
      t3ShortIsTradable = false;
   }

   return signal;
}

bool getBidTriggerShortGridLimitOrderSignal() {

   bool signal = false;

   if(sellPositionIsOpenState) {
      for(int orderGridLimitOrderValueId = 0; orderGridLimitOrderValueId < ArraySize(orderGridLimitOrderValuesArray); orderGridLimitOrderValueId++) {
         if(orderGridLimitOrderValuesArray[orderGridLimitOrderValueId] != EMPTY_VALUE
               && Bid() > orderGridLimitOrderValuesArray[orderGridLimitOrderValueId]) {
            signal = true;
            orderGridLimitOrderValuesArray[orderGridLimitOrderValueId] = EMPTY_VALUE;
         }
      }
   }

   return signal;
}

bool getBidTriggerShortGridStopOrderSignal() {

   bool signal = false;

   if(sellPositionIsOpenState) {
      for(int orderGridStopOrderValueId = 0; orderGridStopOrderValueId < ArraySize(orderGridStopOrderValuesArray); orderGridStopOrderValueId++) {
         if(orderGridStopOrderValuesArray[orderGridStopOrderValueId] != EMPTY_VALUE
               && Bid() < orderGridStopOrderValuesArray[orderGridStopOrderValueId]) {
            signal = true;
            orderGridStopOrderValuesArray[orderGridStopOrderValueId] = EMPTY_VALUE;
         }
      }
   }

   return signal;
}

bool getBidLowerShortReEntryAreaFilter() {

   bool filter = false;

   if(Bid() < reEntryAreaMinEndValue) {
      filter = true;
      t3ShortIsTradable = false;
   }

   return filter;
}

