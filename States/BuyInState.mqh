/*

   BuyInStates
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

   Beschreibung
   ===============

*/

bool getBuyInSignal() {

   bool signal = false;

   setLowestLowDateTime();
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

void setLowestLowDateTime() {

   int      startCandleShift = iBarShift(Symbol(), Period(), t3p4DateTime);

   long     positionTicket = 0;
   if(buyPositionIsOpen == true) {
      buyPositionIsOpen = false;
      for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
         positionTicket = positionTickets[positionTicketsId];
         if(
            positionTicket > 0
            && PositionSymbol(positionTicket) == Symbol()
            && PositionMagicNumber(positionTicket) == InpMagicNumber
         ) {
            buyPositionIsOpen = true;
         }
      }

      if(buyPositionIsOpen == false) {
         createT3LowestLowVLine();
         handleScreenshotAction();
      }
   }

   if(t3LowestLowVLineDateTime != 0) startCandleShift = iBarShift(Symbol(), Period(), t3LowestLowVLineDateTime);

   if(startCandleShift != 0) {
      t3LowestLowDateTime = iTime(Symbol(), PERIOD_CURRENT, iLowest(Symbol(), PERIOD_CURRENT, MODE_LOW, startCandleShift, 0));
   } else {
      t3LowestLowDateTime = iTime(Symbol(), PERIOD_CURRENT, 0);
   }
}

bool getT3LongEntryIsTriggertFilter() {

   bool filter = false;
   long positionTicket = 0;

   int positionTicketsId = 0;
   for(positionTicketsId; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
      positionTicket = positionTickets[positionTicketsId];
      if(
         positionTicket > 0
         && PositionSymbol(positionTicket) == Symbol()
         && PositionMagicNumber(positionTicket) == InpMagicNumber
         && PositionType(positionTicket) == ORDER_TYPE_BUY
      ) {
         filter = true;
         t3LongEntryIsTriggert = true;
      }
   }

   if(filter == false) t3LongEntryIsTriggert = false;

   return (filter);
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
