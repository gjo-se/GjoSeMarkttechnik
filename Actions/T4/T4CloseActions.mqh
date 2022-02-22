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
   closeOnT4RegressionChannelTrailingStop();
}

void closeOnT4StopLossLine() {

   int      chartId = 0;
   long     positionTicket = 0;

   if(t4StopLossLineLevel != 0) {
      for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
         positionTicket = positionTickets[positionTicketsId];
         if(
            PositionSymbol(positionTicket) == Symbol()
            && PositionMagicNumber(positionTicket) == InpMagicNumber
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

void closeOnT4RegressionChannelTrailingStop() {

   long     positionTicket = 0;
   long     triggerTicket = 0;
   int      barShift = 0;
   t4RegressionChannelStopLossLineLevel = ObjectGetValueByTime(ChartID(), T4_TRAILING_STOP_LINE, iTime(Symbol(), Period(), 0));

   if(t4OKDateTime != 0 && t4RegressionChannelStopLossLineLevel != 0) {
      for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
         positionTicket = positionTickets[positionTicketsId];
         if(
            PositionSymbol(positionTicket) == Symbol()
            && PositionMagicNumber(positionTicket) == InpMagicNumber
         ) {
            if(PositionType(positionTicket) == ORDER_TYPE_BUY && Bid() < t4RegressionChannelStopLossLineLevel) {
               Trade.Close(positionTicket, PositionVolume(positionTicket), T4_REGRESSION_CHANNEL);
            }
            if(PositionType(positionTicket) == ORDER_TYPE_SELL && Bid() > t4RegressionChannelStopLossLineLevel) {
               Trade.Close(positionTicket, PositionVolume(positionTicket), T4_REGRESSION_CHANNEL);
            }
         }
      }
   }
}
//+------------------------------------------------------------------+
