//+------------------------------------------------------------------+
//|                                           HandleObjectAction.mqh |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
void t3HandleObjectsInitAction() {

   deleteTrendLineLike(T3_TRENDLINE);
   deleteRegressionChannelObject(T3_REGRESSION_CHANNEL);
   deleteFiboLevelsObject(T3_FIBO_LEVELS);
   deleteChannelObject(T3_IN_SIGNAL_FIBO_LEVEL_AREA);
   deleteChannelObject(T3_IN_SIGNAL_REGRESSION_CHANNEL_AREA);
   deleteChannelObject(T3_RE_ENTRY_AREA);

   createT3TrendLines();
   createT3HighVolumeAreaTrendLines();
   createT3RegressionChannel();
   createT3RegressionChannelLevels();
   createT3FiboRetracement();
   createT3InSignalFiboLevelChannelArea();
   createt3InSignalRegressionChannelArea();

   if(t3trendDirection == TREND_DIRECTION_LONG && buyT3PositionIsOpenState == false) {
      deleteTrendLineLike(T3_ORDER_GRID_LIMIT_TLINE);
      deleteTrendLineLike(T3_ORDER_GRID_STOP_TLINE);
      createT3OrderGridTrendLines();
   }
   if(t3trendDirection == TREND_DIRECTION_SHORT && sellT3PositionIsOpenState == false) {
      deleteTrendLineLike(T3_ORDER_GRID_LIMIT_TLINE);
      deleteTrendLineLike(T3_ORDER_GRID_STOP_TLINE);
      createT3OrderGridTrendLines();
   }


   t3HandleObjectsAction();
}


