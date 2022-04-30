//+------------------------------------------------------------------+
//|                                                     T3VLines.mqh |
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
   setT3VLineStyles();
   setT3VLinesAlerts();
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void setT3VLineDateTimes() {
   t3StartDateTime = getVlineDatetimeByTextLike(T3_START_VLINE);
   t3p1DateTime = getVlineDatetimeByTextLike(T3_P1_VLINE);
   t3p2DateTime = getVlineDatetimeByTextLike(T3_P2_VLINE);
   t3p3DateTime = getVlineDatetimeByTextLike(T3_P3_VLINE);
   t3p4DateTime = getVlineDatetimeByTextLike(T3_P4_VLINE);
   t3p5DateTime = getVlineDatetimeByTextLike(T3_P5_VLINE);
   t3EndDateTime = getVlineDatetimeByTextLike(T3_END_VLINE);
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

   if(t3p1DateTime != 0 && t3p2DateTime != 0) t3AlertT3VLineOn0Sended = false;
}
//+------------------------------------------------------------------+

void setT3VLineStyles(const string pSubString = "T3-") {

   int objectsTotal = ObjectsTotal(ChartID(), 0, -1);
   string objName;

   for(int i = objectsTotal; i >= 0; i--) {
      objName = ObjectName(ChartID(), i);
      if(ObjectGetInteger(ChartID(), objName, OBJPROP_TYPE) == OBJ_VLINE
      && StringFind(objName, pSubString) != -1
      ) {
      ObjectSetInteger(ChartID(), objName, OBJPROP_WIDTH, InpT3LineWidth);
      ObjectSetInteger(ChartID(), objName, OBJPROP_STYLE, InpT3LineStyle);
      ObjectSetInteger(ChartID(), objName, OBJPROP_COLOR, InpT3VLineColor);
      ObjectSetInteger(ChartID(), objName, OBJPROP_BACK, true);
      ObjectSetInteger(ChartID(), objName, OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);
      }
   }      
}

void createT3P1VLine(datetime pDateTime) {

   long zOrder = 0;
   bool isBackground = true;
   bool isSelected = true;
   bool isSelectable = true;

   t3p1DateTime = pDateTime;
   t3p1ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p1DateTime));
   t3p1ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p1DateTime));

   createVLine(T3_P1_VLINE, t3p1DateTime, InpT3VLineColor, InpT3LineWidth, InpT3LineStyle, T3_P1_VLINE, zOrder, isBackground, isSelected, isSelectable);
   ObjectSetInteger(ChartID(), T3_P1_VLINE, OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);
}

void createT3P2VLine(datetime pDateTime) {

   long zOrder = 0;
   bool isBackground = true;
   bool isSelected = true;
   bool isSelectable = true;

   t3p2DateTime = pDateTime;
   t3p2ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p2DateTime));
   t3p2ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p2DateTime));

   createVLine(T3_P2_VLINE, t3p2DateTime, InpT3VLineColor, InpT3LineWidth, InpT3LineStyle, T3_P2_VLINE, zOrder, isBackground, isSelected, isSelectable);
   ObjectSetInteger(ChartID(), T3_P2_VLINE, OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);
}

void createT3P3VLine(datetime pDateTime) {

   long zOrder = 0;
   bool isBackground = true;
   bool isSelected = true;
   bool isSelectable = true;

   t3p3DateTime = pDateTime;
   t3p3ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p3DateTime));
   t3p3ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p3DateTime));

   createVLine(T3_P3_VLINE, t3p3DateTime, InpT3VLineColor, InpT3LineWidth, InpT3LineStyle, T3_P3_VLINE, zOrder, isBackground, isSelected, isSelectable);
   ObjectSetInteger(ChartID(), T3_P3_VLINE, OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);
}

void createT3P4VLine(datetime pDateTime) {

   long zOrder = 0;
   bool isBackground = true;
   bool isSelected = false;
   bool isSelectable = true;

   t3p4DateTime = pDateTime;
   t3p4ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p4DateTime));
   t3p4ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p4DateTime));

   createVLine(T3_P4_VLINE, t3p4DateTime, InpT3VLineColor, InpT3LineWidth, InpT3LineStyle, T3_P4_VLINE, zOrder, isBackground, isSelected, isSelectable);
   ObjectSetInteger(ChartID(), T3_P4_VLINE, OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);
}
//+------------------------------------------------------------------+

void createT3P5VLine(datetime pDateTime) {

   long zOrder = 0;
   bool isBackground = true;
   bool isSelected = false;
   bool isSelectable = true;

   t3p5DateTime = pDateTime;
   t3p5ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p5DateTime));
   t3p5ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p5DateTime));

   createVLine(T3_P5_VLINE, t3p5DateTime, InpT3VLineColor, InpT3LineWidth, InpT3LineStyle, T3_P5_VLINE, zOrder, isBackground, isSelected, isSelectable);
   ObjectSetInteger(ChartID(), T3_P5_VLINE, OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);
}
//+------------------------------------------------------------------+

void setT3VLinesAlerts() {
   string errorText = "t3p1DateTime == 0";
   if(ObjectFind(ChartID(), T3_P1_VLINE) >= 0 && t3p1DateTime == 0) {
      if(t3AlertT3VLineOn0Sended == false) t3AlertT3VLineOn0Action();
      createErrorLabel(errorText);
   } else {
      deleteLabel(ERROR_LABEL + errorText);
   }

   errorText = "t3p2DateTime == 0";
   if(ObjectFind(ChartID(), T3_P2_VLINE) >= 0 && t3p2DateTime == 0) {
      if(t3AlertT3VLineOn0Sended == false) t3AlertT3VLineOn0Action();
      createErrorLabel(errorText);
   } else {
      deleteLabel(ERROR_LABEL + errorText);
   }

   if(t3p1DateTime != 0 && t3p2DateTime != 0) t3AlertT3VLineOn0Sended = false;
}