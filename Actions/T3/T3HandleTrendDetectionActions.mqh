//+------------------------------------------------------------------+
//|                                 T3HandleTrendDetectionAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void getT3TrendDirection() {

   double t3p2ValueTmp = 0;
   t3SemiTrendDirection = TREND_DIRECTION_ROTATION;
   t3trendDirection = TREND_DIRECTION_ROTATION;

   if(t3p1ValueHigh != 0) {
      (t3p2ValueLow != 0) ? t3p2ValueTmp = t3p2ValueLow : t3p2ValueTmp = Bid();
      if(t3p1ValueHigh < t3p2ValueTmp) t3SemiTrendDirection = TREND_DIRECTION_LONG;
      if(t3p1ValueHigh > t3p2ValueTmp) t3SemiTrendDirection = TREND_DIRECTION_SHORT;
   }

   if(t3p3ValueHigh != 0 && t3p4ValueHigh != 0) {
      if(t3p3ValueHigh < t3p4ValueHigh) t3trendDirection = TREND_DIRECTION_LONG;
      if(t3p3ValueHigh > t3p4ValueHigh) t3trendDirection = TREND_DIRECTION_SHORT;
   }
}

void handleT3TrendDetectionAction() {

   handleT3P2();
   handleT3P3();
   handleT3P4();
   handleT3P5();
   handleT3BuildNewTrend();
   handleT3TrendBrokenOnP1();
   handleT3TrendBrokenOnP3();
}
//+------------------------------------------------------------------+

void handleT3P2() {

   datetime t3p1DateTimeTmp = 0;
   datetime t3p2DateTimeTmp = 0;
   double   t3p2ValueTmp = 0;
   double   t3P1P2MovementPoints = 0;

   if(t3p1DateTime != 0
         && t3p1DateTime < (int)TimeCurrent()
         && t3p3DateTime == 0
     ) {

      if(t3SemiTrendDirection == TREND_DIRECTION_LONG) {
         t3p2DateTimeTmp = iTime(Symbol(), PERIOD_M1, iHighest(Symbol(), PERIOD_M1, MODE_HIGH,  iBarShift(Symbol(), PERIOD_M1, t3p1DateTimeTmp) + 1));
         t3p2ValueTmp = iHigh(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t3p2DateTimeTmp));
         t3P1P2MovementPoints = t3p2ValueTmp / Point() - t3p1ValueLow / Point();

         if(isNewCurrentBar == true && t3ScreenshotT3P2CreatedBefore == true && t3ScreenshotT3P2CreatedAfter == false) {
            createScreenshot("T3P2-After");
            t3ScreenshotT3P2CreatedAfter = true;
         }

         if(Bid() >= t3p2ValueTmp
               && t3P1P2MovementPoints > (tt3movementLength * InpT3MinMovementLengthBasedOnTT3MovementPercent / 100)
           ) {
            if(t3ScreenshotT3P2CreatedBefore == false) {
               createScreenshot("T3P2-Before");
               t3ScreenshotT3P2CreatedBefore = true;
            }
            createT3P2VLine(t3p2DateTimeTmp);
            getT3TrendDirection();
            if(t3AlertT3P2CreatedSended == false) t3AlertT3P2CreatedAction();
         }
      }

      if(t3SemiTrendDirection == TREND_DIRECTION_SHORT) {
         t3p2DateTimeTmp = iTime(Symbol(), PERIOD_M1, iLowest(Symbol(), PERIOD_M1, MODE_LOW,  iBarShift(Symbol(), PERIOD_M1, t3p1DateTimeTmp) + 1));
         t3p2ValueTmp = iLow(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t3p2DateTimeTmp));
         t3P1P2MovementPoints = t3p1ValueHigh / Point() - t3p2ValueTmp / Point();

         if(isNewCurrentBar == true && t3ScreenshotT3P2CreatedBefore == true && t3ScreenshotT3P2CreatedAfter == false) {
            createScreenshot("T3P2-After");
            t3ScreenshotT3P2CreatedAfter = true;
         }

         if(Bid() <= t3p2ValueTmp
               && t3P1P2MovementPoints > (tt3movementLength * InpT3MinMovementLengthBasedOnTT3MovementPercent / 100)
           ) {
            if(t3ScreenshotT3P2CreatedBefore == false) {
               createScreenshot("T3P2-Before");
               t3ScreenshotT3P2CreatedBefore = true;
            }
            createT3P2VLine(t3p2DateTimeTmp);
            getT3TrendDirection();
            if(t3AlertT3P2CreatedSended == false) t3AlertT3P2CreatedAction();
         }
      }

   }
}

