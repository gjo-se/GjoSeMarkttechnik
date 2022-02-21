//+------------------------------------------------------------------+
//|                                             InitializeAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void handleT3StatesAction() {
   setT3Action();
   resetT3Action();
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void setT3Action() {
   if(maxBuyPositionsAreOpenState == true) {
      ArrayResize(t3OrderGridStopOrderValuesArray, 0);
      t3LongIsTradable = false;
   }

   if(maxSellPositionsAreOpenState == true) {
      ArrayResize(t3OrderGridStopOrderValuesArray, 0);
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

   if(t3InSignalAreaMinEndValue != 0) {
      if(Bid() < t3InSignalAreaMinEndValue) {
         t3IsBidLowerInSignalAreaMinEndValue = true;
         t3IsBidHigherInSignalAreaMinEndValue = false;
      } else {
         t3IsBidLowerInSignalAreaMinEndValue = false;
         t3IsBidHigherInSignalAreaMinEndValue = true;
      }
   }

   if(t3InSignalAreaMaxEndValue != 0) {
      if(Bid() < t3InSignalAreaMaxEndValue) {
         t3IsBidLowerInSignalAreaMaxEndValue = true;
         t3IsBidHigherInSignalAreaMaxEndValue = false;
      } else {
         t3IsBidLowerInSignalAreaMaxEndValue = false;
         t3IsBidHigherInSignalAreaMaxEndValue = true;
      }
   }
}

void resetT3Action() {

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
