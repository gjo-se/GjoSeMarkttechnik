/*

   EA GjoSeMarkttechnik.mq5
   Copyright 2022, Gregory Jo
   https://www.gjo-se.com

   Version History
   ===============

   1.0   Initial version
   1.1   GWL Features
   1.2   solved PerformanceProblem
   1.3   first Testversion
   1.4   Trailing per Trendline
   1.5   isTradeableButton activeted
   1.6   fixed LotsSize Automatic
   1.6.1 fixed isTradeableButton
   1.6.2 fixed diverse
   1.7   TrailingStop on RegressionChannel
   1.7.1 fixed diverse
   1.7.2 fixed InSignalArea & Btoon OFF
   1.7.3 remove LONG LL & EntryLevel
   2.0   add T4
   2.1   changed stopLossLineValue incl OffsetMulti
   2.2   added closeOnT3TrailingStopMA
   2.3   added MarketTrailingStop
   3.0   added MADynamikTrailing, changed T4
   3.0.1 fixed createT4
   3.0.2 fixed createT4 SHORT
   3.0.3 fixed diverse
   3.1.0 added VolumeProfilArea
   3.1.1 fixed GridLevels
   3.1.2 fixed SL in SHORT & createGrid only if no Position Open
   3.2.0 rebuild InSignal Strategy: After Regression
   3.2.1 fixed missing t3HighestHighDateTime
   3.2.2 cleaned t4IsBidHigherInSignalAreaMinEndValue
   3.2.3 fixed multiPush on t3AlertDisableTradeableButtonSended
   3.2.4 fixed missing t3LongEntry
   3.2.5 diverse little Fixings
   3.2.6 fixed missing t3HighestHighIsInSignalArea
   3.3.0 fixed trailingStopMA
   3.3.1 fixed diverse
   3.4.0 added T4 Trend Logic on Markttechnik


   ===============

*/

//+------------------------------------------------------------------+
//| Includes                                                         |
//+------------------------------------------------------------------+
#include "Basics\\T3\\T3Includes.mqh"
#include "Basics\\T4\\T4Includes.mqh"

//+------------------------------------------------------------------+
//| Headers                                                          |
//+------------------------------------------------------------------+
#property copyright   "2022, GjoSe"
#property link        "http://www.gjo-se.com"
#property description "GjoSe Markttechnik"
#define   VERSION "3.4.0"
#property version VERSION
#property strict

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit() {

   if(UninitializeReason() != REASON_CHARTCHANGE) {
      initializeEAAction();
      initializeT3GlobalsAction();
      initializeT4GlobalsAction();
      initializeT3ArraysAction();
      initializeT4ArraysAction();
      initializeT3IndicatorsAction();
      initializeT4IndicatorsAction();

      rewriteVLineNamesWithText();
      setT3LineValues();
      setT4LineValues();
      getT3TrendDirection();
      getT4TrendDirection();
      setT3TrendLineValues();
      setT4TrendLineValues();

      t3HandleObjectsInitAction();
      t4HandleObjectsInitAction();
      handleCommentAction(VERSION);
   }



   if(MQLInfoInteger(MQL_TESTER) == 1) {

      t3IsTradabelButtonState = true;
      t4IsTradabelButtonState = true;

      if(MQLInfoInteger(MQL_VISUAL_MODE) != 1) {
         t3p1DateTime = InpT3p1DateTime;
         t3p2DateTime = InpT3p2DateTime;
         t3p3DateTime = InpT3p3DateTime;
         t3p4DateTime = InpT3p4DateTime;
         t4p1DateTime = InpT4p1DateTime;
         t4p2DateTime = InpT4p2DateTime;
         t4p3DateTime = InpT4p3DateTime;
         t4p4DateTime = InpT4p4DateTime;
      }
   }

   return(INIT_SUCCEEDED);
}

void OnTick() {

   (NewCurrentBar()) ? isNewCurrentBar = true : isNewCurrentBar = false;

   if(MQLInfoInteger(MQL_VISUAL_MODE) == 1) {
      setT3LineValues();
      getT3TrendDirection();
      createT3HighVolumeAreaTrendLines();
      setT4LineValues();
      getT4TrendDirection();
   }

   handleT3Indictaors();
   handleT4Indictaors();
   handleT3StatesAction();
   handleT4StatesAction();
   handleT4TrendDetectionAction();
   setT3PositionStates();
   setT4PositionStates();
   if(InpPrintScreenshot == true) handleScreenshotAction();

   closeT3Actions();
   closeT4Actions();
   t3AlertOnBidStopLossLineOffset();
   t4AlertOnBidStopLossLineOffset();

   t3HandleObjectsAction();
   t4HandleObjectsAction();
   if(isNewCurrentBar) {
      handleCommentAction(VERSION);
//      if((buyT3PositionIsOpenState == true || sellT3PositionIsOpenState == true) && buyT4PositionIsOpenState == false && sellT4PositionIsOpenState == false) ChartSetSymbolPeriod(ChartID(), Symbol(), InpT3trailingStopMATimeframe);
//      if(buyT4PositionIsOpenState == true || sellT4PositionIsOpenState == true) ChartSetSymbolPeriod(ChartID(), Symbol(), InpT4trailingStopMATimeframe);
   }

   if(getT3BuyAlertRegressionSignal() == true) t3AlertBuyRegressionAction();
   if(getT4BuyAlertRegressionSignal() == true) t4AlertBuyRegressionAction();
   if(getT3SellAlertRegressionSignal() == true) t3AlertSellRegressionAction();
   if(getT4SellAlertRegressionSignal() == true) t4AlertSellRegressionAction();

   if(getT3BuyInSignal() == true) openT3BuyOrderAction();
   if(getT4BuyInSignal() == true) openT4BuyOrderAction();
   if(getT3SellInSignal() == true) openT3SellOrderAction();
   if(getT4SellInSignal() == true) openT4SellOrderAction();

}