void handleT3P3() {

   datetime t3p3DateTimeTmp = 0;
   double   t3p3ValueTmp = 0;
   double   t3P2P3RegressionPoints = 0;

   if(t3p2ValueLow != 0
         && t3p2DateTime < (int)TimeCurrent()
         && t3p4DateTime == 0
     ) {

      if(t3SemiTrendDirection == TREND_DIRECTION_LONG) {
         t3p3DateTimeTmp = iTime(Symbol(), PERIOD_M1, iLowest(Symbol(), PERIOD_M1, MODE_LOW,  iBarShift(Symbol(), PERIOD_M1, t3p2DateTime) + 1));
         t3p3ValueTmp = iLow(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t3p3DateTimeTmp));
         t3P2P3RegressionPoints = t3p2ValueHigh / Point() - t3p3ValueTmp / Point();

         if(isNewCurrentBar == true && t3ScreenshotT3P3CreatedBefore == true && t3ScreenshotT3P3CreatedAfter == false) {
            createScreenshot("T3P3-After");
            t3ScreenshotT3P3CreatedAfter = true;
         }

         if(Bid() <= t3p3ValueTmp
               && t3P2P3RegressionPoints > (tt3regressionLength * InpT3MinRegressionLengthBasedOnTT3RegressionPercent / 100)
           ) {
            if(t3ScreenshotT3P3CreatedBefore == false) {
               createScreenshot("T3P3-Before");
               t3ScreenshotT3P3CreatedBefore = true;
            }
            createT3P3VLine(t3p3DateTimeTmp);
            if(t3AlertT3P3CreatedSended == false) t3AlertT3P3CreatedAction();
         }
      }

      if(t3SemiTrendDirection == TREND_DIRECTION_SHORT) {
         t3p3DateTimeTmp = iTime(Symbol(), PERIOD_M1, iHighest(Symbol(), PERIOD_M1, MODE_HIGH,  iBarShift(Symbol(), PERIOD_M1, t3p2DateTime) + 1));
         t3p3ValueTmp = iHigh(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t3p3DateTimeTmp));
         t3P2P3RegressionPoints = t3p3ValueTmp / Point() - t3p2ValueLow / Point();

         if(isNewCurrentBar == true && t3ScreenshotT3P3CreatedBefore == true && t3ScreenshotT3P3CreatedAfter == false) {
            createScreenshot("T3P3-After");
            t3ScreenshotT3P3CreatedAfter = true;
         }

         if(Bid() >= t3p3ValueTmp
               && t3P2P3RegressionPoints > (tt3regressionLength * InpT3MinRegressionLengthBasedOnTT3RegressionPercent / 100)
           ) {
            if(t3ScreenshotT3P3CreatedBefore == false) {
               createScreenshot("T3P3-Before");
               t3ScreenshotT3P3CreatedBefore = true;
            }
            createT3P3VLine(t3p3DateTimeTmp);
            if(t3AlertT3P3CreatedSended == false) t3AlertT3P3CreatedAction();
         }
      }
   }
}

