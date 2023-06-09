//+------------------------------------------------------------------+
//|                                 T3HandleTrendDetectionAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void getT3TrendDirection() {

   double t3p2ValueLocal = 0;

   t3SemiTrendDirection = TREND_DIRECTION_ROTATION;
   t3trendDirection = TREND_DIRECTION_ROTATION;

   if(t3p1ValueHigh != 0) {
      (t3p2ValueLow != 0) ? t3p2ValueLocal = t3p2ValueLow : t3p2ValueLocal = Bid();
      if(t3p1ValueHigh < t3p2ValueLocal) t3SemiTrendDirection = TREND_DIRECTION_LONG;
      if(t3p1ValueHigh > t3p2ValueLocal) t3SemiTrendDirection = TREND_DIRECTION_SHORT;
   }

   if(t3p3ValueHigh != 0 && t3p4ValueHigh != 0) {
      if(t3p3ValueHigh < t3p4ValueHigh) t3trendDirection = TREND_DIRECTION_LONG;
      if(t3p3ValueHigh > t3p4ValueHigh) t3trendDirection = TREND_DIRECTION_SHORT;
   }
}

void handleT3TrendDetectionAction() {

   if(t3AutoButtonState == true) {
      handleT3P2();
      handleT3P3();
      handleT3P4();
      handleT3P5();
      handleT3P6();
      handleT3P7();
      handleT3BuildNewTrend();
      handleT3TrendBrokenOnP1();
      handleT3TrendBrokenOnP3();
   }
}
//+------------------------------------------------------------------+

void handleT3P2() {

   datetime t3p2DateTimeLocal = 0;
   double   t3p2ValueLocal = 0;
   string   t3p2ObjectName = "";
   double   t3P1P2MovementPoints = 0;
   string   errorText = "TT3 is Missing";

   deleteLabel(ERROR_LABEL + errorText);

   if(t3p1DateTime != 0 && t3p1DateTime < (int)TimeCurrent()
         && t3p3DateTime == 0
     ) {

      if(tt3p1DateTime != 0) {

         t3AlertT3VLineOn0Sended = false;

         if(t3SemiTrendDirection == TREND_DIRECTION_LONG) {
            t3p2DateTimeLocal = iTime(Symbol(), PERIOD_M1, iHighest(Symbol(), PERIOD_M1, MODE_HIGH,  iBarShift(Symbol(), PERIOD_M1, t3p1DateTime) + 1));
            t3p2ValueLocal = iHigh(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t3p2DateTimeLocal));
            t3p2ObjectName = getVlineNameByNameLike(T3_P2_VLINE);
            t3P1P2MovementPoints = t3p2ValueLocal / Point() - t3p1ValueLow / Point();

            if(Bid() >= t3p2ValueLocal
                  && t3P1P2MovementPoints > (tt3RegressionChannelWidthAveragePoints * InpT3MinMovementLengthBasedOnTT3MovementPercent / 100)
              ) {
               createT3P2VLine(t3p2DateTimeLocal, t3p2ObjectName);
               if(t4p1DateTime != 0 && t4p2DateTime != 0 && t4p1DateTime > t4p2DateTime) {
                  resetT4Trend();
                  createT3P2VLine(t3p2DateTimeLocal, t3p2ObjectName);
               }
               getT3TrendDirection();
            }
         }

         if(t3SemiTrendDirection == TREND_DIRECTION_SHORT) {
            t3p2DateTimeLocal = iTime(Symbol(), PERIOD_M1, iLowest(Symbol(), PERIOD_M1, MODE_LOW,  iBarShift(Symbol(), PERIOD_M1, t3p1DateTime) + 1));
            t3p2ValueLocal = iLow(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t3p2DateTimeLocal));
            t3p2ObjectName = getVlineNameByNameLike(T3_P2_VLINE);
            t3P1P2MovementPoints = t3p1ValueHigh / Point() - t3p2ValueLocal / Point();

            if(Bid() <= t3p2ValueLocal
                  && t3P1P2MovementPoints > (tt3RegressionChannelWidthAveragePoints * InpT3MinMovementLengthBasedOnTT3MovementPercent / 100)
              ) {
               createT3P2VLine(t3p2DateTimeLocal, t3p2ObjectName);
               if(t4p1DateTime != 0 && t4p2DateTime != 0 && t4p1DateTime > t4p2DateTime) {
                  resetT4Trend();
                  createT3P2VLine(t3p2DateTimeLocal, t3p2ObjectName);
               }
               getT3TrendDirection();
            }
         }
      } else {
         // TODO: der erscheint mir blödsinnig!!
         if(t3AlertT3VLineOn0Sended == false) t3AlertT3VLineOn0Action();

         createErrorLabel(errorText);
      }
   }
}

