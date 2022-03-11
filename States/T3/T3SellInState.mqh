/*

   SellInState
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

   Beschreibung
   ===============

*/

bool getT3SellInSignal() {

   bool signal = false;

   if(getT3BidHigherShortEntryLevelSignal() == true) signal = true;
//   if(getT3BidLowerShortEntryLevelSignal() == true) signal = true;
//   if(getT3HighestHighIsInSignalAreaState() == false) signal = false;

   if(getT3BidTriggerShortGridLimitOrderSignal() == true) signal = true;
   if(getT3BidTriggerShortGridStopOrderSignal() == true) signal = true;

   if(!TerminalInfoInteger(TERMINAL_TRADE_ALLOWED) || !MQLInfoInteger(MQL_TRADE_ALLOWED)) signal = false;
   if(t3trendDirection != TREND_DIRECTION_SHORT) signal = false;
   if(t3IsTradabelButtonState == false) signal = false;
   if(maxT3SellPositionsAreOpenState == true) signal = false;

//   if(getT3BidLowerShortReEntryAreaFilter() == true) return false;
//   if(t3ShortIsTradable == false) return false;
//   if(spreadGreaterThanMaxSpreadSellInFilter() == true) signal = false;

   return(signal);

}

bool getT3BidHigherShortEntryLevelSignal() {

   bool signal = false;

   if(sellT3PositionIsOpenState == false && Bid() > t3ShortEntryValue){
      signal = true;
   }

   return signal;
}

// TODO: Rückbau
bool getT3HighestHighIsInSignalAreaState() {

   bool state = false;

   if(t3HighestHighIsInSignalArea) state = true;

   if(t3UseReEntryArea == true) {
      if(t3ReEntryAreaMinEndValue != 0 && Bid() >= t3ReEntryAreaMinEndValue
            && t3ReEntryAreaMaxEndValue != 0 && Bid() <= t3ReEntryAreaMaxEndValue) {
         state = true;
      }
   }
   return state;
}

// TODO: Rückbau
bool getT3BidLowerShortEntryLevelSignal() {

   bool signal = false;

   if(Bid() > t3ShortEntryValue) t3ShortIsTradable = true;

   if(sellT3PositionIsOpenState == false && t3ShortIsTradable == true && Bid() <= t3ShortEntryValue) {
      signal = true;
      t3ShortIsTradable = false;
   }

   return signal;
}

bool getT3BidTriggerShortGridLimitOrderSignal() {

   bool signal = false;

   if(sellT3PositionIsOpenState) {
      for(int orderGridLimitOrderValueId = 0; orderGridLimitOrderValueId < ArraySize(t3OrderGridLimitOrderValuesArray); orderGridLimitOrderValueId++) {
         if(t3OrderGridLimitOrderValuesArray[orderGridLimitOrderValueId] != EMPTY_VALUE
               && Bid() > t3OrderGridLimitOrderValuesArray[orderGridLimitOrderValueId]) {
            signal = true;
            t3OrderGridLimitOrderValuesArray[orderGridLimitOrderValueId] = EMPTY_VALUE;
         }
      }
   }

   return signal;
}

bool getT3BidTriggerShortGridStopOrderSignal() {

   bool signal = false;

   if(sellT3PositionIsOpenState) {
      for(int orderGridStopOrderValueId = 0; orderGridStopOrderValueId < ArraySize(t3OrderGridStopOrderValuesArray); orderGridStopOrderValueId++) {
         if(t3OrderGridStopOrderValuesArray[orderGridStopOrderValueId] != EMPTY_VALUE
               && Bid() < t3OrderGridStopOrderValuesArray[orderGridStopOrderValueId]) {
            signal = true;
            t3OrderGridStopOrderValuesArray[orderGridStopOrderValueId] = EMPTY_VALUE;
         }
      }
   }

   return signal;
}

bool getT3BidLowerShortReEntryAreaFilter() {

   bool filter = false;

   if(Bid() < t3ReEntryAreaMinEndValue) {
      filter = true;
      t3ShortIsTradable = false;
   }

   return filter;
}

//+------------------------------------------------------------------+