void handleT3P4() {

   datetime t3p4DateTimeTmp = 0;
   double   t3p4ValueTmp = 0;
   double   t3P2P4MovementPoints = 0;

   if(t3p3ValueHigh != 0
         && t3p3DateTime < (int)TimeCurrent()
         && t3p5DateTime == 0
     ) {

      if(t3SemiTrendDirection == TREND_DIRECTION_LONG || t3trendDirection == TREND_DIRECTION_LONG) {
         t3p4DateTimeTmp = iTime(Symbol(), PERIOD_M1, iHighest(Symbol(), PERIOD_M1, MODE_HIGH,  iBarShift(Symbol(), PERIOD_M1, t3p3DateTime) + 1));
         t3p4ValueTmp = iHigh(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t3p4DateTimeTmp));
         t3P2P4MovementPoints = t3p4ValueTmp / Point() - t3p3ValueLow / Point();

         if(isNewCurrentBar == true && t3ScreenshotT3P4CreatedBefore == true && t3ScreenshotT3P4CreatedAfter == false) {
            createScreenshot("T3P4-After");
            t3ScreenshotT3P4CreatedAfter = true;
         }

         if(Bid() >= t3p4ValueTmp
               && t3P2P4MovementPoints > (tt3movementLength * InpT3MinMovementLengthBasedOnTT3MovementPercent / 100)
               && t3p2ValueHigh != 0
               && t3p4ValueTmp > t3p2ValueHigh
           ) {
            if(t3ScreenshotT3P4CreatedBefore == false) {
               createScreenshot("T3P4-Before");
               t3ScreenshotT3P4CreatedBefore = true;
            }
            createT3P4VLine(t3p4DateTimeTmp);
            getT3TrendDirection();
            if(t3AlertT3P4CreatedSended == false) t3AlertT3P4CreatedAction();
         }
      }

      if(t3SemiTrendDirection == TREND_DIRECTION_SHORT || t3trendDirection == TREND_DIRECTION_SHORT) {
         t3p4DateTimeTmp = iTime(Symbol(), PERIOD_M1, iLowest(Symbol(), PERIOD_M1, MODE_LOW,  iBarShift(Symbol(), PERIOD_M1, t3p3DateTime) + 1));
         t3p4ValueTmp = iLow(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t3p4DateTimeTmp));
         t3P2P4MovementPoints = t3p3ValueHigh / Point() - t3p4ValueTmp / Point();

         if(isNewCurrentBar == true && t3ScreenshotT3P4CreatedBefore == true && t3ScreenshotT3P4CreatedAfter == false) {
            createScreenshot("T3P4-After");
            t3ScreenshotT3P4CreatedAfter = true;
         }

         if(Bid() <= t3p4ValueTmp
               && t3P2P4MovementPoints > (tt3movementLength * InpT3MinMovementLengthBasedOnTT3MovementPercent / 100)
               && t3p2ValueLow != 0
               && t3p4ValueTmp < t3p2ValueLow
           ) {
            if(t3ScreenshotT3P4CreatedBefore == false) {
               createScreenshot("T3P4-Before");
               t3ScreenshotT3P4CreatedBefore = true;
            }
            createT3P4VLine(t3p4DateTimeTmp);
            getT3TrendDirection();
            if(t3AlertT3P4CreatedSended == false) t3AlertT3P4CreatedAction();
         }
      }
   }
}