void handleT3P3() {

   datetime t3p3DateTimeTmp = 0;
   double   t3p3ValueTmp = 0;
   string   t3p3ObjectName = "";
   double   t3P2P3RegressionPoints = 0;

   if(t3p2ValueLow != 0
         && t3p2DateTime < (int)TimeCurrent()
         && t3p4DateTime == 0
     ) {

      if(t3SemiTrendDirection == TREND_DIRECTION_LONG) {
         t3p3DateTimeTmp = iTime(Symbol(), PERIOD_M1, iLowest(Symbol(), PERIOD_M1, MODE_LOW,  iBarShift(Symbol(), PERIOD_M1, t3p2DateTime) + 1));
         t3p3ValueTmp = iLow(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t3p3DateTimeTmp));
         t3p3ObjectName = getVlineNameByNameLike(T3_P3_VLINE);
         t3P2P3RegressionPoints = t3p2ValueHigh / Point() - t3p3ValueTmp / Point();

         if(Bid() <= t3p3ValueTmp
               && t3P2P3RegressionPoints > (tt3RegressionChannelWidthAveragePoints * InpT3MinRegressionLengthBasedOnTT3RegressionPercent / 100)
           ) {
            createT3P3VLine(t3p3DateTimeTmp, t3p3ObjectName);
            if(t4p1DateTime != 0 && t4p2DateTime != 0 && t4p1DateTime > t4p2DateTime) {
               resetT4Trend();
               createT3P3VLine(t3p3DateTimeTmp, t3p3ObjectName);
            }
         }
      }

      if(t3SemiTrendDirection == TREND_DIRECTION_SHORT) {
         t3p3DateTimeTmp = iTime(Symbol(), PERIOD_M1, iHighest(Symbol(), PERIOD_M1, MODE_HIGH,  iBarShift(Symbol(), PERIOD_M1, t3p2DateTime) + 1));
         t3p3ValueTmp = iHigh(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t3p3DateTimeTmp));
         t3p3ObjectName = getVlineNameByNameLike(T3_P3_VLINE);
         t3P2P3RegressionPoints = t3p3ValueTmp / Point() - t3p2ValueLow / Point();

         if(Bid() >= t3p3ValueTmp
               && t3P2P3RegressionPoints > (tt3RegressionChannelWidthAveragePoints * InpT3MinRegressionLengthBasedOnTT3RegressionPercent / 100)
           ) {
            createT3P3VLine(t3p3DateTimeTmp, t3p3ObjectName);
            if(t4p1DateTime != 0 && t4p2DateTime != 0 && t4p1DateTime > t4p2DateTime) {
               resetT4Trend();
               createT3P3VLine(t3p3DateTimeTmp, t3p3ObjectName);
            }
         }
      }
   }
}

