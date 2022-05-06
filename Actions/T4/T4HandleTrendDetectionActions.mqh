//+------------------------------------------------------------------+
//|                                 T4HandleTrendDetectionAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void getT4TrendDirection() {

   double t4p2ValueLocal = 0;

   t4SemiTrendDirection = TREND_DIRECTION_ROTATION;
   t4trendDirection = TREND_DIRECTION_ROTATION;

   if(t4p1ValueHigh != 0) {
      (t4p2ValueLow != 0) ? t4p2ValueLocal = t4p2ValueLow : t4p2ValueLocal = Bid();
      if(t4p1ValueHigh < t4p2ValueLocal) t4SemiTrendDirection = TREND_DIRECTION_LONG;
      if(t4p1ValueHigh > t4p2ValueLocal) t4SemiTrendDirection = TREND_DIRECTION_SHORT;
   }

   if(t4p3ValueHigh != 0 && t4p4ValueHigh != 0) {
      if(t4p3ValueHigh < t4p4ValueHigh) t4trendDirection = TREND_DIRECTION_LONG;
      if(t4p3ValueHigh > t4p4ValueHigh) t4trendDirection = TREND_DIRECTION_SHORT;
   }
}

void handleT4TrendDetectionAction() {

   if(t4AutoButtonState == true) {
      handleT4P2();
      handleT4P3();
      handleT4P4();
      handleT4P5();
      handleT4BuildNewTrend();
      handleT4TrendBrokenOnP1();
      handleT4TrendBrokenOnP3();
   }
}

void handleT4P2() {

   datetime t4p2DateTimeLocal = 0;
   double   t4p2ValueLocal = 0;
   double   t4P1P2MovementPoints = 0;
   string   errorText = "TT4 is Missing";


   if(t4p1DateTime != 0 && t4p1DateTime < (int)TimeCurrent()
         && t4p3DateTime == 0
     ) {

      if(tt4p1DateTime != 0) {

         deleteLabel(ERROR_LABEL + errorText);

         if(t4SemiTrendDirection == TREND_DIRECTION_LONG) {
            t4p2DateTimeLocal = iTime(Symbol(), PERIOD_M1, iHighest(Symbol(), PERIOD_M1, MODE_HIGH,  iBarShift(Symbol(), PERIOD_M1, t4p1DateTime) + 1));
            t4p2ValueLocal = iHigh(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t4p2DateTimeLocal));
            t4P1P2MovementPoints = t4p2ValueLocal / Point() - t4p1ValueLow / Point();

            if(isNewCurrentBar == true && t4ScreenshotT4P2CreatedBefore == true && t4ScreenshotT4P2CreatedAfter == false) {
               createScreenshot("T4P2-After");
               t4ScreenshotT4P2CreatedAfter = true;
            }

            if(Bid() >= t4p2ValueLocal
                  && t4P1P2MovementPoints > (tt4movementLength * InpT4MinMovementLengthBasedOnTT4MovementPercent / 100)
              ) {
               if(t4ScreenshotT4P2CreatedBefore == false) {
                  createScreenshot("T4P2-Before");
                  t4ScreenshotT4P2CreatedBefore = true;
               }
               createT4P2VLine(t4p2DateTimeLocal);
               getT4TrendDirection();
            }
         }

         if(t4SemiTrendDirection == TREND_DIRECTION_SHORT) {
            t4p2DateTimeLocal = iTime(Symbol(), PERIOD_M1, iLowest(Symbol(), PERIOD_M1, MODE_LOW,  iBarShift(Symbol(), PERIOD_M1, t4p1DateTime) + 1));
            t4p2ValueLocal = iLow(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t4p2DateTimeLocal));
            t4P1P2MovementPoints = t4p1ValueHigh / Point() - t4p2ValueLocal / Point();

            if(isNewCurrentBar == true && t4ScreenshotT4P2CreatedBefore == true && t4ScreenshotT4P2CreatedAfter == false) {
               createScreenshot("T4P2-After");
               t4ScreenshotT4P2CreatedAfter = true;
            }

            if(Bid() <= t4p2ValueLocal
                  && t4P1P2MovementPoints > (tt4movementLength * InpT4MinMovementLengthBasedOnTT4MovementPercent / 100)
              ) {
               if(t4ScreenshotT4P2CreatedBefore == false) {
                  createScreenshot("T4P2-Before");
                  t4ScreenshotT4P2CreatedBefore = true;
               }
               createT4P2VLine(t4p2DateTimeLocal);
               getT4TrendDirection();
            }
         }

      } else {
         createErrorLabel(errorText);
      }
   }
}

