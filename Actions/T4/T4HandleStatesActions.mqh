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
      if(t3trendDirection == TREND_DIRECTION_SHORT) {
         if(t4MinRegressionForTrendDetectionLevel != 0 && Bid() < t4MinRegressionForTrendDetectionLevel) t4MinRegressionForTrendDetectionState = true;
         if(t4MinRegressionForTrendDetectionState == true && t4p4DateTime != 0 && t4p4DateTime < (int)TimeCurrent()) {
            double t4p5ValueLowLocal = iLow(Symbol(), Period(), iLowest( Symbol(), Period(), MODE_LOW,  iBarShift(Symbol(), Period(), t4p4DateTime) + 1));
            if(t4p5ValueLowLocal != 0 && getT4P3HighLowValueByTrendDirection() != 0 && t4p5ValueLowLocal < getT4P3HighLowValueByTrendDirection()) {
               if(t4AlertBidCrossedT4P3ValueSended == false) t4AlertBidCrossedT4P3ValueAction();
               t4MinRegressionForTrendDetectionState = false;
            }
         }
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
      if(t3trendDirection == TREND_DIRECTION_LONG) {
         if(t4MinRegressionForTrendDetectionLevel != 0 && Bid() > t4MinRegressionForTrendDetectionLevel) t4MinRegressionForTrendDetectionState = true;
         if(t4MinRegressionForTrendDetectionState == true && t4p4DateTime != 0 && t4p4DateTime < (int)TimeCurrent()) {
            double t4p5ValueHighLocal = iHigh(Symbol(), Period(), iHighest( Symbol(), Period(), MODE_HIGH,  iBarShift(Symbol(), Period(), t4p4DateTime) + 1));
            if(t4p5ValueHighLocal != 0 && getT4P3HighLowValueByTrendDirection() != 0 && t4p5ValueHighLocal > getT4P3HighLowValueByTrendDirection()) {
               if(t4AlertBidCrossedT4P3ValueSended == false) t4AlertBidCrossedT4P3ValueAction();
               t4MinRegressionForTrendDetectionState = false;
            }
         }
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
