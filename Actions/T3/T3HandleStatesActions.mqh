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
   }

   if(maxT3SellPositionsAreOpenState == true) {
      ArrayResize(t3OrderGridStopOrderValuesArray, 0);
   }

   if(t3trendDirection == TREND_DIRECTION_LONG) {
      if(t3LowestLowValue != 0 && t3MinHighVolumeAreaLevel != 0 && t3MaxHighVolumeAreaLevel != 0) {
         if(t3LowestLowValue >= t3MinHighVolumeAreaLevel && t3LowestLowValue <= t3MaxHighVolumeAreaLevel) {
            t3LowestLowIsInSignalArea = true;
            if(t3alertBidIsInSignalAreaSended == false) t3AlertBidIsInSignalAreaAction();
         } else {
            t3LowestLowIsInSignalArea = false;
         }

         if(t3LowestLowValue < t3MinHighVolumeAreaLevel) {
            t3LowestLowDateTime = 0;
         }
         if(t3LowestLowValue < t3MinHighVolumeAreaLevel && Bid() > t3MinHighVolumeAreaLevel) {
            if(t3alertBidAgainInHighVolumeAreaSended == false) t3alertBidAgainInHighVolumeAreaAction();
         }
      }

      if(t3LowestLowVLineDateTime != 0 && t3LowestLowVLineDateTime < (int)TimeCurrent()) {
         double t3MaxProfitLevel = iHigh(Symbol(), Period(), iHighest( Symbol(), Period(), MODE_HIGH,  iBarShift(Symbol(), Period(), t3LowestLowVLineDateTime) + 1));
         if(t3MinProfitFiboRetracmentLevel != 0 && t3MaxProfitLevel >= t3MinProfitFiboRetracmentLevel) t3ProfitLevelGreaterMinProfitFiboRetracmentLevel = true;
      } else {
         t3ProfitLevelGreaterMinProfitFiboRetracmentLevel = false;
      }
   }

   if(t3trendDirection == TREND_DIRECTION_SHORT) {
      if(t3HighestHighValue != 0 && t3MinHighVolumeAreaLevel != 0 && t3MaxHighVolumeAreaLevel != 0) {
         if(t3HighestHighValue >= t3MinHighVolumeAreaLevel && t3HighestHighValue <= t3MaxHighVolumeAreaLevel) {
            t3HighestHighIsInSignalArea = true;
            if(t3alertBidIsInSignalAreaSended == false) t3AlertBidIsInSignalAreaAction();
         } else {
            t3HighestHighIsInSignalArea = false;
         }

         if(t3HighestHighValue > t3MaxHighVolumeAreaLevel) {
            // TODO: das hier kann ich auch in Frage stellen
            t3HighestHighDateTime = 0;
         }
         if(t3HighestHighValue > t3MaxHighVolumeAreaLevel && Bid() < t3MaxHighVolumeAreaLevel) {
            if(t3alertBidAgainInHighVolumeAreaSended == false) t3alertBidAgainInHighVolumeAreaAction();
         }         
      }

      if(t3HighestHighVLineDateTime != 0 && t3HighestHighVLineDateTime < (int)TimeCurrent()) {
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
