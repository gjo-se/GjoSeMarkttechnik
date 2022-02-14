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
   closeOnT4RegressionChannelTrailingStop();
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
               handleScreenshotAction();
            }
            if(PositionType(positionTicket) == ORDER_TYPE_SELL && Bid() > t4RegressionChannelStopLossLineLevel) {
               Trade.Close(positionTicket, PositionVolume(positionTicket), T4_REGRESSION_CHANNEL);
               handleScreenshotAction();
            }
         }
      }
   }
}
//+------------------------------------------------------------------+
