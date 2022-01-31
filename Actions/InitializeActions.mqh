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
   t3StartDateTime = 0;
   t3EndDateTime = 0;

   t3trendDirection = TREND_DIRECTION_ROTATION;

   alertRegressionChannelLevel = 0;
   alertFiboRetracementLevel = 0;
   isBuyRegressionAlertSendable = false;
   isBuyRegressionAlertSended = false;
   isSellRegressionAlertSendable = false;
   isSellRegressionAlertSended = false;

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
}
//+------------------------------------------------------------------+
