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
   setAllBuyPositionsAreClosedState();
   setAllSellPositionsAreClosedState();
}

void setAllBuyPositionsAreClosedState() {

   long positionTicket = 0;

   if(buyPositionIsOpenState == true) {
      buyPositionIsOpenState = false;
      for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
         positionTicket = positionTickets[positionTicketsId];
         if(
            positionTicket > 0
            && PositionSymbol(positionTicket) == Symbol()
            && PositionMagicNumber(positionTicket) == InpMagicNumber
         ) {
            buyPositionIsOpenState = true;
         }
      }

      if(buyPositionIsOpenState == false) {
         allBuyPositionsAreClosedState = true;
      } else {
         allBuyPositionsAreClosedState = false;
      }
   }
}
//+------------------------------------------------------------------+

void setAllSellPositionsAreClosedState() {

   long positionTicket = 0;

   if(sellPositionIsOpenState == true) {
      sellPositionIsOpenState = false;
      for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
         positionTicket = positionTickets[positionTicketsId];
         if(
            positionTicket > 0
            && PositionSymbol(positionTicket) == Symbol()
            && PositionMagicNumber(positionTicket) == InpMagicNumber
         ) {
            sellPositionIsOpenState = true;
         }
      }

      if(sellPositionIsOpenState == false) {
         allSellPositionsAreClosedState = true;
      } else {
         allSellPositionsAreClosedState = false;
      }
   }
}
//+------------------------------------------------------------------+