void handleT3P4() {

   datetime t3p4DateTimeTmp = 0;
   double   t3p4ValueTmp = 0;
   string   t3p4ObjectName = "";

   if(t3p3ValueHigh != 0
         && t3p3DateTime < (int)TimeCurrent()
         && t3p5DateTime == 0
     ) {

      if(t3SemiTrendDirection == TREND_DIRECTION_LONG || t3trendDirection == TREND_DIRECTION_LONG) {
         t3p4DateTimeTmp = iTime(Symbol(), PERIOD_M1, iHighest(Symbol(), PERIOD_M1, MODE_HIGH,  iBarShift(Symbol(), PERIOD_M1, t3p3DateTime) + 1));
         t3p4ValueTmp = iHigh(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t3p4DateTimeTmp));
         t3p4ObjectName = getVlineNameByNameLike(T3_P4_VLINE);

         if(Bid() >= t3p4ValueTmp
               && t3p2ValueHigh != 0
               && t3p4ValueTmp > t3p2ValueHigh
           ) {
            createT3P4VLine(t3p4DateTimeTmp, t3p4ObjectName);
            if(t4p1DateTime != 0 && t4p2DateTime != 0 && t4p1DateTime > t4p2DateTime) {
               resetT4Trend();
               createT3P4VLine(t3p4DateTimeTmp, t3p4ObjectName);
            }
            getT3TrendDirection();
         }
      }

      if(t3SemiTrendDirection == TREND_DIRECTION_SHORT || t3trendDirection == TREND_DIRECTION_SHORT) {
         t3p4DateTimeTmp = iTime(Symbol(), PERIOD_M1, iLowest(Symbol(), PERIOD_M1, MODE_LOW,  iBarShift(Symbol(), PERIOD_M1, t3p3DateTime) + 1));
         t3p4ValueTmp = iLow(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t3p4DateTimeTmp));
         t3p4ObjectName = getVlineNameByNameLike(T3_P4_VLINE);

         if(Bid() <= t3p4ValueTmp
               && t3p2ValueLow != 0
               && t3p4ValueTmp < t3p2ValueLow
           ) {
            createT3P4VLine(t3p4DateTimeTmp, t3p4ObjectName);
            if(t4p1DateTime != 0 && t4p2DateTime != 0 && t4p1DateTime > t4p2DateTime) {
               resetT4Trend();
               createT3P4VLine(t3p4DateTimeTmp, t3p4ObjectName);
            }
            getT3TrendDirection();
         }
      }
   }
}

void handleT3P5() {

   datetime t3p5DateTimeTmp = 0;
   double   t3p5ValueTmp = 0;
   string   t3p5ObjectName = "";
   double   t3P4P5RegressionPoints = 0;

   if(t3p4ValueLow != 0
         && t3p4DateTime < (int)TimeCurrent()
     ) {

      if(t3trendDirection == TREND_DIRECTION_LONG) {
         t3p5DateTimeTmp = iTime(Symbol(), PERIOD_M1, iLowest(Symbol(), PERIOD_M1, MODE_LOW,  iBarShift(Symbol(), PERIOD_M1, t3p4DateTime) + 1));
         t3p5ValueTmp = iLow(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t3p5DateTimeTmp));
         t3p5ObjectName = getVlineNameByNameLike(T3_P5_VLINE);
         t3P4P5RegressionPoints = t3p4ValueHigh / Point() - t3p5ValueTmp / Point();

         if(Bid() <= t3p5ValueTmp
               && t3P4P5RegressionPoints > (tt3RegressionChannelWidthAveragePoints * InpT3MinRegressionLengthBasedOnTT3RegressionPercent / 100)
           ) {
            createT3P5VLine(t3p5DateTimeTmp, t3p5ObjectName);
            if(t4p1DateTime != 0 && t4p2DateTime != 0 && t4p1DateTime > t4p2DateTime) {
               resetT4Trend();
               createT3P5VLine(t3p5DateTimeTmp, t3p5ObjectName);
            }
         }
      }

      if(t3trendDirection == TREND_DIRECTION_SHORT) {
         t3p5DateTimeTmp = iTime(Symbol(), PERIOD_M1, iHighest(Symbol(), PERIOD_M1, MODE_HIGH,  iBarShift(Symbol(), PERIOD_M1, t3p4DateTime) + 1));
         t3p5ValueTmp = iHigh(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t3p5DateTimeTmp));
         t3p5ObjectName = getVlineNameByNameLike(T3_P5_VLINE);
         t3P4P5RegressionPoints = t3p5ValueTmp / Point() - t3p4ValueLow / Point();

         if(Bid() >= t3p5ValueTmp
               && t3P4P5RegressionPoints > (tt3RegressionChannelWidthAveragePoints * InpT3MinRegressionLengthBasedOnTT3RegressionPercent / 100)
           ) {
            createT3P5VLine(t3p5DateTimeTmp, t3p5ObjectName);
            if(t4p1DateTime != 0 && t4p2DateTime != 0 && t4p1DateTime > t4p2DateTime) {
               resetT4Trend();
               createT3P5VLine(t3p5DateTimeTmp, t3p5ObjectName);
            }
         }
      }
   }
}