void t3HandleObjectsAction() {

   if(ObjectFind(ChartID(), T3_IS_TRADEABLE_BUTTON) < 0) {
      createT3IsTradeableButton();
   }

   if(InpT3ObjectsShow == true) {

      if(t3trendDirection == TREND_DIRECTION_LONG) {

         setT3LowestLowDateTime();

         if(t3LowestLowDateTime != 0) {
            double localT3LowestLowValue = 0;
            if(iBarShift(Symbol(), Period(), t3LowestLowDateTime) != 0) {
               localT3LowestLowValue = iLow(Symbol(), Period(), iLowest( Symbol(), Period(), MODE_LOW, iBarShift(Symbol(), Period(), t3LowestLowDateTime) + 1));
            } else {
               localT3LowestLowValue = iLow(Symbol(), PERIOD_CURRENT, 0);
            }

            if(localT3LowestLowValue != 0) {
               t3LowestLowValue = localT3LowestLowValue;
               createT3LowestLowTrendLine();
               createT3LongEntryTrendLine();
               if(buyT3PositionIsOpenState == false) createT3OrderGridTrendLines();
            }
         }

         if(maxT3BuyPositionsAreOpenState == true) {
            deleteTrendLine(T3_LOWEST_LOW_TLINE);
            deleteTrendLine(T3_LONG_ENTRY_TLINE);
            deleteTrendLineLike(T3_ORDER_GRID_LIMIT_TLINE);
            deleteTrendLineLike(T3_ORDER_GRID_STOP_TLINE);
         }
      }

      if(t3trendDirection == TREND_DIRECTION_SHORT) {

         setT3HighestHighDateTime();

         if(t3HighestHighDateTime != 0) {
            double localT3HighestHighValue = 0;
            if(iBarShift(Symbol(), Period(), t3HighestHighDateTime) != 0) {
               localT3HighestHighValue = iHigh(Symbol(), Period(), iHighest( Symbol(), Period(), MODE_HIGH, iBarShift(Symbol(), Period(), t3HighestHighDateTime) + 1));
            } else {
               localT3HighestHighValue = iHigh(Symbol(), Period(), 0);
            }

            if(localT3HighestHighValue != 0) {
               t3HighestHighValue = localT3HighestHighValue;
               createT3HighestHighTrendLine();
               createT3ShortEntryTrendLine();
               if(sellT3PositionIsOpenState == false) createT3OrderGridTrendLines();
            }
         }

         if(maxT3SellPositionsAreOpenState == true) {
            deleteTrendLine(T3_HIGHEST_HIGH_TLINE);
            deleteTrendLine(T3_SHORT_ENTRY_TLINE);
            deleteTrendLineLike(T3_ORDER_GRID_LIMIT_TLINE);
            deleteTrendLineLike(T3_ORDER_GRID_STOP_TLINE);
         }
      }

      if(isNewCurrentBar == true || t3ObjectHasChanged == true) {
         if(Period() <= InpT3MaxTimeframe) {
            createT3TrendLines();
            createT3RegressionChannel();
            createT3RegressionChannelLevels();
            createT3FiboRetracement();
            createT3InSignalFiboLevelChannelArea();
            createt3InSignalRegressionChannelArea();
            createT3ReEntryArea();
         } else {
            deleteTrendLineLike(T3_TRENDLINE);
            deleteRegressionChannelObject(T3_REGRESSION_CHANNEL);
            deleteFiboLevelsObject(T3_FIBO_LEVELS);
            deleteChannelObject(T3_IN_SIGNAL_FIBO_LEVEL_AREA);
            deleteChannelObject(T3_IN_SIGNAL_REGRESSION_CHANNEL_AREA);
            deleteChannelObject(T3_RE_ENTRY_AREA);
         }

         t3ObjectHasChanged = false;
      }

      double t3StopLossLineLevelLocal = ObjectGetValueByTime(0, T3_STOP_LOSS_TLINE, iTime(Symbol(), Period(), 0));
      if(t3StopLossLineLevelLocal != 0) t3StopLossLineLevel = t3StopLossLineLevelLocal;

      handleInsideBars();

   } else {
      deleteTrendLineLike(T3_TRENDLINE);
      deleteRegressionChannelObject(T3_REGRESSION_CHANNEL);
      deleteFiboLevelsObject(T3_FIBO_LEVELS);
      deleteChannelObject(T3_IN_SIGNAL_FIBO_LEVEL_AREA);
      deleteChannelObject(T3_IN_SIGNAL_REGRESSION_CHANNEL_AREA);
      deleteChannelObject(T3_RE_ENTRY_AREA);
   }

   if(allT3BuyPositionsAreClosedState || allT3SellPositionsAreClosedState) {
      string t3DisableTradeableButtonReason = "allT3PositionsAreClosedState";
      if(InpT3DisableTradabelButtonStateAfterClose == true) t3DisableTradeableButton(t3DisableTradeableButtonReason);
      deleteTrendLine(T3_STOP_LOSS_TLINE);
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
double getT3P1HighLowValueByTrendDirection() {
   return (t3trendDirection == TREND_DIRECTION_LONG) ? t3p1ValueLow : t3p1ValueHigh;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getT3P2HighLowValueByTrendDirection() {
   return (t3trendDirection == TREND_DIRECTION_LONG) ? t3p2ValueHigh : t3p2ValueLow;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getT3P3HighLowValueByTrendDirection() {
   return (t3trendDirection == TREND_DIRECTION_LONG) ? t3p3ValueLow : t3p3ValueHigh;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getT3P4HighLowValueByTrendDirection() {
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
      InpInsideBarMinRange != 0
      && outSideBarDateTime == 0
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
         deleteTrendLine(T3_INSIDEBAR_TOP_TLINE);
         deleteTrendLine(T3_INSIDEBAR_BUTTOM_TLINE);
      }
   }
}
//+------------------------------------------------------------------+

void setT3HighestHighDateTime() {

   if((int)t3p4DateTime < (int) TimeCurrent() && t3MinHighVolumeAreaLevel != 0 && t3MaxHighVolumeAreaLevel != 0 && Bid() >= t3MinHighVolumeAreaLevel) {
      int startCandleShift = iBarShift(Symbol(), Period(), t3p4DateTime);
      if(t3HighestHighVLineDateTime == 0) {
         createT3HighestHighVLine();
         if(ObjectFind(ChartID(), T4_P1_VLINE) < 0) createT4P1VLine();
         if(ObjectFind(ChartID(), T4_P2_VLINE) < 0) createT4P2VLine();
         if(ObjectFind(ChartID(), T4_P3_VLINE) < 0) createT4P3VLine();
      }
      if(t3HighestHighVLineDateTime != 0) startCandleShift = iBarShift(Symbol(), Period(), t3HighestHighVLineDateTime);

      if(startCandleShift != 0) {
         t3HighestHighDateTime = iTime(Symbol(), PERIOD_CURRENT, iHighest(Symbol(), PERIOD_CURRENT, MODE_HIGH, startCandleShift, 0));
      } else {
         t3HighestHighDateTime = iTime(Symbol(), PERIOD_CURRENT, 0);
      }
   }
}

void setT3LowestLowDateTime() {

   if((int)t3p4DateTime < (int) TimeCurrent() && t3MinHighVolumeAreaLevel != 0 && t3MaxHighVolumeAreaLevel != 0 && Bid() <= t3MaxHighVolumeAreaLevel) {
      int startCandleShift = iBarShift(Symbol(), Period(), t3p4DateTime);
      if(t3LowestLowVLineDateTime == 0) {
         createT3LowestLowVLine();
         if(ObjectFind(ChartID(), T4_P1_VLINE) < 0) createT4P1VLine();
         if(ObjectFind(ChartID(), T4_P2_VLINE) < 0) createT4P2VLine();
         if(ObjectFind(ChartID(), T4_P3_VLINE) < 0) createT4P3VLine();
      }
      if(t3LowestLowVLineDateTime != 0) startCandleShift = iBarShift(Symbol(), Period(), t3LowestLowVLineDateTime);

      if(startCandleShift != 0) {
         t3LowestLowDateTime = iTime(Symbol(), PERIOD_CURRENT, iLowest(Symbol(), PERIOD_CURRENT, MODE_LOW, startCandleShift, 0));
      } else {
         t3LowestLowDateTime = iTime(Symbol(), PERIOD_CURRENT, 0);
      }
   }
}
//+------------------------------------------------------------------+
