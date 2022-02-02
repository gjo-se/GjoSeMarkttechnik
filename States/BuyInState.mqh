/*

   TriggerBuyInStates
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

   Beschreibung
   ===============

*/

bool getBuyInSignal() {

   bool signal = false;

//    Print("t3trendDirection: " + t3trendDirection);
   if(t3trendDirection != TREND_DIRECTION_LONG) return false;
   if(getBidInInSignalAreaState() == false) return false;

   setLowestLowDateTime();

//   if(getBidGreaterLowestLowAndOffsetSignal() == true) signal = true;
//
//   if(spreadGreaterThanMaxSpreadBuyInFilter() == true) signal = false;
//
//   if(getTradeDirectionIsNotLongFilter() == true) signal = false;
//   if(getOpenBuyPositionsFilter() == true) signal = false;
//   if(getBidNotBetweenMinMaxValuesBuyInFilter() == true) signal = false;

   return(signal);

}

void setLowestLowDateTime() {

    int      startCandleShift = iBarShift(Symbol(), Period(), t3p4DateTime);

    //   long     positionTicket = 0;
    //      if(sellPositionIsOpen == true) {
    //         sellPositionIsOpen = false;
    //         for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
    //            positionTicket = positionTickets[positionTicketsId];
    //            if(
    //               positionTicket > 0
    //               && PositionSymbol(positionTicket) == Symbol()
    //               && PositionMagicNumber(positionTicket) == InpMagicNumber
    //            ) {
    //               sellPositionIsOpen = true;
    ////               Print("buyPositionIsOpen == true");
    //            }
    //         }
    //
    //         if(sellPositionIsOpen == false) {
    //            startShortDateTime = TimeCurrent();
    //         }
    //
    //      }
    //   }

    //t3highestHighStartCandleShift = startCandleShift;
//    t3highHighValue = iHigh(Symbol(), PERIOD_CURRENT, iHighest(Symbol(), PERIOD_CURRENT, MODE_HIGH, startCandleShift, 0));
    t3LowestLowDateTime = iTime(Symbol(), PERIOD_CURRENT, iLowest(Symbol(), PERIOD_CURRENT, MODE_LOW, startCandleShift, 0));

}

bool getBidGreaterLowestLowAndOffsetSignal() {

   bool signal = false;
//   double lowestLowValue = 0;
   bool bidGreaterLowestLowAndOffset = false;

//   int shiftP4 = iBarShift(Symbol(), PERIOD_M1, p4DateTime);
//   if(shiftP4 > 0) lowestLowValue = iLow(Symbol(), PERIOD_M1, iLowest(Symbol(), PERIOD_M1, MODE_LOW, shiftP4, 0));

   if(getLowestLowValue() > 0 && (Ask() > (getLowestLowValue() + InpStopLoss * Point()))) bidGreaterLowestLowAndOffset = true;
   if(bidGreaterLowestLowAndOffset == true) {
      if(bidGreaterLowestLowAndOffsetSignal == false) signal = true;
      bidGreaterLowestLowAndOffsetSignal = true;
   } else {
      signal = false;
      bidGreaterLowestLowAndOffsetSignal = false;
   }

//   if(signal == true) Print("bidGreaterLowestLowAndOffsetSignal: " + signal + " Spread(): " + Spread());
//   Print("shiftP4: " + shiftP4 + " lowestLowValue: " + lowestLowValue + " bidGreaterLowestLowAndOffset: " + bidGreaterLowestLowAndOffset +" signal: " + signal + " (lowestLowValue + InpStopLoss * Point()): " + (lowestLowValue + InpStopLoss * Point()));

   return signal;
}

double getLowestLowValue() {

   double lowestLowValue = 0;
   long positionTicket = 0;

//   if(p4DateTime < TimeCurrent()) {
//
//    if(startLongDateTime == 0){
//      startLongBarShift = iBarShift(Symbol(), PERIOD_M1, p4DateTime);
////      Print("p4Datetime: " + startBarShift);
//    }else{
//      startLongBarShift = iBarShift(Symbol(), PERIOD_M1, startLongDateTime) + 1;
////      Print("newCandle: " + startBarShift);
//    }
//
//      if(buyPositionIsOpen == true) {
//         buyPositionIsOpen = false;
//         for(int positionTicketsId = 0; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
//            positionTicket = positionTickets[positionTicketsId];
//            if(
//               positionTicket > 0
//               && PositionSymbol(positionTicket) == Symbol()
//               && PositionMagicNumber(positionTicket) == InpMagicNumber
//            ) {
//               buyPositionIsOpen = true;
////               Print("buyPositionIsOpen == true");
//            }
//         }
//
//         if(buyPositionIsOpen == false) {
//            startLongDateTime = TimeCurrent();
//         }
//
//      }
//
//      if(startLongBarShift == 0) {
//         lowestLowValue = iLow(Symbol(), PERIOD_M1, startLongBarShift);
//      } else {
//         lowestLowValue = iLow(Symbol(), PERIOD_M1, iLowest(Symbol(), PERIOD_M1, MODE_LOW, startLongBarShift, 0));
//      }
//   }

//   Print("p4DateTime: " + p4DateTime + " TimeCurrent(): " + TimeCurrent() + " startShift: " + startBarShift + " lowestLowValu: " + lowestLowValue);

   return(lowestLowValue);

}

bool spreadGreaterThanMaxSpreadBuyInFilter() {

   bool filter = true;

//   if(Spread() <= InpMaxSpread) Print("Spread: " + Spread());

   if(Spread() < InpMaxSpread) {
      filter = false;
   }

   return(filter);

}

bool getTradeDirectionIsNotLongFilter() {

   bool filter = true;

   //if(p2High > 0 && p3Low > 0 && p2High > p3Low) {
   //   tradeDirection = LONG;
   //   filter = false;
   //}

   return(filter);
}

bool getOpenBuyPositionsFilter() {

   bool filter = false;
   long positionTicket = 0;

   int positionTicketsId = 0;
   for(positionTicketsId; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
      positionTicket = positionTickets[positionTicketsId];
      if(
         positionTicket > 0
         && PositionSymbol(positionTicket) == Symbol()
         && PositionMagicNumber(positionTicket) == InpMagicNumber
         && PositionType(positionTicket) == ORDER_TYPE_BUY
      ) {
         filter = true;
      }
   }

   return (filter);
}

bool getBidNotBetweenMinMaxValuesBuyInFilter() {

   bool filter = true;

   //Print("minValue: " +  + " maxValue: " + maxValue);

   //if(minValue != 0 && maxValue != 0 && Bid() > minValue && Bid() < maxValue) {
   //   filter = false;
   //}

   return (filter);
}
//+------------------------------------------------------------------+