void handleT3P6() {

   datetime t3p6DateTimeTmp = 0;
   double   t3p6ValueTmp = 0;
   string   t3p6ObjectName = "";

   if(t3p5ValueHigh != 0 && t3p5DateTime < (int)TimeCurrent()
         && t3p7DateTime == 0
     ) {

      if(t3SemiTrendDirection == TREND_DIRECTION_LONG || t3trendDirection == TREND_DIRECTION_LONG) {
         t3p6DateTimeTmp = iTime(Symbol(), PERIOD_M1, iHighest(Symbol(), PERIOD_M1, MODE_HIGH,  iBarShift(Symbol(), PERIOD_M1, t3p5DateTime) + 1));
         t3p6ValueTmp = iHigh(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t3p6DateTimeTmp));
         t3p6ObjectName = getVlineNameByNameLike(T3_P6_VLINE);

         if(Bid() >= t3p6ValueTmp
               && t3p4ValueHigh != 0
               && t3p6ValueTmp > t3p4ValueHigh
           ) {
            if(tt4p1DateTime == 0 && t3AlertT3P6CreatedTT4MissingSended == false) t3AlertT3P6CreatedTT4MissingAction();
            if(t3AlertT3P6CreatedSended == false && t4p1DateTime == 0) t3AlertT3P6CreatedAction();
            createT3P6VLine(t3p6DateTimeTmp, t3p6ObjectName);
            if(t4p1DateTime != 0 && t4p2DateTime != 0 && t4p1DateTime > t4p2DateTime) {
               resetT4Trend();
               createT3P6VLine(t3p6DateTimeTmp, t3p6ObjectName);
            }
         }
      }

      if(t3SemiTrendDirection == TREND_DIRECTION_SHORT || t3trendDirection == TREND_DIRECTION_SHORT) {
         t3p6DateTimeTmp = iTime(Symbol(), PERIOD_M1, iLowest(Symbol(), PERIOD_M1, MODE_LOW,  iBarShift(Symbol(), PERIOD_M1, t3p5DateTime) + 1));
         t3p6ValueTmp = iLow(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t3p6DateTimeTmp));
         t3p6ObjectName = getVlineNameByNameLike(T3_P6_VLINE);

         if(Bid() <= t3p6ValueTmp
               && t3p4ValueLow != 0
               && t3p6ValueTmp < t3p4ValueLow
           ) {
            if(tt4p1DateTime == 0 && t3AlertT3P6CreatedTT4MissingSended == false) t3AlertT3P6CreatedTT4MissingAction();
            if(t3AlertT3P6CreatedSended == false && t4p1DateTime == 0) t3AlertT3P6CreatedAction();
            createT3P6VLine(t3p6DateTimeTmp, t3p6ObjectName);
            if(t4p1DateTime != 0 && t4p2DateTime != 0 && t4p1DateTime > t4p2DateTime) {
               resetT4Trend();
               createT3P6VLine(t3p6DateTimeTmp, t3p6ObjectName);
            }
         }
      }
   }
}

