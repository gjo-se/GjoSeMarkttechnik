//+------------------------------------------------------------------+
//|                                                      Global.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

bool  t2AutoButtonState;
bool  t2TMPButtonState;

datetime t2StartDateTime;
datetime t2p1DateTime;
double t2p1ValueHigh;
double t2p1ValueLow;
datetime t2p2DateTime;
double t2p2ValueHigh;
double t2p2ValueLow;
datetime t2p3DateTime;
double t2p3ValueHigh;
double t2p3ValueLow;
datetime t2p4DateTime;
double t2p4ValueHigh;
double t2p4ValueLow;
datetime t2p5DateTime;
double t2p5ValueHigh;
double t2p5ValueLow;
datetime t2EndDateTime;

int t2SemiTrendDirection;
int t2trendDirection;
int t2MovementLengthPoints;
double t2TrendBrokeOnFiboLevel;
string t2FiboLevelsArray[];

// Alerts
bool t2AlertT2P4CreatedTT3MissingSended;
bool t2AlertT2P4CreatedHighVolumeAreaMissingSended;
bool t2AlertT2P4CreatedSended;
bool t2AlertT2P5CreatedSended;
bool t2AlertT2BuildNewTrendSended;
bool t2AlertT2TrendBrokenSended;
bool t2AlertT2VLineOn0Sended;

// HighVolumeArea
double t2MaxHighVolumeAreaLevel;
double t2MinHighVolumeAreaLevel;

// Screenshots
bool t2ScreenshotT2BuildNewTrendBefore;
bool t2ScreenshotT2TrendBrokenOnP1Before;
bool t2ScreenshotT2TrendBrokenOnP3Before;
