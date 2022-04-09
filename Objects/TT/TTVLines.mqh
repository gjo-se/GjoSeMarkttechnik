//+------------------------------------------------------------------+
//|                                            RegressionChannel.mqh |
//|                                       Copyright 2021, Gregory Jo |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void setTT3LineValues() {
   setTT3VLineDateTimes();
   setTT3VLineValues();
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void setTT3VLineDateTimes() {
   if(ObjectFind(ChartID(), TT3_P1_VLINE) >= 0) {
      tt3p1DateTime = (datetime)ObjectGetInteger(ChartID(), TT3_P1_VLINE, OBJPROP_TIME);
      setTT3VLineStyles(TT3_P1_VLINE);
   } else {
      tt3p1DateTime = 0;
   }
   if(ObjectFind(ChartID(), TT3_P2_VLINE) >= 0) {
      tt3p2DateTime = (datetime)ObjectGetInteger(ChartID(), TT3_P2_VLINE, OBJPROP_TIME);
      setTT3VLineStyles(TT3_P2_VLINE);
   } else {
      tt3p2DateTime = 0;
   }
   if(ObjectFind(ChartID(), TT3_P3_VLINE) >= 0) {
      tt3p3DateTime = (datetime)ObjectGetInteger(ChartID(), TT3_P3_VLINE, OBJPROP_TIME);
      setTT3VLineStyles(TT3_P3_VLINE);
   } else {
      tt3p3DateTime = 0;
   }
   if(ObjectFind(ChartID(), TT3_P4_VLINE) >= 0) {
      tt3p4DateTime = (datetime)ObjectGetInteger(ChartID(), TT3_P4_VLINE, OBJPROP_TIME);
      setTT3VLineStyles(TT3_P4_VLINE);
   } else {
      tt3p4DateTime = 0;
   }
   if(ObjectFind(ChartID(), TT3_P5_VLINE) >= 0) {
      tt3p5DateTime = (datetime)ObjectGetInteger(ChartID(), TT3_P5_VLINE, OBJPROP_TIME);
      setTT3VLineStyles(TT3_P5_VLINE);
   } else {
      tt3p5DateTime = 0;
   }
   if(ObjectFind(ChartID(), TT3_P6_VLINE) >= 0) {
      tt3p6DateTime = (datetime)ObjectGetInteger(ChartID(), TT3_P6_VLINE, OBJPROP_TIME);
      setTT3VLineStyles(TT3_P6_VLINE);
   } else {
      tt3p6DateTime = 0;
   }
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

void setTT3VLineStyles(const string pLineName) {
      ObjectSetInteger(ChartID(), pLineName, OBJPROP_WIDTH, InpT3LineWidth);
      ObjectSetInteger(ChartID(), pLineName, OBJPROP_STYLE, InpT3LineStyle);
      ObjectSetInteger(ChartID(), pLineName, OBJPROP_COLOR, InpT3VLineColor);
      ObjectSetInteger(ChartID(), pLineName, OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void setTT4LineValues() {
   setTT4VLineDateTimes();
   setTT4VLineValues();
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void setTT4VLineDateTimes() {
   if(ObjectFind(ChartID(), TT4_P1_VLINE) >= 0) {
      tt4p1DateTime = (datetime)ObjectGetInteger(ChartID(), TT4_P1_VLINE, OBJPROP_TIME);
      setTT4VLineStyles(TT4_P1_VLINE);
   } else {
      tt4p1DateTime = 0;
   }
   if(ObjectFind(ChartID(), TT4_P2_VLINE) >= 0) {
      tt4p2DateTime = (datetime)ObjectGetInteger(ChartID(), TT4_P2_VLINE, OBJPROP_TIME);
      setTT4VLineStyles(TT4_P2_VLINE);
   } else {
      tt4p2DateTime = 0;
   }
   if(ObjectFind(ChartID(), TT4_P3_VLINE) >= 0) {
      tt4p3DateTime = (datetime)ObjectGetInteger(ChartID(), TT4_P3_VLINE, OBJPROP_TIME);
      setTT4VLineStyles(TT4_P3_VLINE);
   } else {
      tt4p3DateTime = 0;
   }
   if(ObjectFind(ChartID(), TT4_P4_VLINE) >= 0) {
      tt4p4DateTime = (datetime)ObjectGetInteger(ChartID(), TT4_P4_VLINE, OBJPROP_TIME);
      setTT4VLineStyles(TT4_P4_VLINE);
   } else {
      tt4p4DateTime = 0;
   }
   if(ObjectFind(ChartID(), TT4_P5_VLINE) >= 0) {
      tt4p5DateTime = (datetime)ObjectGetInteger(ChartID(), TT4_P5_VLINE, OBJPROP_TIME);
      setTT4VLineStyles(TT4_P5_VLINE);
   } else {
      tt4p5DateTime = 0;
   }
   if(ObjectFind(ChartID(), TT4_P6_VLINE) >= 0) {
      tt4p6DateTime = (datetime)ObjectGetInteger(ChartID(), TT4_P6_VLINE, OBJPROP_TIME);
      setTT4VLineStyles(TT4_P6_VLINE);
   } else {
      tt4p6DateTime = 0;
   }
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

void setTT4VLineStyles(const string pLineName) {
      ObjectSetInteger(ChartID(), pLineName, OBJPROP_WIDTH, InpT4LineWidth);
      ObjectSetInteger(ChartID(), pLineName, OBJPROP_STYLE, InpT4LineStyle);
      ObjectSetInteger(ChartID(), pLineName, OBJPROP_COLOR, InpT4VLineColor);
      ObjectSetInteger(ChartID(), pLineName, OBJPROP_TIMEFRAMES, InpT4VisibleTimeframes);
}