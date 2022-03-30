//+------------------------------------------------------------------+
//|                                 T4HandleTrendDetectionAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void getT4TrendDirection() {

   double t4p2ValueTmp = 0;
   t4SemiTrendDirection = TREND_DIRECTION_ROTATION;
   t4trendDirection = TREND_DIRECTION_ROTATION;

   if(t4p1ValueHigh != 0) {
      (t4p2ValueLow != 0) ? t4p2ValueTmp = t4p2ValueLow : t4p2ValueTmp = Bid();
      if(t4p1ValueHigh < t4p2ValueTmp) t4SemiTrendDirection = TREND_DIRECTION_LONG;
      if(t4p1ValueHigh > t4p2ValueTmp) t4SemiTrendDirection = TREND_DIRECTION_SHORT;
   }

   if(t4p3ValueHigh != 0 && t4p4ValueHigh != 0) {
      if(t4p3ValueHigh < t4p4ValueHigh) t4trendDirection = TREND_DIRECTION_LONG;
      if(t4p3ValueHigh > t4p4ValueHigh) t4trendDirection = TREND_DIRECTION_SHORT;
   }
}

string getT4TrendDirectionString() {

   string trendDirectionString = "ROTATION";

   if(t4trendDirection == TREND_DIRECTION_LONG) trendDirectionString = "LONG";
   if(t4trendDirection == TREND_DIRECTION_SHORT) trendDirectionString = "SHORT";

   return trendDirectionString;
}

void handleT4TrendDetectionAction() {

   handleT4P2();
   handleT4P3();
   handleT4P4();
   handleT4P5();
   handleT4BuildNewTrend();
   handleT4TrendBrokenOnP1();
   handleT4TrendBrokenOnP3();
}

void handleT4P2() {

   datetime t4p1DateTimeTmp = 0;
   datetime t4p2DateTimeTmp = 0;
   double   t4p2ValueTmp = 0;
   double t4P1P2MovementPoints = 0;

   (t4p1DateTime != 0) ? t4p1DateTimeTmp = t4p1DateTime : t4p1DateTimeTmp = t3p4DateTime;

   if(t4p1DateTimeTmp != 0
         && t4p1DateTimeTmp < (int)TimeCurrent()
         && t4p3DateTime == 0
     ) {

      if(t4SemiTrendDirection == TREND_DIRECTION_LONG) {
         t4p2DateTimeTmp = iTime(Symbol(), Period(), iHighest(Symbol(), Period(), MODE_HIGH,  iBarShift(Symbol(), Period(), t4p1DateTimeTmp) + 1));
         t4p2ValueTmp = iHigh(Symbol(), Period(), iBarShift(Symbol(), Period(), t4p2DateTimeTmp));
         t4P1P2MovementPoints = t4p2ValueTmp / Point() - t4p1ValueLow / Point();
      }

      if(t4SemiTrendDirection == TREND_DIRECTION_SHORT) {
         t4p2DateTimeTmp = iTime(Symbol(), Period(), iLowest(Symbol(), Period(), MODE_LOW,  iBarShift(Symbol(), Period(), t4p1DateTimeTmp) + 1));
         t4p2ValueTmp = iLow(Symbol(), Period(), iBarShift(Symbol(), Period(), t4p2DateTimeTmp));
         t4P1P2MovementPoints = t4p1ValueHigh / Point() - t4p2ValueTmp / Point();
      }

      if(t4P1P2MovementPoints > (t3MovementLengthPoints * InpT4MinMovementLengthBasedOnT3MovementPercent / 100)) createT4P2VLine(t4p2DateTimeTmp);
   }
}

void handleT4P3() {

   datetime t4p3DateTimeTmp = 0;
   double   t4p3ValueTmp = 0;
   double   t4P1P2MovementPoints = 0;
   double   t4P2P3RegressionPoints = 0;

   if(t4p2ValueLow != 0
         && t4p2DateTime < (int)TimeCurrent()
         && t4p4DateTime == 0
     ) {

      if(t4SemiTrendDirection == TREND_DIRECTION_LONG) {
         t4p3DateTimeTmp = iTime(Symbol(), Period(), iLowest(Symbol(), Period(), MODE_LOW,  iBarShift(Symbol(), Period(), t4p2DateTime) + 1));
         t4p3ValueTmp = iLow(Symbol(), Period(), iBarShift(Symbol(), Period(), t4p3DateTimeTmp));
         t4P1P2MovementPoints = t4p2ValueHigh / Point() - t4p1ValueLow / Point();
         t4P2P3RegressionPoints = t4p2ValueHigh / Point() - t4p3ValueTmp / Point();
      }

      if(t4SemiTrendDirection == TREND_DIRECTION_SHORT) {
         t4p3DateTimeTmp = iTime(Symbol(), Period(), iHighest(Symbol(), Period(), MODE_HIGH,  iBarShift(Symbol(), Period(), t4p2DateTime) + 1));
         t4p3ValueTmp = iHigh(Symbol(), Period(), iBarShift(Symbol(), Period(), t4p3DateTimeTmp));
         t4P1P2MovementPoints = t4p1ValueHigh / Point() - t4p2ValueLow / Point();
         t4P2P3RegressionPoints = t4p3ValueTmp / Point() - t4p2ValueLow / Point();
      }

      if(t4P2P3RegressionPoints > (t4P1P2MovementPoints * InpT4MinRegressionForTrendDetectionPercent / 100)) createT4P3VLine(t4p3DateTimeTmp);
   }
}

