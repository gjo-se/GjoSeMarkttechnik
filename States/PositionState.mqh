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
void setPositionStates() {

   setBuyPositionIsOpen();
   setMaxBuyPositionsAreOpen();
   setAllBuyPositionsAreClosedState();

   setSellPositionIsOpen();
   setMaxSellPositionsAreOpen();
   setAllSellPositionsAreClosedState();
}

void setAllBuyPositionsAreClosedState() {

   long positionTicket = 0;
   bool minOneBuyPositionIsOpen = false;


   if(buyPositionIsOpenState == true) {
      for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
         positionTicket = positionTickets[positionTicketsId];
         if(
            positionTicket > 0
            && PositionSymbol(positionTicket) == Symbol()
            && PositionMagicNumber(positionTicket) == InpMagicNumber
            && PositionType(positionTicket) == ORDER_TYPE_BUY
         ) {
            minOneBuyPositionIsOpen = true;
         }
      }

      if(minOneBuyPositionIsOpen == false) {
         allBuyPositionsAreClosedState = true;
      } else {
         allBuyPositionsAreClosedState = false;
      }
   }
}

void setBuyPositionIsOpen() {

   long positionTicket = 0;

   if(buyPositionIsOpenState == false) {
       for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
          positionTicket = positionTickets[positionTicketsId];
          if(
             positionTicket > 0
             && PositionSymbol(positionTicket) == Symbol()
             && PositionMagicNumber(positionTicket) == InpMagicNumber
             && PositionType(positionTicket) == ORDER_TYPE_BUY
          ) {
             buyPositionIsOpenState = true;
          }
       }
   }
}
//+------------------------------------------------------------------+

void setMaxBuyPositionsAreOpen() {

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
      maxBuyPositionsAreOpenState = true;
   }
}


void setMaxSellPositionsAreOpen() {

   long     positionTicket = 0;
   int      openPositionCount = 0;

   for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
      positionTicket = positionTickets[positionTicketsId];
      if(
         positionTicket > 0
         && PositionSymbol(positionTicket) == Symbol()
         && PositionMagicNumber(positionTicket) == InpMagicNumber
         && PositionType(positionTicket) == ORDER_TYPE_SELL
      ) {
         openPositionCount++;
      }
   }

   if(openPositionCount >= InpOrderGridCount) {
      maxSellPositionsAreOpenState = true;
   }
}
//+------------------------------------------------------------------+

void setSellPositionIsOpen() {

   long positionTicket = 0;

   if(sellPositionIsOpenState == false) {
       for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
          positionTicket = positionTickets[positionTicketsId];
          if(
             positionTicket > 0
             && PositionSymbol(positionTicket) == Symbol()
             && PositionMagicNumber(positionTicket) == InpMagicNumber
             && PositionType(positionTicket) == ORDER_TYPE_SELL
          ) {
             sellPositionIsOpenState = true;
          }
       }
   }
}

void setAllSellPositionsAreClosedState() {

   long positionTicket = 0;
   bool minOneSellPositionIsOpen = false;

   if(sellPositionIsOpenState == true) {
      for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
         positionTicket = positionTickets[positionTicketsId];
         if(
            positionTicket > 0
            && PositionSymbol(positionTicket) == Symbol()
            && PositionMagicNumber(positionTicket) == InpMagicNumber
            && PositionType(positionTicket) == ORDER_TYPE_SELL
         ) {
            minOneSellPositionIsOpen = true;
         }
      }

      if(minOneSellPositionIsOpen == false) {
         allSellPositionsAreClosedState = true;
      } else {
         allSellPositionsAreClosedState = false;
      }
   }
}
//+------------------------------------------------------------------+