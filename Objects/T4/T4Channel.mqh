//+------------------------------------------------------------------+
//|                                                   FiboLevels.mqh |
//|                                       Copyright 2022, Gregory Jo |
//+------------------------------------------------------------------+

void createT4InSignalFiboLevelChannelArea() {

   if(
      t4MinHighVolumeAreaLevel != 0
      && t4MaxHighVolumeAreaLevel != 0
   ) {
      createChannel(T4_IN_SIGNAL_FIBO_LEVEL_AREA, t4p4DateTime, t4MinHighVolumeAreaLevel, iTime(Symbol(), PERIOD_CURRENT, 0), t4MinHighVolumeAreaLevel, t4p4DateTime, t4MaxHighVolumeAreaLevel, InpT4InSignalAreaColor);
   }
}

void createt4InSignalRegressionChannelArea() {

   if(
      t4InSignalRegressionChannelAreaMinStartValue != 0
      && t4InSignalRegressionChannelAreaMinEndValue != 0
      && t4InSignalRegressionChannelAreaMaxStartValue != 0
      && t4InSignalRegressionChannelAreaMaxEndValue != 0
   ) {
      createChannel(T4_IN_SIGNAL_REGRESSION_CHANNEL_AREA, t4p4DateTime, t4InSignalRegressionChannelAreaMaxStartValue, iTime(Symbol(), PERIOD_CURRENT, 0), t4InSignalRegressionChannelAreaMaxEndValue, t4p4DateTime, t4InSignalRegressionChannelAreaMinStartValue, InpT4InSignalAreaColor);
   }
}

void createT4ReEntryArea() {

   if(
      t4ReEntryAreaMinStartValue != 0
      && t4ReEntryAreaMinEndValue != 0
      && t4ReEntryAreaMaxStartValue != 0
      && t4ReEntryAreaMaxEndValue != 0
   ) {

      createChannel(T4_RE_ENTRY_AREA, t4p4DateTime, t4ReEntryAreaMaxStartValue, iTime(Symbol(), PERIOD_CURRENT, 0), t4ReEntryAreaMaxEndValue, t4p4DateTime, t4ReEntryAreaMinStartValue, InpT4ReEntryAreaColor);

   }
}