void handleT3P7() {

   datetime t3p7DateTimeTmp = 0;
   double   t3p7ValueTmp = 0;
   string   t3p7ObjectName = "";
   double   t3P6P7RegressionPoints = 0;

   if(t3p6ValueLow != 0 && t3p6DateTime < (int)TimeCurrent()
     ) {

      if(t3trendDirection == TREND_DIRECTION_LONG) {
         t3p7DateTimeTmp = iTime(Symbol(), PERIOD_M1, iLowest(Symbol(), PERIOD_M1, MODE_LOW,  iBarShift(Symbol(), PERIOD_M1, t3p6DateTime) + 1));
         t3p7ValueTmp = iLow(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t3p7DateTimeTmp));
         t3p7ObjectName = getVlineNameByNameLike(T3_P7_VLINE);
         t3P6P7RegressionPoints = t3p6ValueHigh / Point() - t3p7ValueTmp / Point();

         if(Bid() <= t3p7ValueTmp
               && t3P6P7RegressionPoints > (tt3RegressionChannelWidthAveragePoints * InpT3MinRegressionLengthBasedOnTT3RegressionPercent / 100)
           ) {
            createT3P7VLine(t3p7DateTimeTmp, t3p7ObjectName);
            if(t4p1DateTime != 0 && t4p2DateTime != 0 && t4p1DateTime > t4p2DateTime) {
               resetT4Trend();
               createT3P7VLine(t3p7DateTimeTmp, t3p7ObjectName);
            }
         }
      }

      if(t3trendDirection == TREND_DIRECTION_SHORT) {
         t3p7DateTimeTmp = iTime(Symbol(), PERIOD_M1, iHighest(Symbol(), PERIOD_M1, MODE_HIGH,  iBarShift(Symbol(), PERIOD_M1, t3p6DateTime) + 1));
         t3p7ValueTmp = iHigh(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t3p7DateTimeTmp));
         t3p7ObjectName = getVlineNameByNameLike(T3_P7_VLINE);
         t3P6P7RegressionPoints = t3p7ValueTmp / Point() - t3p6ValueLow / Point();

         if(Bid() >= t3p7ValueTmp
               && t3P6P7RegressionPoints > (tt3RegressionChannelWidthAveragePoints * InpT3MinRegressionLengthBasedOnTT3RegressionPercent / 100)
           ) {
            createT3P7VLine(t3p7DateTimeTmp, t3p7ObjectName);
            if(t4p1DateTime != 0 && t4p2DateTime != 0 && t4p1DateTime > t4p2DateTime) {
               resetT4Trend();
               createT3P7VLine(t3p7DateTimeTmp, t3p7ObjectName);
            }
         }
      }
   }
}

void handleT3BuildNewTrend() {

   datetime t3p3DateTimeTmp = 0;
   datetime t3p4DateTimeTmp = 0;
   datetime t3p5DateTimeTmp = 0;
   datetime t3p6DateTimeTmp = 0;
   datetime t3p7DateTimeTmp = 0;
   string   t3p1ObjectName = "";
   string   t3p2ObjectName = "";
   string   t3p3ObjectName = "";
   string   t3p4ObjectName = "";
   string   t3p5ObjectName = "";

   if(t3p7ValueHigh != 0 && t3p7DateTime < (int)TimeCurrent()
     ) {

      if(t3SemiTrendDirection == TREND_DIRECTION_LONG || t3trendDirection == TREND_DIRECTION_LONG) {

         if(t3p6ValueHigh != 0 && Bid() > t3p6ValueHigh) {
            if(t3ScreenshotT3BuildNewTrendBefore == false) {
               ChartSetSymbolPeriod(ChartID(), Symbol(), PERIOD_M10);
               createScreenshot("T3BuildNewTrend-Before");
               t3ScreenshotT3BuildNewTrendBefore = true;
            }
            if(t3p5DateTime != 0 && t3p6DateTime != 0 && t3p7DateTime != 0) {
               t3p3DateTimeTmp = t3p3DateTime;
               t3p4DateTimeTmp = t3p4DateTime;
               t3p5DateTimeTmp = t3p5DateTime;
               t3p6DateTimeTmp = t3p6DateTime;
               t3p7DateTimeTmp = t3p7DateTime;
               t3p1ObjectName = getVlineNameByNameLike(T3_P1_VLINE);
               t3p2ObjectName = getVlineNameByNameLike(T3_P2_VLINE);
               t3p3ObjectName = getVlineNameByNameLike(T3_P3_VLINE);
               t3p4ObjectName = getVlineNameByNameLike(T3_P4_VLINE);
               t3p5ObjectName = getVlineNameByNameLike(T3_P5_VLINE);
               resetT3Trend();
               createT3P1VLine(t3p3DateTimeTmp, t3p1ObjectName);
               createT3P2VLine(t3p4DateTimeTmp, t3p2ObjectName);
               createT3P3VLine(t3p5DateTimeTmp, t3p3ObjectName);
               createT3P4VLine(t3p6DateTimeTmp, t3p4ObjectName);
               createT3P5VLine(t3p7DateTimeTmp, t3p5ObjectName);
               getT3TrendDirection();
            }
         }
      }

      if(t3SemiTrendDirection == TREND_DIRECTION_SHORT || t3trendDirection == TREND_DIRECTION_SHORT) {

         if(t3p6ValueLow != 0 && Bid() < t3p6ValueLow) {
            if(t3ScreenshotT3BuildNewTrendBefore == false) {
               ChartSetSymbolPeriod(ChartID(), Symbol(), PERIOD_M10);
               createScreenshot("T3BuildNewTrend-Before");
               t3ScreenshotT3BuildNewTrendBefore = true;
            }
            if(t3p5DateTime != 0 && t3p6DateTime != 0 && t3p7DateTime != 0) {
               t3p3DateTimeTmp = t3p3DateTime;
               t3p4DateTimeTmp = t3p4DateTime;
               t3p5DateTimeTmp = t3p5DateTime;
               t3p6DateTimeTmp = t3p6DateTime;
               t3p7DateTimeTmp = t3p7DateTime;
               t3p1ObjectName = getVlineNameByNameLike(T3_P1_VLINE);
               t3p2ObjectName = getVlineNameByNameLike(T3_P2_VLINE);
               t3p3ObjectName = getVlineNameByNameLike(T3_P3_VLINE);
               t3p4ObjectName = getVlineNameByNameLike(T3_P4_VLINE);
               t3p5ObjectName = getVlineNameByNameLike(T3_P5_VLINE);
               resetT3Trend();
               createT3P1VLine(t3p3DateTimeTmp, t3p1ObjectName);
               createT3P2VLine(t3p4DateTimeTmp, t3p2ObjectName);
               createT3P3VLine(t3p5DateTimeTmp, t3p3ObjectName);
               createT3P4VLine(t3p6DateTimeTmp, t3p4ObjectName);
               createT3P5VLine(t3p7DateTimeTmp, t3p5ObjectName);
               getT3TrendDirection();
            }
         }
      }
   }
}