void handleT3P5() {

   datetime t3p5DateTimeTmp = 0;
   double   t3p5ValueTmp = 0;
   double   t3P4P5RegressionPoints = 0;

   if(t3p4ValueLow != 0
         && t3p4DateTime < (int)TimeCurrent()
     ) {

      if(t3trendDirection == TREND_DIRECTION_LONG) {
         t3p5DateTimeTmp = iTime(Symbol(), PERIOD_M1, iLowest(Symbol(), PERIOD_M1, MODE_LOW,  iBarShift(Symbol(), PERIOD_M1, t3p4DateTime) + 1));
         t3p5ValueTmp = iLow(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t3p5DateTimeTmp));
         t3P4P5RegressionPoints = t3p4ValueHigh / Point() - t3p5ValueTmp / Point();

         if(isNewCurrentBar == true && t3ScreenshotT3P5CreatedBefore == true && t3ScreenshotT3P5CreatedAfter == false) {
            createScreenshot("T3P5-After");
            t3ScreenshotT3P5CreatedAfter = true;
         }

         if(Bid() <= t3p5ValueTmp
               && t3P4P5RegressionPoints > (tt3regressionLength * InpT3MinRegressionLengthBasedOnTT3RegressionPercent / 100)
           ) {
            createT3P5VLine(t3p5DateTimeTmp);
            if(t3ScreenshotT3P5CreatedBefore == false) {
               createScreenshot("T3P5-Before");
               t3ScreenshotT3P5CreatedBefore = true;
            }
            if(t3AlertT3P5CreatedSended == false) t3AlertT3P5CreatedAction();
         }
      }

      if(t3trendDirection == TREND_DIRECTION_SHORT) {
         t3p5DateTimeTmp = iTime(Symbol(), PERIOD_M1, iHighest(Symbol(), PERIOD_M1, MODE_HIGH,  iBarShift(Symbol(), PERIOD_M1, t3p4DateTime) + 1));
         t3p5ValueTmp = iHigh(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t3p5DateTimeTmp));
         t3P4P5RegressionPoints = t3p5ValueTmp / Point() - t3p4ValueLow / Point();

         if(isNewCurrentBar == true && t3ScreenshotT3P5CreatedBefore == true && t3ScreenshotT3P5CreatedAfter == false) {
            createScreenshot("T3P5-After");
            t3ScreenshotT3P5CreatedAfter = true;
         }

         if(Bid() >= t3p5ValueTmp
               && t3P4P5RegressionPoints > (tt3regressionLength * InpT3MinRegressionLengthBasedOnTT3RegressionPercent / 100)
           ) {
            createT3P5VLine(t3p5DateTimeTmp);
            if(t3ScreenshotT3P5CreatedBefore == false) {
               createScreenshot("T3P5-Before");
               t3ScreenshotT3P5CreatedBefore = true;
            }
            if(t3AlertT3P5CreatedSended == false) t3AlertT3P5CreatedAction();
         }
      }
   }
}

void handleT3BuildNewTrend() {

   double   t3P5P6MovementPoints = 0;
   datetime t3p3DateTimeTmp = 0;
   datetime t3p4DateTimeTmp = 0;
   datetime t3p5DateTimeTmp = 0;

   if(t3p5ValueHigh != 0
         && t3p5DateTime < (int)TimeCurrent()
     ) {

      if(t3SemiTrendDirection == TREND_DIRECTION_LONG || t3trendDirection == TREND_DIRECTION_LONG) {
         t3P5P6MovementPoints = Bid() / Point() - t3p5ValueLow / Point();

         if(isNewCurrentBar == true && t3ScreenshotT3BuildNewTrendBefore == true && t3ScreenshotT3BuildNewTrendAfter == false) {
            createScreenshot("T3BuildNewTrend-After");
            t3ScreenshotT3BuildNewTrendAfter = true;
         }

         if(t3P5P6MovementPoints > (tt3movementLength * InpT3MinMovementLengthBasedOnTT3MovementPercent / 100)
               && t3p4ValueHigh != 0
               && Bid() > t3p4ValueHigh
           ) {
            if(t3ScreenshotT3BuildNewTrendBefore == false) {
               createScreenshot("T3BuildNewTrend-Before");
               t3ScreenshotT3BuildNewTrendBefore = true;
            }
            if(t3p3DateTime != 0 && t3p4DateTime != 0 && t3p5DateTime != 0) {
               t3p3DateTimeTmp = t3p3DateTime;
               t3p4DateTimeTmp = t3p4DateTime;
               t3p5DateTimeTmp = t3p5DateTime;
               resetT3Trend();
               createT3P1VLine(t3p3DateTimeTmp);
               createT3P2VLine(t3p4DateTimeTmp);
               createT3P3VLine(t3p5DateTimeTmp);
               getT3TrendDirection();
               if(t3AlertT3BuildNewTrendSended == false) t3AlertT3BuildNewTrendAction();
            }
         }
      }

      if(t3SemiTrendDirection == TREND_DIRECTION_SHORT || t3trendDirection == TREND_DIRECTION_SHORT) {
         t3P5P6MovementPoints = t3p5ValueHigh / Point() - Bid() / Point();

         if(isNewCurrentBar == true && t3ScreenshotT3BuildNewTrendBefore == true && t3ScreenshotT3BuildNewTrendAfter == false) {
            createScreenshot("T3BuildNewTrend-After");
            t3ScreenshotT3BuildNewTrendAfter = true;
         }

         if(t3P5P6MovementPoints > (tt3movementLength * InpT3MinMovementLengthBasedOnTT3MovementPercent / 100)
               && t3p4ValueLow != 0
               && Bid() < t3p4ValueLow
           ) {
            if(t3ScreenshotT3BuildNewTrendBefore == false) {
               createScreenshot("T3BuildNewTrend-Before");
               t3ScreenshotT3BuildNewTrendBefore = true;
            }
            if(t3p3DateTime != 0 && t3p4DateTime != 0 && t3p5DateTime != 0) {
               t3p3DateTimeTmp = t3p3DateTime;
               t3p4DateTimeTmp = t3p4DateTime;
               t3p5DateTimeTmp = t3p5DateTime;
               resetT3Trend();
               createT3P1VLine(t3p3DateTimeTmp);
               createT3P2VLine(t3p4DateTimeTmp);
               createT3P3VLine(t3p5DateTimeTmp);
               getT3TrendDirection();
               if(t3AlertT3BuildNewTrendSended == false) t3AlertT3BuildNewTrendAction();
            }
         }
      }
   }
}

