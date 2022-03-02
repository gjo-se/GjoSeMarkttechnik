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
   if(maxT3BuyPositionsAreOpenState == true) {
      ArrayResize(t3OrderGridStopOrderValuesArray, 0);
      t3LongIsTradable = false;
   }

   if(maxT3SellPositionsAreOpenState == true) {
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
   if(t3trendDirection == TREND_DIRECTION_LONG) {
      if(t3LowestLowVLineDateTime != 0) {
         double t3MaxProfitLevel = iHigh(Symbol(), Period(), iHighest( Symbol(), Period(), MODE_HIGH,  iBarShift(Symbol(), Period(), t3LowestLowVLineDateTime) + 1));
         if(t3MinProfitFiboRetracmentLevel != 0 && t3MaxProfitLevel >= t3MinProfitFiboRetracmentLevel) t3ProfitLevelGreaterMinProfitFiboRetracmentLevel = true;
      } else {
         t3ProfitLevelGreaterMinProfitFiboRetracmentLevel = false;
      }
   }

   if(t3trendDirection == TREND_DIRECTION_SHORT) {
      if(t3HighestHighVLineDateTime != 0) {
         double t3MaxProfitLevel = iLow(Symbol(), Period(), iLowest( Symbol(), Period(), MODE_LOW,  iBarShift(Symbol(), Period(), t3HighestHighVLineDateTime) + 1));
         if(t3MinProfitFiboRetracmentLevel != 0 && t3MaxProfitLevel <= t3MinProfitFiboRetracmentLevel) t3ProfitLevelGreaterMinProfitFiboRetracmentLevel = true;
      } else {
         t3ProfitLevelGreaterMinProfitFiboRetracmentLevel = false;
      }
   }

}

void resetT3Action() {

   if(allT3BuyPositionsAreClosedState) {
      buyT3PositionIsOpenState = false;
      maxT3BuyPositionsAreOpenState = false;
   }

   if(allT3SellPositionsAreClosedState) {
      sellT3PositionIsOpenState = false;
      maxT3SellPositionsAreOpenState = false;
   }
}

//+------------------------------------------------------------------+
