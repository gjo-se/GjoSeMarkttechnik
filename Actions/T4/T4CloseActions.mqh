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
   if(InpT4UseTrailingStopMarket == true) closeOnT4TrailingStopMarket();
}

void closeOnT4StopLossLine() {

   int      chartId = 0;
   long     positionTicket = 0;

   if(t4StopLossLineLevel != 0) {
      long positionTicketsLocal[];
      Positions.GetTickets(InpT4MagicNumber, positionTicketsLocal);
      for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTicketsLocal); positionTicketsId++) {
         positionTicket = positionTicketsLocal[positionTicketsId];
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

   if(InpT4trailingStopMATimeframe == Period() && t4ProfitLevelGreaterMinProfitFiboRetracmentLevel == true && t4TrailingStopMALevel != 0) {
      long positionTicketsLocal[];
      Positions.GetTickets(InpT4MagicNumber, positionTicketsLocal);
      for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTicketsLocal); positionTicketsId++) {
         positionTicket = positionTicketsLocal[positionTicketsId];
         if(
            PositionSymbol(positionTicket) == Symbol()
            && PositionMagicNumber(positionTicket) == InpT4MagicNumber
         ) {
            if(t4trendDirection == TREND_DIRECTION_LONG && PositionType(positionTicket) == ORDER_TYPE_BUY && Bid() < t4TrailingStopMALevel) {
               Trade.Close(positionTicket, PositionVolume(positionTicket), "Close on " + IntegerToString(t4TrailingStopMAActive) + " t4TrailingStopMA");
            }
            if(t4trendDirection == TREND_DIRECTION_SHORT && PositionType(positionTicket) == ORDER_TYPE_SELL && Bid() > t4TrailingStopMALevel) {
               Trade.Close(positionTicket, PositionVolume(positionTicket), "Close on " + IntegerToString(t4TrailingStopMAActive) + " t4TrailingStopMA");
            }
         }
      }
   }
}
//+------------------------------------------------------------------+
void closeOnT4TrailingStopMarket() {

   long positionTicket = 0;

   if(t4ProfitLevelGreaterMinProfitFiboRetracmentLevel == true) {
      long positionTicketsLocal[];
      Positions.GetTickets(InpT4MagicNumber, positionTicketsLocal);
      for(int positionTicketId = 0; positionTicketId < ArraySize(positionTicketsLocal); positionTicketId++) {
         positionTicket = positionTicketsLocal[positionTicketId];
         if(
            PositionSymbol(positionTicket) == Symbol()
            && PositionMagicNumber(positionTicket) == InpT4MagicNumber
         ) {
            if(t4trendDirection == TREND_DIRECTION_LONG && PositionType(positionTicket) == ORDER_TYPE_BUY) {
               Trail.TrailingStop(positionTicket, InpT4TrailingStopMarketMaxOffset);
            }
            if(t4trendDirection == TREND_DIRECTION_SHORT && PositionType(positionTicket) == ORDER_TYPE_SELL) {
               Trail.TrailingStop(positionTicket, InpT4TrailingStopMarketMaxOffset);
            }
         }
      }
   }
}
//+------------------------------------------------------------------+
