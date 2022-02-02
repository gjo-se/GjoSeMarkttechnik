/*

   SellInState
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

   Beschreibung
   ===============

*/

bool getSellInSignal() {

   bool signal = false;

   if(t3trendDirection != TREND_DIRECTION_SHORT) return false;
   if(getBidInInSignalAreaState() == false) return false;

   setHighestHighDateTime();




   if(getBidLowerHighestHighAndOffsetSignal() == true) signal = true;

   if(spreadGreaterThanMaxSpreadSellInFilter() == true) signal = false;

   //if(getTradeDirectionIsNotShortFilter() == true) signal = false;
   if(getOpenSellPositionsFilter() == true) signal = false;
   if(getBidNotBetweenMinMaxValuesSellInFilter() == true) signal = false;

//   if(signal == true) Print("Signal is true");

   return(signal);

}

bool getBidInInSignalAreaState() {

   bool state = false;

   if(inSignalAreaMinEndValue != 0 && Bid() > inSignalAreaMinEndValue
         && inSignalAreaMaxEndValue != 0 && Bid() < inSignalAreaMaxEndValue) {
      state = true;
   }

   return state;

}

void setHighestHighDateTime() {

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

    //h3highestHighStartCandleShift = startCandleShift;
//    t3highestHighValue = iHigh(Symbol(), PERIOD_CURRENT, iHighest(Symbol(), PERIOD_CURRENT, MODE_HIGH, startCandleShift, 0));
    t3HighestHighDateTime = iTime(Symbol(), PERIOD_CURRENT, iHighest(Symbol(), PERIOD_CURRENT, MODE_HIGH, startCandleShift, 0));

}



//###################################################################

bool getBidLowerHighestHighAndOffsetSignal() {

   bool signal = false;
//   double lowestLowValue = 0;
   bool bidLowerHighestHighAndOffset = false;

//   int shiftP4 = iBarShift(Symbol(), PERIOD_M1, p4DateTime);
//   if(shiftP4 > 0) lowestLowValue = iLow(Symbol(), PERIOD_M1, iLowest(Symbol(), PERIOD_M1, MODE_LOW, shiftP4, 0));

   //if(getHighestHighValue() > 0 && (Bid() < (getHighestHighValue() - InpStopLoss * Point()))) bidLowerHighestHighAndOffset = true;
   //if(bidLowerHighestHighAndOffset == true) {
   //   if(bidLowerHighestHighAndOffsetSignal == false) signal = true;
   //   bidLowerHighestHighAndOffsetSignal = true;
   //} else {
   //   signal = false;
   //   bidLowerHighestHighAndOffsetSignal = false;
   //}

//   Print("getHighestHighValue: " + getHighestHighValue() + " getHighestHighValue() - InpStopLoss * Point(): " + (getHighestHighValue() - InpStopLoss * Point()) + " signal: " + signal);

//   if(signal == true) Print("bidGreaterLowestLowAndOffsetSignal: " + signal + " Spread(): " + Spread());
//   Print("shiftP4: " + shiftP4 + " lowestLowValue: " + lowestLowValue + " bidGreaterLowestLowAndOffset: " + bidGreaterLowestLowAndOffset +" signal: " + signal + " (lowestLowValue + InpStopLoss * Point()): " + (lowestLowValue + InpStopLoss * Point()));

   return signal;
}



bool spreadGreaterThanMaxSpreadSellInFilter() {

   bool filter = true;

//  Print("Spread: " + Spread());

   if(Spread() < InpMaxSpread) {
      filter = false;
   }

   return(filter);
}

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
