//+------------------------------------------------------------------+
//|                                             InitializeAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void handleT4StatesAction() {
   setT4Action();
   resetT4Action();
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void setT4Action() {
   if(maxBuyPositionsAreOpenState == true) {
      ArrayResize(t4OrderGridStopOrderValuesArray, 0);
      t4LongIsTradable = false;
   }

   if(maxSellPositionsAreOpenState == true) {
      ArrayResize(t4OrderGridStopOrderValuesArray, 0);
      t4ShortIsTradable = false;
   }

   if(t4HighestHighValue >= t4InSignalAreaMinEndValue && t4HighestHighValue <= t4InSignalAreaMaxEndValue) {
      t4HighestHighIsInSignalArea = true;
   } else {
      t4HighestHighIsInSignalArea = false;
   }
   if(t4LowestLowValue >= t4InSignalAreaMinEndValue && t4LowestLowValue <= t4InSignalAreaMaxEndValue) {
      t4LowestLowIsInSignalArea = true;
   } else {
      t4LowestLowIsInSignalArea = false;
   }

   if(t4InSignalAreaMinEndValue != 0) {
      if(Bid() < t4InSignalAreaMinEndValue) {
         t4IsBidLowerInSignalAreaMinEndValue = true;
         t4IsBidHigherInSignalAreaMinEndValue = false;
      } else {
         t4IsBidLowerInSignalAreaMinEndValue = false;
         t4IsBidHigherInSignalAreaMinEndValue = true;
      }
   }

   if(t4InSignalAreaMaxEndValue != 0) {
      if(Bid() < t4InSignalAreaMaxEndValue) {
         t4IsBidLowerInSignalAreaMaxEndValue = true;
         t4IsBidHigherInSignalAreaMaxEndValue = false;
      } else {
         t4IsBidLowerInSignalAreaMaxEndValue = false;
         t4IsBidHigherInSignalAreaMaxEndValue = true;
      }
   }
}

void resetT4Action() {

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