void handleT4P3() {

   datetime t4p3DateTimeLocal = 0;
   double   t4p3ValueLocal = 0;
   double   t4P2P3RegressionPoints = 0;

   if(t4p2ValueLow != 0 && t4p2DateTime < (int)TimeCurrent()
         && t4p4DateTime == 0
     ) {

      if(t4SemiTrendDirection == TREND_DIRECTION_LONG) {
         t4p3DateTimeLocal = iTime(Symbol(), PERIOD_M1, iLowest(Symbol(), PERIOD_M1, MODE_LOW,  iBarShift(Symbol(), PERIOD_M1, t4p2DateTime) + 1));
         t4p3ValueLocal = iLow(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t4p3DateTimeLocal));
         t4P2P3RegressionPoints = t4p2ValueHigh / Point() - t4p3ValueLocal / Point();

         if(isNewCurrentBar == true && t4ScreenshotT4P3CreatedBefore == true && t4ScreenshotT4P3CreatedAfter == false) {
            createScreenshot("T4P3-After");
            t4ScreenshotT4P3CreatedAfter = true;
         }

         if(Bid() <= t4p3ValueLocal
               && t4P2P3RegressionPoints > (tt4regressionLength * InpT4MinRegressionLengthBasedOnTT4RegressionPercent / 100)
           ) {
            if(t4ScreenshotT4P3CreatedBefore == false) {
               createScreenshot("T4P3-Before");
               t4ScreenshotT4P3CreatedBefore = true;
            }
            createT4P3VLine(t4p3DateTimeLocal);
            if(t4AlertT4P3CreatedSended == false) t4AlertT4P3CreatedAction();
         }
      }

      if(t4SemiTrendDirection == TREND_DIRECTION_SHORT) {
         t4p3DateTimeLocal = iTime(Symbol(), PERIOD_M1, iHighest(Symbol(), PERIOD_M1, MODE_HIGH,  iBarShift(Symbol(), PERIOD_M1, t4p2DateTime) + 1));
         t4p3ValueLocal = iHigh(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t4p3DateTimeLocal));
         t4P2P3RegressionPoints = t4p3ValueLocal / Point() - t4p2ValueLow / Point();

         if(isNewCurrentBar == true && t4ScreenshotT4P3CreatedBefore == true && t4ScreenshotT4P3CreatedAfter == false) {
            createScreenshot("T4P3-After");
            t4ScreenshotT4P3CreatedAfter = true;
         }

         if(Bid() >= t4p3ValueLocal
               && t4P2P3RegressionPoints > (tt4regressionLength * InpT4MinRegressionLengthBasedOnTT4RegressionPercent / 100)
           ) {
            if(t4ScreenshotT4P3CreatedBefore == false) {
               createScreenshot("T4P3-Before");
               t4ScreenshotT4P3CreatedBefore = true;
            }
            createT4P3VLine(t4p3DateTimeLocal);
            if(t4AlertT4P3CreatedSended == false) t4AlertT4P3CreatedAction();
         }
      }

   }
}

