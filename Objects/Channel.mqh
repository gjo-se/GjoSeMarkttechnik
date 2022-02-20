//+------------------------------------------------------------------+
//|                                                   FiboLevels.mqh |
//|                                       Copyright 2022, Gregory Jo |
//+------------------------------------------------------------------+

void createT3InSignalFiboLevelArea() {

   if(
      t3InSignalFiboLevelAreaMinStartValue != 0
      && t3InSignalFiboLevelAreaMinEndValue != 0
      && t3InSignalFiboLevelAreaMaxStartValue != 0
      && t3InSignalFiboLevelAreaMaxEndValue != 0
   ) {
      createChannel(T3_IN_SIGNAL_FIBO_LEVEL_AREA, t3p4DateTime, t3InSignalFiboLevelAreaMaxStartValue, iTime(Symbol(), PERIOD_CURRENT, 0), t3InSignalFiboLevelAreaMaxEndValue, t3p4DateTime, t3InSignalFiboLevelAreaMinStartValue, InpT3InSignalAreaColor);
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
      reEntryAreaMinStartValue != 0
      && reEntryAreaMinEndValue != 0
      && reEntryAreaMaxStartValue != 0
      && reEntryAreaMaxEndValue != 0
   ) {

      createChannel(T3_RE_ENTRY_AREA, t3p4DateTime, reEntryAreaMaxStartValue, iTime(Symbol(), PERIOD_CURRENT, 0), reEntryAreaMaxEndValue, t3p4DateTime, reEntryAreaMinStartValue, InpT3ReEntryAreaColor);

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
