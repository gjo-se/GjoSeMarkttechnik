//+------------------------------------------------------------------+
//|                                             InitializeAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void handleStatesAction() {
   setAction();
   resetAction();
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void setAction() {
   if(maxBuyPositionsAreOpenState == true) {
      ArrayResize(orderGridStopOrderValuesArray, 0);
      t3LongIsTradable = false;
   }

   if(maxSellPositionsAreOpenState == true) {
      ArrayResize(orderGridStopOrderValuesArray, 0);
      t3ShortIsTradable = false;
   }

   if(t3HighestHighValue >= t3InSignalAreaMinEndValue && t3HighestHighValue <= t3InSignalAreaMaxEndValue) {
      t3HighestHighIsInSignalArea = true;
   } else {
      t3HighestHighIsInSignalArea = false;
   }
   if(t3LowestLowValue >= t3InSignalAreaMinEndValue && t3LowestLowValue <= t3InSignalAreaMaxEndValue) {
      t3LowestLowIsInSignalArea = true;
   } else {
      t3LowestLowIsInSignalArea = false;
   }

   if(Bid() < t3InSignalAreaMinEndValue) {
      isBidLowerInSignalAreaMinEndValue = true;
      isBidHigherInSignalAreaMinEndValue = false;
   } else {
      isBidLowerInSignalAreaMinEndValue = false;
      isBidHigherInSignalAreaMinEndValue = true;
   }
   if(Bid() < t3InSignalAreaMaxEndValue) {
      isBidLowerInSignalAreaMaxEndValue = true;
      isBidHigherInSignalAreaMaxEndValue = false;
   } else {
      isBidLowerInSignalAreaMaxEndValue = false;
      isBidHigherInSignalAreaMaxEndValue = true;
   }

}

void resetAction() {

   if(allBuyPositionsAreClosedState) {
      buyPositionIsOpenState = false;
      maxBuyPositionsAreOpenState = false;
   }

   if(allSellPositionsAreClosedState) {
      sellPositionIsOpenState = false;
      maxSellPositionsAreOpenState = false;
   }
}

//+------------------------------------------------------------------+
