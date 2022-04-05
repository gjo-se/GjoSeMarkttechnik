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
   if(ObjectFind(ChartID(), T4_P1_VLINE) >= 0) {
      t4p1DateTime = (datetime)ObjectGetInteger(ChartID(), T4_P1_VLINE, OBJPROP_TIME);
      string errorText = "t4p1DateTime == 0";
      if(t4p1DateTime == 0){
            if(t4AlertT4VLineOn0Sended == false) t4AlertT4VLineOn0Action();
            createErrorLabel(errorText);
      }else{
            deleteLabel(ERROR_LABEL + errorText);
      }
   } else {
      t4p1DateTime = 0;
   }
   if(ObjectFind(ChartID(), T4_P2_VLINE) >= 0) {
      t4p2DateTime = (datetime)ObjectGetInteger(ChartID(), T4_P2_VLINE, OBJPROP_TIME);
      string errorText = "t4p2DateTime == 0";
      if(t4p2DateTime == 0){
            if(t4AlertT4VLineOn0Sended == false) t4AlertT4VLineOn0Action();
            createErrorLabel(errorText);
      }else{
            deleteLabel(ERROR_LABEL + errorText);
      }
   } else {
      t4p2DateTime = 0;
   }
   if(ObjectFind(ChartID(), T4_P3_VLINE) >= 0) {
      t4p3DateTime = (datetime)ObjectGetInteger(ChartID(), T4_P3_VLINE, OBJPROP_TIME);
   } else {
      t4p3DateTime = 0;
   }
   if(ObjectFind(ChartID(), T4_P4_VLINE) >= 0) {
      t4p4DateTime = (datetime)ObjectGetInteger(ChartID(), T4_P4_VLINE, OBJPROP_TIME);
   } else {
      t4p4DateTime = 0;
   }
   if(ObjectFind(ChartID(), T4_P5_VLINE) >= 0) {
      t4p5DateTime = (datetime)ObjectGetInteger(ChartID(), T4_P5_VLINE, OBJPROP_TIME);
   } else {
      t4p5DateTime = 0;
   }
   if(ObjectFind(ChartID(), T4_HH_VLINE) >= 0) {
      t4HighestHighVLineDateTime = (datetime)ObjectGetInteger(ChartID(), T4_HH_VLINE, OBJPROP_TIME);
   } else {
      t4HighestHighVLineDateTime = 0;
   }
   if(ObjectFind(ChartID(), T4_LL_VLINE) >= 0) {
      t4LowestLowVLineDateTime = (datetime)ObjectGetInteger(ChartID(), T4_LL_VLINE, OBJPROP_TIME);
   } else {
      t4LowestLowVLineDateTime = 0;
   }
}

void setT4VLineValues() {

   if(t4p1DateTime != 0 && (int)t4p1DateTime < (int) TimeCurrent()) {
      t4p1ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p1DateTime));
      t4p1ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p1DateTime));
   } else {
      t4p1ValueHigh = 0;
      t4p1ValueLow = 0;
   }

   if(t4p2DateTime != 0 && (int)t4p2DateTime < (int) TimeCurrent()) {
      t4p2ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p2DateTime));
      t4p2ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p2DateTime));
   } else {
      t4p2ValueHigh = 0;
      t4p2ValueLow = 0;
   }

   if(t4p3DateTime != 0 && (int)t4p3DateTime < (int) TimeCurrent()) {
      t4p3ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p3DateTime));
      t4p3ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p3DateTime));
   } else {
      t4p3ValueHigh = 0;
      t4p3ValueLow = 0;
   }

   if(t4p4DateTime != 0 && (int)t4p4DateTime < (int) TimeCurrent()) {
      t4p4ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p4DateTime));
      t4p4ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p4DateTime));
   } else {
      t4p4ValueHigh = 0;
      t4p4ValueLow = 0;
   }

   if(t4p5DateTime != 0 && (int)t4p5DateTime < (int) TimeCurrent()) {
      t4p5ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p5DateTime));
      t4p5ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p5DateTime));
   } else {
      t4p5ValueHigh = 0;
      t4p5ValueLow = 0;
   }

   if(t4p1DateTime != 0 && t4p2DateTime != 0) t4AlertT4VLineOn0Sended = false;
}

void createT4HighestHighVLine() {

   long zOrder = 0;
   bool isBackground = false;
   bool isSelected = false;
   bool isSelectable = true;

   int barShift = 0;
   createVLine(T4_HH_VLINE, iTime(Symbol(), Period(), barShift), InpT4TrendLineColor, 2, STYLE_SOLID, T4_HH_VLINE, zOrder, isBackground, isSelected, isSelectable);
   t4HighestHighVLineDateTime = iTime(Symbol(), Period(), barShift);
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

void createT4P1VLine(datetime pDateTime) {

   long zOrder = 0;
   bool isBackground = false;
   bool isSelected = true;
   bool isSelectable = true;

   t4p1DateTime = pDateTime;
   t4p1ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p1DateTime));
   t4p1ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p1DateTime));

   createVLine(T4_P1_VLINE, t4p1DateTime, clrGray, 2, STYLE_SOLID, T4_P1_VLINE, zOrder, isBackground, isSelected, isSelectable);
}

void createT4P2VLine(datetime pDateTime) {

   long zOrder = 0;
   bool isBackground = false;
   bool isSelected = true;
   bool isSelectable = true;

   t4p2DateTime = pDateTime;
   t4p2ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p2DateTime));
   t4p2ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p2DateTime));

   createVLine(T4_P2_VLINE, t4p2DateTime, clrGray, 2, STYLE_SOLID, T4_P2_VLINE, zOrder, isBackground, isSelected, isSelectable);
}

void createT4P3VLine(datetime pDateTime) {

   long zOrder = 0;
   bool isBackground = false;
   bool isSelected = true;
   bool isSelectable = true;

   t4p3DateTime = pDateTime;
   t4p3ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p3DateTime));
   t4p3ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p3DateTime));

   createVLine(T4_P3_VLINE, t4p3DateTime, clrGray, 2, STYLE_SOLID, T4_P3_VLINE, zOrder, isBackground, isSelected, isSelectable);
}

void createT4P4VLine(datetime pDateTime) {

   long zOrder = 0;
   bool isBackground = false;
   bool isSelected = false;
   bool isSelectable = true;

   t4p4DateTime = pDateTime;
   t4p4ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p4DateTime));
   t4p4ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p4DateTime));

   createVLine(T4_P4_VLINE, t4p4DateTime, clrGray, 2, STYLE_SOLID, T4_P4_VLINE, zOrder, isBackground, isSelected, isSelectable);
}
//+------------------------------------------------------------------+

void createT4P5VLine(datetime pDateTime) {

   long zOrder = 0;
   bool isBackground = false;
   bool isSelected = false;
   bool isSelectable = true;

   t4p5DateTime = pDateTime;
   t4p5ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p5DateTime));
   t4p5ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p5DateTime));

   createVLine(T4_P5_VLINE, t4p5DateTime, clrGray, 2, STYLE_SOLID, T4_P5_VLINE, zOrder, isBackground, isSelected, isSelectable);
}
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
