//+------------------------------------------------------------------+
//|                                             InitializeAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

void initializeEAAction() {

   Trade.Deviation(InpMaxSlippage);
   Trade.MagicNumber(InpMagicNumber);

}

void initializeGlobalsAction() {

   isNewCurrentBar = false;

   isTradabelButtonState = ObjectGetInteger(0, IS_TRADEABLE_BUTTON, OBJPROP_STATE);

   buyPositionIsOpenState = false;
   maxBuyPositionsAreOpenState = false;
   allBuyPositionsAreClosedState = false;

   sellPositionIsOpenState = false;
   maxSellPositionsAreOpenState = false;
   allSellPositionsAreClosedState = false;

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

   t4StartDateTime = 0;
   t4OKDateTime = 0;

   objectHasChanged = false;

   alertRegressionChannelLevel = 0;
   alertFiboRetracementLevel = 0;
   isBuyRegressionAlertSendable = false;
   isBuyRegressionAlertSended = false;
   isSellRegressionAlertSendable = false;
   isSellRegressionAlertSended = false;
   isBidStopLossLineOffsetAlertSendable = false;
   isBidStopLossLineOffsetAlertSended = false;

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
   isBidLowerInSignalAreaMinEndValue = false;
   isBidLowerInSignalAreaMaxEndValue = false;
   isBidHigherInSignalAreaMinEndValue = false;
   isBidHigherInSignalAreaMaxEndValue = false;
   t3HighestHighIsInSignalArea = false;
   t3LowestLowIsInSignalArea = false;

   reEntryAreaMinStartValue = 0;
   reEntryAreaMinEndValue = 0;
   reEntryAreaMaxStartValue = 0;
   reEntryAreaMaxEndValue = 0;
   useReEntryArea = false;


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


//   bidGreaterLowestLowAndOffsetSignal = false;
//   bidLowerHighestHighAndOffsetSignal = false;

   outSideBarDateTime = 0;
   t3StopLossLineLevel = 0;
   t3TrailingStopLevel = 0;
   t4RegressionChannelStopLossLineLevel = 0;
}

void initializeArraysAction() {

   initializeArray(positionTickets);
   convertInpStringsToArray();
}

void initializeIndicatorsAction() {

}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void convertInpStringsToArray() {
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
}
//+------------------------------------------------------------------+