void handleT4P4() {

   datetime t4p4DateTimeLocal = 0;
   double   t4p4ValueLocal = 0;
   double   t4P3P4MovementPoints = 0;

   if(t4p3ValueHigh != 0 && t4p3DateTime < (int)TimeCurrent()
         && t4p5DateTime == 0
     ) {

      if(t4SemiTrendDirection == TREND_DIRECTION_LONG || t4trendDirection == TREND_DIRECTION_LONG) {
         t4p4DateTimeLocal = iTime(Symbol(), PERIOD_M1, iHighest(Symbol(), PERIOD_M1, MODE_HIGH,  iBarShift(Symbol(), PERIOD_M1, t4p3DateTime) + 1));
         t4p4ValueLocal = iHigh(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t4p4DateTimeLocal));
         t4P3P4MovementPoints = t4p4ValueLocal / Point() - t4p3ValueLow / Point();

         if(isNewCurrentBar == true && t4ScreenshotT4P4CreatedBefore == true && t4ScreenshotT4P4CreatedAfter == false) {
            createScreenshot("T4P4-After");
            t4ScreenshotT4P4CreatedAfter = true;
         }

         if(Bid() >= t4p4ValueLocal
               && t4P3P4MovementPoints > (tt4movementLength * InpT4MinMovementLengthBasedOnTT4MovementPercent / 100)
               && t4p2ValueHigh != 0
               && t4p4ValueLocal > t4p2ValueHigh
           ) {
            if(t4ScreenshotT4P4CreatedBefore == false) {
               createScreenshot("T4P4-Before");
               t4ScreenshotT4P4CreatedBefore = true;
            }
            createT4P4VLine(t4p4DateTimeLocal);
            getT4TrendDirection();
         }
      }

      if(t4SemiTrendDirection == TREND_DIRECTION_SHORT || t4trendDirection == TREND_DIRECTION_SHORT) {
         t4p4DateTimeLocal = iTime(Symbol(), PERIOD_M1, iLowest(Symbol(), PERIOD_M1, MODE_LOW,  iBarShift(Symbol(), PERIOD_M1, t4p3DateTime) + 1));
         t4p4ValueLocal = iLow(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t4p4DateTimeLocal));
         t4P3P4MovementPoints = t4p3ValueHigh / Point() - t4p4ValueLocal / Point();

         if(isNewCurrentBar == true && t4ScreenshotT4P4CreatedBefore == true && t4ScreenshotT4P4CreatedAfter == false) {
            createScreenshot("T4P4-After");
            t4ScreenshotT4P4CreatedAfter = true;
         }

         if(Bid() <= t4p4ValueLocal
               && t4P3P4MovementPoints > (tt4movementLength * InpT4MinMovementLengthBasedOnTT4MovementPercent / 100)
               && t4p2ValueLow != 0
               && t4p4ValueLocal < t4p2ValueLow
           ) {
            if(t4ScreenshotT4P4CreatedBefore == false) {
               createScreenshot("T4P4-Before");
               t4ScreenshotT4P4CreatedBefore = true;
            }
            createT4P4VLine(t4p4DateTimeLocal);
            getT4TrendDirection();
         }
      }

   }
}

void handleT4P5() {

   datetime t4p5DateTimeTmp = 0;
   double   t4p5ValueTmp = 0;
   double   t4P4P5RegressionPoints = 0;

   if(t4p4ValueLow != 0
         && t4p4DateTime < (int)TimeCurrent()
     ) {

      if(t4trendDirection == TREND_DIRECTION_LONG) {
         t4p5DateTimeTmp = iTime(Symbol(), PERIOD_M1, iLowest(Symbol(), PERIOD_M1, MODE_LOW,  iBarShift(Symbol(), PERIOD_M1, t4p4DateTime) + 1));
         t4p5ValueTmp = iLow(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t4p5DateTimeTmp));
         t4P4P5RegressionPoints = t4p4ValueHigh / Point() - t4p5ValueTmp / Point();

         if(isNewCurrentBar == true && t4ScreenshotT4P5CreatedBefore == true && t4ScreenshotT4P5CreatedAfter == false) {
            createScreenshot("T4P5-After");
            t4ScreenshotT4P5CreatedAfter = true;
         }

         if(Bid() <= t4p5ValueTmp
               && t4P4P5RegressionPoints > (tt4regressionLength * InpT4MinRegressionLengthBasedOnTT4RegressionPercent / 100)
           ) {
            createT4P5VLine(t4p5DateTimeTmp);
            if(t3trendDirection == t4trendDirection && buyT4PositionIsOpenState == false) {
               if(t4ScreenshotT4P5CreatedBefore == false) {
                  createScreenshot("T4P5-Before");
                  t4ScreenshotT4P5CreatedBefore = true;
               }
               if(t4AlertT4P5CreatedSended == false) t4AlertT4P5CreatedAction();
               t4StopLossValue = t4p5ValueTmp;
               createT4StopLossTrendline(t4StopLossValue);
               if(ObjectFind(ChartID(), T4_LONG_ENTRY_TLINE) < 0) {
                  t4LongEntryValue = t4p4ValueHigh;
                  createT4LongEntryTrendLine(t4LongEntryValue);
               }
               string realVolume = DoubleToString(getT4BuyVolume(), 2);
               string verifiedVolume = DoubleToString(VerifyVolume(Symbol(), getT4BuyVolume()), 2);
               string lineText = T4_LONG_ENTRY_TLINE + ": " + DoubleToString(t4LongEntryValue, Digits()) + " Vol: " + realVolume + " (" + verifiedVolume + ")";
               ObjectSetString(ChartID(), T4_LONG_ENTRY_TLINE, OBJPROP_TEXT, lineText);
            }
         }
      }

      if(t4trendDirection == TREND_DIRECTION_SHORT) {
         t4p5DateTimeTmp = iTime(Symbol(), PERIOD_M1, iHighest(Symbol(), PERIOD_M1, MODE_HIGH,  iBarShift(Symbol(), PERIOD_M1, t4p4DateTime) + 1));
         t4p5ValueTmp = iHigh(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t4p5DateTimeTmp));
         t4P4P5RegressionPoints = t4p5ValueTmp / Point() - t4p4ValueLow / Point();

         if(isNewCurrentBar == true && t4ScreenshotT4P5CreatedBefore == true && t4ScreenshotT4P5CreatedAfter == false) {
            createScreenshot("T4P5-After");
            t4ScreenshotT4P5CreatedAfter = true;
         }

         if(Bid() >= t4p5ValueTmp
               && t4P4P5RegressionPoints > (tt4regressionLength * InpT4MinRegressionLengthBasedOnTT4RegressionPercent / 100)
           ) {
            createT4P5VLine(t4p5DateTimeTmp);
            if(t3trendDirection == t4trendDirection && sellT4PositionIsOpenState == false) {
               if(t4ScreenshotT4P5CreatedBefore == false) {
                  createScreenshot("T4P5-Before");
                  t4ScreenshotT4P5CreatedBefore = true;
               }
               if(t4AlertT4P5CreatedSended == false) t4AlertT4P5CreatedAction();
               t4StopLossValue = t4p5ValueTmp;
               createT4StopLossTrendline(t4StopLossValue);
               if(ObjectFind(ChartID(), T4_SHORT_ENTRY_TLINE) < 0) {
                  t4ShortEntryValue = t4p4ValueLow;
                  createT4ShortEntryTrendLine(t4ShortEntryValue);
               }
               string realVolume = DoubleToString(getT4SellVolume(), 2);
               string verifiedVolume = DoubleToString(VerifyVolume(Symbol(), getT4SellVolume()), 2);
               string lineText = T4_SHORT_ENTRY_TLINE + ": " + DoubleToString(t4ShortEntryValue, Digits()) + " Vol: " + realVolume + " (" + verifiedVolume + ")";
               ObjectSetString(ChartID(), T4_SHORT_ENTRY_TLINE, OBJPROP_TEXT, lineText);
            }
         }
      }
   }
}

