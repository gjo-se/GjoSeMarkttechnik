//+------------------------------------------------------------------+
//|                                                   FiboLevels.mqh |
//|                                       Copyright 2022, Gregory Jo |
//+------------------------------------------------------------------+

void createT2HighVolumeAreaChannel() {

   datetime startDateTime = t2p3DateTime;
   if(ObjectFind(ChartID(), T2_MAX_HIGH_VOL_AREA) >= 0) {
      startDateTime = (datetime) ObjectGetInteger(ChartID(), T2_MAX_HIGH_VOL_AREA, OBJPROP_TIME, 0);
   }

   if(
      t2MinHighVolumeAreaLevel != 0
      && t2MaxHighVolumeAreaLevel != 0
   ) {
      createChannel(T2_HIGH_VOL_CHANNEL, startDateTime, t2MinHighVolumeAreaLevel, iTime(Symbol(), PERIOD_CURRENT, 0), t2MinHighVolumeAreaLevel, startDateTime, t2MaxHighVolumeAreaLevel, InpT2LigthColor);
      ObjectSetInteger(ChartID(), T2_HIGH_VOL_CHANNEL, OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);
   }
}
//+------------------------------------------------------------------+
