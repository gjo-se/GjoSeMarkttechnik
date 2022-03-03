//+------------------------------------------------------------------+
//|                                           HandleObjectAction.mqh |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
void t4HandleObjectsAction() {

   if(ObjectFind(ChartID(), T4_IS_TRADEABLE_BUTTON) < 0) {
      createT4IsTradeableButton();
   }

   if(InpT4ObjectsShow == true) {

      if(t4InSignalFiboLevelAreaMinStartValue != 0 && t4InSignalRegressionChannelAreaMinStartValue != 0) t4InSignalAreaMinStartValue = MathMax(t4InSignalFiboLevelAreaMinStartValue, t4InSignalRegressionChannelAreaMinStartValue);
      if(t4InSignalFiboLevelAreaMinStartValue == 0 && t4InSignalRegressionChannelAreaMinStartValue != 0) t4InSignalAreaMinStartValue = t4InSignalRegressionChannelAreaMinStartValue;
      if(t4InSignalFiboLevelAreaMinStartValue != 0 && t4InSignalRegressionChannelAreaMinStartValue == 0) t4InSignalAreaMinStartValue = t4InSignalFiboLevelAreaMinStartValue;
      if(t4InSignalFiboLevelAreaMaxStartValue != 0 && t4InSignalRegressionChannelAreaMaxStartValue != 0) t4InSignalAreaMaxStartValue = MathMin(t4InSignalFiboLevelAreaMaxStartValue, t4InSignalRegressionChannelAreaMaxStartValue);
      if(t4InSignalFiboLevelAreaMaxStartValue == 0 && t4InSignalRegressionChannelAreaMaxStartValue != 0) t4InSignalAreaMaxStartValue = t4InSignalRegressionChannelAreaMaxStartValue;
      if(t4InSignalFiboLevelAreaMaxStartValue != 0 && t4InSignalRegressionChannelAreaMaxStartValue == 0) t4InSignalAreaMaxStartValue = t4InSignalFiboLevelAreaMaxStartValue;
      if(t4InSignalFiboLevelAreaMinEndValue != 0 && t4InSignalRegressionChannelAreaMinEndValue != 0) t4InSignalAreaMinEndValue = MathMax(t4InSignalFiboLevelAreaMinEndValue, t4InSignalRegressionChannelAreaMinEndValue);
      if(t4InSignalFiboLevelAreaMinEndValue == 0 && t4InSignalRegressionChannelAreaMinEndValue != 0) t4InSignalAreaMinEndValue = t4InSignalRegressionChannelAreaMinEndValue;
      if(t4InSignalFiboLevelAreaMinEndValue != 0 && t4InSignalRegressionChannelAreaMinEndValue == 0) t4InSignalAreaMinEndValue = t4InSignalFiboLevelAreaMinEndValue;
      if(t4InSignalFiboLevelAreaMaxEndValue != 0 && t4InSignalRegressionChannelAreaMaxEndValue != 0) t4InSignalAreaMaxEndValue = MathMin(t4InSignalFiboLevelAreaMaxEndValue, t4InSignalRegressionChannelAreaMaxEndValue);
      if(t4InSignalFiboLevelAreaMaxEndValue == 0 && t4InSignalRegressionChannelAreaMaxEndValue != 0) t4InSignalAreaMaxEndValue = t4InSignalRegressionChannelAreaMaxEndValue;
      if(t4InSignalFiboLevelAreaMaxEndValue != 0 && t4InSignalRegressionChannelAreaMaxEndValue == 0) t4InSignalAreaMaxEndValue = t4InSignalFiboLevelAreaMaxEndValue;

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
               t4LongEntryValue = t4LowestLowValue + InpT4StopLoss * Point();
               createT4LowestLowTrendLine();
               createT4LongEntryTrendLine();
               if(buyT4PositionIsOpenState == false) createT4OrderGridTrendLines();
            }
         }

         if(t4LowestLowDateTime == 0 || maxT4BuyPositionsAreOpenState == true) {
            deleteTrendLine(T4_LOWEST_LOW_TLINE);
            deleteTrendLine(T4_LONG_ENTRY_TLINE);
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
               t4ShortEntryValue = t4HighestHighValue - InpT4StopLoss * Point();
               createT4HighestHighTrendLine();
               createT4ShortEntryTrendLine();
               if(sellT4PositionIsOpenState == false) createT4OrderGridTrendLines();
            }
         }

         if(t4HighestHighDateTime == 0 || maxT4SellPositionsAreOpenState == true) {
            deleteTrendLine(T4_HIGHEST_HIGH_TLINE);
            deleteTrendLine(T4_SHORT_ENTRY_TLINE);
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
            createT4InSignalFiboLevelArea();
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

      double t4StopLossLineLevelLocal = ObjectGetValueByTime(0, T4_STOP_LOSS_TLINE, iTime(Symbol(), Period(), 0));
      if(t4StopLossLineLevelLocal != 0) t4StopLossLineLevel = t4StopLossLineLevelLocal;

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
      if(InpT4SetIsTradabelButtonStateAfterClose == true) setT4IsTradeableButtonFalse();
      deleteTrendLine(T4_STOP_LOSS_TLINE);
   }

