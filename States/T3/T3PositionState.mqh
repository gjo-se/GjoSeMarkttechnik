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

void setT3BuyPositionIsOpen() {

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

void setT3MaxBuyPositionsAreOpen() {

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

   if(openPositionCount >= InpT3OrderGridCount) {
      maxBuyPositionsAreOpenState = true;
   }
}


void setT3MaxSellPositionsAreOpen() {

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

   if(openPositionCount >= InpT3OrderGridCount) {
      maxSellPositionsAreOpenState = true;
   }
}
//+------------------------------------------------------------------+

void setT3SellPositionIsOpen() {

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

void setT3AllSellPositionsAreClosedState() {

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
