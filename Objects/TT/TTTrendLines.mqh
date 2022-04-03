//+------------------------------------------------------------------+
//|                                                   TrendLines.mqh |
//|                                       Copyright 2022, Gregory Jo |
//+------------------------------------------------------------------+



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void createTT3TrendLines() {

   color lineColor = InpT3TrendLineColor;

   if(tt3p1DateTime != 0 && tt3p2DateTime != 0) createTrendLine(TT3_TRENDLINE + "P1-P2", tt3p1DateTime, getTT3P1HighLowValueByTrendDirection(), tt3p2DateTime, getTT3P2HighLowValueByTrendDirection(), lineColor, 2);
   if(tt3p2DateTime != 0 && tt3p3DateTime != 0) createTrendLine(TT3_TRENDLINE + "P2-P3", tt3p2DateTime, getTT3P2HighLowValueByTrendDirection(), tt3p3DateTime, getTT3P3HighLowValueByTrendDirection(), lineColor, 2);
   if(tt3p3DateTime != 0 && tt3p4DateTime != 0) createTrendLine(TT3_TRENDLINE + "P3-P4", tt3p3DateTime, getTT3P3HighLowValueByTrendDirection(), tt3p4DateTime, getTT3P4HighLowValueByTrendDirection(), lineColor, 2);
   if(tt3p4DateTime != 0 && tt3p5DateTime != 0) createTrendLine(TT3_TRENDLINE + "P4-P5", tt3p4DateTime, getTT3P4HighLowValueByTrendDirection(), tt3p5DateTime, getTT3P5HighLowValueByTrendDirection(), lineColor, 2);
   if(tt3p5DateTime != 0 && tt3p6DateTime != 0) createTrendLine(TT3_TRENDLINE + "P5-P6", tt3p5DateTime, getTT3P5HighLowValueByTrendDirection(), tt3p6DateTime, getTT3P6HighLowValueByTrendDirection(), lineColor, 2);
}

void createTT4TrendLines() {

   color lineColor = InpT4TrendLineColor;

   if(tt4p1DateTime != 0 && tt4p2DateTime != 0) createTrendLine(TT4_TRENDLINE + "P1-P2", tt4p1DateTime, getTT4P1HighLowValueByTrendDirection(), tt4p2DateTime, getTT4P2HighLowValueByTrendDirection(), lineColor, 2);
   if(tt4p2DateTime != 0 && tt4p3DateTime != 0) createTrendLine(TT4_TRENDLINE + "P2-P3", tt4p2DateTime, getTT4P2HighLowValueByTrendDirection(), tt4p3DateTime, getTT4P3HighLowValueByTrendDirection(), lineColor, 2);
   if(tt4p3DateTime != 0 && tt4p4DateTime != 0) createTrendLine(TT4_TRENDLINE + "P3-P4", tt4p3DateTime, getTT4P3HighLowValueByTrendDirection(), tt4p4DateTime, getTT4P4HighLowValueByTrendDirection(), lineColor, 2);
   if(tt4p4DateTime != 0 && tt4p5DateTime != 0) createTrendLine(TT4_TRENDLINE + "P4-P5", tt4p4DateTime, getTT4P4HighLowValueByTrendDirection(), tt4p5DateTime, getTT4P5HighLowValueByTrendDirection(), lineColor, 2);
   if(tt4p5DateTime != 0 && tt4p6DateTime != 0) createTrendLine(TT4_TRENDLINE + "P5-P6", tt4p5DateTime, getTT4P5HighLowValueByTrendDirection(), tt4p6DateTime, getTT4P6HighLowValueByTrendDirection(), lineColor, 2);
}
//+------------------------------------------------------------------+
