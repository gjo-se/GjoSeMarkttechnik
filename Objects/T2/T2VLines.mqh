//+------------------------------------------------------------------+
//|                                                     T2VLines.mqh |
//|                                       Copyright 2021, Gregory Jo |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void setT2LineValues() {
   setT2VLineDateTimes();
   setT2VLineValues();
   setT2VLineStyles();
   setT2VLinesAlerts();
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void setT2VLineDateTimes() {
   t2StartDateTime = getVlineDatetimeByTextLike(T2_START_VLINE);
   t2p1DateTime = getVlineDatetimeByTextLike(T2_P1_VLINE);
   t2p2DateTime = getVlineDatetimeByTextLike(T2_P2_VLINE);
   t2p3DateTime = getVlineDatetimeByTextLike(T2_P3_VLINE);
   t2p4DateTime = getVlineDatetimeByTextLike(T2_P4_VLINE);
   t2p5DateTime = getVlineDatetimeByTextLike(T2_P5_VLINE);
   t2EndDateTime = getVlineDatetimeByTextLike(T2_END_VLINE);
}

void setT2VLineValues() {

   if(t2p1DateTime != 0 && (int)t2p1DateTime < (int) TimeCurrent()) {
      t2p1ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t2p1DateTime));
      t2p1ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t2p1DateTime));
   } else {
      t2p1ValueHigh = 0;
      t2p1ValueLow = 0;
   }

   if(t2p2DateTime != 0 && (int)t2p2DateTime < (int) TimeCurrent()) {
      t2p2ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t2p2DateTime));
      t2p2ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t2p2DateTime));
   } else {
      t2p2ValueHigh = 0;
      t2p2ValueLow = 0;
   }

   if(t2p3DateTime != 0 && (int)t2p3DateTime < (int) TimeCurrent()) {
      t2p3ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t2p3DateTime));
      t2p3ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t2p3DateTime));
   } else {
      t2p3ValueHigh = 0;
      t2p3ValueLow = 0;
   }

   if(t2p4DateTime != 0 && (int)t2p4DateTime < (int) TimeCurrent()) {
      t2p4ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t2p4DateTime));
      t2p4ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t2p4DateTime));
   } else {
      t2p4ValueHigh = 0;
      t2p4ValueLow = 0;
   }

   if(t2p5DateTime != 0 && (int)t2p5DateTime < (int) TimeCurrent()) {
      t2p5ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t2p5DateTime));
      t2p5ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t2p5DateTime));
   } else {
      t2p5ValueHigh = 0;
      t2p5ValueLow = 0;
   }
}
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void setT2VLineStyles(const string pLineName = "T2-") {

   int objectsTotal = ObjectsTotal(ChartID(), 0, -1);
   string objName;

   for(int i = objectsTotal; i >= 0; i--) {
      objName = ObjectName(ChartID(), i);
      if(ObjectGetInteger(ChartID(), objName, OBJPROP_TYPE) == OBJ_VLINE) {
         ObjectSetInteger(ChartID(), pLineName, OBJPROP_WIDTH, InpT2LineWidth);
         ObjectSetInteger(ChartID(), pLineName, OBJPROP_STYLE, InpT2LineStyle);
         ObjectSetInteger(ChartID(), pLineName, OBJPROP_COLOR, InpT2VLineColor);
         ObjectSetInteger(ChartID(), pLineName, OBJPROP_BACK, true);
         ObjectSetInteger(ChartID(), pLineName, OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);
      }
   }
}

void createT2P1VLine(datetime pDateTime) {

   long zOrder = 0;
   bool isBackground = true;
   bool isSelected = true;
   bool isSelectable = true;

   t2p1DateTime = pDateTime;
   t2p1ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t2p1DateTime));
   t2p1ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t2p1DateTime));

   createVLine(T2_P1_VLINE, t2p1DateTime, InpT2VLineColor, InpT2LineWidth, InpT2LineStyle, T2_P1_VLINE, zOrder, isBackground, isSelected, isSelectable);
   ObjectSetInteger(ChartID(), T2_P1_VLINE, OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);
}

void createT2P2VLine(datetime pDateTime) {

   long zOrder = 0;
   bool isBackground = true;
   bool isSelected = true;
   bool isSelectable = true;

   t2p2DateTime = pDateTime;
   t2p2ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t2p2DateTime));
   t2p2ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t2p2DateTime));

   createVLine(T2_P2_VLINE, t2p2DateTime, InpT2VLineColor, InpT2LineWidth, InpT2LineStyle, T2_P2_VLINE, zOrder, isBackground, isSelected, isSelectable);
   ObjectSetInteger(ChartID(), T2_P2_VLINE, OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);
}

void createT2P3VLine(datetime pDateTime) {

   long zOrder = 0;
   bool isBackground = true;
   bool isSelected = true;
   bool isSelectable = true;

   t2p3DateTime = pDateTime;
   t2p3ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t2p3DateTime));
   t2p3ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t2p3DateTime));

   createVLine(T2_P3_VLINE, t2p3DateTime, InpT2VLineColor, InpT2LineWidth, InpT2LineStyle, T2_P3_VLINE, zOrder, isBackground, isSelected, isSelectable);
   ObjectSetInteger(ChartID(), T2_P3_VLINE, OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);
}

void createT2P4VLine(datetime pDateTime) {

   long zOrder = 0;
   bool isBackground = true;
   bool isSelected = false;
   bool isSelectable = true;

   t2p4DateTime = pDateTime;
   t2p4ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t2p4DateTime));
   t2p4ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t2p4DateTime));

   createVLine(T2_P4_VLINE, t2p4DateTime, InpT2VLineColor, InpT2LineWidth, InpT2LineStyle, T2_P4_VLINE, zOrder, isBackground, isSelected, isSelectable);
   ObjectSetInteger(ChartID(), T2_P4_VLINE, OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);
}
//+------------------------------------------------------------------+

void createT2P5VLine(datetime pDateTime) {

   long zOrder = 0;
   bool isBackground = true;
   bool isSelected = false;
   bool isSelectable = true;

   t2p5DateTime = pDateTime;
   t2p5ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t2p5DateTime));
   t2p5ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t2p5DateTime));

   createVLine(T2_P5_VLINE, t2p5DateTime, InpT2VLineColor, InpT2LineWidth, InpT2LineStyle, T2_P5_VLINE, zOrder, isBackground, isSelected, isSelectable);
   ObjectSetInteger(ChartID(), T2_P5_VLINE, OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);
}
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void setT2VLinesAlerts() {
   string errorText = "t2p1DateTime == 0";
   if(ObjectFind(ChartID(), T2_P1_VLINE) >= 0 && t2p1DateTime == 0) {
      if(t2AlertT2VLineOn0Sended == false) t2AlertT2VLineOn0Action();
      createErrorLabel(errorText);
   } else {
      deleteLabel(ERROR_LABEL + errorText);
   }

   errorText = "t2p2DateTime == 0";
   if(ObjectFind(ChartID(), T2_P2_VLINE) >= 0 && t2p2DateTime == 0) {
      if(t2AlertT2VLineOn0Sended == false) t2AlertT2VLineOn0Action();
      createErrorLabel(errorText);
   } else {
      deleteLabel(ERROR_LABEL + errorText);
   }

   if(t2p1DateTime != 0 && t2p2DateTime != 0) t2AlertT2VLineOn0Sended = false;
}
//+------------------------------------------------------------------+
