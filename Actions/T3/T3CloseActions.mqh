//+------------------------------------------------------------------+
//|                                                 CloseAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void  closeT3Actions() {
   closeOnT3StopLossLine();
}

void closeOnT3StopLossLine() {

   int      chartId = 0;
   long     positionTicket = 0;

   if(t3StopLossLineLevel != 0) {
      for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
         positionTicket = positionTickets[positionTicketsId];
         if(
            PositionSymbol(positionTicket) == Symbol()
            && PositionMagicNumber(positionTicket) == InpMagicNumber
         ) {
            if(PositionType(positionTicket) == ORDER_TYPE_BUY && Bid() < t3StopLossLineLevel) {
               Trade.Close(positionTicket, PositionVolume(positionTicket), T3_STOP_LOSS_TLINE);
            }
            if(PositionType(positionTicket) == ORDER_TYPE_SELL && Bid() > t3StopLossLineLevel) {
               Trade.Close(positionTicket, PositionVolume(positionTicket), T3_STOP_LOSS_TLINE);
            }
         }
      }
   }
}
//+------------------------------------------------------------------+
