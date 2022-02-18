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

         setLowestLowDateTime();

         if(useReEntryArea == false && inSignalAreaMaxEndValue != 0 && Bid() < inSignalAreaMaxEndValue) {
            if(isBidLowerInSignalAreaMaxEndValue == false) {
               isBidLowerInSignalAreaMaxEndValue = true;
            }
         } else {
            isBidLowerInSignalAreaMaxEndValue = false;
         }

         double localT3LowestLowValue = 0;
         if(iBarShift(Symbol(), Period(), t3LowestLowDateTime) != 0) {
            localT3LowestLowValue = iLow(Symbol(), Period(), iLowest( Symbol(), Period(), MODE_LOW, iBarShift(Symbol(), Period(), t3LowestLowDateTime) + 1));
         } else {
            localT3LowestLowValue = iLow(Symbol(), PERIOD_CURRENT, 0);
         }

         if(localT3LowestLowValue != 0) {
            t3LowestLowValue = MathMax(localT3LowestLowValue, inSignalAreaMinEndValue - InpStopLoss * Point());
            t3LongEntryValue = t3LowestLowValue + InpStopLoss * Point();
            createT3LowestLowTrendLine();
            createT3LongEntryTrendLine();
            if(getFirstBuyPositionIsOpened() == false) createT3OrderGridTrendLines();
         }

         if(t3LongEntryIsTriggert == true && t4StartDateTime == 0) createT4StartVLine();
         if(InpT4RegressionChannelShow == true && t4StartDateTime != 0) {
            createT4RegressionChannel();
            createT4RegressionChannelLevels();
            if(Bid() > (t3LongEntryValue + InpStopLoss * Point() * InpT4TrendOKOnMulti) && t4OKDateTime == 0) createT4OKVLine();
         }

      }

      if(t3trendDirection == TREND_DIRECTION_SHORT) {

         setHighestHighDateTime();

         if(useReEntryArea == false && inSignalAreaMinEndValue != 0 && Bid() > inSignalAreaMinEndValue) {
            if(isBidGreaterInSignalAreaMinEndValue == false) {
               isBidGreaterInSignalAreaMinEndValue = true;
            }
         } else {
            isBidGreaterInSignalAreaMinEndValue = false;
         }

         double localT3HighestHighValue = 0;
         if(iBarShift(Symbol(), Period(), t3HighestHighDateTime) != 0) {
            localT3HighestHighValue = iHigh(Symbol(), Period(), iHighest( Symbol(), Period(), MODE_HIGH, iBarShift(Symbol(), Period(), t3HighestHighDateTime) + 1));
         } else {
            localT3HighestHighValue = iHigh(Symbol(), Period(), 0);
         }

         if(localT3HighestHighValue != 0) {

            t3HighestHighValue = MathMin(localT3HighestHighValue, inSignalAreaMaxEndValue + InpStopLoss * Point());
            t3ShortEntryValue = t3HighestHighValue - InpStopLoss * Point();
            createT3HighestHighTrendLine();
            createT3ShortEntryTrendLine();
            if(getFirstSellPositionIsOpened() == false) createT3OrderGridTrendLines();
         }

         if(t3ShortEntryIsTriggert == true && t4StartDateTime == 0) createT4StartVLine();
         if(InpT4RegressionChannelShow == true && t4StartDateTime != 0) {
            createT4RegressionChannel();
            createT4RegressionChannelLevels();
            if(Bid() < (t3ShortEntryValue - InpStopLoss * Point() * InpT4TrendOKOnMulti) && t4OKDateTime == 0) createT4OKVLine();
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

   if(allBuyPositionsAreClosedState || allSellPositionsAreClosedState) {
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

   int startCandleShift = iBarShift(Symbol(), Period(), t3p4DateTime);
   if(t3HighestHighVLineDateTime != 0) startCandleShift = iBarShift(Symbol(), Period(), t3HighestHighVLineDateTime);

   if(startCandleShift != 0) {
      t3HighestHighDateTime = iTime(Symbol(), PERIOD_CURRENT, iHighest(Symbol(), PERIOD_CURRENT, MODE_HIGH, startCandleShift, 0));
   } else {
      t3HighestHighDateTime = iTime(Symbol(), PERIOD_CURRENT, 0);
   }
}

void setLowestLowDateTime() {

   int startCandleShift = iBarShift(Symbol(), Period(), t3p4DateTime);
   if(t3LowestLowVLineDateTime != 0) startCandleShift = iBarShift(Symbol(), Period(), t3LowestLowVLineDateTime);

   if(startCandleShift != 0) {
      t3LowestLowDateTime = iTime(Symbol(), PERIOD_CURRENT, iLowest(Symbol(), PERIOD_CURRENT, MODE_LOW, startCandleShift, 0));
   } else {
      t3LowestLowDateTime = iTime(Symbol(), PERIOD_CURRENT, 0);
   }
}
