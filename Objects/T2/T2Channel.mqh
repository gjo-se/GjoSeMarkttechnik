//+------------------------------------------------------------------+
//|                                                   FiboLevels.mqh |
//|                                       Copyright 2022, Gregory Jo |
//+------------------------------------------------------------------+

void createT2HighVolumeAreaChannel() {

   datetime startDateTime = TimeCurrent();
   if(t2p1DateTime != 0) startDateTime = t2p1DateTime;
   if(t2p3DateTime != 0) startDateTime = t2p3DateTime;
   if(t2p5DateTime != 0) startDateTime = t2p5DateTime;

   if(
      t2MinHighVolumeAreaLevel != 0
      && t2MaxHighVolumeAreaLevel != 0
   ) {
      createChannel(T2_HIGH_VOL_CHANNEL, startDateTime, t2MinHighVolumeAreaLevel, iTime(Symbol(), PERIOD_CURRENT, 0), t2MinHighVolumeAreaLevel, startDateTime, t2MaxHighVolumeAreaLevel, InpT2LigthColor);
   }
}