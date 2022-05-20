//+------------------------------------------------------------------+
//|                                 T2HandleTrendDetectionAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void getT2TrendDirection() {

   double t2p2ValueTmp = 0;
   t2SemiTrendDirection = TREND_DIRECTION_ROTATION;
   t2trendDirection = TREND_DIRECTION_ROTATION;

   if(t2p1ValueHigh != 0) {
      (t2p2ValueLow != 0) ? t2p2ValueTmp = t2p2ValueLow : t2p2ValueTmp = Bid();
      if(t2p1ValueHigh < t2p2ValueTmp) t2SemiTrendDirection = TREND_DIRECTION_LONG;
      if(t2p1ValueHigh > t2p2ValueTmp) t2SemiTrendDirection = TREND_DIRECTION_SHORT;
   }

   if(t2p3ValueHigh != 0 && t2p4ValueHigh != 0) {
      if(t2p3ValueHigh < t2p4ValueHigh) t2trendDirection = TREND_DIRECTION_LONG;
      if(t2p3ValueHigh > t2p4ValueHigh) t2trendDirection = TREND_DIRECTION_SHORT;
   }
}

void handleT2TrendDetectionAction() {

   if(t2AutoButtonState == true){
       handleT2P2();
       handleT2P3();
       handleT2P4();
       handleT2P5();
       handleT2BuildNewTrend();
       handleT2TrendBrokenOnP1();
       handleT2TrendBrokenOnP3();
   }
}
//+------------------------------------------------------------------+

void handleT2P2() {

   datetime t2p2DateTimeTmp = 0;
   double   t2p2ValueTmp = 0;
   double   t2P1P2MovementPoints = 0;

   if(t2p1DateTime != 0 && t2p1DateTime < (int)TimeCurrent()
         && t2p3DateTime == 0
     ) {

      if(t2SemiTrendDirection == TREND_DIRECTION_LONG) {
         t2p2DateTimeTmp = iTime(Symbol(), PERIOD_M1, iHighest(Symbol(), PERIOD_M1, MODE_HIGH,  iBarShift(Symbol(), PERIOD_M1, t2p1DateTime) + 1));
         t2p2ValueTmp = iHigh(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t2p2DateTimeTmp));
         t2P1P2MovementPoints = t2p2ValueTmp / Point() - t2p1ValueLow / Point();

         if(Bid() >= t2p2ValueTmp
               && t2P1P2MovementPoints > (tt2movementLength * InpT2MinMovementLengthBasedOnTT2MovementPercent / 100)
           ) {
            createT2P2VLine(t2p2DateTimeTmp);
         }
      }

      if(t2SemiTrendDirection == TREND_DIRECTION_SHORT) {
         t2p2DateTimeTmp = iTime(Symbol(), PERIOD_M1, iLowest(Symbol(), PERIOD_M1, MODE_LOW,  iBarShift(Symbol(), PERIOD_M1, t2p1DateTime) + 1));
         t2p2ValueTmp = iLow(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t2p2DateTimeTmp));
         t2P1P2MovementPoints = t2p1ValueHigh / Point() - t2p2ValueTmp / Point();

         if(Bid() <= t2p2ValueTmp
               && t2P1P2MovementPoints > (tt2movementLength * InpT2MinMovementLengthBasedOnTT2MovementPercent / 100)
           ) {
            createT2P2VLine(t2p2DateTimeTmp);
            getT2TrendDirection();
         }
      }

   }
}

