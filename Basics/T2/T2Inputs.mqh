//+------------------------------------------------------------------+
//|                                                     T2Inputs.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
input group             "---------------------------------------------------------------"
input group             "------------------------------ T2 -----------------------------"
input group             "---------------------------------------------------------------"

input group             "------------------------------ T2 LEVELS ----------------------"
input int               InpT2MinMovementLengthBasedOnTT2MovementPercent = 66; // T2 MIN Movement % on Template
input int               InpT2MinRegressionLengthBasedOnTT2RegressionPercent = 66; // T2 MIN Regression % on Template

input group             "------------------------------ T2 HighVolume LEVELS ----------------------"

input double            InpT2MaxHighVolumeAreaLevel = 0; // T2 Max HighVolume Area Level
input double            InpT2MinHighVolumeAreaLevel = 0; // T2 Min HighVolume Area Level

// ****************  INTERN **************** //

//input group             "---------- T2 Object-Styles ---------"
int               InpT2LineWidth = 4;
ENUM_LINE_STYLE   InpT2LineStyle = STYLE_SOLID;
int               InpT2VisibleTimeframes = OBJ_PERIOD_H1|OBJ_PERIOD_M10;

color             InpT2DefaultColor = clrTomato;
color             InpT2LigthColor = clrWheat;
color             InpT2VLineColor = clrLightPink;
color             InpT2TLineZigZagTrendLongColor = clrGreen;
color             InpT2TLineZigZagTrendShortColor = clrRed;

string            InpT2FiboLevels = "25,50,75";
int               InpT2ChannelEndShift = 10; // T2 Anzahl Candles Offset RegressionChannel