void handleT4BuildNewTrend() {

   double   t4P5P6MovementPoints = 0;
   datetime t4p3DateTimeTmp = 0;
   datetime t4p4DateTimeTmp = 0;
   datetime t4p5DateTimeTmp = 0;

   if(t4p5ValueHigh != 0
         && t4p5DateTime < (int)TimeCurrent()
     ) {

      if(t4SemiTrendDirection == TREND_DIRECTION_LONG || t4trendDirection == TREND_DIRECTION_LONG) {
         t4P5P6MovementPoints = Bid() / Point() - t4p5ValueLow / Point();

         if(isNewCurrentBar == true && t4ScreenshotT4BuildNewTrendBefore == true && t4ScreenshotT4BuildNewTrendAfter == false) {
            createScreenshot("T4BuildNewTrend-After");
            t4ScreenshotT4BuildNewTrendAfter = true;
         }

         if(t4P5P6MovementPoints > (tt4movementLength * InpT4MinMovementLengthBasedOnTT4MovementPercent / 100)
               && t4p4ValueHigh != 0
               && Bid() > t4p4ValueHigh
           ) {
            if(t4ScreenshotT4BuildNewTrendBefore == false) {
               createScreenshot("T4BuildNewTrend-Before");
               t4ScreenshotT4BuildNewTrendBefore = true;
            }
            if(t4p3DateTime != 0 && t4p4DateTime != 0 && t4p5DateTime != 0) {
               t4p3DateTimeTmp = t4p3DateTime;
               t4p4DateTimeTmp = t4p4DateTime;
               t4p5DateTimeTmp = t4p5DateTime;
               resetT4Trend();
               createT4P1VLine(t4p3DateTimeTmp);
               createT4P2VLine(t4p4DateTimeTmp);
               createT4P3VLine(t4p5DateTimeTmp);
               getT4TrendDirection();
            }
         }
      }

      if(t4SemiTrendDirection == TREND_DIRECTION_SHORT || t4trendDirection == TREND_DIRECTION_SHORT) {
         t4P5P6MovementPoints = t4p5ValueHigh / Point() - Bid() / Point();

         if(isNewCurrentBar == true && t4ScreenshotT4BuildNewTrendBefore == true && t4ScreenshotT4BuildNewTrendAfter == false) {
            createScreenshot("T4BuildNewTrend-After");
            t4ScreenshotT4BuildNewTrendAfter = true;
         }

         if(t4P5P6MovementPoints > (tt4movementLength * InpT4MinMovementLengthBasedOnTT4MovementPercent / 100)
               && t4p4ValueLow != 0
               && Bid() < t4p4ValueLow
           ) {
            if(t4ScreenshotT4BuildNewTrendBefore == false) {
               createScreenshot("T4BuildNewTrend-Before");
               t4ScreenshotT4BuildNewTrendBefore = true;
            }
            if(t4p3DateTime != 0 && t4p4DateTime != 0 && t4p5DateTime != 0) {
               t4p3DateTimeTmp = t4p3DateTime;
               t4p4DateTimeTmp = t4p4DateTime;
               t4p5DateTimeTmp = t4p5DateTime;
               resetT4Trend();
               createT4P1VLine(t4p3DateTimeTmp);
               createT4P2VLine(t4p4DateTimeTmp);
               createT4P3VLine(t4p5DateTimeTmp);
               getT4TrendDirection();
            }
         }
      }
   }
}
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void handleT4TrendBrokenOnP1() {

   datetime t4p2DateTimeTmp = 0;
   datetime t4p3DateTimeTmp = 0;

   if(t4p1ValueHigh != 0
         && t4p2ValueLow != 0
         && t4p3ValueHigh != 0
         && t4p1DateTime <= (int)TimeCurrent()
         && t4p2DateTime <= (int)TimeCurrent()
         && t4p3DateTime <= (int)TimeCurrent()
     ) {

      if(t4SemiTrendDirection == TREND_DIRECTION_LONG || t4trendDirection == TREND_DIRECTION_LONG) {

         if(Bid() < t4p1ValueLow) {
            if(t4ScreenshotT4TrendBrokenOnP1Before == false) {
               createScreenshot("T4TrendBrokenOnP1-Before");
               t4ScreenshotT4TrendBrokenOnP1Before = true;
            }
            if(t4p2DateTime != 0 && t4p3DateTime != 0) {
               t4p2DateTimeTmp = t4p2DateTime;
               t4p3DateTimeTmp = t4p3DateTime;
               resetT4Trend();
               createT4P1VLine(t4p2DateTimeTmp);
               createT4P2VLine(t4p3DateTimeTmp);
               getT4TrendDirection();
               if(t4AlertT4TrendBrokenSended == false) t4AlertT4TrendBrokenAction();
            }
         }
      }

      if(t4SemiTrendDirection == TREND_DIRECTION_SHORT || t4trendDirection == TREND_DIRECTION_SHORT) {

         if(Bid() > t4p1ValueHigh) {
            if(t4ScreenshotT4TrendBrokenOnP1Before == false) {
               createScreenshot("T4TrendBrokenOnP1-Before");
               t4ScreenshotT4TrendBrokenOnP1Before = true;
            }
            if(t4p2DateTime != 0 && t4p3DateTime != 0) {
               t4p2DateTimeTmp = t4p2DateTime;
               t4p3DateTimeTmp = t4p3DateTime;
               resetT4Trend();
               createT4P1VLine(t4p2DateTimeTmp);
               createT4P2VLine(t4p3DateTimeTmp);
               getT4TrendDirection();
               if(t4AlertT4TrendBrokenSended == false) t4AlertT4TrendBrokenAction();
            }
         }
      }
   }

   if(isNewCurrentBar == true && t4ScreenshotT4TrendBrokenOnP1Before == true && t4ScreenshotT4TrendBrokenOnP1After == false) {
      createScreenshot("T4TrendBrokenOnP1-After");
      t4ScreenshotT4TrendBrokenOnP1After = true;
   }

}