void handleT3TrendBrokenOnP1() {

   datetime t3p2DateTimeTmp = 0;
   datetime t3p3DateTimeTmp = 0;

   if(t3p1ValueHigh != 0
         && t3p2ValueLow != 0
         && t3p3ValueHigh != 0
         && t3p1DateTime <= (int)TimeCurrent()
         && t3p2DateTime <= (int)TimeCurrent()
         && t3p3DateTime <= (int)TimeCurrent()
     ) {

      if(t3SemiTrendDirection == TREND_DIRECTION_LONG || t3trendDirection == TREND_DIRECTION_LONG) {

         if(Bid() < t3p1ValueLow) {
            if(t3ScreenshotT3TrendBrokenOnP1Before == false) {
               createScreenshot("T3TrendBrokenOnP1-Before");
               t3ScreenshotT3TrendBrokenOnP1Before = true;
            }
            if(t3p2DateTime != 0 && t3p3DateTime != 0) {
               t3p2DateTimeTmp = t3p2DateTime;
               t3p3DateTimeTmp = t3p3DateTime;
               resetT3Trend();
               createT3P1VLine(t3p2DateTimeTmp);
               createT3P2VLine(t3p3DateTimeTmp);
               getT3TrendDirection();
               if(t3AlertT3TrendBrokenSended == false) t3AlertT3TrendBrokenAction();
            }
         }
      }

      if(t3SemiTrendDirection == TREND_DIRECTION_SHORT || t3trendDirection == TREND_DIRECTION_SHORT) {

         if(Bid() > t3p1ValueHigh) {
            if(t3ScreenshotT3TrendBrokenOnP1Before == false) {
               createScreenshot("T3TrendBrokenOnP1-Before");
               t3ScreenshotT3TrendBrokenOnP1Before = true;
            }
            if(t3p2DateTime != 0 && t3p3DateTime != 0) {
               t3p2DateTimeTmp = t3p2DateTime;
               t3p3DateTimeTmp = t3p3DateTime;
               resetT3Trend();
               createT3P1VLine(t3p2DateTimeTmp);
               createT3P2VLine(t3p3DateTimeTmp);
               getT3TrendDirection();
               if(t3AlertT3TrendBrokenSended == false) t3AlertT3TrendBrokenAction();
            }
         }
      }
   }

   if(isNewCurrentBar == true && t3ScreenshotT3TrendBrokenOnP1Before == true && t3ScreenshotT3TrendBrokenOnP1After == false) {
      createScreenshot("T3TrendBrokenOnP1-After");
      t3ScreenshotT3TrendBrokenOnP1After = true;
   }

}

