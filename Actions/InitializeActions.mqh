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
   t3HhDateTime = 0;
   t3EndDateTime = 0;

   t3trendDirection = TREND_DIRECTION_ROTATION;

   objectHasChanged = false;

   alertRegressionChannelLevel = 0;
   alertFiboRetracementLevel = 0;
   isBuyRegressionAlertSendable = false;
   isBuyRegressionAlertSended = false;
   isSellRegressionAlertSendable = false;
   isSellRegressionAlertSended = false;

   inSignalAreaMinStartValue = 0;
   inSignalAreaMinEndValue = 0;
   inSignalAreaMaxStartValue = 0;
   inSignalAreaMaxEndValue = 0;

//    t3highestHighStartCandleShift = 0;
   t3HighestHighValue = 0;
   t3HighestHighDateTime = 0;
   t3ShortEntryValue = 0;
   t3ShortIsTradable = false;


   t3LowestLowValue = 0;
   t3LowestLowDateTime = 0;


   bidGreaterLowestLowAndOffsetSignal = false;
   bidLowerHighestHighAndOffsetSignal = false;
   buyPositionIsOpen = false;
   sellPositionIsOpen = false;

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
      t3FiboLevelsArray[ArraySize(t3FiboLevelsArray) - 1] = InpT3AlertOnRegressionChannelLevel;
   }

   if(InpT3AlertOnFiboRetracmentLevel != 0) {
      ArrayResize(t3FiboLevelsArray, ArraySize(t3FiboLevelsArray) + 1);
      t3FiboLevelsArray[ArraySize(t3FiboLevelsArray) - 1] = InpT3AlertOnFiboRetracmentLevel;
   }

   if(InpT3MinRegressionChannelLevel != 0) {
      ArrayResize(t3FiboLevelsArray, ArraySize(t3FiboLevelsArray) + 1);
      t3FiboLevelsArray[ArraySize(t3FiboLevelsArray) - 1] = InpT3MinRegressionChannelLevel;
   }

   if(InpT3MaxRegressionChannelLevel != 0) {
      ArrayResize(t3FiboLevelsArray, ArraySize(t3FiboLevelsArray) + 1);
      t3FiboLevelsArray[ArraySize(t3FiboLevelsArray) - 1] = InpT3MaxRegressionChannelLevel;
   }

   if(InpT3MinFiboRetracmentLevel != 0) {
      ArrayResize(t3FiboLevelsArray, ArraySize(t3FiboLevelsArray) + 1);
      t3FiboLevelsArray[ArraySize(t3FiboLevelsArray) - 1] = InpT3MinFiboRetracmentLevel;

   }

   if(InpT3MaxFiboRetracmentLevel != 0) {
      ArrayResize(t3FiboLevelsArray, ArraySize(t3FiboLevelsArray) + 1);
      t3FiboLevelsArray[ArraySize(t3FiboLevelsArray) - 1] = InpT3MaxFiboRetracmentLevel;

   }
}
//+------------------------------------------------------------------+
