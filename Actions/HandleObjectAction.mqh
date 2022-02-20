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

      if(t3InSignalFiboLevelAreaMinStartValue != 0 && t3InSignalRegressionChannelAreaMinStartValue != 0) t3InSignalAreaMinStartValue = MathMax(t3InSignalFiboLevelAreaMinStartValue, t3InSignalRegressionChannelAreaMinStartValue);
      if(t3InSignalFiboLevelAreaMinStartValue == 0 && t3InSignalRegressionChannelAreaMinStartValue != 0) t3InSignalAreaMinStartValue = t3InSignalRegressionChannelAreaMinStartValue;
      if(t3InSignalFiboLevelAreaMinStartValue != 0 && t3InSignalRegressionChannelAreaMinStartValue == 0) t3InSignalAreaMinStartValue = t3InSignalFiboLevelAreaMinStartValue;
      if(t3InSignalFiboLevelAreaMaxStartValue != 0 && t3InSignalRegressionChannelAreaMaxStartValue != 0) t3InSignalAreaMaxStartValue = MathMin(t3InSignalFiboLevelAreaMaxStartValue, t3InSignalRegressionChannelAreaMaxStartValue);
      if(t3InSignalFiboLevelAreaMaxStartValue == 0 && t3InSignalRegressionChannelAreaMaxStartValue != 0) t3InSignalAreaMaxStartValue = t3InSignalRegressionChannelAreaMaxStartValue;
      if(t3InSignalFiboLevelAreaMaxStartValue != 0 && t3InSignalRegressionChannelAreaMaxStartValue == 0) t3InSignalAreaMaxStartValue = t3InSignalFiboLevelAreaMaxStartValue;
      if(t3InSignalFiboLevelAreaMinEndValue != 0 && t3InSignalRegressionChannelAreaMinEndValue != 0) t3InSignalAreaMinEndValue = MathMax(t3InSignalFiboLevelAreaMinEndValue, t3InSignalRegressionChannelAreaMinEndValue);
      if(t3InSignalFiboLevelAreaMinEndValue == 0 && t3InSignalRegressionChannelAreaMinEndValue != 0) t3InSignalAreaMinEndValue = t3InSignalRegressionChannelAreaMinEndValue;
      if(t3InSignalFiboLevelAreaMinEndValue != 0 && t3InSignalRegressionChannelAreaMinEndValue == 0) t3InSignalAreaMinEndValue = t3InSignalFiboLevelAreaMinEndValue;
      if(t3InSignalFiboLevelAreaMaxEndValue != 0 && t3InSignalRegressionChannelAreaMaxEndValue != 0) t3InSignalAreaMaxEndValue = MathMin(t3InSignalFiboLevelAreaMaxEndValue, t3InSignalRegressionChannelAreaMaxEndValue);
      if(t3InSignalFiboLevelAreaMaxEndValue == 0 && t3InSignalRegressionChannelAreaMaxEndValue != 0) t3InSignalAreaMaxEndValue = t3InSignalRegressionChannelAreaMaxEndValue;
      if(t3InSignalFiboLevelAreaMaxEndValue != 0 && t3InSignalRegressionChannelAreaMaxEndValue == 0) t3InSignalAreaMaxEndValue = t3InSignalFiboLevelAreaMaxEndValue;

      if(t3trendDirection == TREND_DIRECTION_LONG) {

         setLowestLowDateTime();

         if(t3LowestLowDateTime != 0) {
            double localT3LowestLowValue = 0;
            if(iBarShift(Symbol(), Period(), t3LowestLowDateTime) != 0) {
               localT3LowestLowValue = iLow(Symbol(), Period(), iLowest( Symbol(), Period(), MODE_LOW, iBarShift(Symbol(), Period(), t3LowestLowDateTime) + 1));
            } else {
               localT3LowestLowValue = iLow(Symbol(), PERIOD_CURRENT, 0);
            }

            if(localT3LowestLowValue != 0) {
               t3LowestLowValue = localT3LowestLowValue;
               t3LongEntryValue = t3LowestLowValue + InpStopLoss * Point();
               createT3LowestLowTrendLine();
               createT3LongEntryTrendLine();
               if(buyPositionIsOpenState == false) createT3OrderGridTrendLines();
            }
         }

         if(t3LowestLowDateTime == 0 || maxBuyPositionsAreOpenState == true) {
            deleteTrendLineObject(T3_HIGHEST_HIGH_TLINE);
            deleteTrendLineObject(T3_SHORT_ENTRY_TLINE);
            deleteTrendLineObject(T3_ORDER_GRID_LIMIT_TLINE);
            deleteTrendLineObject(T3_ORDER_GRID_STOP_TLINE);
         }

         if(InpT4RegressionChannelShow == true) {
            if(buyPositionIsOpenState == true && t4StartDateTime == 0) createT4StartVLine();
            if(t4StartDateTime != 0) {
               createT4RegressionChannel();
               createT4RegressionChannelLevels();
               if(Bid() > (t3LongEntryValue + InpStopLoss * Point() * InpT4TrendOKOnMulti) && t4OKDateTime == 0) createT4OKVLine();
            }
         }
      }

      if(t3trendDirection == TREND_DIRECTION_SHORT) {

         setHighestHighDateTime();

         if(t3HighestHighDateTime != 0) {
            double localT3HighestHighValue = 0;
            if(iBarShift(Symbol(), Period(), t3HighestHighDateTime) != 0) {
               localT3HighestHighValue = iHigh(Symbol(), Period(), iHighest( Symbol(), Period(), MODE_HIGH, iBarShift(Symbol(), Period(), t3HighestHighDateTime) + 1));
            } else {
               localT3HighestHighValue = iHigh(Symbol(), Period(), 0);
            }

            if(localT3HighestHighValue != 0) {
               t3HighestHighValue = localT3HighestHighValue;
               t3ShortEntryValue = t3HighestHighValue - InpStopLoss * Point();
               createT3HighestHighTrendLine();
               createT3ShortEntryTrendLine();
               if(sellPositionIsOpenState == false) createT3OrderGridTrendLines();
            }
         }

         if(t3HighestHighDateTime == 0 || maxSellPositionsAreOpenState == true) {
            deleteTrendLineObject(T3_HIGHEST_HIGH_TLINE);
            deleteTrendLineObject(T3_SHORT_ENTRY_TLINE);
            deleteTrendLineObject(T3_ORDER_GRID_LIMIT_TLINE);
            deleteTrendLineObject(T3_ORDER_GRID_STOP_TLINE);
         }

         if(InpT4RegressionChannelShow == true) {
            if(sellPositionIsOpenState == true && t4StartDateTime == 0) createT4StartVLine();
            if(t4StartDateTime != 0) {
               createT4RegressionChannel();
               createT4RegressionChannelLevels();
               if(Bid() < (t3ShortEntryValue - InpStopLoss * Point() * InpT4TrendOKOnMulti) && t4OKDateTime == 0) createT4OKVLine();
            }
         }
      }

      if(isNewCurrentBar == true || objectHasChanged == true) {
         if(Period() <= InpT3MaxTimeframe) {
            createT3TrendLines();
            createT3RegressionChannel();
            createT3RegressionChannelLevels();
            createT3FiboRetracement();
            createT3InSignalFiboLevelArea();
            createt3InSignalRegressionChannelArea();
            createT3ReEntryArea();
         } else {
            deleteTrendLineObject(T3_TRENDLINE);
            deleteRegressionChannelObject(T3_REGRESSION_CHANNEL);
            deleteFiboLevelsObject(T3_FIBO_LEVELS);
            deleteChannelObject(T3_IN_SIGNAL_FIBO_LEVEL_AREA);
            deleteChannelObject(T3_IN_SIGNAL_REGRESSION_CHANNEL_AREA);
            deleteChannelObject(T3_RE_ENTRY_AREA);
         }

         objectHasChanged = false;
      }

      t3StopLossLineLevel = ObjectGetValueByTime(0, T3_STOP_LOSS_TLINE, iTime(Symbol(), Period(), 0));

      handleInsideBars();

   } else {
      deleteTrendLineObject(T3_TRENDLINE);
      deleteRegressionChannelObject(T3_REGRESSION_CHANNEL);
      deleteChannelObject(T3_IN_SIGNAL_FIBO_LEVEL_AREA);
      deleteChannelObject(T3_IN_SIGNAL_REGRESSION_CHANNEL_AREA);
      deleteChannelObject(T3_RE_ENTRY_AREA);
   }

   if(allBuyPositionsAreClosedState || allSellPositionsAreClosedState) {
      if(InpSetIsTradabelButtonStateAfterClose == true) setIsTradeableButtonFalse();
      deleteTrendLineObject(T3_STOP_LOSS_TLINE);
      deleteVLineObject(T4_START_VLINE);
      deleteVLineObject(T4_OK_VLINE);
      deleteRegressionChannelObject(T4_REGRESSION_CHANNEL);
      deleteTrendLineObject(T4_REGRESSION_CHANNEL);
      deleteTrendLineObject(T4_TRAILING_STOP_LINE);
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
         deleteTrendLineObject(T3_INSIDEBAR_TOP_TLINE);
         deleteTrendLineObject(T3_INSIDEBAR_BUTTOM_TLINE);
      }
   }
}
//+------------------------------------------------------------------+

