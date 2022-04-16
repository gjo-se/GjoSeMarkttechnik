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
   3.5.0 added T3&T4 Template
   3.5.1 fixed diverse
   3.5.2 changed Push-Logic
   3.5.3 fixed diverse
   3.6.0 optimized Objects (VLINES, TLINES, Regression, Fibo)
   3.7.0 added TT2

   ===============

*/

//+------------------------------------------------------------------+
//| Includes                                                         |
//+------------------------------------------------------------------+
#include "Basics\\T2\\T2Includes.mqh"
#include "Basics\\T3\\T3Includes.mqh"
#include "Basics\\T4\\T4Includes.mqh"
#include "Basics\\TT\\TTIncludes.mqh"

//+------------------------------------------------------------------+
//| Headers                                                          |
//+------------------------------------------------------------------+
#property copyright   "2022, GjoSe"
#property link        "http://www.gjo-se.com"
#property description "GjoSe Markttechnik"
#define   VERSION "3.7.0"
#property version VERSION
#property strict

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit() {

   if(UninitializeReason() != REASON_CHARTCHANGE) {
      initializeEAAction();
      initializeTTGlobalsAction();
      initializeT2GlobalsAction();
      initializeT3GlobalsAction();
      initializeT4GlobalsAction();
      initializeT2ArraysAction();
      initializeT3ArraysAction();
      initializeT4ArraysAction();
      initializeT3IndicatorsAction();
      initializeT4IndicatorsAction();

      rewriteVLineNamesWithText();

      setTT2LineValues();
      setT2LineValues();
      setTT3LineValues();
      setT3LineValues();
      setTT4LineValues();
      setT4LineValues();

      getTT2TrendDirection();
      getT2TrendDirection();
      getTT3TrendDirection();
      getT3TrendDirection();
      getTT4TrendDirection();
      getT4TrendDirection();

      setT3TrendLineValues();
      setT4TrendLineValues();

      handleTT2ObjectsInitAction();
      handleTT3ObjectsInitAction();
      handleT3ObjectsInitAction();
      handleTT4ObjectsInitAction();
      handleT4ObjectsInitAction();

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
      setT2LineValues();
      setT3LineValues();
      setT4LineValues();
      getT2TrendDirection();
      getT3TrendDirection();
      getT4TrendDirection();
      createT3HighVolumeAreaTrendLines();
   }

   handleT3Indictaors();
   handleT4Indictaors();
   handleT3StatesAction();
   handleT4StatesAction();
   handleT2TrendDetectionAction();
   handleT3TrendDetectionAction();
   handleT4TrendDetectionAction();
   setT3PositionStates();
   setT4PositionStates();
   if(InpPrintScreenshot == true) handleScreenshotAction();

   closeT3Actions();
   closeT4Actions();
   t3AlertOnBidStopLossLineOffset();
   t4AlertOnBidStopLossLineOffset();

   t2HandleObjectsAction();
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
      setTT2LineValues();
      setT2LineValues();
      setTT3LineValues();
      setT3LineValues();
      setTT4LineValues();
      setT4LineValues();

      getTT2TrendDirection();
      getT2TrendDirection();
      getTT3TrendDirection();
      getT3TrendDirection();
      getTT4TrendDirection();
      getT4TrendDirection();

      createTT2ZigZagTemplateLines();
      createTT3ZigZagTemplateLines();
      createT3ZigZagTrendDetectionLines();
      createTT4ZigZagTemplateLines();
      createT4ZigZagTrendDetectionLines();

      createTT2RegressionChannel();
      createT2RegressionChannel();
      createTT3RegressionChannel();
      createT3RegressionChannel();
      createT3RegressionChannelLevels();
      createTT4RegressionChannel();
      createT4RegressionChannel();
      createT4RegressionChannelLevels();

      createT2FiboRetracement();
      createT3FiboRetracement();
      createT4FiboRetracement();

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

      if(sparam == T2_MIN_HIGH_VOL_AREA || sparam == T2_MAX_HIGH_VOL_AREA) {

         datetime startDateTime = TimeCurrent();
         if(t2p1DateTime != 0) startDateTime = t2p1DateTime;
         if(t2p3DateTime != 0) startDateTime = t2p3DateTime;
         if(t2p5DateTime != 0) startDateTime = t2p5DateTime;

         t2MinHighVolumeAreaLevel = getTrendlineLevelByText(T2_MIN_HIGH_VOL_AREA, PERIOD_CURRENT, Symbol(), ChartID(), true);
         if(ObjectFind(ChartID(), T2_MIN_HIGH_VOL_AREA) >= 0) {
            ObjectSetString(ChartID(), T2_MIN_HIGH_VOL_AREA, OBJPROP_TEXT, T2_MIN_HIGH_VOL_AREA + ": " + DoubleToString(t2MinHighVolumeAreaLevel, Digits()));
            ObjectSetInteger(ChartID(), T2_MIN_HIGH_VOL_AREA, OBJPROP_TIME, 0, startDateTime);
            ObjectSetDouble(ChartID(), T2_MIN_HIGH_VOL_AREA, OBJPROP_PRICE, 0, t2MinHighVolumeAreaLevel);
            ObjectSetDouble(ChartID(), T2_MIN_HIGH_VOL_AREA, OBJPROP_PRICE, 1, t2MinHighVolumeAreaLevel);
         }

         t2MaxHighVolumeAreaLevel = getTrendlineLevelByText(T2_MAX_HIGH_VOL_AREA, PERIOD_CURRENT, Symbol(), ChartID(), true);
         if(ObjectFind(ChartID(), T2_MAX_HIGH_VOL_AREA) >= 0) {
            ObjectSetString(ChartID(), T2_MAX_HIGH_VOL_AREA, OBJPROP_TEXT, T2_MAX_HIGH_VOL_AREA + ": " + DoubleToString(t2MaxHighVolumeAreaLevel, Digits()));
            ObjectSetInteger(ChartID(), T2_MAX_HIGH_VOL_AREA, OBJPROP_TIME, 0, startDateTime);
            ObjectSetDouble(ChartID(), T2_MAX_HIGH_VOL_AREA, OBJPROP_PRICE, 0, t2MaxHighVolumeAreaLevel);
            ObjectSetDouble(ChartID(), T2_MAX_HIGH_VOL_AREA, OBJPROP_PRICE, 1, t2MaxHighVolumeAreaLevel);
         }

         createT2HighVolumeAreaChannel();
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

      if(sparam == T4_LONG_ENTRY_TLINE) {
         t4LongEntryValue = ObjectGetDouble(ChartID(), T4_LONG_ENTRY_TLINE, OBJPROP_PRICE, 1);
         if(t4LongEntryValue != 0) {
            string realVolume = DoubleToString(getT4BuyVolume(), 2);
            string verifiedVolume = DoubleToString(VerifyVolume(Symbol(), getT4BuyVolume()), 2);
            string lineText = T4_LONG_ENTRY_TLINE + ": " + DoubleToString(t4LongEntryValue, Digits()) + " Vol: " + realVolume + " (" + verifiedVolume + ")";
            ObjectSetString(ChartID(), T4_LONG_ENTRY_TLINE, OBJPROP_TEXT, lineText);
            ObjectSetInteger(ChartID(), T4_LONG_ENTRY_TLINE, OBJPROP_TIME, 0, t3p3DateTime);
            ObjectSetDouble(ChartID(), T4_LONG_ENTRY_TLINE, OBJPROP_PRICE, 0, t4LongEntryValue);
            ObjectSetDouble(ChartID(), T4_LONG_ENTRY_TLINE, OBJPROP_PRICE, 1, t4LongEntryValue);
         }
      }
      if(sparam == T4_SHORT_ENTRY_TLINE) {
         t4ShortEntryValue = ObjectGetDouble(ChartID(), T4_SHORT_ENTRY_TLINE, OBJPROP_PRICE, 1);
         if(t4ShortEntryValue != 0) {
            string realVolume = DoubleToString(getT4SellVolume(), 2);
            string verifiedVolume = DoubleToString(VerifyVolume(Symbol(), getT4SellVolume()), 2);
            string lineText = T4_SHORT_ENTRY_TLINE + ": " + DoubleToString(t4ShortEntryValue, Digits()) + " Vol: " + realVolume + " (" + verifiedVolume + ")";
            ObjectSetString(ChartID(), T4_SHORT_ENTRY_TLINE, OBJPROP_TEXT, lineText);
            ObjectSetInteger(ChartID(), T4_SHORT_ENTRY_TLINE, OBJPROP_TIME, 0, t3p3DateTime);
            ObjectSetDouble(ChartID(), T4_SHORT_ENTRY_TLINE, OBJPROP_PRICE, 0, t4ShortEntryValue);
            ObjectSetDouble(ChartID(), T4_SHORT_ENTRY_TLINE, OBJPROP_PRICE, 1, t4ShortEntryValue);
         }
      }
      if(sparam == T4_STOP_LOSS_TLINE) {
         t4StopLossValue = ObjectGetDouble(ChartID(), T4_STOP_LOSS_TLINE, OBJPROP_PRICE, 1);
         if(t4StopLossValue != 0) {
            if(t4LongEntryValue != 0) {
               string realVolume = DoubleToString(getT4BuyVolume(), 2);
               string verifiedVolume = DoubleToString(VerifyVolume(Symbol(), getT4BuyVolume()), 2);
               string lineText = T4_LONG_ENTRY_TLINE + ": " + DoubleToString(t4LongEntryValue, Digits()) + " Vol: " + realVolume + " (" + verifiedVolume + ")";
               ObjectSetString(ChartID(), T4_LONG_ENTRY_TLINE, OBJPROP_TEXT, lineText);
            }
            if(t4ShortEntryValue != 0) {
               string realVolume = DoubleToString(getT4SellVolume(), 2);
               string verifiedVolume = DoubleToString(VerifyVolume(Symbol(), getT4SellVolume()), 2);
               string lineText = T4_SHORT_ENTRY_TLINE + ": " + DoubleToString(t4ShortEntryValue, Digits()) + " Vol: " + realVolume + " (" + verifiedVolume + ")";
               ObjectSetString(ChartID(), T4_SHORT_ENTRY_TLINE, OBJPROP_TEXT, lineText);
            }
            ObjectSetString(ChartID(), T4_STOP_LOSS_TLINE, OBJPROP_TEXT, T4_STOP_LOSS_TLINE + ": " + DoubleToString(t4StopLossValue, Digits()));
            ObjectSetInteger(ChartID(), T4_STOP_LOSS_TLINE, OBJPROP_TIME, 0, t3p3DateTime);
            ObjectSetDouble(ChartID(), T4_STOP_LOSS_TLINE, OBJPROP_PRICE, 0, t4StopLossValue);
            ObjectSetDouble(ChartID(), T4_STOP_LOSS_TLINE, OBJPROP_PRICE, 1, t4StopLossValue);
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
