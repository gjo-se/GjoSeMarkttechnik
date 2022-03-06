//+------------------------------------------------------------------+
//|                                     T4HandleIndicatorsAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

void handleT4Indictaors() {

   int subWindow = 0;

   if(InpT4trailingStopMATimeframe == Period()
         && t4ProfitLevelGreaterMinProfitFiboRetracmentLevel == true
     ){
            int bufferNumber = 0;
            int start = 0;
            int toCopy = 1;
            
            if(t4TrailingStopMAHandle00 != 0 && t4TrailingStopMAActive >= t4TrailingStopMAPeriod00){
                CopyBuffer(t4TrailingStopMAHandle00, bufferNumber, start, toCopy, t4TrailingStopMABuffer00);
                if(t4TrailingStopMAActive == t4TrailingStopMAPeriod00) t4TrailingStopMALevel = t4TrailingStopMABuffer00[0];
            }

            if(t4TrailingStopMAHandle01 != 0 && t4TrailingStopMAActive >= t4TrailingStopMAPeriod01){
                CopyBuffer(t4TrailingStopMAHandle01, bufferNumber, start, toCopy, t4TrailingStopMABuffer01);
                if(t4trendDirection == TREND_DIRECTION_LONG && t4TrailingStopMABuffer01[0] != 0 && Bid() - (InpT4TrailingStopMAMaxOffset * Point()) > t4TrailingStopMABuffer01[0]) t4TrailingStopMAActive = t4TrailingStopMAPeriod01;
                if(t4trendDirection == TREND_DIRECTION_SHORT && t4TrailingStopMABuffer01[0] != 0 && Bid() + (InpT4TrailingStopMAMaxOffset * Point()) < t4TrailingStopMABuffer01[0]) t4TrailingStopMAActive = t4TrailingStopMAPeriod01;
                if(t4TrailingStopMAActive == t4TrailingStopMAPeriod01) t4TrailingStopMALevel = t4TrailingStopMABuffer01[0];
            }

            if(t4TrailingStopMAHandle02 != 0 && t4TrailingStopMAActive >= t4TrailingStopMAPeriod02){
                CopyBuffer(t4TrailingStopMAHandle02, bufferNumber, start, toCopy, t4TrailingStopMABuffer02);
                if(t4trendDirection == TREND_DIRECTION_LONG && t4TrailingStopMABuffer02[0] != 0 && Bid() - (InpT4TrailingStopMAMaxOffset * Point()) > t4TrailingStopMABuffer02[0]) t4TrailingStopMAActive = t4TrailingStopMAPeriod02;
                if(t4trendDirection == TREND_DIRECTION_SHORT && t4TrailingStopMABuffer02[0] != 0 && Bid() + (InpT4TrailingStopMAMaxOffset * Point()) < t4TrailingStopMABuffer02[0]) t4TrailingStopMAActive = t4TrailingStopMAPeriod02;
                if(t4TrailingStopMAActive == t4TrailingStopMAPeriod02) t4TrailingStopMALevel = t4TrailingStopMABuffer02[0];
            }

            if(t4TrailingStopMAHandle03 != 0 && t4TrailingStopMAActive >= t4TrailingStopMAPeriod03){
                CopyBuffer(t4TrailingStopMAHandle03, bufferNumber, start, toCopy, t4TrailingStopMABuffer03);
                if(t4trendDirection == TREND_DIRECTION_LONG && t4TrailingStopMABuffer03[0] != 0 && Bid() - (InpT4TrailingStopMAMaxOffset * Point()) > t4TrailingStopMABuffer03[0]) t4TrailingStopMAActive = t4TrailingStopMAPeriod03;
                if(t4trendDirection == TREND_DIRECTION_SHORT && t4TrailingStopMABuffer03[0] != 0 && Bid() + (InpT4TrailingStopMAMaxOffset * Point()) < t4TrailingStopMABuffer03[0]) t4TrailingStopMAActive = t4TrailingStopMAPeriod03;
                if(t4TrailingStopMAActive == t4TrailingStopMAPeriod03) t4TrailingStopMALevel = t4TrailingStopMABuffer03[0];
            }

            if(t4TrailingStopMAHandle04 != 0 && t4TrailingStopMAActive >= t4TrailingStopMAPeriod04){
                CopyBuffer(t4TrailingStopMAHandle04, bufferNumber, start, toCopy, t4TrailingStopMABuffer04);
                if(t4trendDirection == TREND_DIRECTION_LONG && t4TrailingStopMABuffer04[0] != 0 && Bid() - (InpT4TrailingStopMAMaxOffset * Point()) > t4TrailingStopMABuffer04[0]) t4TrailingStopMAActive = t4TrailingStopMAPeriod04;
                if(t4trendDirection == TREND_DIRECTION_SHORT && t4TrailingStopMABuffer04[0] != 0 && Bid() + (InpT4TrailingStopMAMaxOffset * Point()) < t4TrailingStopMABuffer04[0]) t4TrailingStopMAActive = t4TrailingStopMAPeriod04;
                if(t4TrailingStopMAActive == t4TrailingStopMAPeriod04) t4TrailingStopMALevel = t4TrailingStopMABuffer04[0];
            }

            if(t4TrailingStopMAHandle05 != 0 && t4TrailingStopMAActive >= t4TrailingStopMAPeriod05){
                CopyBuffer(t4TrailingStopMAHandle05, bufferNumber, start, toCopy, t4TrailingStopMABuffer05);
                if(t4trendDirection == TREND_DIRECTION_LONG && t4TrailingStopMABuffer05[0] != 0 && Bid() - (InpT4TrailingStopMAMaxOffset * Point()) > t4TrailingStopMABuffer05[0]) t4TrailingStopMAActive = t4TrailingStopMAPeriod05;
                if(t4trendDirection == TREND_DIRECTION_SHORT && t4TrailingStopMABuffer05[0] != 0 && Bid() + (InpT4TrailingStopMAMaxOffset * Point()) < t4TrailingStopMABuffer05[0]) t4TrailingStopMAActive = t4TrailingStopMAPeriod05;
                if(t4TrailingStopMAActive == t4TrailingStopMAPeriod05) t4TrailingStopMALevel = t4TrailingStopMABuffer05[0];
            }
     }

}
//+------------------------------------------------------------------+
