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
//    bool sellPosIsOpen = false;
//    int barShift = 0;
//    int lastBarShift = 1;
//    double maxStopLossLevel = 0;
//
//    deleteTrendLineObject(T3_TRAILING_STOP_TLINE);
//
//    if(getOpenSellPositionsFilter() == true) {
//        maxStopLossLevel = iLow(Symbol(), Period(), barShift) + (InpT3StopLoss * Point());
//        t3TrailingStopLevel = MathMin(iHigh(Symbol(), Period(), lastBarShift), maxStopLossLevel);
//        if(outSideBarDateTime != 0)  t3TrailingStopLevel = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, outSideBarDateTime)) + (InpT3StopLoss * Point() * InpInsideBarMaxStopLossMulti);
//
//        createT3TrailingStopTrendLine();
//    }
//
//    if(getOpenBuyPositionsFilter() == true) {
//        maxStopLossLevel = iHigh(Symbol(), Period(), barShift) - (InpT3StopLoss * Point());
//        t3TrailingStopLevel = MathMax(iLow(Symbol(), Period(), lastBarShift), maxStopLossLevel);
//        if(outSideBarDateTime != 0)  t3TrailingStopLevel = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, outSideBarDateTime)) - (InpT3StopLoss * Point() * InpInsideBarMaxStopLossMulti);
//
//        createT3TrailingStopTrendLine();
//    }
//
//}