void handleT2P3() {

   datetime t2p3DateTimeTmp = 0;
   double   t2p3ValueTmp = 0;
   double   t2P2P3RegressionPoints = 0;

   if(t2p2ValueLow != 0 && t2p2DateTime < (int)TimeCurrent()
         && t2p4DateTime == 0
     ) {

      if(t2SemiTrendDirection == TREND_DIRECTION_LONG) {
         t2p3DateTimeTmp = iTime(Symbol(), PERIOD_M1, iLowest(Symbol(), PERIOD_M1, MODE_LOW,  iBarShift(Symbol(), PERIOD_M1, t2p2DateTime) + 1));
         t2p3ValueTmp = iLow(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t2p3DateTimeTmp));
         t2P2P3RegressionPoints = t2p2ValueHigh / Point() - t2p3ValueTmp / Point();

         if(Bid() <= t2p3ValueTmp
               && t2P2P3RegressionPoints > (tt2regressionLength * InpT2MinRegressionLengthBasedOnTT2RegressionPercent / 100)
           ) {
            createT2P3VLine(t2p3DateTimeTmp);
         }
      }

      if(t2SemiTrendDirection == TREND_DIRECTION_SHORT) {
         t2p3DateTimeTmp = iTime(Symbol(), PERIOD_M1, iHighest(Symbol(), PERIOD_M1, MODE_HIGH,  iBarShift(Symbol(), PERIOD_M1, t2p2DateTime) + 1));
         t2p3ValueTmp = iHigh(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t2p3DateTimeTmp));
         t2P2P3RegressionPoints = t2p3ValueTmp / Point() - t2p2ValueLow / Point();

         if(Bid() >= t2p3ValueTmp
               && t2P2P3RegressionPoints > (tt2regressionLength * InpT2MinRegressionLengthBasedOnTT2RegressionPercent / 100)
           ) {
            createT2P3VLine(t2p3DateTimeTmp);
         }
      }
   }
}

void handleT2P4() {

   datetime t2p4DateTimeTmp = 0;
   double   t2p4ValueTmp = 0;

   if(t2p3ValueHigh != 0 && t2p3DateTime < (int)TimeCurrent()
         && t2p5DateTime == 0
     ) {

      if(t2SemiTrendDirection == TREND_DIRECTION_LONG || t2trendDirection == TREND_DIRECTION_LONG) {
         t2p4DateTimeTmp = iTime(Symbol(), PERIOD_M1, iHighest(Symbol(), PERIOD_M1, MODE_HIGH,  iBarShift(Symbol(), PERIOD_M1, t2p3DateTime) + 1));
         t2p4ValueTmp = iHigh(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t2p4DateTimeTmp));

         if(Bid() >= t2p4ValueTmp
               && t2p2ValueHigh != 0
               && t2p4ValueTmp > t2p2ValueHigh
           ) {
            createT2P4VLine(t2p4DateTimeTmp);
            if(tt3p1DateTime == 0 && t2AlertT2P4CreatedTT3MissingSended == false) t2AlertT2P4CreatedTT3MissingAction();
            if(t2MaxHighVolumeAreaLevel == 0 && t2AlertT2P4CreatedHighVolumeAreaMissingSended == false) t2AlertT2P4CreatedHighVolumeAreaMissingAction();
            getT2TrendDirection();
            resetT3Trend();
         }
      }

      if(t2SemiTrendDirection == TREND_DIRECTION_SHORT || t2trendDirection == TREND_DIRECTION_SHORT) {
         t2p4DateTimeTmp = iTime(Symbol(), PERIOD_M1, iLowest(Symbol(), PERIOD_M1, MODE_LOW,  iBarShift(Symbol(), PERIOD_M1, t2p3DateTime) + 1));
         t2p4ValueTmp = iLow(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t2p4DateTimeTmp));

         if(Bid() <= t2p4ValueTmp
               && t2p2ValueLow != 0
               && t2p4ValueTmp < t2p2ValueLow
           ) {
            createT2P4VLine(t2p4DateTimeTmp);
            if(tt3p1DateTime == 0 && t2AlertT2P4CreatedTT3MissingSended == false) t2AlertT2P4CreatedTT3MissingAction();
            if(t2MaxHighVolumeAreaLevel == 0 && t2AlertT2P4CreatedHighVolumeAreaMissingSended == false) t2AlertT2P4CreatedHighVolumeAreaMissingAction();
            getT2TrendDirection();
            resetT3Trend();
         }
      }
   }
}

