//+------------------------------------------------------------------+
//|                                                 CloseAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void  closeActions() {
   closeOnTrailingStop();
}

void closeOnTrailingStop() {

   long     positionTicket = 0;
   long     triggerTicket = 0;
   int      barShift = 0;

   for(int positionTicketId = 0; positionTicketId < ArraySize(positionTickets); positionTicketId++) {
      positionTicket = positionTickets[positionTicketId];
      if(positionTicket > 0) {

         if(
            PositionSymbol(positionTicket) == Symbol()
            && PositionMagicNumber(positionTicket) == InpMagicNumber
            && PositionType(positionTicket) == ORDER_TYPE_BUY
            && Bid() < t3TrailingStopLevel
         ) {
            Trade.Close(positionTicket, PositionVolume(positionTicket), __FUNCTION__);
         }

         if(
            PositionSymbol(positionTicket) == Symbol()
            && PositionMagicNumber(positionTicket) == InpMagicNumber
            && PositionType(positionTicket) == ORDER_TYPE_SELL
            && Bid() > t3TrailingStopLevel
         ) {
            Trade.Close(positionTicket, PositionVolume(positionTicket), __FUNCTION__);
         }
      }
   }
}
//+------------------------------------------------------------------+
