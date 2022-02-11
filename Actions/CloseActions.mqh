//+------------------------------------------------------------------+
//|                                                 CloseAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void  closeActions() {
   closeOnT3StopLossLine();
//   closeOnTrailingStop();

}

void closeOnT3StopLossLine() {

   int      chartId = 0;
   string   objName = T3_STOP_LOSS_TLINE;
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
               ObjectSetString(chartId, objName, OBJPROP_TEXT, T3_STOP_LOSS_TLINE + "-triggert");
               ObjectSetInteger(chartId, objName, OBJPROP_WIDTH, 1);
               ObjectSetInteger(chartId, objName, OBJPROP_STYLE, STYLE_DASH);
               handleScreenshotAction();
            }
            if(PositionType(positionTicket) == ORDER_TYPE_SELL && Bid() > t3StopLossLineLevel) {
               Trade.Close(positionTicket, PositionVolume(positionTicket), T3_STOP_LOSS_TLINE);
               ObjectSetString(chartId, objName, OBJPROP_TEXT, T3_STOP_LOSS_TLINE + "-triggert");
               ObjectSetInteger(chartId, objName, OBJPROP_WIDTH, 1);
               ObjectSetInteger(chartId, objName, OBJPROP_STYLE, STYLE_DASH);
               handleScreenshotAction();
            }
         }
      }
   }
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