void handleT2P5() {

   datetime t2p5DateTimeTmp = 0;
   double   t2p5ValueTmp = 0;
   double   t2P4P5RegressionPoints = 0;

   if(t2p4ValueLow != 0 && t2p4DateTime < (int)TimeCurrent()
     ) {

      if(t2trendDirection == TREND_DIRECTION_LONG) {
         t2p5DateTimeTmp = iTime(Symbol(), PERIOD_M1, iLowest(Symbol(), PERIOD_M1, MODE_LOW,  iBarShift(Symbol(), PERIOD_M1, t2p4DateTime) + 1));
         t2p5ValueTmp = iLow(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t2p5DateTimeTmp));
         t2P4P5RegressionPoints = t2p4ValueHigh / Point() - t2p5ValueTmp / Point();

         if(Bid() <= t2p5ValueTmp
               && t2P4P5RegressionPoints > (tt2regressionLength * InpT2MinRegressionLengthBasedOnTT2RegressionPercent / 100)
           ) {
            createT2P5VLine(t2p5DateTimeTmp);
            if(t2AlertT2P5CreatedSended == false && t3p1DateTime == 0) t2AlertT2P5CreatedAction();
         }
      }

      if(t2trendDirection == TREND_DIRECTION_SHORT) {
         t2p5DateTimeTmp = iTime(Symbol(), PERIOD_M1, iHighest(Symbol(), PERIOD_M1, MODE_HIGH,  iBarShift(Symbol(), PERIOD_M1, t2p4DateTime) + 1));
         t2p5ValueTmp = iHigh(Symbol(), PERIOD_M1, iBarShift(Symbol(), PERIOD_M1, t2p5DateTimeTmp));
         t2P4P5RegressionPoints = t2p5ValueTmp / Point() - t2p4ValueLow / Point();

         if(Bid() >= t2p5ValueTmp
               && t2P4P5RegressionPoints > (tt2regressionLength * InpT2MinRegressionLengthBasedOnTT2RegressionPercent / 100)
           ) {
            createT2P5VLine(t2p5DateTimeTmp);
            if(t2AlertT2P5CreatedSended == false && t3p1DateTime == 0) t2AlertT2P5CreatedAction();
         }
      }
   }
}

void handleT2BuildNewTrend() {

   datetime t2p3DateTimeTmp = 0;
   datetime t2p4DateTimeTmp = 0;
   datetime t2p5DateTimeTmp = 0;
   string   t2p1ObjectName = "";
   string   t2p2ObjectName = "";
   string   t2p3ObjectName = "";

   if(t2p5ValueHigh != 0 && t2p5DateTime < (int)TimeCurrent()
     ) {

      if(t2SemiTrendDirection == TREND_DIRECTION_LONG || t2trendDirection == TREND_DIRECTION_LONG) {

         if(t2p4ValueHigh != 0 && Bid() > t2p4ValueHigh) {
            if(t2ScreenshotT2BuildNewTrendBefore == false) {
               ChartSetSymbolPeriod(ChartID(), Symbol(), PERIOD_H1);
               createScreenshot("T2BuildNewTrend-Before");
               t2ScreenshotT2BuildNewTrendBefore = true;
            }
            if(t2p3DateTime != 0 && t2p4DateTime != 0 && t2p5DateTime != 0) {
               t2p3DateTimeTmp = t2p3DateTime;
               t2p4DateTimeTmp = t2p4DateTime;
               t2p5DateTimeTmp = t2p5DateTime;
               t2p1ObjectName = getVlineNameByNameLike(T2_P1_VLINE);
               t2p2ObjectName = getVlineNameByNameLike(T2_P2_VLINE);
               t2p3ObjectName = getVlineNameByNameLike(T2_P3_VLINE);
               resetT2Trend();
               createT2P1VLine(t2p3DateTimeTmp, t2p1ObjectName);
               createT2P2VLine(t2p4DateTimeTmp, t2p2ObjectName);
               createT2P3VLine(t2p5DateTimeTmp, t2p3ObjectName);
               if(t2AlertT2BuildNewTrendSended == false) t2AlertT2BuildNewTrendAction();
               getT2TrendDirection();
            }
         }
      }

      if(t2SemiTrendDirection == TREND_DIRECTION_SHORT || t2trendDirection == TREND_DIRECTION_SHORT) {

         if(t2p4ValueLow != 0 && Bid() < t2p4ValueLow) {
            if(t2ScreenshotT2BuildNewTrendBefore == false) {
               ChartSetSymbolPeriod(ChartID(), Symbol(), PERIOD_H1);
               createScreenshot("T2BuildNewTrend-Before");
               t2ScreenshotT2BuildNewTrendBefore = true;
            }
            if(t2p3DateTime != 0 && t2p4DateTime != 0 && t2p5DateTime != 0) {
               t2p3DateTimeTmp = t2p3DateTime;
               t2p4DateTimeTmp = t2p4DateTime;
               t2p5DateTimeTmp = t2p5DateTime;
               t2p1ObjectName = getVlineNameByNameLike(T2_P1_VLINE);
               t2p2ObjectName = getVlineNameByNameLike(T2_P2_VLINE);
               t2p3ObjectName = getVlineNameByNameLike(T2_P3_VLINE);
               resetT2Trend();
               createT2P1VLine(t2p3DateTimeTmp, t2p1ObjectName);
               createT2P2VLine(t2p4DateTimeTmp, t2p2ObjectName);
               createT2P3VLine(t2p5DateTimeTmp, t2p3ObjectName);
               if(t2AlertT2BuildNewTrendSended == false) t2AlertT2BuildNewTrendAction();
               getT2TrendDirection();
            }
         }
      }
   }
}

