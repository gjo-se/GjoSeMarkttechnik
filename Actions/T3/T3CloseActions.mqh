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
   closeOnT3TrailingStopMA();
   if(InpT3UseTrailingStopMarket == true) closeOnT3TrailingStopMarket();
}

void closeOnT3StopLossLine() {

   int      chartId = 0;
   long     positionTicket = 0;

   if(t3StopLossLineLevel != 0) {
      long positionTicketsLocal[];
      Positions.GetTickets(InpT3MagicNumber, positionTicketsLocal);
      for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTicketsLocal); positionTicketsId++) {
         positionTicket = positionTicketsLocal[positionTicketsId];
         if(
            PositionSymbol(positionTicket) == Symbol()
            && PositionMagicNumber(positionTicket) == InpT3MagicNumber
         ) {
            if(t3trendDirection == TREND_DIRECTION_LONG && PositionType(positionTicket) == ORDER_TYPE_BUY && Bid() < t3StopLossLineLevel) {
               Trade.Close(positionTicket, PositionVolume(positionTicket), T3_STOP_LOSS_TLINE);
            }
            if(t3trendDirection == TREND_DIRECTION_SHORT && PositionType(positionTicket) == ORDER_TYPE_SELL && Bid() > t3StopLossLineLevel) {
               Trade.Close(positionTicket, PositionVolume(positionTicket), T3_STOP_LOSS_TLINE);
            }
         }
      }
   }
}
//+------------------------------------------------------------------+

void closeOnT3TrailingStopMA() {

   long     positionTicket = 0;

   if(InpT3trailingStopMATimeframe == Period() && t3ProfitLevelGreaterMinProfitFiboRetracmentLevel == true && t3TrailingStopMALevel != 0) {
      long positionTicketsLocal[];
      Positions.GetTickets(InpT3MagicNumber, positionTicketsLocal);
      for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTicketsLocal); positionTicketsId++) {
         positionTicket = positionTicketsLocal[positionTicketsId];
         if(
            PositionSymbol(positionTicket) == Symbol()
            && PositionMagicNumber(positionTicket) == InpT3MagicNumber
         ) {
            if(t3trendDirection == TREND_DIRECTION_LONG && PositionType(positionTicket) == ORDER_TYPE_BUY && Bid() < t3TrailingStopMALevel) {
               Trade.Close(positionTicket, PositionVolume(positionTicket), "Close on " + IntegerToString(t4TrailingStopMAActive) + " t4TrailingStopMA");
            }
            if(t3trendDirection == TREND_DIRECTION_SHORT && PositionType(positionTicket) == ORDER_TYPE_SELL && Bid() > t3TrailingStopMALevel) {
               Trade.Close(positionTicket, PositionVolume(positionTicket), "Close on " + IntegerToString(t4TrailingStopMAActive) + " t4TrailingStopMA");
            }
         }
      }
   }
}

void closeOnT3TrailingStopMarket() {

   long positionTicket = 0;

   if(t3ProfitLevelGreaterMinProfitFiboRetracmentLevel == true && InpT3TrailingStopOffset != 0) {
      long positionTicketsLocal[];
      Positions.GetTickets(InpT4MagicNumber, positionTicketsLocal);
      for(int positionTicketId = 0; positionTicketId < ArraySize(positionTicketsLocal); positionTicketId++) {
         positionTicket = positionTicketsLocal[positionTicketId];
         if(
            PositionSymbol(positionTicket) == Symbol()
            && PositionMagicNumber(positionTicket) == InpT3MagicNumber
         ) {
            if(t3trendDirection == TREND_DIRECTION_LONG && PositionType(positionTicket) == ORDER_TYPE_BUY) {
               Trail.TrailingStop(positionTicket, InpT3TrailingStopOffset);
            }
            if(t3trendDirection == TREND_DIRECTION_SHORT && PositionType(positionTicket) == ORDER_TYPE_SELL) {
               Trail.TrailingStop(positionTicket, InpT3TrailingStopOffset);
            }
         }
      }
   }
}
//+------------------------------------------------------------------+
