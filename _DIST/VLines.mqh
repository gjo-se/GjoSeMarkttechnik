//+------------------------------------------------------------------+
//|                                            RegressionChannel.mqh |
//|                                       Copyright 2021, Gregory Jo |
//+------------------------------------------------------------------+

//void createT3HighestHighVLine() {
//
//   long zOrder = 0;
//   bool isBackground = true;
//   bool isSelected = false;
//   bool isSelectable = true;
//
//   int barShift = 0;
//   createVLine(T3_HH_VLINE, iTime(Symbol(), Period(), barShift), clrRed, 2, STYLE_SOLID, T3_HH_VLINE, zOrder, isBackground, isSelected, isSelectable);
//
//   t3HighestHighVLineDateTime = iTime(Symbol(), Period(), barShift);
//}
//
//void createT3LowestLowVLine() {
//
//   long zOrder = 0;
//   bool isBackground = true;
//   bool isSelected = false;
//   bool isSelectable = true;
//
//   int barShift = 0;
//   createVLine(T3_LL_VLINE, iTime(Symbol(), Period(), barShift), clrRed, 2, STYLE_SOLID, T3_LL_VLINE, zOrder, isBackground, isSelected, isSelectable);
//
//   t3LowestLowVLineDateTime = iTime(Symbol(), Period(), barShift);
//}