void handleT2TrendBrokenOnP1() {

   datetime t2p2DateTimeTmp = 0;
   datetime t2p3DateTimeTmp = 0;
   string   t2p1ObjectName = "";
   string   t2p2ObjectName = "";

   if(t2p1ValueHigh != 0 && t2p1DateTime <= (int)TimeCurrent()
         && t2p2ValueLow != 0 && t2p2DateTime <= (int)TimeCurrent()
         && t2p3ValueHigh != 0 && t2p3DateTime <= (int)TimeCurrent()
         && t2TrendBrokeOnFiboLevel != 0
     ) {

      if(t2SemiTrendDirection == TREND_DIRECTION_LONG || t2trendDirection == TREND_DIRECTION_LONG) {

         if(Bid() < t2TrendBrokeOnFiboLevel) {
            if(t2ScreenshotT2TrendBrokenOnP1Before == false) {
               ChartSetSymbolPeriod(ChartID(), Symbol(), PERIOD_H1);
               createScreenshot("T2TrendBrokenOnP1-Before");
               t2ScreenshotT2TrendBrokenOnP1Before = true;
            }
            if(t2p2DateTime != 0 && t2p3DateTime != 0) {
               t2p2DateTimeTmp = t2p2DateTime;
               t2p3DateTimeTmp = t2p3DateTime;
               resetT2Trend();
               createT2P1VLine(t2p2DateTimeTmp, T2_P1_VLINE);
               createT2P2VLine(t2p3DateTimeTmp, T2_P2_VLINE);
               if(t2AlertT2TrendBrokenSended == false) t2AlertT2TrendBrokenAction();
               getT2TrendDirection();
            }
         }
      }

      if(t2SemiTrendDirection == TREND_DIRECTION_SHORT || t2trendDirection == TREND_DIRECTION_SHORT) {

         if(Bid() > t2TrendBrokeOnFiboLevel) {
            if(t2ScreenshotT2TrendBrokenOnP1Before == false) {
               ChartSetSymbolPeriod(ChartID(), Symbol(), PERIOD_H1);
               createScreenshot("T2TrendBrokenOnP1-Before");
               t2ScreenshotT2TrendBrokenOnP1Before = true;
            }
            if(t2p2DateTime != 0 && t2p3DateTime != 0) {
               t2p2DateTimeTmp = t2p2DateTime;
               t2p3DateTimeTmp = t2p3DateTime;
               resetT2Trend();
               createT2P1VLine(t2p2DateTimeTmp, T2_P1_VLINE);
               createT2P2VLine(t2p3DateTimeTmp, T2_P2_VLINE);
               if(t2AlertT2TrendBrokenSended == false) t2AlertT2TrendBrokenAction();
               getT2TrendDirection();
            }
         }
      }
   }
}

