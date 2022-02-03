//+------------------------------------------------------------------+
//|                                             BreakevenAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

void setBreakevenAction() {

   long positionTicket = 0;

   int positionTicketId = 0;
   for(positionTicketId; positionTicketId < ArraySize(positionTickets); positionTicketId++) {
      positionTicket = positionTickets[positionTicketId];
      Trail.BreakEven(positionTicket, InpBreakEvenProfit, InpLockProfit);
   }

}
//+------------------------------------------------------------------+

//void setTrailingStopAction() {
//
//   long positionTicket = 0;
//
//   int positionTicketId = 0;
//   for(positionTicketId; positionTicketId < ArraySize(positionTickets); positionTicketId++) {
//      positionTicket = positionTickets[positionTicketId];
//      Trail.TrailingStop(positionTicket, InpTrailingStop, InpMinimumProfit, InpStep);
//   }
//
//}