//+------------------------------------------------------------------+
//|                                          TTRegressionChannel.mqh |
//|                                       Copyright 2021, Gregory Jo |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void createTT2RegressionChannel() {

   bool isFilled = false;

   datetime startDateTime = tt2p1DateTime;
   if(tt2StartDateTime != 0) startDateTime = tt2StartDateTime;

   datetime endDateTime = tt2p3DateTime;
   if(tt2p4DateTime != 0) endDateTime = tt2p4DateTime;
   if(tt2p5DateTime != 0) endDateTime = tt2p5DateTime;
   if(tt2p6DateTime != 0) endDateTime = tt2p6DateTime;
   if(tt2EndDateTime != 0) endDateTime = tt2EndDateTime;

   if(startDateTime != 0 && endDateTime != 0 ) {
      createRegressionChannel(TT2_REGRESSION_CHANNEL, startDateTime, endDateTime, InpT2DefaultColor, isFilled, InpT2LineStyle, InpT2LineWidth);
      ObjectSetInteger(ChartID(), TT2_REGRESSION_CHANNEL, OBJPROP_TIMEFRAMES, InpT2VisibleTimeframes);
   }
}

void createTT3RegressionChannel() {

   bool isFilled = false;

   datetime startDateTime = tt3p1DateTime;
   if(tt3StartDateTime != 0) startDateTime = tt3StartDateTime;

   datetime endDateTime = tt3p3DateTime;
   if(tt3p4DateTime != 0) endDateTime = tt3p4DateTime;
   if(tt3p5DateTime != 0) endDateTime = tt3p5DateTime;
   if(tt3p6DateTime != 0) endDateTime = tt3p6DateTime;
   if(tt3EndDateTime != 0) endDateTime = tt3EndDateTime;

   if(startDateTime != 0 && endDateTime != 0 ) {
      createRegressionChannel(TT3_REGRESSION_CHANNEL, startDateTime, endDateTime, InpT3DefaultColor, isFilled, InpT3LineStyle, InpT3LineWidth);
      ObjectSetInteger(ChartID(), TT3_REGRESSION_CHANNEL, OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);
   }
}

void createTT4RegressionChannel() {

   bool isFilled = false;

   datetime startDateTime = tt4p1DateTime;
   if(tt4StartDateTime != 0) startDateTime = tt4StartDateTime;

   datetime endDateTime = tt4p3DateTime;
   if(tt4p4DateTime != 0) endDateTime = tt4p4DateTime;
   if(tt4p5DateTime != 0) endDateTime = tt4p5DateTime;
   if(tt4p6DateTime != 0) endDateTime = tt4p6DateTime;
   if(tt4EndDateTime != 0) endDateTime = tt4EndDateTime;

   if(startDateTime != 0 && endDateTime != 0 ) {
      createRegressionChannel(TT4_REGRESSION_CHANNEL, startDateTime, endDateTime, InpT4DefaultColor, isFilled, InpT4LineStyle, InpT4LineWidth);
      ObjectSetInteger(ChartID(), TT4_REGRESSION_CHANNEL, OBJPROP_TIMEFRAMES, InpT4VisibleTimeframes);
   }
}
//+------------------------------------------------------------------+

void setTT3RegressionChannelValues() {

   long chartId = ChartID();
   int objectsTotal = ObjectsTotal(chartId, 0, -1);
   int regressionChannelCount = 0;
   double regressionChannelWidthPoints = 0;
   double regressionChannelLengthPoints = 0;
   datetime startDateTime = 0;
   datetime endDateTime = 0;
   double   startMaxValue = 0;
   double   startMinValue = 0;
   double   endMinValue = 0;

   string objectName;
   for(int i = objectsTotal; i >= 0; i--) {
      objectName = ObjectName(chartId, i);
      if ( StringFind(objectName, TT3_REGRESSION_CHANNEL) != -1 && ObjectGetInteger(chartId, objectName, OBJPROP_TYPE) == OBJ_REGRESSION) {
         startDateTime = (datetime)ObjectGetInteger(ChartID(), objectName, OBJPROP_TIME, 0);
         endDateTime = (datetime)ObjectGetInteger(ChartID(), objectName, OBJPROP_TIME, 1);
         startMaxValue = ObjectGetValueByTime(ChartID(), objectName, startDateTime, 1);
         startMinValue = ObjectGetValueByTime(ChartID(), objectName, startDateTime, 2);
         endMinValue = ObjectGetValueByTime(ChartID(), objectName, endDateTime, 2);

         if(startMinValue != 0 && startMaxValue != 0) {
            regressionChannelWidthPoints += (MathMax(startMinValue, startMaxValue) - MathMin(startMinValue, startMaxValue)) / Point();
            regressionChannelLengthPoints += (MathMax(startMinValue, endMinValue) - MathMin(startMinValue, endMinValue)) / Point();
            regressionChannelCount++;
            ObjectSetInteger(ChartID(), objectName, OBJPROP_COLOR, clrDarkKhaki);
            ObjectSetInteger(ChartID(), objectName, OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);
         } else {
            Alert(objectName + " TMP3RegressionChannel mit 0-Werten");
            ObjectSetInteger(ChartID(), objectName, OBJPROP_COLOR, clrRed);
         }
      }
   }

   tt3RegressionChannelWidthAveragePoints = regressionChannelWidthPoints / regressionChannelCount;
   tt3RegressionChannelLengthAveragePoints = regressionChannelLengthPoints / regressionChannelCount;
}