void handleT4TrendBrokenOnP3() {

   datetime t4p4DateTimeTmp = 0;
   datetime t4p5DateTimeTmp = 0;

   if(t4p3ValueHigh != 0
         && t4p4ValueLow != 0
         && t4p5ValueHigh != 0
         && t4p3DateTime < (int)TimeCurrent()
         && t4p4DateTime < (int)TimeCurrent()
         && t4p5DateTime < (int)TimeCurrent()
     ) {

      if(t4SemiTrendDirection == TREND_DIRECTION_LONG || t4trendDirection == TREND_DIRECTION_LONG) {

         if(Bid() < t4p3ValueLow) {
            if(t4ScreenshotT4TrendBrokenOnP3Before == false) {
               createScreenshot("T4TrendBrokenOnP3-Before");
               t4ScreenshotT4TrendBrokenOnP3Before = true;
            }
            if(t4p4DateTime != 0 && t4p5DateTime != 0) {
               t4p4DateTimeTmp = t4p4DateTime;
               t4p5DateTimeTmp = t4p5DateTime;
               resetT4Trend();
               deleteVLine(T4_STOP_LOSS_TLINE);
               deleteVLine(T4_LONG_ENTRY_TLINE);
               createT4P1VLine(t4p4DateTimeTmp);
               createT4P2VLine(t4p5DateTimeTmp);
               getT4TrendDirection();
               if(t4AlertT4TrendBrokenSended == false) t4AlertT4TrendBrokenAction();
            }
         }
      }

      if(t4SemiTrendDirection == TREND_DIRECTION_SHORT || t4trendDirection == TREND_DIRECTION_SHORT) {

         if(Bid() > t4p3ValueHigh) {
            if(t4ScreenshotT4TrendBrokenOnP3Before == false) {
               createScreenshot("T4TrendBrokenOnP3-Before");
               t4ScreenshotT4TrendBrokenOnP3Before = true;
            }
            if(t4p4DateTime != 0 && t4p5DateTime != 0) {
               t4p4DateTimeTmp = t4p4DateTime;
               t4p5DateTimeTmp = t4p5DateTime;
               resetT4Trend();
               deleteVLine(T4_STOP_LOSS_TLINE);
               deleteVLine(T4_SHORT_ENTRY_TLINE);
               createT4P1VLine(t4p4DateTimeTmp);
               createT4P2VLine(t4p5DateTimeTmp);
               getT4TrendDirection();
               if(t4AlertT4TrendBrokenSended == false) t4AlertT4TrendBrokenAction();
            }
         }
      }
   }

   if(isNewCurrentBar == true && t4ScreenshotT4TrendBrokenOnP3Before == true && t4ScreenshotT4TrendBrokenOnP3After == false) {
      createScreenshot("T4TrendBrokenOnP3-After");
      t4ScreenshotT4TrendBrokenOnP3After = true;
   }

}

