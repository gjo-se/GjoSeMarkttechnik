//+------------------------------------------------------------------+
//|                                             InitializeAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void handleT2StatesAction() {
   setT2Action();
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void setT2Action() {
   // TODO: NICHT löschen - umbauen auf rein t2MinHighVolumeAreaLevel
   if(t2trendDirection == TREND_DIRECTION_LONG) {
//      if(t2LowestLowValue != 0 && t2MinHighVolumeAreaLevel != 0 && t2MaxHighVolumeAreaLevel != 0) {
//         if(t2LowestLowValue >= t2MinHighVolumeAreaLevel && t2LowestLowValue <= t2MaxHighVolumeAreaLevel) {
//            t2LowestLowIsInSignalArea = true;
//            if(t2alertBidIsInSignalAreaSended == false) t2AlertBidIsInSignalAreaAction();
//         } else {
//            t2LowestLowIsInSignalArea = false;
//         }
//
//         if(t2LowestLowValue < t2MinHighVolumeAreaLevel) {
//            t2LowestLowDateTime = 0;
//         }
//         if(t2LowestLowValue < t2MinHighVolumeAreaLevel && Bid() > t2MinHighVolumeAreaLevel) {
//            if(t2alertBidAgainInHighVolumeAreaSended == false) t2alertBidAgainInHighVolumeAreaAction();
//         }
//      }
   }

   // TODO: NICHT löschen - umbauen auf rein t2MinHighVolumeAreaLevel
   if(t2trendDirection == TREND_DIRECTION_SHORT) {
//      if(t2HighestHighValue != 0 && t2MinHighVolumeAreaLevel != 0 && t2MaxHighVolumeAreaLevel != 0) {
//         if(t2HighestHighValue >= t2MinHighVolumeAreaLevel && t2HighestHighValue <= t2MaxHighVolumeAreaLevel) {
//            t2HighestHighIsInSignalArea = true;
//            if(t2alertBidIsInSignalAreaSended == false) t2AlertBidIsInSignalAreaAction();
//         } else {
//            t2HighestHighIsInSignalArea = false;
//         }
//
//         if(t2HighestHighValue > t2MaxHighVolumeAreaLevel) {
//            
//            t2HighestHighDateTime = 0;
//         }
//         if(t2HighestHighValue > t2MaxHighVolumeAreaLevel && Bid() < t2MaxHighVolumeAreaLevel) {
//            if(t2alertBidAgainInHighVolumeAreaSended == false) t2alertBidAgainInHighVolumeAreaAction();
//         }         
//      }
   }

}