void handleT2TrendBrokenOnP3() {

   datetime t2p4DateTimeTmp = 0;
   datetime t2p5DateTimeTmp = 0;
   string   t2p1ObjectName = "";
   string   t2p2ObjectName = "";

   if(t2p3ValueHigh != 0 && t2p3DateTime < TimeCurrent()
         && t2p4ValueLow != 0 && t2p4DateTime < TimeCurrent()
         && t2p5ValueHigh != 0 && t2p5DateTime < TimeCurrent()
         && t2TrendBrokeOnFiboLevel != 0
     ) {

      if(t2SemiTrendDirection == TREND_DIRECTION_LONG || t2trendDirection == TREND_DIRECTION_LONG) {

         if(Bid() < t2TrendBrokeOnFiboLevel) {
            if(t2ScreenshotT2TrendBrokenOnP3Before == false) {
               ChartSetSymbolPeriod(ChartID(), Symbol(), PERIOD_H1);
               createScreenshot("T2TrendBrokenOnP3-Before");
               t2ScreenshotT2TrendBrokenOnP3Before = true;
            }
            if(t2p4DateTime != 0 && t2p5DateTime != 0) {
               t2p4DateTimeTmp = t2p4DateTime;
               t2p5DateTimeTmp = t2p5DateTime;
               resetT2Trend();
               createT2P1VLine(t2p4DateTimeTmp, T2_P1_VLINE);
               createT2P2VLine(t2p5DateTimeTmp, T2_P2_VLINE);
               if(t2AlertT2TrendBrokenSended == false) t2AlertT2TrendBrokenAction();
               getT2TrendDirection();
            }
         }
      }

      if(t2SemiTrendDirection == TREND_DIRECTION_SHORT || t2trendDirection == TREND_DIRECTION_SHORT) {

         if(Bid() > t2TrendBrokeOnFiboLevel) {
            if(t2ScreenshotT2TrendBrokenOnP3Before == false) {
               ChartSetSymbolPeriod(ChartID(), Symbol(), PERIOD_H1);
               createScreenshot("T2TrendBrokenOnP3-Before");
               t2ScreenshotT2TrendBrokenOnP3Before = true;
            }
            if(t2p4DateTime != 0 && t2p5DateTime != 0) {
               t2p4DateTimeTmp = t2p4DateTime;
               t2p5DateTimeTmp = t2p5DateTime;
               resetT2Trend();
               createT2P1VLine(t2p4DateTimeTmp, T2_P1_VLINE);
               createT2P2VLine(t2p5DateTimeTmp, T2_P2_VLINE);
               if(t2AlertT2TrendBrokenSended == false) t2AlertT2TrendBrokenAction();
               getT2TrendDirection();
            }
         }
      }
   }
}

void resetT2Trend() {

   deleteVlineLike(T2_P1_VLINE);
   deleteVlineLike(T2_P2_VLINE);
   deleteVlineLike(T2_P3_VLINE);
   deleteVlineLike(T2_P4_VLINE);
   deleteVlineLike(T2_P5_VLINE);
   setT2LineValues();
   getT2TrendDirection();

   deleteTrendLine(T2_ZIGZAGLINE + "P1-P2");
   deleteTrendLine(T2_ZIGZAGLINE + "P2-P3");
   deleteTrendLine(T2_ZIGZAGLINE + "P3-P4");
   deleteTrendLine(T2_ZIGZAGLINE + "P4-P5");

   deleteRegressionChannel(T2_REGRESSION_CHANNEL);
   deleteTrendLineLike(T2_FIBO_LEVELS);

   t2AlertT2P4CreatedTT3MissingSended = false;
   t2AlertT2P4CreatedHighVolumeAreaMissingSended = false;
   t2AlertT2P4CreatedSended = false;
   t2AlertT2P5CreatedSended = false;
   t2AlertT2BuildNewTrendSended = false;
   t2AlertT2TrendBrokenSended = false;
   t2AlertT2VLineOn0Sended = false;

   t2ScreenshotT2BuildNewTrendBefore = false;
   t2ScreenshotT2TrendBrokenOnP1Before = false;
   t2ScreenshotT2TrendBrokenOnP3Before = false;
}
//+------------------------------------------------------------------+
