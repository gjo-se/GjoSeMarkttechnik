//+------------------------------------------------------------------+
//|                                                   FiboLevels.mqh |
//|                                       Copyright 2022, Gregory Jo |
//+------------------------------------------------------------------+

void createTT2InSignalFiboLevelChannelArea() {

   datetime startDateTime = TimeCurrent();
   if(tt2p1DateTime != 0) startDateTime = tt2p1DateTime;
   if(tt2p3DateTime != 0) startDateTime = tt2p3DateTime;
   if(tt2p5DateTime != 0) startDateTime = tt2p5DateTime;

   if(
      tt2MinHighVolumeAreaLevel != 0
      && tt2MaxHighVolumeAreaLevel != 0
   ) {
      createChannel(TT2_IN_SIGNAL_FIBO_LEVEL_AREA, startDateTime, tt2MinHighVolumeAreaLevel, iTime(Symbol(), PERIOD_CURRENT, 0), tt2MinHighVolumeAreaLevel, startDateTime, tt2MaxHighVolumeAreaLevel, InpT2LigthColor);
   }
}
//+------------------------------------------------------------------+
