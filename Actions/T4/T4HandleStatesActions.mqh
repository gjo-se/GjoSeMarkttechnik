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
   if(maxT4BuyPositionsAreOpenState == true) {
      ArrayResize(t4OrderGridStopOrderValuesArray, 0);
      t4LongIsTradable = false;
   }

   if(maxT4SellPositionsAreOpenState == true) {
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

   if(t4trendDirection == TREND_DIRECTION_LONG) {
      if(t4LowestLowVLineDateTime != 0) {
         double t4MaxProfitLevel = iHigh(Symbol(), Period(), iHighest( Symbol(), Period(), MODE_HIGH,  iBarShift(Symbol(), Period(), t4LowestLowVLineDateTime) + 1));
         if(t4MinProfitFiboRetracmentLevel != 0 && t4MaxProfitLevel >= t4MinProfitFiboRetracmentLevel) t4ProfitLevelGreaterMinProfitFiboRetracmentLevel = true;
      } else {
         t4ProfitLevelGreaterMinProfitFiboRetracmentLevel = false;
      }
   }

   if(t4trendDirection == TREND_DIRECTION_SHORT) {
      if(t4HighestHighVLineDateTime != 0) {
         double t4MaxProfitLevel = iLow(Symbol(), Period(), iLowest( Symbol(), Period(), MODE_LOW,  iBarShift(Symbol(), Period(), t4HighestHighVLineDateTime) + 1));
         if(t4MinProfitFiboRetracmentLevel != 0 && t4MaxProfitLevel <= t4MinProfitFiboRetracmentLevel) t4ProfitLevelGreaterMinProfitFiboRetracmentLevel = true;
      } else {
         t4ProfitLevelGreaterMinProfitFiboRetracmentLevel = false;
      }
   }

}

void resetT4Action() {

   if(allT4BuyPositionsAreClosedState) {
      buyT4PositionIsOpenState = false;
      maxT4BuyPositionsAreOpenState = false;
   }

   if(allT4SellPositionsAreClosedState) {
      sellT4PositionIsOpenState = false;
      maxT4SellPositionsAreOpenState = false;
   }
}

//+------------------------------------------------------------------+