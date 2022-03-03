//+------------------------------------------------------------------+
//|                                             InitializeAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

void initializeEAAction() {

   Trade.Deviation(InpMaxSlippage);
   Trade.MagicNumber(InpMagicNumber);

}

void initializeT3GlobalsAction() {

   isNewCurrentBar = false;
   comment = "";

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
   t4ObjectHasChanged = false;

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

void initializeT3ArraysAction() {

   initializeArray(positionTickets);
   convertInpT3StringsToArray();
}

void initializeT3IndicatorsAction() {

   initializeArray(t3TrailingStopMABuffer);
   t3TrailingStopMAHandle = 0;

   int sglSLowMAShift = 0;
   int subWindow = 0;

   if(InpT3trailingStopMATimeframe != Period()) Alert(Symbol() + " - Timeframe passt nicht zu InpT3trailingStopMATimeframe");
   t3TrailingStopMAHandle=iMA(Symbol(), InpT3trailingStopMATimeframe, InpT3trailingStopMAPeriod, sglSLowMAShift,MODE_SMA, PRICE_CLOSE);
   ChartIndicatorAdd(ChartID(),subWindow,t3TrailingStopMAHandle);
}

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
}
//+------------------------------------------------------------------+
