/*

   PositionState
   Copyright 2022, Gregory Jo
   https://www.gjo-se.com

   Beschreibung
   ===============

*/

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void setT3PositionStates() {

   setT3BuyPositionIsOpen();
   setT3MaxBuyPositionsAreOpen();
   setT3AllBuyPositionsAreClosedState();

   setT3SellPositionIsOpen();
   setT3MaxSellPositionsAreOpen();
   setT3AllSellPositionsAreClosedState();
}

void setT3AllBuyPositionsAreClosedState() {

   long positionTicket = 0;
   bool minOneBuyPositionIsOpen = false;


   if(buyT3PositionIsOpenState == true) {
      for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
         positionTicket = positionTickets[positionTicketsId];
         if(
            positionTicket > 0
            && PositionSymbol(positionTicket) == Symbol()
            && PositionMagicNumber(positionTicket) == InpT3MagicNumber
            && PositionType(positionTicket) == ORDER_TYPE_BUY
         ) {
            minOneBuyPositionIsOpen = true;
         }
      }

      if(minOneBuyPositionIsOpen == false) {
         allT3BuyPositionsAreClosedState = true;
      } else {
         allT3BuyPositionsAreClosedState = false;
      }
   }
}

void setT3BuyPositionIsOpen() {

   long positionTicket = 0;

   if(t3trendDirection == TREND_DIRECTION_LONG && buyT3PositionIsOpenState == false) {
      for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
         positionTicket = positionTickets[positionTicketsId];
         if(
            positionTicket > 0
            && PositionSymbol(positionTicket) == Symbol()
            && PositionMagicNumber(positionTicket) == InpT3MagicNumber
            && PositionType(positionTicket) == ORDER_TYPE_BUY
         ) {
            buyT3PositionIsOpenState = true;
         }
      }
   }
}
//+------------------------------------------------------------------+

void setT3MaxBuyPositionsAreOpen() {

   long     positionTicket = 0;
   int      openPositionCount = 0;

   if(t3trendDirection == TREND_DIRECTION_LONG) {
      for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
         positionTicket = positionTickets[positionTicketsId];
         if(
            positionTicket > 0
            && PositionSymbol(positionTicket) == Symbol()
            && PositionMagicNumber(positionTicket) == InpT3MagicNumber
            && PositionType(positionTicket) == ORDER_TYPE_BUY
         ) {
            openPositionCount++;
         }
      }

   }

   if(openPositionCount >= InpT3OrderGridCount) {
      maxT3BuyPositionsAreOpenState = true;
   }
}


void setT3MaxSellPositionsAreOpen() {

   long     positionTicket = 0;
   int      openPositionCount = 0;

   if(t3trendDirection == TREND_DIRECTION_SHORT) {
      for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
         positionTicket = positionTickets[positionTicketsId];
         if(
            positionTicket > 0
            && PositionSymbol(positionTicket) == Symbol()
            && PositionMagicNumber(positionTicket) == InpT3MagicNumber
            && PositionType(positionTicket) == ORDER_TYPE_SELL
         ) {
            openPositionCount++;
         }
      }

   }

   if(openPositionCount >= InpT3OrderGridCount) {
      maxT3SellPositionsAreOpenState = true;
   }
}
//+------------------------------------------------------------------+

void setT3SellPositionIsOpen() {

   long positionTicket = 0;

   if(t3trendDirection == TREND_DIRECTION_SHORT && sellT3PositionIsOpenState == false) {
      for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
         positionTicket = positionTickets[positionTicketsId];
         if(
            positionTicket > 0
            && PositionSymbol(positionTicket) == Symbol()
            && PositionMagicNumber(positionTicket) == InpT3MagicNumber
            && PositionType(positionTicket) == ORDER_TYPE_SELL
         ) {
            sellT3PositionIsOpenState = true;
         }
      }
   }
}

void setT3AllSellPositionsAreClosedState() {

   long positionTicket = 0;
   bool minOneSellPositionIsOpen = false;

   if(sellT3PositionIsOpenState == true) {
      for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
         positionTicket = positionTickets[positionTicketsId];
         if(
            positionTicket > 0
            && PositionSymbol(positionTicket) == Symbol()
            && PositionMagicNumber(positionTicket) == InpT3MagicNumber
            && PositionType(positionTicket) == ORDER_TYPE_SELL
         ) {
            minOneSellPositionIsOpen = true;
         }
      }

      if(minOneSellPositionIsOpen == false) {
         allT3SellPositionsAreClosedState = true;
      } else {
         allT3SellPositionsAreClosedState = false;
      }
   }
}
//+------------------------------------------------------------------+