void handleT3TrendBrokenOnP1() {

   datetime t3p2DateTimeTmp = 0;
   datetime t3p3DateTimeTmp = 0;

   if(t3p1ValueHigh != 0 && t3p1DateTime <= (int)TimeCurrent()
         && t3p2ValueLow != 0 && t3p2DateTime <= (int)TimeCurrent()
         && t3p3ValueHigh != 0 && t3p3DateTime <= (int)TimeCurrent()
         && t3TrendBrokeOnFiboLevel != 0
     ) {

      if(t3SemiTrendDirection == TREND_DIRECTION_LONG || t3trendDirection == TREND_DIRECTION_LONG) {

         if(Bid() < t3TrendBrokeOnFiboLevel) {
            if(t3ScreenshotT3TrendBrokenOnP1Before == false) {
               ChartSetSymbolPeriod(ChartID(), Symbol(), PERIOD_M10);
               createScreenshot("T3TrendBrokenOnP1-Before");
               t3ScreenshotT3TrendBrokenOnP1Before = true;
            }
            if(t3p2DateTime != 0 && t3p3DateTime != 0) {
               t3p2DateTimeTmp = t3p2DateTime;
               t3p3DateTimeTmp = t3p3DateTime;
               resetT3Trend();
               createT3P1VLine(t3p2DateTimeTmp, T3_P1_VLINE);
               createT3P2VLine(t3p3DateTimeTmp, T3_P2_VLINE);
               getT3TrendDirection();
               if(t3AlertT3TrendBrokenSended == false) t3AlertT3TrendBrokenAction();
            }
         }
      }

      if(t3SemiTrendDirection == TREND_DIRECTION_SHORT || t3trendDirection == TREND_DIRECTION_SHORT) {

         if(Bid() > t3TrendBrokeOnFiboLevel) {
            if(t3ScreenshotT3TrendBrokenOnP1Before == false) {
               ChartSetSymbolPeriod(ChartID(), Symbol(), PERIOD_M10);
               createScreenshot("T3TrendBrokenOnP1-Before");
               t3ScreenshotT3TrendBrokenOnP1Before = true;
            }
            if(t3p2DateTime != 0 && t3p3DateTime != 0) {
               t3p2DateTimeTmp = t3p2DateTime;
               t3p3DateTimeTmp = t3p3DateTime;
               resetT3Trend();
               createT3P1VLine(t3p2DateTimeTmp, T3_P1_VLINE);
               createT3P2VLine(t3p3DateTimeTmp, T3_P2_VLINE);
               getT3TrendDirection();
               if(t3AlertT3TrendBrokenSended == false) t3AlertT3TrendBrokenAction();
            }
         }
      }
   }
}

