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
void setT4LineValues() {
    setT4VLineDateTimes();
   setT4VLineValues();
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

void setT4VLineDateTimes() {
   t4StartDateTime = getVlineDatetimeByText(T4_START_VLINE);
   t4p1DateTime = getVlineDatetimeByText(T4_P1_VLINE);
   t4p2DateTime = getVlineDatetimeByText(T4_P2_VLINE);
   t4p3DateTime = getVlineDatetimeByText(T4_P3_VLINE);
   t4p4DateTime = getVlineDatetimeByText(T4_P4_VLINE);
   t4HighestHighVLineDateTime = getVlineDatetimeByText(T4_HH_VLINE);
   t4LowestLowVLineDateTime = getVlineDatetimeByText(T4_LL_VLINE);
}

void setT4VLineValues() {

if((int)t4p1DateTime < (int) TimeCurrent()) {
   t4p1ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p1DateTime));
   t4p1ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p1DateTime));
}
   if((int)t4p2DateTime < (int) TimeCurrent()) {
   t4p2ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p2DateTime));
   t4p2ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p2DateTime));
   }
if((int)t4p3DateTime < (int) TimeCurrent()) {
   t4p3ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p3DateTime));
   t4p3ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p3DateTime));
   }
   if((int)t4p4DateTime < (int) TimeCurrent()) {
   t4p4ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p4DateTime));
   t4p4ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p4DateTime));
   }
}


//void setT4VLineValues() {
//   t4StartDateTime = getVlineDatetimeByText(T4_START_VLINE);
//
//   t4p1DateTime = getVlineDatetimeByText(T4_P1_VLINE);
//   t4p1ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p1DateTime));
//   t4p1ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p1DateTime));
//
//   t4p2DateTime = getVlineDatetimeByText(T4_P2_VLINE);
//   t4p2ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p2DateTime));
//   t4p2ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p2DateTime));
//
//   t4p3DateTime = getVlineDatetimeByText(T4_P3_VLINE);
//   t4p3ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p3DateTime));
//   t4p3ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p3DateTime));
//
//   t4p4DateTime = getVlineDatetimeByText(T4_P4_VLINE);
//   t4p4ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p4DateTime));
//   t4p4ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p4DateTime));
//
//   t4HighestHighVLineDateTime = getVlineDatetimeByText(T4_HH_VLINE);
//   t4LowestLowVLineDateTime = getVlineDatetimeByText(T4_LL_VLINE);
//   t4EndDateTime = getVlineDatetimeByText(T4_END_VLINE);
//
//   t4StartDateTime = getVlineDatetimeByText(T4_START_VLINE);
//   t4OKDateTime = getVlineDatetimeByText(T4_OK_VLINE);
//}

void createT4StartVLine() {

   int barShift = 0;
   t4StartDateTime = iTime(Symbol(), Period(), barShift);
   long zOrder = 0;
   bool isBackground = false;
   bool isSelected = false;
   bool isSelectable = true;

   createVLine(T4_START_VLINE, t4StartDateTime, InpT4TrendLineColor, 2, STYLE_SOLID, T4_START_VLINE, zOrder, isBackground, isSelected, isSelectable);
}

void createT4OKVLine() {

   int barShift = 0;
   t4OKDateTime = iTime(Symbol(), Period(), barShift);
   long zOrder = 0;
   bool isBackground = false;
   bool isSelected = false;
   bool isSelectable = true;

   createVLine(T4_OK_VLINE, t4OKDateTime, InpT4TrendLineColor, 2, STYLE_SOLID, T4_OK_VLINE, zOrder, isBackground, isSelected, isSelectable);
}
//+------------------------------------------------------------------+

void createT4HighestHighVLine() {

   long zOrder = 0;
   bool isBackground = false;
   bool isSelected = false;
   bool isSelectable = true;

   int barShift = 0;
   if((int)t4p4DateTime < (int) TimeCurrent()){
       createVLine(T4_HH_VLINE, iTime(Symbol(), Period(), barShift), InpT4TrendLineColor, 2, STYLE_SOLID, T4_HH_VLINE, zOrder, isBackground, isSelected, isSelectable);
       t4HighestHighVLineDateTime = iTime(Symbol(), Period(), barShift);

   }
}

void createT4LowestLowVLine() {

   long zOrder = 0;
   bool isBackground = false;
   bool isSelected = false;
   bool isSelectable = true;

   int barShift = 0;
   createVLine(T4_LL_VLINE, iTime(Symbol(), Period(), barShift), InpT4TrendLineColor, 2, STYLE_SOLID, T4_LL_VLINE, zOrder, isBackground, isSelected, isSelectable);

   t4LowestLowVLineDateTime = iTime(Symbol(), Period(), barShift);
}