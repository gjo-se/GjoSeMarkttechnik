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

   if(!TerminalInfoInteger(TERMINAL_TRADE_ALLOWED) || !MQLInfoInteger(MQL_TRADE_ALLOWED)) signal = false;
   if(t3trendDirection != TREND_DIRECTION_SHORT) signal = false;
   if(isTradabelButtonState == false) signal = false;
   if(getBidInInSignalAreaState() == false) signal = false;
   if(getOpenSellPositionsFilter() == true) signal = false;

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
   if(sellPositionIsOpen == true) {
      sellPositionIsOpen = false;
      for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
         positionTicket = positionTickets[positionTicketsId];
         if(
            positionTicket > 0
            && PositionSymbol(positionTicket) == Symbol()
            && PositionMagicNumber(positionTicket) == InpMagicNumber
         ) {
            sellPositionIsOpen = true;
         }
      }

      if(sellPositionIsOpen == false) {
         createT3HighestHighVLine();
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

bool getBidLowerShortEntryLevelSignal() {

   bool signal = false;

   if(Bid() > t3ShortEntryValue) t3ShortIsTradable = true;

   if(t3ShortIsTradable == true && Bid() <= t3ShortEntryValue) {
      signal = true;
      t3ShortIsTradable = false;
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



//bool spreadGreaterThanMaxSpreadSellInFilter() {
//
//   bool filter = true;
//
////  Print("Spread: " + Spread());
//
//   if(Spread() < InpMaxSpread) {
//      filter = false;
//   }
//
//   return(filter);
//}

//bool getTradeDirectionIsNotShortFilter() {
//
//   bool filter = true;
//
//   //if(p2Low > 0 && p3High > 0 && p2Low < p3High) {
//   //   tradeDirection = SHORT;
//   //   filter = false;
//   //}
//
//   return(filter);
//}

bool getOpenSellPositionsFilter() {

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
      }
   }

   return (filter);
}

bool getBidNotBetweenMinMaxValuesSellInFilter() {

   bool filter = true;

   //Print("minValue: " +  + " maxValue: " + maxValue);

   //if(minValue != 0 && maxValue != 0 && Bid() > minValue && Bid() < maxValue) {
   //   filter = false;
   //}

   return (filter);
}
//+------------------------------------------------------------------+