//+------------------------------------------------------------------+
void resetT4Trend() {

   deleteVLine(T4_P1_VLINE);
   deleteVLine(T4_P2_VLINE);
   deleteVLine(T4_P3_VLINE);
   deleteVLine(T4_P4_VLINE);
   deleteVLine(T4_P5_VLINE);
   setT4LineValues();
   getT4TrendDirection();

   deleteTrendLine(T4_ZIGZAGLINE + "P1-P2");
   deleteTrendLine(T4_ZIGZAGLINE + "P2-P3");
   deleteTrendLine(T4_ZIGZAGLINE + "P3-P4");
   deleteTrendLine(T4_ZIGZAGLINE + "P4-P5");

   deleteRegressionChannel(T4_REGRESSION_CHANNEL);
   deleteFiboLevelsObject(T4_FIBO_LEVELS);

   t4AlertT4P4CreatedSended = false;
   t4AlertT4P5CreatedSended = false;
   t4AlertT4TrendBrokenSended = false;

   t4ScreenshotT4P2CreatedBefore = false;
   t4ScreenshotT4P2CreatedAfter = false;
   t4ScreenshotT4P3CreatedBefore = false;
   t4ScreenshotT4P3CreatedAfter = false;
   t4ScreenshotT4P4CreatedBefore = false;
   t4ScreenshotT4P4CreatedAfter = false;
   t4ScreenshotT4P5CreatedBefore = false;
   t4ScreenshotT4P5CreatedAfter = false;
   t4ScreenshotT4BuildNewTrendBefore = false;
   t4ScreenshotT4BuildNewTrendAfter = false;
   t4ScreenshotT4TrendBrokenOnP1Before = false;
   t4ScreenshotT4TrendBrokenOnP1After = false;
   t4ScreenshotT4TrendBrokenOnP3Before = false;
   t4ScreenshotT4TrendBrokenOnP3After = false;
}

//+------------------------------------------------------------------+
