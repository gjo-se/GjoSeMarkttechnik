//+------------------------------------------------------------------+
//|                                             InitializeAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

void initializeT4GlobalsAction() {

   t4comment = "";

   t4IsTradabelButtonState = ObjectGetInteger(0, T4_IS_TRADEABLE_BUTTON, OBJPROP_STATE);

   t4StartDateTime = 0;
   t4p1DateTime = 0;
   t4p1ValueHigh = 0;
   t4p1ValueLow = 0;
   t4p2DateTime = 0;
   t4p2ValueHigh = 0;
   t4p2ValueLow = 0;
   t4p3DateTime = 0;
   t4p3ValueHigh = 0;
   t4p3ValueLow = 0;
   t4p4DateTime = 0;
   t4p4ValueHigh = 0;
   t4p4ValueLow = 0;
   t4p5DateTime = 0;
   t4p5ValueHigh = 0;
   t4p5ValueLow = 0;
   t4HighestHighVLineDateTime = 0;
   t4LowestLowVLineDateTime = 0;
   t4EndDateTime = 0;

   t4SemiTrendDirection = TREND_DIRECTION_ROTATION;
   t4trendDirection = TREND_DIRECTION_ROTATION;

   buyT4PositionIsOpenState = false;
   maxT4BuyPositionsAreOpenState = false;
   allT4BuyPositionsAreClosedState = false;

   sellT4PositionIsOpenState = false;
   maxT4SellPositionsAreOpenState = false;
   allT4SellPositionsAreClosedState = false;

   t4OKDateTime = 0;

   t4AlertRegressionChannelLevel = 0;
   t4AlertFiboRetracementLevel = 0;
   t4IsBuyRegressionAlertSendable = false;
   t4IsBuyRegressionAlertSended = false;
   t4IsSellRegressionAlertSendable = false;
   t4IsSellRegressionAlertSended = false;
   t4IsBidStopLossLineOffsetAlertSendable = false;
   t4IsBidStopLossLineOffsetAlertSended = false;
   t4AlertDisableTradeableButtonSended = false;
   t4alertMAChangedSended = false;
   t4AlertT4TrendBrokenSended = false;
   t4AlertT4BuildNewTrendSended = false;
   t4AlertT4P5CreatedSended = false;

   t4InSignalFiboLevelAreaMinStartValue = 0;
   t4InSignalFiboLevelAreaMinEndValue = 0;
   t4InSignalFiboLevelAreaMaxStartValue = 0;
   t4InSignalFiboLevelAreaMaxEndValue = 0;
   t4InSignalRegressionChannelAreaMinStartValue = 0;
   t4InSignalRegressionChannelAreaMinEndValue = 0;
   t4InSignalRegressionChannelAreaMaxStartValue = 0;
   t4InSignalRegressionChannelAreaMaxEndValue = 0;

// HighVolumeArea
   t4MinHighVolumeAreaLevel = 0;
   t4MaxHighVolumeAreaLevel = 0;
   t4HighestHighIsInSignalArea = false;
   t4LowestLowIsInSignalArea = false;

   t4MinRegressionForTrendDetectionLevel = 0;
   t4MinRegressionForTrendDetectionState = false;

// OUTSIgnal
   t4MinProfitFiboRetracmentLevel = 0;
   t4ProfitLevelGreaterMinProfitFiboRetracmentLevel = false;
   t4CurrentBidMAOffset = 0;

   t4ReEntryAreaMinStartValue = 0;
   t4ReEntryAreaMinEndValue = 0;
   t4ReEntryAreaMaxStartValue = 0;
   t4ReEntryAreaMaxEndValue = 0;
   t4UseReEntryArea = false;


// SHORT
   t4HighestHighValue = 0;
   t4HighestHighDateTime = 0;
   t4ShortEntryValue = 0;

// LONG
   t4LowestLowValue = 0;
   t4LowestLowDateTime = 0;
   t4LongEntryValue = 0;

   outSideBarDateTime = 0;
   t4StopLossLineLevel = 0;
   t4TrailingStopLevel = 0;
   t4RegressionChannelStopLossLineLevel = 0;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void initializeT4ArraysAction() {
   convertInpT4StringsToArray();
}

void initializeT4IndicatorsAction() {

   t4TrailingStopMALevel = 0;
   int shift = 0;
   int t4trailingStopMAPeriod = 0;

   TesterHideIndicators(InpT4TesterHideIndicators);

  if(InpT4trailingStopMATimeframe == Period()) {

      for(int t4trailingStopMAPeriodsId = 0; t4trailingStopMAPeriodsId < ArraySize(t4trailingStopMAPeriodsArray); t4trailingStopMAPeriodsId++) {
         t4trailingStopMAPeriod = (int)t4trailingStopMAPeriodsArray[t4trailingStopMAPeriodsId];

         switch(t4trailingStopMAPeriodsId) {
         case 0:
            t4TrailingStopMAHandle00 = iMA(Symbol(), InpT4trailingStopMATimeframe, t4trailingStopMAPeriod, shift, MODE_SMA, PRICE_CLOSE);
            t4TrailingStopMAPeriod00 = t4trailingStopMAPeriod;
            break;
         case 1:
            t4TrailingStopMAHandle01 = iMA(Symbol(), InpT4trailingStopMATimeframe, t4trailingStopMAPeriod, shift, MODE_SMA, PRICE_CLOSE);
            t4TrailingStopMAPeriod01 = t4trailingStopMAPeriod;
            break;
         case 2:
            t4TrailingStopMAHandle02 = iMA(Symbol(), InpT4trailingStopMATimeframe, t4trailingStopMAPeriod, shift, MODE_SMA, PRICE_CLOSE);
            t4TrailingStopMAPeriod02 = t4trailingStopMAPeriod;
            break;
         case 3:
            t4TrailingStopMAHandle03 = iMA(Symbol(), InpT4trailingStopMATimeframe, t4trailingStopMAPeriod, shift, MODE_SMA, PRICE_CLOSE);
            t4TrailingStopMAPeriod03 = t4trailingStopMAPeriod;
            break;
         case 4:
            t4TrailingStopMAHandle04 = iMA(Symbol(), InpT4trailingStopMATimeframe, t4trailingStopMAPeriod, shift, MODE_SMA, PRICE_CLOSE);
            t4TrailingStopMAPeriod04 = t4trailingStopMAPeriod;
            break;
         case 5:
            t4TrailingStopMAHandle05 = iMA(Symbol(), InpT4trailingStopMATimeframe, t4trailingStopMAPeriod, shift, MODE_SMA, PRICE_CLOSE);
            t4TrailingStopMAPeriod05 = t4trailingStopMAPeriod;
         }
      }

      t4TrailingStopMAActive = t4TrailingStopMAPeriod00;
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void convertInpT4StringsToArray() {
   StringSplit(InpT4FiboLevels, StringGetCharacter(",", 0), t4FiboLevelsArray);

   if(InpT4AlertOnRegressionChannelLevel != 0) {
      ArrayResize(t4FiboLevelsArray, ArraySize(t4FiboLevelsArray) + 1);
      t4FiboLevelsArray[ArraySize(t4FiboLevelsArray) - 1] = (string)InpT4AlertOnRegressionChannelLevel;
   }

   if(InpT4AlertOnFiboRetracmentLevel != 0) {
      ArrayResize(t4FiboLevelsArray, ArraySize(t4FiboLevelsArray) + 1);
      t4FiboLevelsArray[ArraySize(t4FiboLevelsArray) - 1] = (string)InpT4AlertOnFiboRetracmentLevel;
   }

   if(InpT4MinRegressionChannelLevel != 0) {
      ArrayResize(t4FiboLevelsArray, ArraySize(t4FiboLevelsArray) + 1);
      t4FiboLevelsArray[ArraySize(t4FiboLevelsArray) - 1] = (string)InpT4MinRegressionChannelLevel;
   }

   if(InpT4MaxRegressionChannelLevel != 0) {
      ArrayResize(t4FiboLevelsArray, ArraySize(t4FiboLevelsArray) + 1);
      t4FiboLevelsArray[ArraySize(t4FiboLevelsArray) - 1] = (string)InpT4MaxRegressionChannelLevel;
   }

   if(InpT4MinRegressionForTrendDetectionPercent != 0) {
      ArrayResize(t4FiboLevelsArray, ArraySize(t4FiboLevelsArray) + 1);
      t4FiboLevelsArray[ArraySize(t4FiboLevelsArray) - 1] = (string)InpT4MinRegressionForTrendDetectionPercent;
   }

   if(InpT4MinFiboRetracmentLevel != 0) {
      ArrayResize(t4FiboLevelsArray, ArraySize(t4FiboLevelsArray) + 1);
      t4FiboLevelsArray[ArraySize(t4FiboLevelsArray) - 1] = (string)InpT4MinFiboRetracmentLevel;
   }

   if(InpT4MaxFiboRetracmentLevel != 0) {
      ArrayResize(t4FiboLevelsArray, ArraySize(t4FiboLevelsArray) + 1);
      t4FiboLevelsArray[ArraySize(t4FiboLevelsArray) - 1] = (string)InpT4MaxFiboRetracmentLevel;
   }

   if(InpT4MinReEntryRegressionChannelLevel != 0) {
      ArrayResize(t4FiboLevelsArray, ArraySize(t4FiboLevelsArray) + 1);
      t4FiboLevelsArray[ArraySize(t4FiboLevelsArray) - 1] = (string)InpT4MinReEntryRegressionChannelLevel;
   }

   if(InpT4MinReEntryFiboRetracmentLevel != 0) {
      ArrayResize(t4FiboLevelsArray, ArraySize(t4FiboLevelsArray) + 1);
      t4FiboLevelsArray[ArraySize(t4FiboLevelsArray) - 1] = (string)InpT4MinReEntryFiboRetracmentLevel;
   }

   if(InpT4MinProfitFiboRetracmentLevel != 0) {
      ArrayResize(t4FiboLevelsArray, ArraySize(t4FiboLevelsArray) + 1);
      t4FiboLevelsArray[ArraySize(t4FiboLevelsArray) - 1] = (string)InpT4MinProfitFiboRetracmentLevel;
   }

   StringSplit(InpT4trailingStopMAPeriods, StringGetCharacter(",", 0), t4trailingStopMAPeriodsArray);
}
//+------------------------------------------------------------------+
