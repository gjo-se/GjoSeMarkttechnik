//+------------------------------------------------------------------+
//|                                            RegressionChannel.mqh |
//|                                       Copyright 2021, Gregory Jo |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

void setLineValues(){
    setT3VLineValues();
}

void setT3VLineValues() {
   t3StartDateTime = getVlineDatetimeByText(T3_START_VLINE);

   t3p1DateTime = getVlineDatetimeByText(T3_P1_VLINE);
   t3p1ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p1DateTime));
   t3p1ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p1DateTime));

   t3p2DateTime = getVlineDatetimeByText(T3_P2_VLINE);
   t3p2ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p2DateTime));
   t3p2ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p2DateTime));

   t3p3DateTime = getVlineDatetimeByText(T3_P3_VLINE);
   t3p3ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p3DateTime));
   t3p3ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p3DateTime));

   t3p4DateTime = getVlineDatetimeByText(T3_P4_VLINE);
   t3p4ValueHigh = iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p4DateTime));
   t3p4ValueLow = iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3p4DateTime));

   t3HhDateTime = getVlineDatetimeByText(T3_HH_VLINE);
   t3EndDateTime = getVlineDatetimeByText(T3_END_VLINE);

}

void createT3HighestHighVLine(){

    int barShift = 0;
    createVLine(T3_HH_VLINE, iTime(Symbol(), Period(), barShift), clrRed, 2, STYLE_SOLID, T3_HH_VLINE);

    t3HhDateTime = iTime(Symbol(), Period(), barShift);
}