void handleT3TrendBrokenOnP3() {

   datetime t3p4DateTimeTmp = 0;
   datetime t3p5DateTimeTmp = 0;

   if(t3p3ValueHigh != 0
         && t3p4ValueLow != 0
         && t3p5ValueHigh != 0
         && t3p3DateTime < TimeCurrent()
         && t3p4DateTime < TimeCurrent()
         && t3p5DateTime < (int)TimeCurrent()
     ) {

      if(t3SemiTrendDirection == TREND_DIRECTION_LONG || t3trendDirection == TREND_DIRECTION_LONG) {

         if(Bid() < t3p3ValueLow) {
            if(t3ScreenshotT3TrendBrokenOnP3Before == false) {
               createScreenshot("T3TrendBrokenOnP3-Before");
               t3ScreenshotT3TrendBrokenOnP3Before = true;
            }
            if(t3p4DateTime != 0 && t3p5DateTime != 0) {
               t3p4DateTimeTmp = t3p4DateTime;
               t3p5DateTimeTmp = t3p5DateTime;
               resetT3Trend();
               createT3P1VLine(t3p4DateTimeTmp);
               createT3P2VLine(t3p5DateTimeTmp);
               getT3TrendDirection();
               if(t3AlertT3TrendBrokenSended == false) t3AlertT3TrendBrokenAction();
            }
         }
      }

      if(t3SemiTrendDirection == TREND_DIRECTION_SHORT || t3trendDirection == TREND_DIRECTION_SHORT) {

         if(Bid() > t3p3ValueHigh) {
            if(t3ScreenshotT3TrendBrokenOnP3Before == false) {
               createScreenshot("T3TrendBrokenOnP3-Before");
               t3ScreenshotT3TrendBrokenOnP3Before = true;
            }
            if(t3p4DateTime != 0 && t3p5DateTime != 0) {
               t3p4DateTimeTmp = t3p4DateTime;
               t3p5DateTimeTmp = t3p5DateTime;
               resetT3Trend();
               createT3P1VLine(t3p4DateTimeTmp);
               createT3P2VLine(t3p5DateTimeTmp);
               getT3TrendDirection();
               if(t3AlertT3TrendBrokenSended == false) t3AlertT3TrendBrokenAction();
            }
         }
      }
   }

   if(isNewCurrentBar == true && t3ScreenshotT3TrendBrokenOnP3Before == true && t3ScreenshotT3TrendBrokenOnP3After == false) {
      createScreenshot("T3TrendBrokenOnP3-After");
      t3ScreenshotT3TrendBrokenOnP3After = true;
   }
}

void resetT3Trend() {

   deleteVLine(T3_P1_VLINE);
   deleteVLine(T3_P2_VLINE);
   deleteVLine(T3_P3_VLINE);
   deleteVLine(T3_P4_VLINE);
   deleteVLine(T3_P5_VLINE);
   setT3LineValues();
   getT3TrendDirection();

   deleteTrendLine(T3_TRENDLINE + "P1-P2");
   deleteTrendLine(T3_TRENDLINE + "P2-P3");
   deleteTrendLine(T3_TRENDLINE + "P3-P4");
   deleteTrendLine(T3_TRENDLINE + "P4-P5");

   t3AlertT3P2CreatedSended = false;
   t3AlertT3P3CreatedSended = false;
   t3AlertT3P4CreatedSended = false;
   t3AlertT3P5CreatedSended = false;
   t3AlertT3TrendBrokenSended = false;
   t3AlertT3BuildNewTrendSended = false;

   t3ScreenshotT3P2CreatedBefore = false;
   t3ScreenshotT3P2CreatedAfter = false;
   t3ScreenshotT3P3CreatedBefore = false;
   t3ScreenshotT3P3CreatedAfter = false;
   t3ScreenshotT3P4CreatedBefore = false;
   t3ScreenshotT3P4CreatedAfter = false;
   t3ScreenshotT3P5CreatedBefore = false;
   t3ScreenshotT3P5CreatedAfter = false;
   t3ScreenshotT3BuildNewTrendBefore = false;
   t3ScreenshotT3BuildNewTrendAfter = false;
   t3ScreenshotT3TrendBrokenOnP1Before = false;
   t3ScreenshotT3TrendBrokenOnP1After = false;
   t3ScreenshotT3TrendBrokenOnP3Before = false;
   t3ScreenshotT3TrendBrokenOnP3After = false;
}
//+------------------------------------------------------------------+