//+------------------------------------------------------------------+
//| Expert deInitialization function                                   |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {

   int subWindow = 0;
   int t3trailingStopMAPeriod = 0;
   for(int t3trailingStopMAPeriodsId = 0; t3trailingStopMAPeriodsId < ArraySize(t3trailingStopMAPeriodsArray); t3trailingStopMAPeriodsId++) {
      t3trailingStopMAPeriod = t3trailingStopMAPeriodsArray[t3trailingStopMAPeriodsId];
      string indictaorShortName = "MA(" + IntegerToString(t3trailingStopMAPeriod) + ")";
      if(ChartIndicatorGet(ChartID(), subWindow, indictaorShortName) != INVALID_HANDLE) ChartIndicatorDelete(ChartID(), subWindow, indictaorShortName);
   }

   Comment("");
   Print(__FUNCTION__, " UninitializeReason() = ", getUninitReasonText(UninitializeReason()));
}
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam) {

   if(id == CHARTEVENT_OBJECT_DRAG) {
      rewriteVLineNamesWithText();
      setT3LineValues();
      setT4LineValues();
      getT3TrendDirection();
      getT4TrendDirection();
      t3ObjectHasChanged = true;
      t4ObjectHasChanged = true;

      if(sparam == T3_STOP_LOSS_TLINE) {
         t3IsBidStopLossLineOffsetAlertSendable = true;
         t3IsBidStopLossLineOffsetAlertSended = false;
      }
      if(sparam == T4_STOP_LOSS_TLINE) {
         t4IsBidStopLossLineOffsetAlertSendable = true;
         t4IsBidStopLossLineOffsetAlertSended = false;
      }

      if(sparam == T3_MIN_HIGH_VOL_AREA || sparam == T3_MAX_HIGH_VOL_AREA) {

         t3MinHighVolumeAreaLevel = getTrendlineLevelByText(T3_MIN_HIGH_VOL_AREA, PERIOD_CURRENT, Symbol(), ChartID(), true);
         if(ObjectFind(ChartID(), T3_MIN_HIGH_VOL_AREA) >= 0) {
            ObjectSetString(ChartID(), T3_MIN_HIGH_VOL_AREA, OBJPROP_TEXT, T3_MIN_HIGH_VOL_AREA + ": " + DoubleToString(t3MinHighVolumeAreaLevel, Digits()));
            ObjectSetInteger(ChartID(), T3_MIN_HIGH_VOL_AREA, OBJPROP_TIME, 0, t3p3DateTime);
            ObjectSetDouble(ChartID(), T3_MIN_HIGH_VOL_AREA, OBJPROP_PRICE, 0, t3MinHighVolumeAreaLevel);
            ObjectSetDouble(ChartID(), T3_MIN_HIGH_VOL_AREA, OBJPROP_PRICE, 1, t3MinHighVolumeAreaLevel);
         }

         t3MaxHighVolumeAreaLevel = getTrendlineLevelByText(T3_MAX_HIGH_VOL_AREA, PERIOD_CURRENT, Symbol(), ChartID(), true);
         if(ObjectFind(ChartID(), T3_MAX_HIGH_VOL_AREA) >= 0) {
            ObjectSetString(ChartID(), T3_MAX_HIGH_VOL_AREA, OBJPROP_TEXT, T3_MAX_HIGH_VOL_AREA + ": " + DoubleToString(t3MaxHighVolumeAreaLevel, Digits()));
            ObjectSetInteger(ChartID(), T3_MAX_HIGH_VOL_AREA, OBJPROP_TIME, 0, t3p3DateTime);
            ObjectSetDouble(ChartID(), T3_MAX_HIGH_VOL_AREA, OBJPROP_PRICE, 0, t3MaxHighVolumeAreaLevel);
            ObjectSetDouble(ChartID(), T3_MAX_HIGH_VOL_AREA, OBJPROP_PRICE, 1, t3MaxHighVolumeAreaLevel);
         }

         t3alertBidAgainInHighVolumeAreaSended = false;

         createT3InSignalFiboLevelChannelArea();
      }

      if(sparam == T4_MIN_HIGH_VOL_AREA || sparam == T4_MAX_HIGH_VOL_AREA) {

         t4MinHighVolumeAreaLevel = getTrendlineLevelByText(T4_MIN_HIGH_VOL_AREA, PERIOD_CURRENT, Symbol(), ChartID(), true);
         if(ObjectFind(ChartID(), T4_MIN_HIGH_VOL_AREA) >= 0) {
            ObjectSetString(ChartID(), T4_MIN_HIGH_VOL_AREA, OBJPROP_TEXT, T4_MIN_HIGH_VOL_AREA + ": " + DoubleToString(t4MinHighVolumeAreaLevel, Digits()));
            ObjectSetInteger(ChartID(), T4_MIN_HIGH_VOL_AREA, OBJPROP_TIME, 0, t4p3DateTime);
            ObjectSetDouble(ChartID(), T4_MIN_HIGH_VOL_AREA, OBJPROP_PRICE, 0, t4MinHighVolumeAreaLevel);
            ObjectSetDouble(ChartID(), T4_MIN_HIGH_VOL_AREA, OBJPROP_PRICE, 1, t4MinHighVolumeAreaLevel);
         }

         t4MaxHighVolumeAreaLevel = getTrendlineLevelByText(T4_MAX_HIGH_VOL_AREA, PERIOD_CURRENT, Symbol(), ChartID(), true);
         if(ObjectFind(ChartID(), T4_MAX_HIGH_VOL_AREA) >= 0) {
            ObjectSetString(ChartID(), T4_MAX_HIGH_VOL_AREA, OBJPROP_TEXT, T4_MAX_HIGH_VOL_AREA + ": " + DoubleToString(t4MaxHighVolumeAreaLevel, Digits()));
            ObjectSetInteger(ChartID(), T4_MAX_HIGH_VOL_AREA, OBJPROP_TIME, 0, t4p3DateTime);
            ObjectSetDouble(ChartID(), T4_MAX_HIGH_VOL_AREA, OBJPROP_PRICE, 0, t4MaxHighVolumeAreaLevel);
            ObjectSetDouble(ChartID(), T4_MAX_HIGH_VOL_AREA, OBJPROP_PRICE, 1, t4MaxHighVolumeAreaLevel);
         }

         createT4InSignalFiboLevelChannelArea();
      }

      if(sparam == T4_LONG_ENTRY_TLINE) {
         t4LongEntryValue = ObjectGetDouble(ChartID(), T4_LONG_ENTRY_TLINE, OBJPROP_PRICE, 1);
         if(t4LongEntryValue != 0) {
            ObjectSetString(ChartID(), T4_LONG_ENTRY_TLINE, OBJPROP_TEXT, T4_LONG_ENTRY_TLINE + ": " + DoubleToString(t4LongEntryValue, Digits()));
            ObjectSetInteger(ChartID(), T4_LONG_ENTRY_TLINE, OBJPROP_TIME, 0, t3p3DateTime);
            ObjectSetDouble(ChartID(), T4_LONG_ENTRY_TLINE, OBJPROP_PRICE, 0, t4LongEntryValue);
            ObjectSetDouble(ChartID(), T4_LONG_ENTRY_TLINE, OBJPROP_PRICE, 1, t4LongEntryValue);
         }
      }
      if(sparam == T4_SHORT_ENTRY_TLINE) {
         t4ShortEntryValue = ObjectGetDouble(ChartID(), T4_SHORT_ENTRY_TLINE, OBJPROP_PRICE, 1);
         if(t4ShortEntryValue != 0) {
            ObjectSetString(ChartID(), T4_SHORT_ENTRY_TLINE, OBJPROP_TEXT, T4_SHORT_ENTRY_TLINE + ": " + DoubleToString(t4ShortEntryValue, Digits()));
            ObjectSetInteger(ChartID(), T4_SHORT_ENTRY_TLINE, OBJPROP_TIME, 0, t3p3DateTime);
            ObjectSetDouble(ChartID(), T4_SHORT_ENTRY_TLINE, OBJPROP_PRICE, 0, t4ShortEntryValue);
            ObjectSetDouble(ChartID(), T4_SHORT_ENTRY_TLINE, OBJPROP_PRICE, 1, t4ShortEntryValue);
         }
      }
   }

   if(id == CHARTEVENT_OBJECT_CLICK) {
      if(sparam == T3_IS_TRADEABLE_BUTTON) {
         handleT3IsTradeableButton();
         handleCommentAction(VERSION);
      }
      if(sparam == T4_IS_TRADEABLE_BUTTON) {
         handleT4IsTradeableButton();
         handleCommentAction(VERSION);
      }
   }
}
//+------------------------------------------------------------------+