void handleT4P4() {

   datetime t4p4DateTimeTmp = 0;
   double   t4p4ValueTmp = 0;
   double   t4P2P4MovementPoints = 0;

   if(t4p3ValueHigh != 0
         && t4p3DateTime < (int)TimeCurrent()
         && t4p5DateTime == 0
     ) {

      if(t4SemiTrendDirection == TREND_DIRECTION_LONG || t4trendDirection == TREND_DIRECTION_LONG) {
         t4p4DateTimeTmp = iTime(Symbol(), Period(), iHighest(Symbol(), Period(), MODE_HIGH,  iBarShift(Symbol(), Period(), t4p3DateTime) + 1));
         t4p4ValueTmp = iHigh(Symbol(), Period(), iBarShift(Symbol(), Period(), t4p4DateTimeTmp));
         t4P2P4MovementPoints = t4p4ValueTmp / Point() - t4p3ValueLow / Point();

         if(t4P2P4MovementPoints > (t3MovementLengthPoints * InpT4MinMovementLengthBasedOnT3MovementPercent / 100)
               && t4p2ValueHigh != 0
               && t4p4ValueTmp > t4p2ValueHigh
           ) createT4P4VLine(t4p4DateTimeTmp);

      }

      if(t4SemiTrendDirection == TREND_DIRECTION_SHORT || t4trendDirection == TREND_DIRECTION_SHORT) {
         t4p4DateTimeTmp = iTime(Symbol(), Period(), iLowest(Symbol(), Period(), MODE_LOW,  iBarShift(Symbol(), Period(), t4p3DateTime) + 1));
         t4p4ValueTmp = iLow(Symbol(), Period(), iBarShift(Symbol(), Period(), t4p4DateTimeTmp));
         t4P2P4MovementPoints = t4p3ValueHigh / Point() - t4p4ValueTmp / Point();

         if(t4P2P4MovementPoints > (t3MovementLengthPoints * InpT4MinMovementLengthBasedOnT3MovementPercent / 100)
               && t4p2ValueLow != 0
               && t4p4ValueTmp < t4p2ValueLow
           ) createT4P4VLine(t4p4DateTimeTmp);

      }

   }
}

