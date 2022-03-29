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
   }

   if(maxT4SellPositionsAreOpenState == true) {
      ArrayResize(t4OrderGridStopOrderValuesArray, 0);
   }

   if(t4trendDirection == TREND_DIRECTION_LONG) {
      if(t4LowestLowValue != 0 && t4MinHighVolumeAreaLevel != 0 && t4MaxHighVolumeAreaLevel != 0) {
         if(t4LowestLowValue >= t4MinHighVolumeAreaLevel && t4LowestLowValue <= t4MaxHighVolumeAreaLevel) {
            t4LowestLowIsInSignalArea = true;
         } else {
            t4LowestLowIsInSignalArea = false;
         }

         if(t4LowestLowValue < t4MinHighVolumeAreaLevel) {
            t4LowestLowDateTime = 0;
            string t4DisableTradeableButtonReason = "t4LowestLowValue < t4MinHighVolumeAreaLevel";
            t4DisableTradeableButton(t4DisableTradeableButtonReason);
         }
      }

      if(t4LowestLowVLineDateTime != 0 && t4LowestLowVLineDateTime < (int)TimeCurrent()) {
         double t4MaxProfitLevel = iHigh(Symbol(), Period(), iHighest( Symbol(), Period(), MODE_HIGH,  iBarShift(Symbol(), Period(), t4LowestLowVLineDateTime) + 1));
         if(t4MinProfitFiboRetracmentLevel != 0 && t4MaxProfitLevel >= t4MinProfitFiboRetracmentLevel) t4ProfitLevelGreaterMinProfitFiboRetracmentLevel = true;
      } else {
         t4ProfitLevelGreaterMinProfitFiboRetracmentLevel = false;
      }
   }

   if(t4trendDirection == TREND_DIRECTION_SHORT) {
      if(t4HighestHighValue != 0 && t4MinHighVolumeAreaLevel != 0 && t4MaxHighVolumeAreaLevel != 0) {
         if(t4HighestHighValue >= t4MinHighVolumeAreaLevel && t4HighestHighValue <= t4MaxHighVolumeAreaLevel) {
            t4HighestHighIsInSignalArea = true;
         } else {
            t4HighestHighIsInSignalArea = false;
         }

         if(t4HighestHighValue > t4MaxHighVolumeAreaLevel) {
            t4HighestHighDateTime = 0;
            string t4DisableTradeableButtonReason = "t4HighestHighValue > t4MaxHighVolumeAreaLevel";
            t4DisableTradeableButton(t4DisableTradeableButtonReason);
         }
      }
      if(t4HighestHighVLineDateTime != 0 && t4HighestHighVLineDateTime < (int)TimeCurrent()) {
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