void setTT3RegressionChannelAverage() {

   long chartId = ChartID();
   int objectsTotal = ObjectsTotal(chartId, 0, -1);
   datetime startDateTime = 0;
   double startMiddleValue = 0;
   datetime endDateTime = 0;
   double endMiddleValue = 0;
   double startMinAverageValue = 0;
   double endMinAverageValue = 0;
   double startMaxAverageValue = 0;
   double endMaxAverageValue = 0;
   int startCandleIndex = 0;
   int endCandleIndex = 0;
   double realPoints = 0;
   double pointPerCandle = 0;
   int destinationCandleIndex = 0;
   datetime destinationCandleDatetime = 0;
   double destinationMinValue = 0;
   double destinationMaxValue = 0;

   string objectName;
   for(int i = objectsTotal; i >= 0; i--) {
      objectName = ObjectName(chartId, i);
      if ( StringFind(objectName, TT3_REGRESSION_CHANNEL) != -1 && ObjectGetInteger(chartId, objectName, OBJPROP_TYPE) == OBJ_REGRESSION) {
         startDateTime = (datetime)ObjectGetInteger(ChartID(), objectName, OBJPROP_TIME, 0);
         endDateTime = (datetime)ObjectGetInteger(ChartID(), objectName, OBJPROP_TIME, 1);
         startMiddleValue   = ObjectGetValueByTime(ChartID(), objectName, startDateTime, 0);
         endMiddleValue   = ObjectGetValueByTime(ChartID(), objectName, endDateTime, 0);
         startMinAverageValue = startMiddleValue - (tt3RegressionChannelWidthAveragePoints * Point() / 2);
         startMaxAverageValue = startMiddleValue + (tt3RegressionChannelWidthAveragePoints * Point() / 2);
         startCandleIndex = iBarShift(Symbol(), Period(), startDateTime);
         endCandleIndex = iBarShift(Symbol(), Period(), endDateTime);
         realPoints = (endMiddleValue - startMiddleValue) / Point();
         pointPerCandle = realPoints / (startCandleIndex - endCandleIndex);
         destinationCandleIndex = startCandleIndex - (int)(MathAbs(tt3RegressionChannelLengthAveragePoints / pointPerCandle));
         destinationCandleDatetime = iTime(Symbol(), Period(), destinationCandleIndex);
         destinationMinValue = startMinAverageValue - (pointPerCandle * (destinationCandleIndex - startCandleIndex) * Point());
         destinationMaxValue = startMaxAverageValue - (pointPerCandle * (destinationCandleIndex - startCandleIndex) * Point());

         createTrendLine(objectName + "AverageMin", startDateTime, startMinAverageValue, destinationCandleDatetime, destinationMinValue, clrMaroon, InpT3LineWidth, InpT3LineStyle, "   AVG");
         ObjectSetInteger(ChartID(), objectName + "AverageMin", OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);
         createTrendLine(objectName + "AverageMax", startDateTime, startMaxAverageValue, destinationCandleDatetime, destinationMaxValue, clrMaroon, InpT3LineWidth, InpT3LineStyle, "   AVG");
         ObjectSetInteger(ChartID(), objectName + "AverageMax", OBJPROP_TIMEFRAMES, InpT3VisibleTimeframes);
      }
   }
}
//+------------------------------------------------------------------+
