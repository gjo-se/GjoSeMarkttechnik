//+------------------------------------------------------------------+
//|                                           HandleObjectAction.mqh |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
void handleObjectsAction() {



  if(ObjectFind(ChartID(), IS_TRADEABLE_BUTTON) < 0) {
     createIsTradeableButton();
  }

   if(InpT3ObjectsShow == true) {

      if(t3trendDirection == TREND_DIRECTION_LONG) {
         if(t3LowestLowValue != iLow(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3LowestLowDateTime))) {
            createT3LowestLowTrendLine();
            createT3LongEntryTrendLine();
         }
      }

      if(t3trendDirection == TREND_DIRECTION_SHORT) {
         if(t3HighestHighValue != iHigh(Symbol(), PERIOD_CURRENT, iBarShift(Symbol(), PERIOD_CURRENT, t3HighestHighDateTime))) {
            createT3HighestHighTrendLine();
            createT3ShortEntryTrendLine();
         }
      }

      if(isNewCurrentBar == true || objectHasChanged == true) {
         if(Period() <= InpT3MaxTimeframe) {
            createT3TrendLines();
            createT3RegressionChannel();
            createT3RegressionChannelLevels();
            createT3FiboRetracement();
            createT3InSignalArea();
            createT3ReEntryArea();
            if(t3trendDirection == TREND_DIRECTION_LONG) createT3LowestLowTrendLine();
            if(t3trendDirection == TREND_DIRECTION_SHORT) createT3HighestHighTrendLine();
         } else {
            deleteTrendLineObject(T3_TRENDLINE);
            deleteRegressionChannelObject(T3_REGRESSION_CHANNEL);
            deleteFiboLevelsObject(T3_FIBO_LEVELS);
            deleteChannelObject(T3_IN_SIGNAL_AREA);
            deleteChannelObject(T3_RE_ENTRY_AREA);
         }

         objectHasChanged = false;
      }

      t3StopLossLineLevel = ObjectGetValueByTime(0, T3_STOP_LOSS_TLINE, iTime(Symbol(), Period(), 0));

      handleInsideBars();

   } else {
      deleteTrendLineObject(T3_TRENDLINE);
      deleteRegressionChannelObject(T3_REGRESSION_CHANNEL);
      deleteFiboLevelsObject(T3_FIBO_LEVELS);
      deleteChannelObject(T3_IN_SIGNAL_AREA);
      deleteChannelObject(T3_RE_ENTRY_AREA);
   }

}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void getT3TrendDirection() {
   if(t3p1ValueHigh != 0 && t3p2ValueHigh != 0) {
      if(t3p1ValueHigh < t3p2ValueHigh) t3trendDirection = TREND_DIRECTION_LONG;
      if(t3p1ValueHigh > t3p2ValueHigh) t3trendDirection = TREND_DIRECTION_SHORT;
   }
}

string getT3TrendDirectionString() {

   string trendDirectionString = "ROTATION";

   if(t3trendDirection == TREND_DIRECTION_LONG) trendDirectionString = "LONG";
   if(t3trendDirection == TREND_DIRECTION_SHORT) trendDirectionString = "SHORT";

   return trendDirectionString;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getP1HighLowValueByTrendDirection() {
   return (t3trendDirection == TREND_DIRECTION_LONG) ? t3p1ValueLow : t3p1ValueHigh;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getP2HighLowValueByTrendDirection() {
   return (t3trendDirection == TREND_DIRECTION_LONG) ? t3p2ValueHigh : t3p2ValueLow;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getP3HighLowValueByTrendDirection() {
   return (t3trendDirection == TREND_DIRECTION_LONG) ? t3p3ValueLow : t3p3ValueHigh;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getP4HighLowValueByTrendDirection() {
   return (t3trendDirection == TREND_DIRECTION_LONG) ? t3p4ValueHigh : t3p4ValueLow;
}
//+------------------------------------------------------------------+

void handleInsideBars() {

   int lastBarShift = 1;
   int penultimateBarShift = 2;

   double lastClose = iClose(Symbol(), InpInsideBarTimeframe, lastBarShift);
   double penultimateHigh = iHigh(Symbol(), InpInsideBarTimeframe, penultimateBarShift);
   double penultimateLow = iLow(Symbol(), InpInsideBarTimeframe, penultimateBarShift);

   if(
      outSideBarDateTime == 0
      && lastClose < penultimateHigh
      && lastClose > penultimateLow
      && (penultimateHigh - penultimateLow) >= InpInsideBarMinRange * Point()
   ) {
      outSideBarDateTime = iTime(Symbol(), InpInsideBarTimeframe, penultimateBarShift);
   }

   if(outSideBarDateTime != 0) {
      createT3InsideBarTrendLines();
      if(
         lastClose > iHigh(Symbol(), InpInsideBarTimeframe, iBarShift(Symbol(), InpInsideBarTimeframe, outSideBarDateTime))
         || lastClose < iLow(Symbol(), InpInsideBarTimeframe, iBarShift(Symbol(), InpInsideBarTimeframe, outSideBarDateTime))
      ) {
         outSideBarDateTime = 0;
         deleteTrendLineObject(T3_INSIDEBAR_TOP_TLINE);
         deleteTrendLineObject(T3_INSIDEBAR_BUTTOM_TLINE);
      }
   }
}
//+------------------------------------------------------------------+