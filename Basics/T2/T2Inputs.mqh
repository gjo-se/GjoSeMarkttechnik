//+------------------------------------------------------------------+
//|                                                     T3Inputs.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

// ****************  INTERN **************** //

//input group             "---------- T3 Object-Styles ---------"
int               InpT2LineWidth = 4;
ENUM_LINE_STYLE   InpT2LineStyle = STYLE_SOLID;
int               InpT2VisibleTimeframes = OBJ_PERIOD_H1|OBJ_PERIOD_M10;

color             InpT2DefaultColor = clrTomato;
color             InpT2InvisibleColor = clrWhite;
color             InpT2VLineColor = clrPeachPuff;
color             InpT2TLineZigZagTrendLongColor = clrGreen;
color             InpT2TLineZigZagTrendShortColor = clrRed;

