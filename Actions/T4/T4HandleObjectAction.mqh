//+------------------------------------------------------------------+
//|                                           HandleObjectAction.mqh |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
void t4HandleObjectsInitAction() {

   deleteTrendLineLike(T4_TRENDLINE);
   deleteRegressionChannelObject(T4_REGRESSION_CHANNEL);
   deleteFiboLevelsObject(T4_FIBO_LEVELS);
   deleteChannelObject(T4_IN_SIGNAL_FIBO_LEVEL_AREA);
   deleteChannelObject(T4_IN_SIGNAL_REGRESSION_CHANNEL_AREA);
   deleteChannelObject(T4_RE_ENTRY_AREA);

   createT4TrendLines();
   createT4RegressionChannel();
   createT4RegressionChannelLevels();
   createT4FiboRetracement();
   createT4HighVolumeAreaTrendLines();
   createT4InSignalFiboLevelChannelArea();
   createt4InSignalRegressionChannelArea();

   t4HandleObjectsAction();
}

void t4HandleObjectsAction() {

   if(ObjectFind(ChartID(), T4_IS_TRADEABLE_BUTTON) < 0) {
      createT4IsTradeableButton();
   }

   if(InpT4ObjectsShow == true) {

      if(t4trendDirection == TREND_DIRECTION_LONG) {

         setT4LowestLowDateTime();

         if(t4LowestLowDateTime != 0) {
            double localT4LowestLowValue = 0;
            if(iBarShift(Symbol(), Period(), t4LowestLowDateTime) != 0) {
               localT4LowestLowValue = iLow(Symbol(), Period(), iLowest( Symbol(), Period(), MODE_LOW, iBarShift(Symbol(), Period(), t4LowestLowDateTime) + 1));
            } else {
               localT4LowestLowValue = iLow(Symbol(), PERIOD_CURRENT, 0);
            }

            if(localT4LowestLowValue != 0) {
               t4LowestLowValue = localT4LowestLowValue;
               double minRegressionPoints = (getT4P4HighLowValueByTrendDirection() / Point() - t4LowestLowValue / Point()) * InpT4MinRegressionPercent / 100;
               createT4LowestLowTrendLine();
               if(buyT4PositionIsOpenState == false) createT4OrderGridTrendLines();
            }
         }

         if(t4LowestLowDateTime == 0 || maxT4BuyPositionsAreOpenState == true) {
            deleteTrendLine(T4_LOWEST_LOW_TLINE);
            deleteTrendLineLike(T4_ORDER_GRID_LIMIT_TLINE);
            deleteTrendLineLike(T4_ORDER_GRID_STOP_TLINE);
         }
      }

      if(t4trendDirection == TREND_DIRECTION_SHORT) {

         setT4HighestHighDateTime();

         if(t4HighestHighDateTime != 0) {
            double localT4HighestHighValue = 0;
            if(iBarShift(Symbol(), Period(), t4HighestHighDateTime) != 0) {
               localT4HighestHighValue = iHigh(Symbol(), Period(), iHighest( Symbol(), Period(), MODE_HIGH, iBarShift(Symbol(), Period(), t4HighestHighDateTime) + 1));
            } else {
               localT4HighestHighValue = iHigh(Symbol(), Period(), 0);
            }

            if(localT4HighestHighValue != 0) {
               t4HighestHighValue = localT4HighestHighValue;
               double minRegressionPoints = (t4HighestHighValue / Point() - getT4P4HighLowValueByTrendDirection() / Point()) * InpT4MinRegressionPercent / 100;
               createT4HighestHighTrendLine();
               if(sellT4PositionIsOpenState == false) createT4OrderGridTrendLines();
            }
         }

         if(t4HighestHighDateTime == 0 || maxT4SellPositionsAreOpenState == true) {
            deleteTrendLine(T4_HIGHEST_HIGH_TLINE);
            deleteTrendLineLike(T4_ORDER_GRID_LIMIT_TLINE);
            deleteTrendLineLike(T4_ORDER_GRID_STOP_TLINE);
         }
      }

      if(isNewCurrentBar == true || t4ObjectHasChanged == true) {
         if(Period() <= InpT4MaxTimeframe) {
            createT4TrendLines();
            createT4RegressionChannel();
            createT4RegressionChannelLevels();
            createT4FiboRetracement();
            createT4InSignalFiboLevelChannelArea();
            createt4InSignalRegressionChannelArea();
            createT4ReEntryArea();
         } else {
            deleteTrendLineLike(T4_TRENDLINE);
            deleteRegressionChannelObject(T4_REGRESSION_CHANNEL);
            deleteFiboLevelsObject(T4_FIBO_LEVELS);
            deleteChannelObject(T4_IN_SIGNAL_FIBO_LEVEL_AREA);
            deleteChannelObject(T4_IN_SIGNAL_REGRESSION_CHANNEL_AREA);
            deleteChannelObject(T4_RE_ENTRY_AREA);
         }

         t4ObjectHasChanged = false;
      }

      handleInsideBars();

   } else {
      deleteTrendLineLike(T4_TRENDLINE);
      deleteRegressionChannelObject(T4_REGRESSION_CHANNEL);
      deleteFiboLevelsObject(T4_FIBO_LEVELS);
      deleteChannelObject(T4_IN_SIGNAL_FIBO_LEVEL_AREA);
      deleteChannelObject(T4_IN_SIGNAL_REGRESSION_CHANNEL_AREA);
      deleteChannelObject(T4_RE_ENTRY_AREA);
   }

   if(allT4BuyPositionsAreClosedState || allT4SellPositionsAreClosedState) {
      string t4DisableTradeableButtonReason = "allT4PositionsAreClosedState";
      if(InpT4DisableTradabelButtonStateAfterClose == true) t4DisableTradeableButton(t4DisableTradeableButtonReason);
      deleteTrendLine(T4_STOP_LOSS_TLINE);
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getT4P1HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(t4p1ValueLow != 0 && t4p2ValueLow != 0) {
      returnValue = (t4p1ValueLow < t4p2ValueLow) ? t4p1ValueLow : t4p1ValueHigh;
   }
   return returnValue;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getT4P2HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(t4p1ValueLow != 0 && t4p2ValueLow != 0) {
      returnValue = (t4p1ValueLow > t4p2ValueLow) ? t4p2ValueLow : t4p2ValueHigh;
   }
   return returnValue;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getT4P3HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(t4p1ValueLow != 0 && t4p2ValueLow != 0) {
      returnValue = (t4p1ValueLow < t4p2ValueLow) ? t4p3ValueLow : t4p3ValueHigh;
   }
   return returnValue;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getT4P4HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(t4p1ValueLow != 0 && t4p2ValueLow != 0) {
      returnValue = (t4p1ValueLow > t4p2ValueLow) ? t4p4ValueLow : t4p4ValueHigh;
   }
   return returnValue;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getT4P5HighLowValueByTrendDirection() {
   double returnValue = 0;
   if(t4p1ValueLow != 0 && t4p2ValueLow != 0) {
      returnValue = (t4p1ValueLow < t4p2ValueLow) ? t4p5ValueLow : t4p5ValueHigh;
   }
   return returnValue;
}
//+------------------------------------------------------------------+

void setT4HighestHighDateTime() {

   if((int)t4p4DateTime < (int) TimeCurrent() && t4MinHighVolumeAreaLevel != 0 && Bid() >= t4MinHighVolumeAreaLevel) {
      int startCandleShift = iBarShift(Symbol(), Period(), t4p4DateTime);
      if(t4HighestHighVLineDateTime == 0) createT4HighestHighVLine();
      if(t4HighestHighVLineDateTime != 0) startCandleShift = iBarShift(Symbol(), Period(), t4HighestHighVLineDateTime);

      if(startCandleShift != 0) {
         t4HighestHighDateTime = iTime(Symbol(), PERIOD_CURRENT, iHighest(Symbol(), PERIOD_CURRENT, MODE_HIGH, startCandleShift, 0));
      } else {
         t4HighestHighDateTime = iTime(Symbol(), PERIOD_CURRENT, 0);
      }
   }
}

void setT4LowestLowDateTime() {

   if((int)t4p4DateTime < (int) TimeCurrent() && t4MaxHighVolumeAreaLevel != 0 && Bid() <= t4MaxHighVolumeAreaLevel) {
      int startCandleShift = iBarShift(Symbol(), Period(), t4p4DateTime);
      if(t4LowestLowVLineDateTime == 0) createT4LowestLowVLine();
      if(t4LowestLowVLineDateTime != 0) startCandleShift = iBarShift(Symbol(), Period(), t4LowestLowVLineDateTime);

      if(startCandleShift != 0) {
         t4LowestLowDateTime = iTime(Symbol(), PERIOD_CURRENT, iLowest(Symbol(), PERIOD_CURRENT, MODE_LOW, startCandleShift, 0));
      } else {
         t4LowestLowDateTime = iTime(Symbol(), PERIOD_CURRENT, 0);
      }
   }
}
//+------------------------------------------------------------------+
