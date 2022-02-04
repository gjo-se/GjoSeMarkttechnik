/*

   BuyInStates
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

   Beschreibung
   ===============

*/

bool getBuyInSignal() {

   bool signal = false;

   if(t3trendDirection != TREND_DIRECTION_LONG) return false;
   if(getBidInInSignalAreaState() == false) return false;
   if(getOpenBuyPositionsFilter() == true) return false;

   setLowestLowDateTime();

   if(getBidGreaterLongReEntryAreaFilter() == true) return false;
   if(t3LongIsTradable == false) return false;

   if(getBidGreaterLongEntryLevelSignal() == true) signal = true;


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
      }

   }

   if(t3LlDateTime != 0) startCandleShift = iBarShift(Symbol(), Period(), t3LlDateTime);

   if(startCandleShift != 0) {
      t3LowestLowDateTime = iTime(Symbol(), PERIOD_CURRENT, iLowest(Symbol(), PERIOD_CURRENT, MODE_LOW, startCandleShift, 0));
   } else {
      t3LowestLowDateTime = iTime(Symbol(), PERIOD_CURRENT, 0);
   }
}

bool getOpenBuyPositionsFilter() {

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
      }
   }

   return (filter);
}

bool getBidGreaterLongEntryLevelSignal() {

   bool signal = false;

   if(Bid() < t3LongEntryValue) t3LongIsTradable = true;

   if(t3LongIsTradable == true && Bid() > t3LongEntryValue) {
      signal = true;
      t3LongIsTradable = false;
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

bool spreadGreaterThanMaxSpreadBuyInFilter() {

   bool filter = true;

//   if(Spread() <= InpMaxSpread) Print("Spread: " + Spread());

   if(Spread() < InpMaxSpread) {
      filter = false;
   }

   return(filter);

}

//+------------------------------------------------------------------+