// T4 LONG
   if(t3HighestHighVLineDateTime != 0 && t4LowestLowVLineDateTime == 0) {
      datetime highestHighDateTimeLocal = iTime(Symbol(), Period(), iHighest(Symbol(), Period(), MODE_HIGH,  iBarShift(Symbol(), Period(), t3HighestHighVLineDateTime) + 1));
      if(t4p4DateTime != highestHighDateTimeLocal) createT4P4VLine();
   }

// T4 SHORT
   if(t3LowestLowVLineDateTime != 0 && t4HighestHighVLineDateTime == 0) {
      datetime lowestLowDateTimeLocal = iTime(Symbol(), Period(), iLowest(Symbol(), Period(), MODE_LOW,  iBarShift(Symbol(), Period(), t3LowestLowVLineDateTime) + 1));
      if(t4p4DateTime != lowestLowDateTimeLocal) createT4P4VLine();
   }

}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void getT4TrendDirection() {
   if(t4p1ValueHigh != 0 && t4p2ValueHigh != 0) {
      if(t4p1ValueHigh < t4p2ValueHigh) t4trendDirection = TREND_DIRECTION_LONG;
      if(t4p1ValueHigh > t4p2ValueHigh) t4trendDirection = TREND_DIRECTION_SHORT;
   }
}

string getT4TrendDirectionString() {

   string trendDirectionString = "ROTATION";

   if(t4trendDirection == TREND_DIRECTION_LONG) trendDirectionString = "LONG";
   if(t4trendDirection == TREND_DIRECTION_SHORT) trendDirectionString = "SHORT";

   return trendDirectionString;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getT4P1HighLowValueByTrendDirection() {
   return (t4trendDirection == TREND_DIRECTION_LONG) ? t4p1ValueLow : t4p1ValueHigh;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getT4P2HighLowValueByTrendDirection() {
   return (t4trendDirection == TREND_DIRECTION_LONG) ? t4p2ValueHigh : t4p2ValueLow;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getT4P3HighLowValueByTrendDirection() {
   return (t4trendDirection == TREND_DIRECTION_LONG) ? t4p3ValueLow : t4p3ValueHigh;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getT4P4HighLowValueByTrendDirection() {
   return (t4trendDirection == TREND_DIRECTION_LONG) ? t4p4ValueHigh : t4p4ValueLow;
}
//+------------------------------------------------------------------+

void setT4HighestHighDateTime() {

   if((int)t4p4DateTime < (int) TimeCurrent() && t4IsBidHigherInSignalAreaMinEndValue == true && t4IsTradabelButtonState == true) {
      int startCandleShift = iBarShift(Symbol(), Period(), t4p4DateTime);
      if(t4HighestHighVLineDateTime == 0) createT4HighestHighVLine();
      if(t4HighestHighVLineDateTime != 0) startCandleShift = iBarShift(Symbol(), Period(), t4HighestHighVLineDateTime);

      if(startCandleShift != 0) {
         t4HighestHighDateTime = iTime(Symbol(), PERIOD_CURRENT, iHighest(Symbol(), PERIOD_CURRENT, MODE_HIGH, startCandleShift, 0));
      } else {
         t4HighestHighDateTime = iTime(Symbol(), PERIOD_CURRENT, 0);
      }
   }

   if(t4IsBidHigherInSignalAreaMaxEndValue == true) {
      t4HighestHighDateTime = 0;
      setT4IsTradeableButtonFalse();
   }
}

void setT4LowestLowDateTime() {

   if((int)t4p4DateTime < (int) TimeCurrent() && t4IsBidLowerInSignalAreaMaxEndValue == true && t4IsTradabelButtonState == true) {
      int startCandleShift = iBarShift(Symbol(), Period(), t4p4DateTime);
      if(t4LowestLowVLineDateTime == 0) createT4LowestLowVLine();
      if(t4LowestLowVLineDateTime != 0) startCandleShift = iBarShift(Symbol(), Period(), t4LowestLowVLineDateTime);

      if(startCandleShift != 0) {
         t4LowestLowDateTime = iTime(Symbol(), PERIOD_CURRENT, iLowest(Symbol(), PERIOD_CURRENT, MODE_LOW, startCandleShift, 0));
      } else {
         t4LowestLowDateTime = iTime(Symbol(), PERIOD_CURRENT, 0);
      }
   }

   if(t4IsBidLowerInSignalAreaMinEndValue == true) {
      t4LowestLowDateTime = 0;
      setT4IsTradeableButtonFalse();
   }

}
//+------------------------------------------------------------------+
