//+------------------------------------------------------------------+
//|                                             InitializeAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
void initializeT2ArraysAction() {
   convertInpT2StringsToArray();
}

void initializeT2GlobalsAction() {

   t2StartDateTime = 0;
   t2p1DateTime = 0;
   t2p1ValueHigh = 0;
   t2p1ValueLow = 0;
   t2p2DateTime = 0;
   t2p2ValueHigh = 0;
   t2p2ValueLow = 0;
   t2p3DateTime = 0;
   t2p3ValueHigh = 0;
   t2p3ValueLow = 0;
   t2p4DateTime = 0;
   t2p4ValueHigh = 0;
   t2p4ValueLow = 0;
   t2EndDateTime = 0;

   t2SemiTrendDirection = TREND_DIRECTION_ROTATION;
   t2trendDirection = TREND_DIRECTION_ROTATION;
   t2MovementLengthPoints = 0;

// Alerts
   t2AlertT2P4CreatedTT3MissingSended = false;
   t2AlertT2P4CreatedTT4MissingSended = false;
   t2AlertT2P4CreatedHighVolumeAreaMissingSended = false;
   t2AlertT2P4CreatedSended = false;
   t2AlertT2P5CreatedSended = false;
   t2AlertT2BuildNewTrendSended = false;
   t2AlertT2TrendBrokenSended = false;
   t2AlertT2VLineOn0Sended = false;

// HighVolumeArea
   t2MinHighVolumeAreaLevel = 0;
   t2MaxHighVolumeAreaLevel = 0;

// Screenshots
   t2ScreenshotT2BuildNewTrendBefore = false;
   t2ScreenshotT2BuildNewTrendAfter = false;
   t2ScreenshotT2TrendBrokenOnP1Before = false;
   t2ScreenshotT2TrendBrokenOnP1After = false;
   t2ScreenshotT2TrendBrokenOnP3Before = false;
   t2ScreenshotT2TrendBrokenOnP3After = false;
}

void convertInpT2StringsToArray() {
   StringSplit(InpT2FiboLevels, StringGetCharacter(",", 0), t2FiboLevelsArray);
}