void handleT3TrendBrokenOnP3() {

   datetime t3p4DateTimeTmp = 0;
   datetime t3p5DateTimeTmp = 0;

   if(t3p3ValueHigh != 0 && t3p3DateTime < TimeCurrent()
         && t3p4ValueLow != 0 && t3p4DateTime < TimeCurrent()
         && t3p5ValueHigh != 0 && t3p5DateTime < TimeCurrent()
         && t3TrendBrokeOnFiboLevel != 0
     ) {

      if(t3SemiTrendDirection == TREND_DIRECTION_LONG || t3trendDirection == TREND_DIRECTION_LONG) {

         if(Bid() < t3TrendBrokeOnFiboLevel) {
            if(t3ScreenshotT3TrendBrokenOnP3Before == false) {
               ChartSetSymbolPeriod(ChartID(), Symbol(), PERIOD_M10);
               createScreenshot("T3TrendBrokenOnP3-Before");
               t3ScreenshotT3TrendBrokenOnP3Before = true;
            }
            if(t3p4DateTime != 0 && t3p5DateTime != 0) {
               t3p4DateTimeTmp = t3p4DateTime;
               t3p5DateTimeTmp = t3p5DateTime;
               resetT3Trend();
               createT3P1VLine(t3p4DateTimeTmp, T3_P1_VLINE);
               createT3P2VLine(t3p5DateTimeTmp, T3_P2_VLINE);
               getT3TrendDirection();
               if(t3AlertT3TrendBrokenSended == false) t3AlertT3TrendBrokenAction();
            }
         }
      }

      if(t3SemiTrendDirection == TREND_DIRECTION_SHORT || t3trendDirection == TREND_DIRECTION_SHORT) {

         if(Bid() > t3TrendBrokeOnFiboLevel) {
            if(t3ScreenshotT3TrendBrokenOnP3Before == false) {
               ChartSetSymbolPeriod(ChartID(), Symbol(), PERIOD_M10);
               createScreenshot("T3TrendBrokenOnP3-Before");
               t3ScreenshotT3TrendBrokenOnP3Before = true;
            }
            if(t3p4DateTime != 0 && t3p5DateTime != 0) {
               t3p4DateTimeTmp = t3p4DateTime;
               t3p5DateTimeTmp = t3p5DateTime;
               resetT3Trend();
               createT3P1VLine(t3p4DateTimeTmp, T3_P1_VLINE);
               createT3P2VLine(t3p5DateTimeTmp, T3_P2_VLINE);
               getT3TrendDirection();
               if(t3AlertT3TrendBrokenSended == false) t3AlertT3TrendBrokenAction();
            }
         }
      }
   }
}

void resetT3Trend() {

   deleteVlineLike(T3_P1_VLINE);
   deleteVlineLike(T3_P2_VLINE);
   deleteVlineLike(T3_P3_VLINE);
   deleteVlineLike(T3_P4_VLINE);
   deleteVlineLike(T3_P5_VLINE);
   deleteVlineLike(T3_P6_VLINE);
   deleteVlineLike(T3_P7_VLINE);
   setT3LineValues();
   getT3TrendDirection();

   deleteTrendLine(T3_ZIGZAGLINE + "P1-P2");
   deleteTrendLine(T3_ZIGZAGLINE + "P2-P3");
   deleteTrendLine(T3_ZIGZAGLINE + "P3-P4");
   deleteTrendLine(T3_ZIGZAGLINE + "P4-P5");
   deleteTrendLine(T3_ZIGZAGLINE + "P5-P6");
   deleteTrendLine(T3_ZIGZAGLINE + "P6-P7");

   deleteRegressionChannel(T3_REGRESSION_CHANNEL);
   deleteTrendLineLike(T3_FIBO_LEVELS);

   t3AlertT3P6CreatedTT4MissingSended = false;
   t3AlertT3P6CreatedSended = false;
   t3AlertT3TrendBrokenSended = false;

   t3ScreenshotT3BuildNewTrendBefore = false;
   t3ScreenshotT3TrendBrokenOnP1Before = false;
   t3ScreenshotT3TrendBrokenOnP3Before = false;
}
//+------------------------------------------------------------------+
