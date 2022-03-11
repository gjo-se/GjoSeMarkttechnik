//+------------------------------------------------------------------+
//|                                             InitializeAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void initializeEAAction() {
   Trade.Deviation(InpMaxSlippage);
}

void initializeT3GlobalsAction() {

   isNewCurrentBar = false;
   t3comment = "";

   t3IsTradabelButtonState = ObjectGetInteger(0, T3_IS_TRADEABLE_BUTTON, OBJPROP_STATE);

   buyT3PositionIsOpenState = false;
   maxT3BuyPositionsAreOpenState = false;
   allT3BuyPositionsAreClosedState = false;

   sellT3PositionIsOpenState = false;
   maxT3SellPositionsAreOpenState = false;
   allT3SellPositionsAreClosedState = false;

   t3StartDateTime = 0;
   t3p1DateTime = 0;
   t3p1ValueHigh = 0;
   t3p1ValueLow = 0;
   t3p2DateTime = 0;
   t3p2ValueHigh = 0;
   t3p2ValueLow = 0;
   t3p3DateTime = 0;
   t3p3ValueHigh = 0;
   t3p3ValueLow = 0;
   t3p4DateTime = 0;
   t3p4ValueHigh = 0;
   t3p4ValueLow = 0;
   t3HighestHighVLineDateTime = 0;
   t3LowestLowVLineDateTime = 0;
   t3EndDateTime = 0;

   t3trendDirection = TREND_DIRECTION_ROTATION;

   t3ObjectHasChanged = false;
   t3ObjectHasChanged = false;

   t3AlertRegressionChannelLevel = 0;
   t3AlertFiboRetracementLevel = 0;
   t3IsBuyRegressionAlertSendable = false;
   t3IsBuyRegressionAlertSended = false;
   t3IsSellRegressionAlertSendable = false;
   t3IsSellRegressionAlertSended = false;
   t3IsBidStopLossLineOffsetAlertSendable = false;
   t3IsBidStopLossLineOffsetAlertSended = false;

   t3InSignalFiboLevelAreaMinStartValue = 0;
   t3InSignalFiboLevelAreaMinEndValue = 0;
   t3InSignalFiboLevelAreaMaxStartValue = 0;
   t3InSignalFiboLevelAreaMaxEndValue = 0;
   t3InSignalRegressionChannelAreaMinStartValue = 0;
   t3InSignalRegressionChannelAreaMinEndValue = 0;
   t3InSignalRegressionChannelAreaMaxStartValue = 0;
   t3InSignalRegressionChannelAreaMaxEndValue = 0;

   t3InSignalAreaMinStartValue = 0;
   t3InSignalAreaMinEndValue = 0;
   t3InSignalAreaMaxStartValue = 0;
   t3InSignalAreaMaxEndValue = 0;
   t3IsBidLowerInSignalAreaMinEndValue = false;
   t3IsBidLowerInSignalAreaMaxEndValue = false;
   t3IsBidHigherInSignalAreaMinEndValue = false;
   t3IsBidHigherInSignalAreaMaxEndValue = false;
   t3HighestHighIsInSignalArea = false;
   t3LowestLowIsInSignalArea = false;

// OUTSIgnal
   t3MinProfitFiboRetracmentLevel = 0;
   t3ProfitLevelGreaterMinProfitFiboRetracmentLevel = false;

   t3ReEntryAreaMinStartValue = 0;
   t3ReEntryAreaMinEndValue = 0;
   t3ReEntryAreaMaxStartValue = 0;
   t3ReEntryAreaMaxEndValue = 0;
   t3UseReEntryArea = false;


// SHORT
   t3HighestHighValue = 0;
   t3HighestHighDateTime = 0;
   t3ShortEntryValue = 0;
   t3ShortIsTradable = false;

// LONG
   t3LowestLowValue = 0;
   t3LowestLowDateTime = 0;
   t3LongEntryValue = 0;
   t3LongIsTradable = false;

   outSideBarDateTime = 0;
   t3StopLossLineLevel = 0;
   t3TrailingStopLevel = 0;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void initializeT3ArraysAction() {
   convertInpT3StringsToArray();
}

void initializeT3IndicatorsAction() {

   t3TrailingStopMALevel = 0;
   int shift = 0;
   int t3trailingStopMAPeriod = 0;


   if(InpT3trailingStopMATimeframe == Period()) {

      for(int t3trailingStopMAPeriodsId = 0; t3trailingStopMAPeriodsId < ArraySize(t3trailingStopMAPeriodsArray); t3trailingStopMAPeriodsId++) {
         t3trailingStopMAPeriod = (int)t3trailingStopMAPeriodsArray[t3trailingStopMAPeriodsId];

         switch(t3trailingStopMAPeriodsId) {
         case 0:
            t3TrailingStopMAHandle00 = iMA(Symbol(), InpT3trailingStopMATimeframe, t3trailingStopMAPeriod, shift, MODE_SMA, PRICE_CLOSE);
            t3TrailingStopMAPeriod00 = t3trailingStopMAPeriod;
            t3TrailingStopMAActive = t3TrailingStopMAPeriod00;
            break;
         case 1:
            t3TrailingStopMAHandle01 = iMA(Symbol(), InpT3trailingStopMATimeframe, t3trailingStopMAPeriod, shift, MODE_SMA, PRICE_CLOSE);
            t3TrailingStopMAPeriod01 = t3trailingStopMAPeriod;
            break;
         case 2:
            t3TrailingStopMAHandle02 = iMA(Symbol(), InpT3trailingStopMATimeframe, t3trailingStopMAPeriod, shift, MODE_SMA, PRICE_CLOSE);
            t3TrailingStopMAPeriod02 = t3trailingStopMAPeriod;
            break;
         case 3:
            t3TrailingStopMAHandle03 = iMA(Symbol(), InpT3trailingStopMATimeframe, t3trailingStopMAPeriod, shift, MODE_SMA, PRICE_CLOSE);
            t3TrailingStopMAPeriod03 = t3trailingStopMAPeriod;
            break;
         case 4:
            t3TrailingStopMAHandle04 = iMA(Symbol(), InpT3trailingStopMATimeframe, t3trailingStopMAPeriod, shift, MODE_SMA, PRICE_CLOSE);
            t3TrailingStopMAPeriod04 = t3trailingStopMAPeriod;
            break;
         case 5:
            t3TrailingStopMAHandle05 = iMA(Symbol(), InpT3trailingStopMATimeframe, t3trailingStopMAPeriod, shift, MODE_SMA, PRICE_CLOSE);
            t3TrailingStopMAPeriod05 = t3trailingStopMAPeriod;
         }
      }
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void convertInpT3StringsToArray() {
   StringSplit(InpT3FiboLevels, StringGetCharacter(",", 0), t3FiboLevelsArray);

   if(InpT3AlertOnRegressionChannelLevel != 0) {
      ArrayResize(t3FiboLevelsArray, ArraySize(t3FiboLevelsArray) + 1);
      t3FiboLevelsArray[ArraySize(t3FiboLevelsArray) - 1] = (string)InpT3AlertOnRegressionChannelLevel;
   }

   if(InpT3AlertOnFiboRetracmentLevel != 0) {
      ArrayResize(t3FiboLevelsArray, ArraySize(t3FiboLevelsArray) + 1);
      t3FiboLevelsArray[ArraySize(t3FiboLevelsArray) - 1] = (string)InpT3AlertOnFiboRetracmentLevel;
   }

   if(InpT3MinRegressionChannelLevel != 0) {
      ArrayResize(t3FiboLevelsArray, ArraySize(t3FiboLevelsArray) + 1);
      t3FiboLevelsArray[ArraySize(t3FiboLevelsArray) - 1] = (string)InpT3MinRegressionChannelLevel;
   }

   if(InpT3MaxRegressionChannelLevel != 0) {
      ArrayResize(t3FiboLevelsArray, ArraySize(t3FiboLevelsArray) + 1);
      t3FiboLevelsArray[ArraySize(t3FiboLevelsArray) - 1] = (string)InpT3MaxRegressionChannelLevel;
   }

   if(InpT3MinFiboRetracmentLevel != 0) {
      ArrayResize(t3FiboLevelsArray, ArraySize(t3FiboLevelsArray) + 1);
      t3FiboLevelsArray[ArraySize(t3FiboLevelsArray) - 1] = (string)InpT3MinFiboRetracmentLevel;
   }

   if(InpT3MaxFiboRetracmentLevel != 0) {
      ArrayResize(t3FiboLevelsArray, ArraySize(t3FiboLevelsArray) + 1);
      t3FiboLevelsArray[ArraySize(t3FiboLevelsArray) - 1] = (string)InpT3MaxFiboRetracmentLevel;
   }

   if(InpT3MinReEntryRegressionChannelLevel != 0) {
      ArrayResize(t3FiboLevelsArray, ArraySize(t3FiboLevelsArray) + 1);
      t3FiboLevelsArray[ArraySize(t3FiboLevelsArray) - 1] = (string)InpT3MinReEntryRegressionChannelLevel;
   }

   if(InpT3MinReEntryFiboRetracmentLevel != 0) {
      ArrayResize(t3FiboLevelsArray, ArraySize(t3FiboLevelsArray) + 1);
      t3FiboLevelsArray[ArraySize(t3FiboLevelsArray) - 1] = (string)InpT3MinReEntryFiboRetracmentLevel;
   }

   if(InpT3MinProfitFiboRetracmentLevel != 0) {
      ArrayResize(t3FiboLevelsArray, ArraySize(t3FiboLevelsArray) + 1);
      t3FiboLevelsArray[ArraySize(t3FiboLevelsArray) - 1] = (string)InpT3MinProfitFiboRetracmentLevel;
   }

   StringSplit(InpT3trailingStopMAPeriods, StringGetCharacter(",", 0), t3trailingStopMAPeriodsArray);
}
//+------------------------------------------------------------------+