void handleT4P5() {

   datetime t4p5DateTimeTmp = 0;
   double   t4p5ValueTmp = 0;
   double   t4P3P4MovementPoints = 0;
   double   t4P4P5RegressionPoints = 0;

   if(t4p4ValueLow != 0
         && t4p4DateTime < (int)TimeCurrent()
     ) {

      if(t4trendDirection == TREND_DIRECTION_LONG) {
         t4p5DateTimeTmp = iTime(Symbol(), Period(), iLowest(Symbol(), Period(), MODE_LOW,  iBarShift(Symbol(), Period(), t4p4DateTime) + 1));
         t4p5ValueTmp = iLow(Symbol(), Period(), iBarShift(Symbol(), Period(), t4p5DateTimeTmp));
         t4P3P4MovementPoints = t4p4ValueHigh / Point() - t4p3ValueLow / Point();
         t4P4P5RegressionPoints = t4p4ValueHigh / Point() - t4p5ValueTmp / Point();
      }

      if(t4trendDirection == TREND_DIRECTION_SHORT) {
         t4p5DateTimeTmp = iTime(Symbol(), Period(), iHighest(Symbol(), Period(), MODE_HIGH,  iBarShift(Symbol(), Period(), t4p4DateTime) + 1));
         t4p5ValueTmp = iHigh(Symbol(), Period(), iBarShift(Symbol(), Period(), t4p5DateTimeTmp));
         t4P3P4MovementPoints = t4p3ValueHigh / Point() - t4p4ValueLow / Point();
         t4P4P5RegressionPoints = t4p5ValueTmp / Point() - t4p4ValueLow / Point();
      }

      if(t4P4P5RegressionPoints > (t4P3P4MovementPoints * InpT4MinRegressionForTrendDetectionPercent / 100)){
        createT4P5VLine(t4p5DateTimeTmp);
        if(t3trendDirection == t4trendDirection && t4AlertT4P5CreatedSended == false) t4AlertT4P5CreatedAction();
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

         if(t4P5P6MovementPoints > (t3MovementLengthPoints * InpT4MinMovementLengthBasedOnT3MovementPercent / 100)
               && t4p4ValueHigh != 0
               && Bid() > t4p4ValueHigh
           ) {
            t4p3DateTimeTmp = t4p3DateTime;
            t4p4DateTimeTmp = t4p4DateTime;
            t4p5DateTimeTmp = t4p5DateTime;
            resetT4Trend();

            createT4P1VLine(t4p3DateTimeTmp);
            createT4P2VLine(t4p4DateTimeTmp);
            createT4P3VLine(t4p5DateTimeTmp);

            if(t4AlertT4BuildNewTrendSended == false) t4AlertT4BuildNewTrendAction();
         }
      }

      if(t4SemiTrendDirection == TREND_DIRECTION_SHORT || t4trendDirection == TREND_DIRECTION_SHORT) {
         t4P5P6MovementPoints = t4p5ValueHigh / Point() - Bid() / Point();

         if(t4P5P6MovementPoints > (t3MovementLengthPoints * InpT4MinMovementLengthBasedOnT3MovementPercent / 100)
               && t4p4ValueLow != 0
               && Bid() < t4p4ValueLow
           ) {
            t4p3DateTimeTmp = t4p3DateTime;
            t4p4DateTimeTmp = t4p4DateTime;
            t4p5DateTimeTmp = t4p5DateTime;
            resetT4Trend();

            createT4P1VLine(t4p3DateTimeTmp);
            createT4P2VLine(t4p4DateTimeTmp);
            createT4P3VLine(t4p5DateTimeTmp);

            if(t4AlertT4BuildNewTrendSended == false) t4AlertT4BuildNewTrendAction();
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
            t4p2DateTimeTmp = t4p2DateTime;
            t4p3DateTimeTmp = t4p3DateTime;
            resetT4Trend();
            createT4P1VLine(t4p2DateTimeTmp);
            createT4P2VLine(t4p3DateTimeTmp);
            if(t4AlertT4TrendBrokenSended == false) t4AlertT4TrendBrokenAction();
         }
      }

      if(t4SemiTrendDirection == TREND_DIRECTION_SHORT || t4trendDirection == TREND_DIRECTION_SHORT) {
         if(Bid() > t4p1ValueHigh) {
            t4p2DateTimeTmp = t4p2DateTime;
            t4p3DateTimeTmp = t4p3DateTime;
            resetT4Trend();
            createT4P1VLine(t4p2DateTimeTmp);
            createT4P2VLine(t4p3DateTimeTmp);
            if(t4AlertT4TrendBrokenSended == false) t4AlertT4TrendBrokenAction();
         }
      }
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
            t4p4DateTimeTmp = t4p4DateTime;
            t4p5DateTimeTmp = t4p5DateTime;
            resetT4Trend();
            createT4P1VLine(t4p4DateTimeTmp);
            createT4P2VLine(t4p5DateTimeTmp);
            if(t4AlertT4TrendBrokenSended == false) t4AlertT4TrendBrokenAction();
         }
      }

      if(t4SemiTrendDirection == TREND_DIRECTION_SHORT || t4trendDirection == TREND_DIRECTION_SHORT) {
         if(Bid() > t4p3ValueHigh) {
            t4p4DateTimeTmp = t4p4DateTime;
            t4p5DateTimeTmp = t4p5DateTime;
            resetT4Trend();
            createT4P1VLine(t4p4DateTimeTmp);
            createT4P2VLine(t4p5DateTimeTmp);
            if(t4AlertT4TrendBrokenSended == false) t4AlertT4TrendBrokenAction();
         }
      }
   }
}

//+------------------------------------------------------------------+
void resetT4Trend() {

   deleteVLine(T4_P2_VLINE);
   t4p2DateTime = 0;
   deleteTrendLine(T4_TRENDLINE + "P1-P2");

   deleteVLine(T4_P3_VLINE);
   t4p3DateTime = 0;
   deleteTrendLine(T4_TRENDLINE + "P2-P3");

   deleteVLine(T4_P4_VLINE);
   t4p4DateTime = 0;
   deleteTrendLine(T4_TRENDLINE + "P3-P4");

   deleteVLine(T4_P5_VLINE);
   t4p5DateTime = 0;
   deleteTrendLine(T4_TRENDLINE + "P4-P5");
}

//+------------------------------------------------------------------+
