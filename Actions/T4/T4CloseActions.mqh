//+------------------------------------------------------------------+
//|                                                 CloseAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void  closeT4Actions() {
   closeOnT4StopLossLine();
   closeOnT4TrailingStopMA();
   closeOnT4MarketTrailingStop();
}

void closeOnT4StopLossLine() {

   int      chartId = 0;
   long     positionTicket = 0;

   if(t4StopLossLineLevel != 0) {
      for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
         positionTicket = positionTickets[positionTicketsId];
         if(
            PositionSymbol(positionTicket) == Symbol()
            && PositionMagicNumber(positionTicket) == InpT4MagicNumber
         ) {
            if(t4trendDirection == TREND_DIRECTION_LONG && PositionType(positionTicket) == ORDER_TYPE_BUY && Bid() < t4StopLossLineLevel) {
               Trade.Close(positionTicket, PositionVolume(positionTicket), T4_STOP_LOSS_TLINE);
            }
            if(t4trendDirection == TREND_DIRECTION_SHORT && PositionType(positionTicket) == ORDER_TYPE_SELL && Bid() > t4StopLossLineLevel) {
               Trade.Close(positionTicket, PositionVolume(positionTicket), T4_STOP_LOSS_TLINE);
            }
         }
      }
   }
}

void closeOnT4TrailingStopMA() {

   long     positionTicket = 0;

   if(InpT4trailingStopMATimeframe == Period() && t4ProfitLevelGreaterMinProfitFiboRetracmentLevel == true && t4TrailingStopMABuffer[0] != 0) {
      for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
         positionTicket = positionTickets[positionTicketsId];
         if(
            PositionSymbol(positionTicket) == Symbol()
            && PositionMagicNumber(positionTicket) == InpT4MagicNumber
         ) {
            if(t4trendDirection == TREND_DIRECTION_LONG && PositionType(positionTicket) == ORDER_TYPE_BUY && Bid() < t4TrailingStopMABuffer[0]) {
               Trade.Close(positionTicket, PositionVolume(positionTicket), "Close on t4TrailingStopMA");
            }
            if(t4trendDirection == TREND_DIRECTION_SHORT && PositionType(positionTicket) == ORDER_TYPE_SELL && Bid() > t4TrailingStopMABuffer[0]) {
               Trade.Close(positionTicket, PositionVolume(positionTicket), "Close on t4TrailingStopMA");
            }
         }
      }
   }
}
//+------------------------------------------------------------------+
void closeOnT4MarketTrailingStop() {

   double trailingStop = InpT4StopLoss * InpT4MarketTrailingStopMulti;
   long positionTicket = 0;

   if(t4ProfitLevelGreaterMinProfitFiboRetracmentLevel == true) {
       for(int positionTicketId = 0; positionTicketId < ArraySize(positionTickets); positionTicketId++) {
          positionTicket = positionTickets[positionTicketId];
         if(
            PositionSymbol(positionTicket) == Symbol()
            && PositionMagicNumber(positionTicket) == InpT4MagicNumber
         ) {
            if(t4trendDirection == TREND_DIRECTION_LONG && PositionType(positionTicket) == ORDER_TYPE_BUY) {
               Trail.TrailingStop(positionTicket, (int)trailingStop);
            }
            if(t4trendDirection == TREND_DIRECTION_SHORT && PositionType(positionTicket) == ORDER_TYPE_SELL) {
               Trail.TrailingStop(positionTicket, (int)trailingStop);
            }
         }
       }
   }
}