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
void setT4PositionStates() {

   setT4BuyPositionIsOpen();
   setT4MaxBuyPositionsAreOpen();
   setT4AllBuyPositionsAreClosedState();

   setT4SellPositionIsOpen();
   setT4MaxSellPositionsAreOpen();
   setT4AllSellPositionsAreClosedState();
}

void setT4AllBuyPositionsAreClosedState() {

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

void setT4BuyPositionIsOpen() {

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

void setT4MaxBuyPositionsAreOpen() {

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

   if(openPositionCount >= InpT4OrderGridCount) {
      maxBuyPositionsAreOpenState = true;
   }
}


void setT4MaxSellPositionsAreOpen() {

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

   if(openPositionCount >= InpT4OrderGridCount) {
      maxSellPositionsAreOpenState = true;
   }
}
//+------------------------------------------------------------------+

void setT4SellPositionIsOpen() {

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

void setT4AllSellPositionsAreClosedState() {

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