void setHighestHighDateTime() {

   if(isBidHigherInSignalAreaMinEndValue == true && isTradabelButtonState == true) {
      int startCandleShift = iBarShift(Symbol(), Period(), t3p4DateTime);
      if(t3HighestHighVLineDateTime == 0) createT3HighestHighVLine();
      if(t3HighestHighVLineDateTime != 0) startCandleShift = iBarShift(Symbol(), Period(), t3HighestHighVLineDateTime);

      if(startCandleShift != 0) {
         t3HighestHighDateTime = iTime(Symbol(), PERIOD_CURRENT, iHighest(Symbol(), PERIOD_CURRENT, MODE_HIGH, startCandleShift, 0));
      } else {
         t3HighestHighDateTime = iTime(Symbol(), PERIOD_CURRENT, 0);
      }
   }

   if(isBidHigherInSignalAreaMaxEndValue == true) {
      t3HighestHighDateTime = 0;
      setIsTradeableButtonFalse();
   }
}

void setLowestLowDateTime() {

   if(isBidLowerInSignalAreaMaxEndValue == true && isTradabelButtonState == true) {
      int startCandleShift = iBarShift(Symbol(), Period(), t3p4DateTime);
      if(t3LowestLowVLineDateTime == 0) createT3LowestLowVLine();
      if(t3LowestLowVLineDateTime != 0) startCandleShift = iBarShift(Symbol(), Period(), t3LowestLowVLineDateTime);

      if(startCandleShift != 0) {
         t3LowestLowDateTime = iTime(Symbol(), PERIOD_CURRENT, iLowest(Symbol(), PERIOD_CURRENT, MODE_LOW, startCandleShift, 0));
      } else {
         t3LowestLowDateTime = iTime(Symbol(), PERIOD_CURRENT, 0);
      }
   }

   if(isBidLowerInSignalAreaMinEndValue == true) {
      t3LowestLowDateTime = 0;
      setIsTradeableButtonFalse();
   }

}
//+------------------------------------------------------------------+
