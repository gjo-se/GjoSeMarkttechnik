//+------------------------------------------------------------------+
//|                                             InitializeAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

void initializeT4GlobalsAction() {

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
   t4HighestHighVLineDateTime = 0;
   t4LowestLowVLineDateTime = 0;
   t4EndDateTime = 0;

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

   t4InSignalFiboLevelAreaMinStartValue = 0;
   t4InSignalFiboLevelAreaMinEndValue = 0;
   t4InSignalFiboLevelAreaMaxStartValue = 0;
   t4InSignalFiboLevelAreaMaxEndValue = 0;
   t4InSignalRegressionChannelAreaMinStartValue = 0;
   t4InSignalRegressionChannelAreaMinEndValue = 0;
   t4InSignalRegressionChannelAreaMaxStartValue = 0;
   t4InSignalRegressionChannelAreaMaxEndValue = 0;

   t4InSignalAreaMinStartValue = 0;
   t4InSignalAreaMinEndValue = 0;
   t4InSignalAreaMaxStartValue = 0;
   t4InSignalAreaMaxEndValue = 0;
   t4IsBidLowerInSignalAreaMinEndValue = false;
   t4IsBidLowerInSignalAreaMaxEndValue = false;
   t4IsBidHigherInSignalAreaMinEndValue = false;
   t4IsBidHigherInSignalAreaMaxEndValue = false;
   t4HighestHighIsInSignalArea = false;
   t4LowestLowIsInSignalArea = false;

   t4ReEntryAreaMinStartValue = 0;
   t4ReEntryAreaMinEndValue = 0;
   t4ReEntryAreaMaxStartValue = 0;
   t4ReEntryAreaMaxEndValue = 0;
   t4UseReEntryArea = false;


// SHORT
   t4HighestHighValue = 0;
   t4HighestHighDateTime = 0;
   t4ShortEntryValue = 0;
   t4ShortIsTradable = false;

// LONG
   t4LowestLowValue = 0;
   t4LowestLowDateTime = 0;
   t4LongEntryValue = 0;
   t4LongIsTradable = false;


   outSideBarDateTime = 0;
   t4StopLossLineLevel = 0;
   t4TrailingStopLevel = 0;
   t4RegressionChannelStopLossLineLevel = 0;
}

void initializeT4ArraysAction() {

   initializeArray(positionTickets);
   convertInpT4StringsToArray();
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
}
//+------------------------------------------------------------------+
