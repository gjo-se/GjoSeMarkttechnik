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

   setT4PositionsCountState();
   setT4BuyPositionIsOpen();
   setT4MaxBuyPositionsAreOpen();
   setT4AllBuyPositionsAreClosedState();

   setT4SellPositionIsOpen();
   setT4MaxSellPositionsAreOpen();
   setT4AllSellPositionsAreClosedState();
}

void setT4PositionsCountStateInit() {

   buyPositionsCount = 0;
   sellPositionsCount = 0;

   long  positionTicket = 0;
   ulong magicNumber = 0;

   long positionTicketsLocal[];
   Positions.GetTickets(magicNumber, positionTicketsLocal);
   for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTicketsLocal); positionTicketsId++) {
      positionTicket = positionTicketsLocal[positionTicketsId];
      if(
         positionTicket > 0
         && PositionSymbol(positionTicket) == Symbol()
      ) {
         if(PositionType(positionTicket) == ORDER_TYPE_BUY) buyPositionsCount++;
         if(PositionType(positionTicket) == ORDER_TYPE_SELL) sellPositionsCount++;
      }
   }
}

void setT4PositionsCountState() {

   long  positionTicket = 0;
   int   buyPositionsCountLocal = 0;
   int   sellPositionsCountLocal = 0;
   ulong magicNumber = 0;

   long positionTicketsLocal[];
   Positions.GetTickets(magicNumber, positionTicketsLocal);
   for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTicketsLocal); positionTicketsId++) {
      positionTicket = positionTicketsLocal[positionTicketsId];
      if(
         positionTicket > 0
         && PositionSymbol(positionTicket) == Symbol()
      ) {
         if(PositionType(positionTicket) == ORDER_TYPE_BUY) buyPositionsCountLocal++;
         if(PositionType(positionTicket) == ORDER_TYPE_SELL) sellPositionsCountLocal++;
      }
   }

   if(buyPositionsCountLocal > buyPositionsCount) {
      buyPositionsCount = buyPositionsCountLocal;
      string alertText = "BUY Position opened";
      t4AlertPositionCountAction(alertText);
   }
   if(buyPositionsCountLocal < buyPositionsCount) {
      buyPositionsCount = buyPositionsCountLocal;
      string alertText = "BUY Position closed";
      t4AlertPositionCountAction(alertText);
   }
   if(sellPositionsCountLocal > sellPositionsCount) {
      sellPositionsCount = sellPositionsCountLocal;
      string alertText = "SELL Position opened";
      t4AlertPositionCountAction(alertText);
   }
   if(sellPositionsCountLocal < sellPositionsCount) {
      sellPositionsCount = sellPositionsCountLocal;
      string alertText = "SELL Position closed";
      t4AlertPositionCountAction(alertText);
   }
}

void setT4AllBuyPositionsAreClosedState() {

   long positionTicket = 0;
   bool minOneBuyPositionIsOpen = false;
   ulong magicNumber = 0;

   if(buyT4PositionIsOpenState == true) {
      long positionTicketsLocal[];
      Positions.GetTickets(magicNumber, positionTicketsLocal);
      for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTicketsLocal); positionTicketsId++) {
         positionTicket = positionTicketsLocal[positionTicketsId];
         if(
            positionTicket > 0
            && PositionSymbol(positionTicket) == Symbol()
            && PositionType(positionTicket) == ORDER_TYPE_BUY
         ) {
            minOneBuyPositionIsOpen = true;
         }
      }

      if(minOneBuyPositionIsOpen == false) {
         allT4BuyPositionsAreClosedState = true;
      } else {
         allT4BuyPositionsAreClosedState = false;
      }
   }
}

void setT4BuyPositionIsOpen() {

   long positionTicket = 0;
   ulong magicNumber = 0;

   if(t4trendDirection == TREND_DIRECTION_LONG && buyT4PositionIsOpenState == false) {
      long positionTicketsLocal[];
      Positions.GetTickets(magicNumber, positionTicketsLocal);
      for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTicketsLocal); positionTicketsId++) {
         positionTicket = positionTicketsLocal[positionTicketsId];
         if(
            positionTicket > 0
            && PositionSymbol(positionTicket) == Symbol()
            && PositionType(positionTicket) == ORDER_TYPE_BUY
         ) {
            buyT4PositionIsOpenState = true;
         }
      }
   }
}
//+------------------------------------------------------------------+

void setT4MaxBuyPositionsAreOpen() {

   long     positionTicket = 0;
   int      openPositionCount = 0;
   ulong magicNumber = 0;

   if(t4trendDirection == TREND_DIRECTION_LONG) {
      long positionTicketsLocal[];
      Positions.GetTickets(magicNumber, positionTicketsLocal);
      for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTicketsLocal); positionTicketsId++) {
         positionTicket = positionTicketsLocal[positionTicketsId];
         if(
            positionTicket > 0
            && PositionSymbol(positionTicket) == Symbol()
            && PositionType(positionTicket) == ORDER_TYPE_BUY
         ) {
            openPositionCount++;
         }
      }
   }


   if(openPositionCount >= InpT4OrderGridCount) {
      maxT4BuyPositionsAreOpenState = true;
   }
}


void setT4MaxSellPositionsAreOpen() {

   long     positionTicket = 0;
   int      openPositionCount = 0;
   ulong magicNumber = 0;

   if(t4trendDirection == TREND_DIRECTION_SHORT) {
      long positionTicketsLocal[];
      Positions.GetTickets(magicNumber, positionTicketsLocal);
      for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTicketsLocal); positionTicketsId++) {
         positionTicket = positionTicketsLocal[positionTicketsId];
         if(
            positionTicket > 0
            && PositionSymbol(positionTicket) == Symbol()
            && PositionType(positionTicket) == ORDER_TYPE_SELL
         ) {
            openPositionCount++;
         }
      }

   }

   if(openPositionCount >= InpT4OrderGridCount) {
      maxT4SellPositionsAreOpenState = true;
   }
}
//+------------------------------------------------------------------+

void setT4SellPositionIsOpen() {

   long positionTicket = 0;
   ulong magicNumber = 0;

   if(t4trendDirection == TREND_DIRECTION_SHORT && sellT4PositionIsOpenState == false) {
      long positionTicketsLocal[];
      Positions.GetTickets(magicNumber, positionTicketsLocal);
      for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTicketsLocal); positionTicketsId++) {
         positionTicket = positionTicketsLocal[positionTicketsId];
         if(
            positionTicket > 0
            && PositionSymbol(positionTicket) == Symbol()
            && PositionType(positionTicket) == ORDER_TYPE_SELL
         ) {
            sellT4PositionIsOpenState = true;
         }
      }
   }
}

void setT4AllSellPositionsAreClosedState() {

   long positionTicket = 0;
   bool minOneSellPositionIsOpen = false;
   ulong magicNumber = 0;

   if(sellT4PositionIsOpenState == true) {
      long positionTicketsLocal[];
      Positions.GetTickets(magicNumber, positionTicketsLocal);
      for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTicketsLocal); positionTicketsId++) {
         positionTicket = positionTicketsLocal[positionTicketsId];
         if(
            positionTicket > 0
            && PositionSymbol(positionTicket) == Symbol()
            && PositionType(positionTicket) == ORDER_TYPE_SELL
         ) {
            minOneSellPositionIsOpen = true;
         }
      }

      if(minOneSellPositionIsOpen == false) {
         allT4SellPositionsAreClosedState = true;
      } else {
         allT4SellPositionsAreClosedState = false;
      }
   }
}
//+------------------------------------------------------------------+
