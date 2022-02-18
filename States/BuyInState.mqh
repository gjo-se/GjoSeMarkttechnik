/*

   BuyInStates
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

   Beschreibung
   ===============

*/

bool getBuyInSignal() {

   bool signal = false;

   if(getBidGreaterLongEntryLevelSignal() == true) signal = true;
   if(getBidInInSignalAreaState() == false) signal = false;

   if(getBidTriggerLongGridLimitOrderSignal() == true) signal = true;
   if(getBidTriggerLongGridStopOrderSignal() == true) signal = true;

   if(!TerminalInfoInteger(TERMINAL_TRADE_ALLOWED) || !MQLInfoInteger(MQL_TRADE_ALLOWED)) signal = false;
   if(t3trendDirection != TREND_DIRECTION_LONG) signal = false;
   if(isTradabelButtonState == false) signal = false;
   if(getOpenLongPositionCountFilter() == true) signal = false;


//   if(getBidGreaterLongReEntryAreaFilter() == true) return false;
//   if(t3LongIsTradable == false) return false;
//   if(spreadGreaterThanMaxSpreadBuyInFilter() == true) signal = false;

   return(signal);

}

bool getBidGreaterLongEntryLevelSignal() {

   bool signal = false;

   if(Bid() < t3LongEntryValue) t3LongIsTradable = true;

   if(t3LongEntryIsTriggert == false && t3LongIsTradable == true && Bid() >= t3LongEntryValue) {
      signal = true;
      t3LongEntryIsTriggert = true;
      t3LongIsTradable = false;
   }

   return signal;
}

bool getBidTriggerLongGridLimitOrderSignal() {

   bool signal = false;

   if(t3LongEntryIsTriggert) {
      for(int orderGridLimitOrderValueId = 0; orderGridLimitOrderValueId < ArraySize(orderGridLimitOrderValuesArray); orderGridLimitOrderValueId++) {
         if(orderGridLimitOrderValuesArray[orderGridLimitOrderValueId] != EMPTY_VALUE
               && Bid() < orderGridLimitOrderValuesArray[orderGridLimitOrderValueId]) {
            signal = true;
            orderGridLimitOrderValuesArray[orderGridLimitOrderValueId] = EMPTY_VALUE;
         }
      }
   }

   return signal;
}

bool getBidTriggerLongGridStopOrderSignal() {

   bool signal = false;

   if(t3LongEntryIsTriggert) {
      for(int orderGridStopOrderValueId = 0; orderGridStopOrderValueId < ArraySize(orderGridStopOrderValuesArray); orderGridStopOrderValueId++) {
         if(orderGridStopOrderValuesArray[orderGridStopOrderValueId] != EMPTY_VALUE
               && Bid() > orderGridStopOrderValuesArray[orderGridStopOrderValueId]) {
            signal = true;
            orderGridStopOrderValuesArray[orderGridStopOrderValueId] = EMPTY_VALUE;
         }
      }
   }

   return signal;
}

bool getBidGreaterLongReEntryAreaFilter() {

   bool filter = false;

   if(Bid() > reEntryAreaMaxEndValue) {
      filter = true;
      t3LongIsTradable = false;
   }

   return filter;
}

bool getOpenLongPositionCountFilter() {

   bool filter = false;
   long     positionTicket = 0;
   int      openPositionCount = 0;

   for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
      positionTicket = positionTickets[positionTicketsId];
      if(
         positionTicket > 0
         && PositionSymbol(positionTicket) == Symbol()
         && PositionMagicNumber(positionTicket) == InpMagicNumber
         && PositionType(positionTicket) == ORDER_TYPE_BUY
      ) {
         openPositionCount++;
      }
   }

   if(openPositionCount >= InpOrderGridCount) {
      filter = true;
      ArrayResize(orderGridStopOrderValuesArray, 0);
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
