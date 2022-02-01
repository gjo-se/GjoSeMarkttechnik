//+------------------------------------------------------------------+
//|                                                   FiboLevels.mqh |
//|                                       Copyright 2022, Gregory Jo |
//+------------------------------------------------------------------+

void createT3InSignalArea() {

   if(
   inSignalAreaMinStartValue != 0
   && inSignalAreaMinEndValue != 0
   && inSignalAreaMaxStartValue != 0
   && inSignalAreaMaxEndValue != 0
   ) {

   createChannel(T3_IN_SIGNAL_AREA, t3p4DateTime, inSignalAreaMaxStartValue, iTime(Symbol(), PERIOD_CURRENT, 0), inSignalAreaMaxEndValue, t3p4DateTime, inSignalAreaMinStartValue, InpT3InSignalAreaColor);

   }
}

void deleteInSignalAreaObject(const string pDimension) {

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
