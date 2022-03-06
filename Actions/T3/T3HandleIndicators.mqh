//+------------------------------------------------------------------+
//|                                       HandleIndicatorsAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

void handleT3Indictaors() {

   if(InpT3trailingStopMATimeframe == Period()
         && t3ProfitLevelGreaterMinProfitFiboRetracmentLevel == true
     ) {
      int bufferNumber = 0;
      int start = 0;
      int toCopy = 1;

      if(t3TrailingStopMAHandle00 != 0 && t3TrailingStopMAActive >= t3TrailingStopMAPeriod00) {
         CopyBuffer(t3TrailingStopMAHandle00, bufferNumber, start, toCopy, t3TrailingStopMABuffer00);
         if(t3TrailingStopMAActive == t3TrailingStopMAPeriod00) t3TrailingStopMALevel = t3TrailingStopMABuffer00[0];
      }

      if(t3TrailingStopMAHandle01 != 0 && t3TrailingStopMAActive >= t3TrailingStopMAPeriod01) {
         CopyBuffer(t3TrailingStopMAHandle01, bufferNumber, start, toCopy, t3TrailingStopMABuffer01);
         if(t3trendDirection == TREND_DIRECTION_LONG && t3TrailingStopMABuffer01[0] != 0 && Bid() - (InpT3TrailingStopMAMaxOffset * Point()) > t3TrailingStopMABuffer01[0]) t3TrailingStopMAActive = t3TrailingStopMAPeriod01;
         if(t3trendDirection == TREND_DIRECTION_SHORT && t3TrailingStopMABuffer01[0] != 0 && Bid() + (InpT3TrailingStopMAMaxOffset * Point()) < t3TrailingStopMABuffer01[0]) t3TrailingStopMAActive = t3TrailingStopMAPeriod01;
         if(t3TrailingStopMAActive == t3TrailingStopMAPeriod01) t3TrailingStopMALevel = t3TrailingStopMABuffer01[0];
      }

      if(t3TrailingStopMAHandle02 != 0 && t3TrailingStopMAActive >= t3TrailingStopMAPeriod02) {
         CopyBuffer(t3TrailingStopMAHandle02, bufferNumber, start, toCopy, t3TrailingStopMABuffer02);
         if(t3trendDirection == TREND_DIRECTION_LONG && t3TrailingStopMABuffer02[0] != 0 && Bid() - (InpT3TrailingStopMAMaxOffset * Point()) > t3TrailingStopMABuffer02[0]) t3TrailingStopMAActive = t3TrailingStopMAPeriod02;
         if(t3trendDirection == TREND_DIRECTION_SHORT && t3TrailingStopMABuffer02[0] != 0 && Bid() + (InpT3TrailingStopMAMaxOffset * Point()) < t3TrailingStopMABuffer02[0]) t3TrailingStopMAActive = t3TrailingStopMAPeriod02;
         if(t3TrailingStopMAActive == t3TrailingStopMAPeriod02) t3TrailingStopMALevel = t3TrailingStopMABuffer02[0];
      }

      if(t3TrailingStopMAHandle03 != 0 && t3TrailingStopMAActive >= t3TrailingStopMAPeriod03) {
         CopyBuffer(t3TrailingStopMAHandle03, bufferNumber, start, toCopy, t3TrailingStopMABuffer03);
         if(t3trendDirection == TREND_DIRECTION_LONG && t3TrailingStopMABuffer03[0] != 0 && Bid() - (InpT3TrailingStopMAMaxOffset * Point()) > t3TrailingStopMABuffer03[0]) t3TrailingStopMAActive = t3TrailingStopMAPeriod03;
         if(t3trendDirection == TREND_DIRECTION_SHORT && t3TrailingStopMABuffer03[0] != 0 && Bid() + (InpT3TrailingStopMAMaxOffset * Point()) < t3TrailingStopMABuffer03[0]) t3TrailingStopMAActive = t3TrailingStopMAPeriod03;
         if(t3TrailingStopMAActive == t3TrailingStopMAPeriod03) t3TrailingStopMALevel = t3TrailingStopMABuffer03[0];
      }

      if(t3TrailingStopMAHandle04 != 0 && t3TrailingStopMAActive >= t3TrailingStopMAPeriod04) {
         CopyBuffer(t3TrailingStopMAHandle04, bufferNumber, start, toCopy, t3TrailingStopMABuffer04);
         if(t3trendDirection == TREND_DIRECTION_LONG && t3TrailingStopMABuffer04[0] != 0 && Bid() - (InpT3TrailingStopMAMaxOffset * Point()) > t3TrailingStopMABuffer04[0]) t3TrailingStopMAActive = t3TrailingStopMAPeriod04;
         if(t3trendDirection == TREND_DIRECTION_SHORT && t3TrailingStopMABuffer04[0] != 0 && Bid() + (InpT3TrailingStopMAMaxOffset * Point()) < t3TrailingStopMABuffer04[0]) t3TrailingStopMAActive = t3TrailingStopMAPeriod04;
         if(t3TrailingStopMAActive == t3TrailingStopMAPeriod04) t3TrailingStopMALevel = t3TrailingStopMABuffer04[0];
      }

      if(t3TrailingStopMAHandle05 != 0 && t3TrailingStopMAActive >= t3TrailingStopMAPeriod05) {
         CopyBuffer(t3TrailingStopMAHandle05, bufferNumber, start, toCopy, t3TrailingStopMABuffer05);
         if(t3trendDirection == TREND_DIRECTION_LONG && t3TrailingStopMABuffer05[0] != 0 && Bid() - (InpT3TrailingStopMAMaxOffset * Point()) > t3TrailingStopMABuffer05[0]) t3TrailingStopMAActive = t3TrailingStopMAPeriod05;
         if(t3trendDirection == TREND_DIRECTION_SHORT && t3TrailingStopMABuffer05[0] != 0 && Bid() + (InpT3TrailingStopMAMaxOffset * Point()) < t3TrailingStopMABuffer05[0]) t3TrailingStopMAActive = t3TrailingStopMAPeriod05;
         if(t3TrailingStopMAActive == t3TrailingStopMAPeriod05) t3TrailingStopMALevel = t3TrailingStopMABuffer05[0];
      }
   }
}
//+------------------------------------------------------------------+
