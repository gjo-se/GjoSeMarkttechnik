//+------------------------------------------------------------------+
//|                                                   FiboLevels.mqh |
//|                                       Copyright 2022, Gregory Jo |
//+------------------------------------------------------------------+

void createT3InSignalFiboLevelChannelArea() {

   if(
      t3MinHighVolumeAreaLevel != 0
      && t3MaxHighVolumeAreaLevel != 0
   ) {
      createChannel(T3_IN_SIGNAL_FIBO_LEVEL_AREA, t3p3DateTime, t3MinHighVolumeAreaLevel, iTime(Symbol(), PERIOD_CURRENT, 0), t3MinHighVolumeAreaLevel, t3p3DateTime, t3MaxHighVolumeAreaLevel, InpT3InSignalAreaColor);
   }
}

void createt3InSignalRegressionChannelArea() {

   if(
      t3InSignalRegressionChannelAreaMinStartValue != 0
      && t3InSignalRegressionChannelAreaMinEndValue != 0
      && t3InSignalRegressionChannelAreaMaxStartValue != 0
      && t3InSignalRegressionChannelAreaMaxEndValue != 0
   ) {
      createChannel(T3_IN_SIGNAL_REGRESSION_CHANNEL_AREA, t3p4DateTime, t3InSignalRegressionChannelAreaMaxStartValue, iTime(Symbol(), PERIOD_CURRENT, 0), t3InSignalRegressionChannelAreaMaxEndValue, t3p4DateTime, t3InSignalRegressionChannelAreaMinStartValue, InpT3InSignalAreaColor);
   }
}

void createT3ReEntryArea() {

   if(
      t3ReEntryAreaMinStartValue != 0
      && t3ReEntryAreaMinEndValue != 0
      && t3ReEntryAreaMaxStartValue != 0
      && t3ReEntryAreaMaxEndValue != 0
   ) {

      createChannel(T3_RE_ENTRY_AREA, t3p4DateTime, t3ReEntryAreaMaxStartValue, iTime(Symbol(), PERIOD_CURRENT, 0), t3ReEntryAreaMaxEndValue, t3p4DateTime, t3ReEntryAreaMinStartValue, InpT3ReEntryAreaColor);

   }
}

void deleteChannelObject(const string pDimension) {

   long chartId = ChartID();
   int objectsTotal = ObjectsTotal(chartId, 0, -1);

   string objectName;
   for(int i = objectsTotal; i >= 0; i--) {
      objectName = ObjectName(chartId, i);
      if ( StringFind(objectName, pDimension) != -1 ) {
         ObjectDelete(chartId, objectName);
      }
   }
}
//+------------------------------------------------------------------+
