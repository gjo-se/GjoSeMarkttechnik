//+------------------------------------------------------------------+
//|                                            RegressionChannel.mqh |
//|                                       Copyright 2021, Gregory Jo |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void setT3LineValues() {
   setT3VLineDateTimes();
   setT3VLineValues();
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void setT3VLineDateTimes() {
   t3StartDateTime = getVlineDatetimeByText(T3_START_VLINE);
   t3p1DateTime = getVlineDatetimeByText(T3_P1_VLINE);
   t3p2DateTime = getVlineDatetimeByText(T3_P2_VLINE);
   t3p3DateTime = getVlineDatetimeByText(T3_P3_VLINE);
   t3p4DateTime = getVlineDatetimeByText(T3_P4_VLINE);
   t3HighestHighVLineDateTime = getVlineDatetimeByText(T3_HH_VLINE);
   t3LowestLowVLineDateTime = getVlineDatetimeByText(T3_LL_VLINE);
}

void setT3VLineValues() {

   if((int)t3p1DateTime < (int) TimeCurrent()) {
      t3p1ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p1DateTime));
      t3p1ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p1DateTime));
   }
   if((int)t3p2DateTime < (int) TimeCurrent()) {
      t3p2ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p2DateTime));
      t3p2ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p2DateTime));
   }
   if((int)t3p3DateTime < (int) TimeCurrent()) {
      t3p3ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p3DateTime));
      t3p3ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p3DateTime));
   }
   if((int)t3p4DateTime < (int) TimeCurrent()) {
      t3p4ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p4DateTime));
      t3p4ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p4DateTime));
   }
}
//+------------------------------------------------------------------+

void deleteVLineObject(const string pDimension) {

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

void createT3HighestHighVLine() {

   long zOrder = 0;
   bool isBackground = false;
   bool isSelected = false;
   bool isSelectable = true;

   int barShift = 0;
   createVLine(T3_HH_VLINE, iTime(Symbol(), Period(), barShift), InpT3TrendLineColor, 2, STYLE_SOLID, T3_HH_VLINE, zOrder, isBackground, isSelected, isSelectable);

   t3HighestHighVLineDateTime = iTime(Symbol(), Period(), barShift);
}

void createT3LowestLowVLine() {

   long zOrder = 0;
   bool isBackground = false;
   bool isSelected = false;
   bool isSelectable = true;

   int barShift = 0;
   createVLine(T3_LL_VLINE, iTime(Symbol(), Period(), barShift), InpT3TrendLineColor, 2, STYLE_SOLID, T3_LL_VLINE, zOrder, isBackground, isSelected, isSelectable);

   t3LowestLowVLineDateTime = iTime(Symbol(), Period(), barShift);
}
//+------------------------------------------------------------------+
