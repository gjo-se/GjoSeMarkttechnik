//+------------------------------------------------------------------+
//|                                                     T3Inputs.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
input group             "---------------------------------------------------------------"
input group             "------------------------------ T2 -----------------------------"
input group             "---------------------------------------------------------------"

input group             "------------------------------ T2 HighVolume LEVELS ----------------------"
input double            InpTT2MaxHighVolumeAreaLevel = 0; // T2 Max HighVolume Area Level
input double            InpTT2MinHighVolumeAreaLevel = 0; // T2 Min HighVolume Area Level
// ****************  INTERN **************** //

//input group             "---------- T3 Object-Styles ---------"
int               InpT2LineWidth = 4;
ENUM_LINE_STYLE   InpT2LineStyle = STYLE_SOLID;
int               InpT2VisibleTimeframes = OBJ_PERIOD_H1|OBJ_PERIOD_M10;

color             InpT2DefaultColor = clrTomato;
color             InpT2LigthColor = clrWheat;
color             InpT2InvisibleColor = clrWhite;
color             InpT2VLineColor = clrPeachPuff;
color             InpT2TLineZigZagTrendLongColor = clrGreen;
color             InpT2TLineZigZagTrendShortColor = clrRed;

