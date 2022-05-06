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
   3.8.0 added T2 Automatic
   3.8.1 deactivate T3 & T4 - new TMP Version
   3.8.2 Alert on Position open/close
   3.8.3 T2 diverse
   3.8.4 added HLINE Alerts
   3.9.0 TrendDetection T2/T3/T4 new Level
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
#define   VERSION "3.9.0"
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

      setT4TrendLineValues();

      handleTT2ObjectsInitAction();
      handleT2ObjectsInitAction();
      handleTT3ObjectsInitAction();
      handleT3ObjectsInitAction();
      handleTT4ObjectsInitAction();
      handleT4ObjectsInitAction();

      handleCommentAction(VERSION);
   }

   int objectsTotal = ObjectsTotal(ChartID(), 0, -1);
   string objName;
   string autotrade = "autotrade";

   for(int i = objectsTotal; i >= 0; i--) {
      objName = ObjectName(ChartID(), i);
      if(StringFind(objName, autotrade) != -1) {
         ObjectSetInteger(ChartID(), objName, OBJPROP_TIMEFRAMES, OBJ_PERIOD_H1 | OBJ_PERIOD_M10 | OBJ_PERIOD_M1);
         ObjectSetString(ChartID(), objName, OBJPROP_TEXT, "");
      }
   }

   if(MQLInfoInteger(MQL_TESTER) == 1) {

      t4IsTradabelButtonState = true;
      t2AutoButtonState = true;
      t3AutoButtonState = true;
      t4AutoButtonState = true;

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
      getT2TrendDirection();
      getT3TrendDirection();
      getT4TrendDirection();
   }

   handleT3Indictaors();
   handleT4Indictaors();
   handleT4StatesAction();
   handleT2TrendDetectionAction();
   handleT3TrendDetectionAction();
   handleT4TrendDetectionAction();
   setT4PositionStates();
   if(InpPrintScreenshot == true) handleScreenshotAction();

   closeT4Actions();
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

   //if(getT4BuyInSignal() == true) openT4BuyOrderAction();
   //if(getT4SellInSignal() == true) openT4SellOrderAction();

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
      getTT2TrendDirection();
      createTT2ZigZagTemplateLines();
      createTT2RegressionChannel();

      setT2LineValues();
      getT2TrendDirection();
      createT2ZigZagTrendDetectionLines();
      createT2RegressionChannel();
      createT2RegressionChannelLevels();
      createT2FiboRetracement();
      createT2HighVolumeAreaTrendLines();

      setTT3LineValues();
      getTT3TrendDirection();
      createTT3ZigZagTemplateLines();
      createTT3RegressionChannel();

      setT3LineValues();
      getT3TrendDirection();
      createT3ZigZagTrendDetectionLines();
      createT3RegressionChannel();
      createT3RegressionChannelLevels();
      createT3FiboRetracement();

      setTT4LineValues();
      getTT4TrendDirection();
      createTT4ZigZagTemplateLines();
      createTT4RegressionChannel();

      setT4LineValues();
      getT4TrendDirection();
      createT4ZigZagTrendDetectionLines();

      if(sparam == T4_STOP_LOSS_TLINE) {
         t4IsBidStopLossLineOffsetAlertSendable = true;
         t4IsBidStopLossLineOffsetAlertSended = false;
      }

      if(sparam == T2_MIN_HIGH_VOL_AREA || sparam == T2_MAX_HIGH_VOL_AREA) {

         t2MaxHighVolumeAreaLevel = ObjectGetDouble(ChartID(), T2_MAX_HIGH_VOL_AREA, OBJPROP_PRICE, 0);
         if(ObjectFind(ChartID(), T2_MAX_HIGH_VOL_AREA) >= 0) {
            ObjectSetString(ChartID(), T2_MAX_HIGH_VOL_AREA, OBJPROP_TEXT, T2_MAX_HIGH_VOL_AREA + ": " + DoubleToString(t2MaxHighVolumeAreaLevel, Digits()));
            ObjectSetDouble(ChartID(), T2_MAX_HIGH_VOL_AREA, OBJPROP_PRICE, 0, t2MaxHighVolumeAreaLevel);
            ObjectSetDouble(ChartID(), T2_MAX_HIGH_VOL_AREA, OBJPROP_PRICE, 1, t2MaxHighVolumeAreaLevel);
         }

         t2MinHighVolumeAreaLevel = getTrendlineLevelByText(T2_MIN_HIGH_VOL_AREA, PERIOD_CURRENT, Symbol(), ChartID(), true);
         if(ObjectFind(ChartID(), T2_MIN_HIGH_VOL_AREA) >= 0) {
            ObjectSetString(ChartID(), T2_MIN_HIGH_VOL_AREA, OBJPROP_TEXT, T2_MIN_HIGH_VOL_AREA + ": " + DoubleToString(t2MinHighVolumeAreaLevel, Digits()));
            datetime startDateTime = (datetime) ObjectGetInteger(ChartID(), T2_MAX_HIGH_VOL_AREA, OBJPROP_TIME, 0);
            ObjectSetInteger(ChartID(), T2_MIN_HIGH_VOL_AREA, OBJPROP_TIME, 0, startDateTime);
            ObjectSetDouble(ChartID(), T2_MIN_HIGH_VOL_AREA, OBJPROP_PRICE, 0, t2MinHighVolumeAreaLevel);
            ObjectSetDouble(ChartID(), T2_MIN_HIGH_VOL_AREA, OBJPROP_PRICE, 1, t2MinHighVolumeAreaLevel);
         }

         createT2HighVolumeAreaChannel();
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

      if(sparam == T4_ALERT_BID_HIGHER_HINE + T4_ALERT_HINE_TIGGERT) {
         t4AlertHigherHLineSended = false;
         t4AlertHigherHLineValue = ObjectGetDouble(ChartID(), T4_ALERT_BID_HIGHER_HINE + T4_ALERT_HINE_TIGGERT, OBJPROP_PRICE);
         string originalText = ObjectGetString(ChartID(), T4_ALERT_BID_HIGHER_HINE + T4_ALERT_HINE_TIGGERT, OBJPROP_TEXT);
         string newText = StringSubstr(originalText, 0, StringLen(originalText) - StringLen(T4_ALERT_HINE_TIGGERT));
         ObjectSetString(ChartID(), T4_ALERT_BID_HIGHER_HINE + T4_ALERT_HINE_TIGGERT, OBJPROP_TEXT, newText);
         ObjectSetInteger(ChartID(), T4_ALERT_BID_HIGHER_HINE + T4_ALERT_HINE_TIGGERT, OBJPROP_STYLE, STYLE_SOLID);
         ObjectSetString(ChartID(), T4_ALERT_BID_HIGHER_HINE + T4_ALERT_HINE_TIGGERT, OBJPROP_NAME, T4_ALERT_BID_HIGHER_HINE);
      }
      if(sparam == T4_ALERT_BID_HIGHER_HINE) {
         t4AlertHigherHLineValue = ObjectGetDouble(ChartID(), T4_ALERT_BID_HIGHER_HINE, OBJPROP_PRICE);
      }

      if(sparam == T4_ALERT_BID_LOWER_HINE + T4_ALERT_HINE_TIGGERT) {
         t4AlertLowerHLineSended = false;
         t4AlertLowerHLineValue = ObjectGetDouble(ChartID(), T4_ALERT_BID_LOWER_HINE + T4_ALERT_HINE_TIGGERT, OBJPROP_PRICE);
         string originalText = ObjectGetString(ChartID(), T4_ALERT_BID_LOWER_HINE + T4_ALERT_HINE_TIGGERT, OBJPROP_TEXT);
         string newText = StringSubstr(originalText, 0, StringLen(originalText) - StringLen(T4_ALERT_HINE_TIGGERT));
         ObjectSetString(ChartID(), T4_ALERT_BID_LOWER_HINE + T4_ALERT_HINE_TIGGERT, OBJPROP_TEXT, newText);
         ObjectSetInteger(ChartID(), T4_ALERT_BID_LOWER_HINE + T4_ALERT_HINE_TIGGERT, OBJPROP_STYLE, STYLE_SOLID);
         ObjectSetString(ChartID(), T4_ALERT_BID_LOWER_HINE + T4_ALERT_HINE_TIGGERT, OBJPROP_NAME, T4_ALERT_BID_LOWER_HINE);
      }
      if(sparam == T4_ALERT_BID_LOWER_HINE) {
         t4AlertLowerHLineValue = ObjectGetDouble(ChartID(), T4_ALERT_BID_LOWER_HINE, OBJPROP_PRICE);
      }
   }

   if(id == CHARTEVENT_OBJECT_CLICK) {

      if(sparam == T2_AUTO_BUTTON) handleT2AutoButton();
      if(sparam == T3_AUTO_BUTTON) handleT3AutoButton();
      if(sparam == T4_AUTO_BUTTON) handleT4AutoButton();

      if(sparam == T4_IS_TRADEABLE_BUTTON) {
         handleT4IsTradeableButton();
         handleCommentAction(VERSION);
      }
   }
}
//+------------------------------------------------------------------+
