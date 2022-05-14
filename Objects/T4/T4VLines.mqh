//+------------------------------------------------------------------+
//|                                                     T4VLines.mqh |
//|                                       Copyright 2021, Gregory Jo |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void setT4LineValues() {
   setT4VLineDateTimes();
   setT4VLineValues();
   setT4VLinesAlerts();
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void setT4VLineDateTimes() {
   t4StartDateTime = getVlineDatetimeByTextLike(T4_START_VLINE);
   t4p1DateTime = getVlineDatetimeByTextLike(T4_P1_VLINE);
   t4p2DateTime = getVlineDatetimeByTextLike(T4_P2_VLINE);
   t4p3DateTime = getVlineDatetimeByTextLike(T4_P3_VLINE);
   t4p4DateTime = getVlineDatetimeByTextLike(T4_P4_VLINE);
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

   if(t4p1DateTime != 0 && t4p2DateTime != 0) t4AlertT4VLineOn0Sended = false;
}

void setT4VLineStyles(const string pSubString = "T4-") {

   int objectsTotal = ObjectsTotal(ChartID(), 0, -1);
   string objName;

   for(int i = objectsTotal; i >= 0; i--) {
      objName = ObjectName(ChartID(), i);
      if(ObjectGetInteger(ChartID(), objName, OBJPROP_TYPE) == OBJ_VLINE
      && StringFind(objName, pSubString) != -1
      ) {
      ObjectSetInteger(ChartID(), objName, OBJPROP_WIDTH, InpT4LineWidth);
      ObjectSetInteger(ChartID(), objName, OBJPROP_STYLE, InpT4LineStyle);
      ObjectSetInteger(ChartID(), objName, OBJPROP_COLOR, InpT4VLineColor);
      ObjectSetInteger(ChartID(), objName, OBJPROP_BACK, true);
      ObjectSetInteger(ChartID(), objName, OBJPROP_TIMEFRAMES, InpT4VisibleTimeframes);
      }
   }          
}

void createT4P1VLine(datetime pDateTime) {

   long zOrder = 0;
   bool isBackground = true;
   bool isSelected = true;
   bool isSelectable = true;

   t4p1DateTime = pDateTime;
   t4p1ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p1DateTime));
   t4p1ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p1DateTime));

   createVLine(T4_P1_VLINE, t4p1DateTime, InpT4VLineColor, InpT4LineWidth, InpT4LineStyle, T4_P1_VLINE, zOrder, isBackground, isSelected, isSelectable);
   ObjectSetInteger(ChartID(), T4_P1_VLINE, OBJPROP_TIMEFRAMES, InpT4VisibleTimeframes);
}

void createT4P2VLine(datetime pDateTime) {

   long zOrder = 0;
   bool isBackground = true;
   bool isSelected = true;
   bool isSelectable = true;

   t4p2DateTime = pDateTime;
   t4p2ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p2DateTime));
   t4p2ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p2DateTime));

   createVLine(T4_P2_VLINE, t4p2DateTime, InpT4VLineColor, InpT4LineWidth, InpT4LineStyle, T4_P2_VLINE, zOrder, isBackground, isSelected, isSelectable);
   ObjectSetInteger(ChartID(), T4_P2_VLINE, OBJPROP_TIMEFRAMES, InpT4VisibleTimeframes);
}

void createT4P3VLine(datetime pDateTime) {

   long zOrder = 0;
   bool isBackground = true;
   bool isSelected = true;
   bool isSelectable = true;

   t4p3DateTime = pDateTime;
   t4p3ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p3DateTime));
   t4p3ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p3DateTime));

   createVLine(T4_P3_VLINE, t4p3DateTime, InpT4VLineColor, InpT4LineWidth, InpT4LineStyle, T4_P3_VLINE, zOrder, isBackground, isSelected, isSelectable);
   ObjectSetInteger(ChartID(), T4_P3_VLINE, OBJPROP_TIMEFRAMES, InpT4VisibleTimeframes);
}

void createT4P4VLine(datetime pDateTime) {

   long zOrder = 0;
   bool isBackground = true;
   bool isSelected = false;
   bool isSelectable = true;

   t4p4DateTime = pDateTime;
   t4p4ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p4DateTime));
   t4p4ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p4DateTime));

   createVLine(T4_P4_VLINE, t4p4DateTime, InpT4VLineColor, InpT4LineWidth, InpT4LineStyle, T4_P4_VLINE, zOrder, isBackground, isSelected, isSelectable);
   ObjectSetInteger(ChartID(), T4_P4_VLINE, OBJPROP_TIMEFRAMES, InpT4VisibleTimeframes);
}
//+------------------------------------------------------------------+

void setT4VLinesAlerts() {
   string errorText = "t4p1DateTime == 0";
   if(ObjectFind(ChartID(), T4_P1_VLINE) >= 0 && t4p1DateTime == 0) {
      if(t4AlertT4VLineOn0Sended == false) t4AlertT4VLineOn0Action();
      createErrorLabel(errorText);
   } else {
      deleteLabel(ERROR_LABEL + errorText);
   }

   errorText = "t4p2DateTime == 0";
   if(ObjectFind(ChartID(), T4_P2_VLINE) >= 0 && t4p2DateTime == 0) {
      if(t4AlertT4VLineOn0Sended == false) t4AlertT4VLineOn0Action();
      createErrorLabel(errorText);
   } else {
      deleteLabel(ERROR_LABEL + errorText);
   }

   if(t4p1DateTime != 0 && t4p2DateTime != 0) t4AlertT4VLineOn0Sended = false;
}