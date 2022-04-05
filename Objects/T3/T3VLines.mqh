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
   if(ObjectFind(ChartID(), T3_P1_VLINE) >= 0) {
      t3p1DateTime = (datetime)ObjectGetInteger(ChartID(), T3_P1_VLINE, OBJPROP_TIME);
   } else {
      t3p1DateTime = 0;
   }
   if(ObjectFind(ChartID(), T3_P2_VLINE) >= 0) {
      t3p2DateTime = (datetime)ObjectGetInteger(ChartID(), T3_P2_VLINE, OBJPROP_TIME);
   } else {
      t3p2DateTime = 0;
   }
   if(ObjectFind(ChartID(), T3_P3_VLINE) >= 0) {
      t3p3DateTime = (datetime)ObjectGetInteger(ChartID(), T3_P3_VLINE, OBJPROP_TIME);
   } else {
      t3p3DateTime = 0;
   }
   if(ObjectFind(ChartID(), T3_P4_VLINE) >= 0) {
      t3p4DateTime = (datetime)ObjectGetInteger(ChartID(), T3_P4_VLINE, OBJPROP_TIME);
   } else {
      t3p4DateTime = 0;
   }
   if(ObjectFind(ChartID(), T3_P5_VLINE) >= 0) {
      t3p5DateTime = (datetime)ObjectGetInteger(ChartID(), T3_P5_VLINE, OBJPROP_TIME);
   } else {
      t3p5DateTime = 0;
   }
   if(ObjectFind(ChartID(), T3_HH_VLINE) >= 0) {
      t3HighestHighVLineDateTime = (datetime)ObjectGetInteger(ChartID(), T3_HH_VLINE, OBJPROP_TIME);
   } else {
      t3HighestHighVLineDateTime = 0;
   }
   if(ObjectFind(ChartID(), T3_LL_VLINE) >= 0) {
      t3LowestLowVLineDateTime = (datetime)ObjectGetInteger(ChartID(), T3_LL_VLINE, OBJPROP_TIME);
   } else {
      t3LowestLowVLineDateTime = 0;
   }
}

void setT3VLineValues() {

   if(t3p1DateTime != 0 && (int)t3p1DateTime < (int) TimeCurrent()) {
      t3p1ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p1DateTime));
      t3p1ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p1DateTime));
   } else {
      t3p1ValueHigh = 0;
      t3p1ValueLow = 0;
   }

   if(t3p2DateTime != 0 && (int)t3p2DateTime < (int) TimeCurrent()) {
      t3p2ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p2DateTime));
      t3p2ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p2DateTime));
   } else {
      t3p2ValueHigh = 0;
      t3p2ValueLow = 0;
   }

   if(t3p3DateTime != 0 && (int)t3p3DateTime < (int) TimeCurrent()) {
      t3p3ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p3DateTime));
      t3p3ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p3DateTime));
   } else {
      t3p3ValueHigh = 0;
      t3p3ValueLow = 0;
   }

   if(t3p4DateTime != 0 && (int)t3p4DateTime < (int) TimeCurrent()) {
      t3p4ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p4DateTime));
      t3p4ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p4DateTime));
   } else {
      t3p4ValueHigh = 0;
      t3p4ValueLow = 0;
   }

   if(t3p5DateTime != 0 && (int)t3p5DateTime < (int) TimeCurrent()) {
      t3p5ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p5DateTime));
      t3p5ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p5DateTime));
   } else {
      t3p5ValueHigh = 0;
      t3p5ValueLow = 0;
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

void createT3P1VLine(datetime pDateTime) {

   long zOrder = 0;
   bool isBackground = false;
   bool isSelected = true;
   bool isSelectable = true;

   t3p1DateTime = pDateTime;
   t3p1ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p1DateTime));
   t3p1ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p1DateTime));

   createVLine(T3_P1_VLINE, t3p1DateTime, InpT3VLineColor, 2, STYLE_SOLID, T3_P1_VLINE, zOrder, isBackground, isSelected, isSelectable);
}

void createT3P2VLine(datetime pDateTime) {

   long zOrder = 0;
   bool isBackground = false;
   bool isSelected = true;
   bool isSelectable = true;

   t3p2DateTime = pDateTime;
   t3p2ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p2DateTime));
   t3p2ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p2DateTime));

   createVLine(T3_P2_VLINE, t3p2DateTime, InpT3VLineColor, 2, STYLE_SOLID, T3_P2_VLINE, zOrder, isBackground, isSelected, isSelectable);
}

void createT3P3VLine(datetime pDateTime) {

   long zOrder = 0;
   bool isBackground = false;
   bool isSelected = true;
   bool isSelectable = true;

   t3p3DateTime = pDateTime;
   t3p3ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p3DateTime));
   t3p3ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p3DateTime));

   createVLine(T3_P3_VLINE, t3p3DateTime, InpT3VLineColor, 2, STYLE_SOLID, T3_P3_VLINE, zOrder, isBackground, isSelected, isSelectable);
}

void createT3P4VLine(datetime pDateTime) {

   long zOrder = 0;
   bool isBackground = false;
   bool isSelected = false;
   bool isSelectable = true;

   t3p4DateTime = pDateTime;
   t3p4ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p4DateTime));
   t3p4ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p4DateTime));

   createVLine(T3_P4_VLINE, t3p4DateTime, InpT3VLineColor, 2, STYLE_SOLID, T3_P4_VLINE, zOrder, isBackground, isSelected, isSelectable);
}
//+------------------------------------------------------------------+

void createT3P5VLine(datetime pDateTime) {

   long zOrder = 0;
   bool isBackground = false;
   bool isSelected = false;
   bool isSelectable = true;

   t3p5DateTime = pDateTime;
   t3p5ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p5DateTime));
   t3p5ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p5DateTime));

   createVLine(T3_P5_VLINE, t3p5DateTime, InpT3VLineColor, 2, STYLE_SOLID, T3_P5_VLINE, zOrder, isBackground, isSelected, isSelectable);
}
//+------------------------------------------------------------------+
