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
void setT2VLineStyles(const string pSubString = "T2-") {

   int objectsTotal = ObjectsTotal(ChartID(), 0, -1);
   string objName;

   for(int i = objectsTotal; i >= 0; i--) {
      objName = ObjectName(ChartID(), i);
      if(ObjectGetInteger(ChartID(), objName, OBJPROP_TYPE) == OBJ_VLINE
            && StringFind(objName, pSubString) != -1
        ) {
         ObjectSetInteger(ChartID(), objName, OBJPROP_WIDTH, InpT2LineWidth);
         ObjectSetInteger(ChartID(), objName, OBJPROP_STYLE, InpT2LineStyle);
         ObjectSetInteger(ChartID(), objName, OBJPROP_COLOR, InpT2VLineColor);
         ObjectSetInteger(ChartID(), objName, OBJPROP_BACK, true);
         ObjectSetInteger(ChartID(), objName, OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);
      }
   }
}

void createT2P1VLine(const datetime pDateTime, const string pObjName = "") {

   long zOrder = 0;
   bool isBackground = true;
   bool isSelected = true;
   bool isSelectable = true;
   string objName = T2_P1_VLINE;

   t2p1DateTime = pDateTime;
   t2p1ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t2p1DateTime));
   t2p1ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t2p1DateTime));

   if(pObjName == objName + " T3-P1") {
      objName = pObjName;
      t3p1DateTime = pDateTime;
      t3p1ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p1DateTime));
      t3p1ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p1DateTime));
   }
   if(pObjName == objName + " T4-P1") {
      objName = pObjName;
      t4p1DateTime = pDateTime;
      t4p1ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p1DateTime));
      t4p1ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p1DateTime));
   }

   createVLine(objName, t2p1DateTime, InpT2VLineColor, InpT2LineWidth, InpT2LineStyle, objName, zOrder, isBackground, isSelected, isSelectable);
   ObjectSetInteger(ChartID(), objName, OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);
}

void createT2P2VLine(const datetime pDateTime, const string pObjName = "") {

   long zOrder = 0;
   bool isBackground = true;
   bool isSelected = true;
   bool isSelectable = true;
   string objName = T2_P2_VLINE;

   t2p2DateTime = pDateTime;
   t2p2ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t2p2DateTime));
   t2p2ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t2p2DateTime));

   if(pObjName == objName + " T3-P1") {
      objName = pObjName;
      t3p1DateTime = pDateTime;
      t3p1ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p1DateTime));
      t3p1ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p1DateTime));
   }
   if(pObjName == objName + " T4-P1") {
      objName = pObjName;
      t4p1DateTime = pDateTime;
      t4p1ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p1DateTime));
      t4p1ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p1DateTime));
   }

   createVLine(objName, t2p2DateTime, InpT2VLineColor, InpT2LineWidth, InpT2LineStyle, objName, zOrder, isBackground, isSelected, isSelectable);
   ObjectSetInteger(ChartID(), objName, OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);
}

void createT2P3VLine(const datetime pDateTime, const string pObjName = "") {

   long zOrder = 0;
   bool isBackground = true;
   bool isSelected = true;
   bool isSelectable = true;
   string objName = T2_P3_VLINE;

   t2p3DateTime = pDateTime;
   t2p3ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t2p3DateTime));
   t2p3ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t2p3DateTime));

   if(pObjName == objName + " T3-P1") {
      objName = pObjName;
      t3p1DateTime = pDateTime;
      t3p1ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p1DateTime));
      t3p1ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p1DateTime));
   }
   if(pObjName == objName + " T4-P1") {
      objName = pObjName;
      t4p1DateTime = pDateTime;
      t4p1ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p1DateTime));
      t4p1ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p1DateTime));
   }

   createVLine(objName, t2p3DateTime, InpT2VLineColor, InpT2LineWidth, InpT2LineStyle, objName, zOrder, isBackground, isSelected, isSelectable);
   ObjectSetInteger(ChartID(), objName, OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);
}

void createT2P4VLine(const datetime pDateTime, const string pObjName = "") {

   long zOrder = 0;
   bool isBackground = true;
   bool isSelected = false;
   bool isSelectable = true;
   string objName = T2_P4_VLINE;

   t2p4DateTime = pDateTime;
   t2p4ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t2p4DateTime));
   t2p4ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t2p4DateTime));

   if(pObjName == objName + " T3-P1") {
      objName = pObjName;
      t3p1DateTime = pDateTime;
      t3p1ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p1DateTime));
      t3p1ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p1DateTime));
   }
   if(pObjName == objName + " T4-P1") {
      objName = pObjName;
      t4p1DateTime = pDateTime;
      t4p1ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p1DateTime));
      t4p1ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p1DateTime));
   }

   createVLine(objName, t2p4DateTime, InpT2VLineColor, InpT2LineWidth, InpT2LineStyle, objName, zOrder, isBackground, isSelected, isSelectable);
   ObjectSetInteger(ChartID(), objName, OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);
}
//+------------------------------------------------------------------+

void createT2P5VLine(const datetime pDateTime, const string pObjName = "") {

   long zOrder = 0;
   bool isBackground = true;
   bool isSelected = false;
   bool isSelectable = true;
   string objName = T2_P5_VLINE;

   t2p5DateTime = pDateTime;
   t2p5ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t2p5DateTime));
   t2p5ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t2p5DateTime));

   if(pObjName == objName + " T3-P1") {
      objName = pObjName;
      t3p1DateTime = pDateTime;
      t3p1ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p1DateTime));
      t3p1ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p1DateTime));
   }
   if(pObjName == objName + " T4-P1") {
      objName = pObjName;
      t4p1DateTime = pDateTime;
      t4p1ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p1DateTime));
      t4p1ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t4p1DateTime));
   }

   createVLine(objName, t2p5DateTime, InpT2VLineColor, InpT2LineWidth, InpT2LineStyle, objName, zOrder, isBackground, isSelected, isSelectable);
   ObjectSetInteger(ChartID(), objName, OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);
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
