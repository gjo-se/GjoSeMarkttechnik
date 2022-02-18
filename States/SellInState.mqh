/*

   SellInState
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

   Beschreibung
   ===============

*/

bool getSellInSignal() {

   bool signal = false;

   setHighestHighDateTime();
   if(getBidLowerShortEntryLevelSignal() == true) signal = true;
   if(getBidInInSignalAreaState() == false) signal = false;

   if(getBidTriggerShortGridLimitOrderSignal() == true) signal = true;
   if(getBidTriggerShortGridStopOrderSignal() == true) signal = true;

   if(!TerminalInfoInteger(TERMINAL_TRADE_ALLOWED) || !MQLInfoInteger(MQL_TRADE_ALLOWED)) signal = false;
   if(t3trendDirection != TREND_DIRECTION_SHORT) signal = false;
   if(isTradabelButtonState == false) signal = false;
   if(getOpenShortPositionCountFilter() == true) signal = false;

//   if(getBidLowerShortReEntryAreaFilter() == true) return false;
//   if(t3ShortIsTradable == false) return false;
//   if(spreadGreaterThanMaxSpreadSellInFilter() == true) signal = false;

   return(signal);

}

// für BUY & SELL Seite
// TODO: auslagern in??
bool getBidInInSignalAreaState() {

   bool state = false;

   if(inSignalAreaMinEndValue != 0 && Bid() >= inSignalAreaMinEndValue
         && inSignalAreaMaxEndValue != 0 && Bid() <= inSignalAreaMaxEndValue) {
      state = true;
   }

   if(useReEntryArea == true) {
      if(reEntryAreaMinEndValue != 0 && Bid() >= reEntryAreaMinEndValue
            && reEntryAreaMaxEndValue != 0 && Bid() <= reEntryAreaMaxEndValue) {
         state = true;
      }
   }

   return state;

}

void setHighestHighDateTime() {

   int      startCandleShift = iBarShift(Symbol(), Period(), t3p4DateTime);

   long     positionTicket = 0;
   if(sellPositionIsOpenState == true) {
      sellPositionIsOpenState = false;
      for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
         positionTicket = positionTickets[positionTicketsId];
         if(
            positionTicket > 0
            && PositionSymbol(positionTicket) == Symbol()
            && PositionMagicNumber(positionTicket) == InpMagicNumber
         ) {
            sellPositionIsOpenState = true;
         }
      }

      if(sellPositionIsOpenState == false) {
         createT3HighestHighVLine();

         // TODO: VLines ok, Regression nicht, Trendline nicht
         deleteVLineObject(T4_START_VLINE);
         deleteVLineObject(T4_OK_VLINE);
         deleteRegressionChannelObject(T4_REGRESSION_CHANNEL);
         deleteTrendLineObject(T4_REGRESSION_CHANNEL);
         deleteTrendLineObject(T4_TRAILING_STOP_LINE);

         // TODO: dadurch eigentlich nicht mehr in den einzelnen Close-Methoden?!
         handleScreenshotAction();
      }

   }

   if(t3HighestHighVLineDateTime != 0) startCandleShift = iBarShift(Symbol(), Period(), t3HighestHighVLineDateTime);

   if(startCandleShift != 0) {
      t3HighestHighDateTime = iTime(Symbol(), PERIOD_CURRENT, iHighest(Symbol(), PERIOD_CURRENT, MODE_HIGH, startCandleShift, 0));
   } else {
      t3HighestHighDateTime = iTime(Symbol(), PERIOD_CURRENT, 0);
   }
}

bool getT3ShortEntryIsTriggertFilter() {

   bool filter = false;
   long positionTicket = 0;

   int positionTicketsId = 0;
   for(positionTicketsId; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
      positionTicket = positionTickets[positionTicketsId];
      if(
         positionTicket > 0
         && PositionSymbol(positionTicket) == Symbol()
         && PositionMagicNumber(positionTicket) == InpMagicNumber
         && PositionType(positionTicket) == ORDER_TYPE_SELL
      ) {
         filter = true;
         t3ShortEntryIsTriggert = true;
      }
   }

   if(filter == false) t3ShortEntryIsTriggert = false;

   return (filter);
}

bool getBidLowerShortEntryLevelSignal() {

   bool signal = false;

   if(Bid() > t3ShortEntryValue) t3ShortIsTradable = true;

   if(t3ShortEntryIsTriggert == false && t3ShortIsTradable == true && Bid() <= t3ShortEntryValue) {
      signal = true;
      t3ShortEntryIsTriggert = true;
      t3ShortIsTradable = false;
   }

   return signal;
}

bool getBidTriggerShortGridLimitOrderSignal() {

   bool signal = false;

   if(t3ShortEntryIsTriggert) {
      for(int orderGridLimitOrderValueId = 0; orderGridLimitOrderValueId < ArraySize(orderGridLimitOrderValuesArray); orderGridLimitOrderValueId++) {
         if(orderGridLimitOrderValuesArray[orderGridLimitOrderValueId] != EMPTY_VALUE
               && Bid() > orderGridLimitOrderValuesArray[orderGridLimitOrderValueId]) {
            signal = true;
            orderGridLimitOrderValuesArray[orderGridLimitOrderValueId] = EMPTY_VALUE;
         }
      }
   }

   return signal;
}

bool getBidTriggerShortGridStopOrderSignal() {

   bool signal = false;

   if(t3ShortEntryIsTriggert) {
      for(int orderGridStopOrderValueId = 0; orderGridStopOrderValueId < ArraySize(orderGridStopOrderValuesArray); orderGridStopOrderValueId++) {
         if(orderGridStopOrderValuesArray[orderGridStopOrderValueId] != EMPTY_VALUE
               && Bid() < orderGridStopOrderValuesArray[orderGridStopOrderValueId]) {
            signal = true;
            orderGridStopOrderValuesArray[orderGridStopOrderValueId] = EMPTY_VALUE;
         }
      }
   }

   return signal;
}

bool getBidLowerShortReEntryAreaFilter() {

   bool filter = false;

   if(Bid() < reEntryAreaMinEndValue) {
      filter = true;
      t3ShortIsTradable = false;
   }

   return filter;
}

bool getOpenShortPositionCountFilter() {

   bool filter = false;
   long     positionTicket = 0;
   int      openPositionCount = 0;

   for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
      positionTicket = positionTickets[positionTicketsId];
      if(
         positionTicket > 0
         && PositionSymbol(positionTicket) == Symbol()
         && PositionMagicNumber(positionTicket) == InpMagicNumber
         && PositionType(positionTicket) == ORDER_TYPE_SELL
      ) {
         openPositionCount++;
      }
   }

   if(openPositionCount >= InpOrderGridCount) {
      filter = true;
      ArrayResize(orderGridStopOrderValuesArray, 0);
      t3ShortIsTradable = false;
   }

   return filter;
}
//+------------------------------------------------------------------+
