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

   if(t3trendDirection == TREND_DIRECTION_LONG) {
      if(t3LowestLowValue >= InpT3MinHighVolumeAreaLevel && t3LowestLowValue <= InpT3MaxHighVolumeAreaLevel) {
         t3LowestLowIsInSignalArea = true;
      } else {
         t3LowestLowIsInSignalArea = false;
      }

      if(t3LowestLowValue != 0 && InpT3MinHighVolumeAreaLevel !=0 && t3LowestLowValue < InpT3MinHighVolumeAreaLevel) {
         t3LowestLowDateTime = 0;
         string t3DisableTradeableButtonReason = "t3LowestLowValue < InpT3MinHighVolumeAreaLevel";
         t3DisableTradeableButton(t3DisableTradeableButtonReason);
      }

      if(t3LowestLowVLineDateTime != 0) {
         double t3MaxProfitLevel = iHigh(Symbol(), Period(), iHighest( Symbol(), Period(), MODE_HIGH,  iBarShift(Symbol(), Period(), t3LowestLowVLineDateTime) + 1));
         if(t3MinProfitFiboRetracmentLevel != 0 && t3MaxProfitLevel >= t3MinProfitFiboRetracmentLevel) t3ProfitLevelGreaterMinProfitFiboRetracmentLevel = true;
      } else {
         t3ProfitLevelGreaterMinProfitFiboRetracmentLevel = false;
      }
   }

   if(t3trendDirection == TREND_DIRECTION_SHORT) {
      if(t3HighestHighValue >= InpT3MinHighVolumeAreaLevel && t3HighestHighValue <= InpT3MaxHighVolumeAreaLevel) {
         t3HighestHighIsInSignalArea = true;
      } else {
         t3HighestHighIsInSignalArea = false;
      }

      if(t3HighestHighValue != 0 && InpT3MaxHighVolumeAreaLevel != 0 && t3HighestHighValue > InpT3MaxHighVolumeAreaLevel) {
         t3HighestHighDateTime = 0;
         string t3DisableTradeableButtonReason = "t3HighestHighValue > InpT3MaxHighVolumeAreaLevel";
         t3DisableTradeableButton(t3DisableTradeableButtonReason);
      }

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
