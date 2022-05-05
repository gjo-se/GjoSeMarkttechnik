//+------------------------------------------------------------------+
//|                                                     TTVLines.mqh |
//|                                       Copyright 2021, Gregory Jo |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void setTT2LineValues() {
   setTT2VLineDateTimes();
   setTT2VLineValues();
   setTT2VLineStyles();
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void setTT2VLineDateTimes() {
   tt2StartDateTime = getVlineDatetimeByTextLike(TT2_START_VLINE);
   tt2p1DateTime = getVlineDatetimeByTextLike(TT2_P1_VLINE);
   tt2p2DateTime = getVlineDatetimeByTextLike(TT2_P2_VLINE);
   tt2p3DateTime = getVlineDatetimeByTextLike(TT2_P3_VLINE);
   tt2p4DateTime = getVlineDatetimeByTextLike(TT2_P4_VLINE);
   tt2p5DateTime = getVlineDatetimeByTextLike(TT2_P5_VLINE);
   tt2p6DateTime = getVlineDatetimeByTextLike(TT2_P6_VLINE);
   tt2EndDateTime = getVlineDatetimeByTextLike(TT2_END_VLINE);
}

void setTT2VLineValues() {

   if(tt2p1DateTime != 0 && (int)tt2p1DateTime < (int) TimeCurrent()) {
      tt2p1ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt2p1DateTime));
      tt2p1ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt2p1DateTime));
   } else {
      tt2p1ValueHigh = 0;
      tt2p1ValueLow = 0;
   }

   if(tt2p2DateTime != 0 && (int)tt2p2DateTime < (int) TimeCurrent()) {
      tt2p2ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt2p2DateTime));
      tt2p2ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt2p2DateTime));
   } else {
      tt2p2ValueHigh = 0;
      tt2p2ValueLow = 0;
   }

   if(tt2p3DateTime != 0 && (int)tt2p3DateTime < (int) TimeCurrent()) {
      tt2p3ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt2p3DateTime));
      tt2p3ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt2p3DateTime));
   } else {
      tt2p3ValueHigh = 0;
      tt2p3ValueLow = 0;
   }

   if(tt2p4DateTime != 0 && (int)tt2p4DateTime < (int) TimeCurrent()) {
      tt2p4ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt2p4DateTime));
      tt2p4ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt2p4DateTime));
   } else {
      tt2p4ValueHigh = 0;
      tt2p4ValueLow = 0;
   }

   if(tt2p5DateTime != 0 && (int)tt2p5DateTime < (int) TimeCurrent()) {
      tt2p5ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt2p5DateTime));
      tt2p5ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt2p5DateTime));
   } else {
      tt2p5ValueHigh = 0;
      tt2p5ValueLow = 0;
   }

   if(tt2p6DateTime != 0 && (int)tt2p6DateTime < (int) TimeCurrent()) {
      tt2p6ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt2p6DateTime));
      tt2p6ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt2p6DateTime));
   } else {
      tt2p6ValueHigh = 0;
      tt2p6ValueLow = 0;
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void setTT2VLineStyles(const string pSubString = "TMP2-") {

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
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void setTT3LineValues() {
   setTT3VLineDateTimes();
   setTT3VLineValues();
   setTT3VLineStyles();
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void setTT3VLineDateTimes() {
   tt3StartDateTime = getVlineDatetimeByTextLike(TT3_START_VLINE);
   tt3p1DateTime = getVlineDatetimeByTextLike(TT3_P1_VLINE);
   tt3p2DateTime = getVlineDatetimeByTextLike(TT3_P2_VLINE);
   tt3p3DateTime = getVlineDatetimeByTextLike(TT3_P3_VLINE);
   tt3p4DateTime = getVlineDatetimeByTextLike(TT3_P4_VLINE);
   tt3p5DateTime = getVlineDatetimeByTextLike(TT3_P5_VLINE);
   tt3p6DateTime = getVlineDatetimeByTextLike(TT3_P6_VLINE);
   tt3EndDateTime = getVlineDatetimeByTextLike(TT3_END_VLINE);
}

void setTT3VLineValues() {

   if(tt3p1DateTime != 0 && (int)tt3p1DateTime < (int) TimeCurrent()) {
      tt3p1ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt3p1DateTime));
      tt3p1ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt3p1DateTime));
   } else {
      tt3p1ValueHigh = 0;
      tt3p1ValueLow = 0;
   }

   if(tt3p2DateTime != 0 && (int)tt3p2DateTime < (int) TimeCurrent()) {
      tt3p2ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt3p2DateTime));
      tt3p2ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt3p2DateTime));
   } else {
      tt3p2ValueHigh = 0;
      tt3p2ValueLow = 0;
   }

   if(tt3p3DateTime != 0 && (int)tt3p3DateTime < (int) TimeCurrent()) {
      tt3p3ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt3p3DateTime));
      tt3p3ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt3p3DateTime));
   } else {
      tt3p3ValueHigh = 0;
      tt3p3ValueLow = 0;
   }

   if(tt3p4DateTime != 0 && (int)tt3p4DateTime < (int) TimeCurrent()) {
      tt3p4ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt3p4DateTime));
      tt3p4ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt3p4DateTime));
   } else {
      tt3p4ValueHigh = 0;
      tt3p4ValueLow = 0;
   }

   if(tt3p5DateTime != 0 && (int)tt3p5DateTime < (int) TimeCurrent()) {
      tt3p5ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt3p5DateTime));
      tt3p5ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt3p5DateTime));
   } else {
      tt3p5ValueHigh = 0;
      tt3p5ValueLow = 0;
   }

   if(tt3p6DateTime != 0 && (int)tt3p6DateTime < (int) TimeCurrent()) {
      tt3p6ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt3p6DateTime));
      tt3p6ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt3p6DateTime));
   } else {
      tt3p6ValueHigh = 0;
      tt3p6ValueLow = 0;
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void setTT3VLineStyles(const string pSubString = "TMP3-") {
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

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void setTT4LineValues() {
   setTT4VLineDateTimes();
   setTT4VLineValues();
   setTT4VLineStyles();
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void setTT4VLineDateTimes() {
   tt4StartDateTime = getVlineDatetimeByTextLike(TT4_START_VLINE);
   tt4p1DateTime = getVlineDatetimeByTextLike(TT4_P1_VLINE);
   tt4p2DateTime = getVlineDatetimeByTextLike(TT4_P2_VLINE);
   tt4p3DateTime = getVlineDatetimeByTextLike(TT4_P3_VLINE);
   tt4p4DateTime = getVlineDatetimeByTextLike(TT4_P4_VLINE);
   tt4p5DateTime = getVlineDatetimeByTextLike(TT4_P5_VLINE);
   tt4p6DateTime = getVlineDatetimeByTextLike(TT4_P6_VLINE);
   tt4EndDateTime = getVlineDatetimeByTextLike(TT4_END_VLINE);
}

void setTT4VLineValues() {

   if(tt4p1DateTime != 0 && (int)tt4p1DateTime < (int) TimeCurrent()) {
      tt4p1ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt4p1DateTime));
      tt4p1ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt4p1DateTime));
   } else {
      tt4p1ValueHigh = 0;
      tt4p1ValueLow = 0;
   }

   if(tt4p2DateTime != 0 && (int)tt4p2DateTime < (int) TimeCurrent()) {
      tt4p2ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt4p2DateTime));
      tt4p2ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt4p2DateTime));
   } else {
      tt4p2ValueHigh = 0;
      tt4p2ValueLow = 0;
   }

   if(tt4p3DateTime != 0 && (int)tt4p3DateTime < (int) TimeCurrent()) {
      tt4p3ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt4p3DateTime));
      tt4p3ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt4p3DateTime));
   } else {
      tt4p3ValueHigh = 0;
      tt4p3ValueLow = 0;
   }

   if(tt4p4DateTime != 0 && (int)tt4p4DateTime < (int) TimeCurrent()) {
      tt4p4ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt4p4DateTime));
      tt4p4ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt4p4DateTime));
   } else {
      tt4p4ValueHigh = 0;
      tt4p4ValueLow = 0;
   }

   if(tt4p5DateTime != 0 && (int)tt4p5DateTime < (int) TimeCurrent()) {
      tt4p5ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt4p5DateTime));
      tt4p5ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt4p5DateTime));
   } else {
      tt4p5ValueHigh = 0;
      tt4p5ValueLow = 0;
   }

   if(tt4p6DateTime != 0 && (int)tt4p6DateTime < (int) TimeCurrent()) {
      tt4p6ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt4p6DateTime));
      tt4p6ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, tt4p6DateTime));
   } else {
      tt4p6ValueHigh = 0;
      tt4p6ValueLow = 0;
   }
}
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void setTT4VLineStyles(const string pSubString = "TMP4-") {
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
//+------------------------------------------------------------------+
