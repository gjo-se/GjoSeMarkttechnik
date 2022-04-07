//+------------------------------------------------------------------+
//|                                                      Global.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

CTradeHedge Trade;
CPositions  Positions;
CTrailing   Trail;
CTimer      Timer;
CNewBar     NewBar;

// Indicators
int         t3TrailingStopMAActive;
double      t3TrailingStopMALevel;
int         t3trailingStopMAPeriodsArray[];
double      t3TrailingStopMABuffer00[];
int         t3TrailingStopMAHandle00;
int         t3TrailingStopMAPeriod00;
double      t3TrailingStopMABuffer01[];
int         t3TrailingStopMAHandle01;
int         t3TrailingStopMAPeriod01;
double      t3TrailingStopMABuffer02[];
int         t3TrailingStopMAHandle02;
int         t3TrailingStopMAPeriod02;
double      t3TrailingStopMABuffer03[];
int         t3TrailingStopMAHandle03;
int         t3TrailingStopMAPeriod03;
double      t3TrailingStopMABuffer04[];
int         t3TrailingStopMAHandle04;
int         t3TrailingStopMAPeriod04;
double      t3TrailingStopMABuffer05[];
int         t3TrailingStopMAHandle05;
int         t3TrailingStopMAPeriod05;

bool isNewCurrentBar;
string t3comment;

bool  t3IsTradabelButtonState;

bool  buyT3PositionIsOpenState;
bool  maxT3BuyPositionsAreOpenState;
bool  allT3BuyPositionsAreClosedState;

bool  sellT3PositionIsOpenState;
bool  maxT3SellPositionsAreOpenState;
bool  allT3SellPositionsAreClosedState;

datetime t3StartDateTime;
datetime t3p1DateTime;
double t3p1ValueHigh;
double t3p1ValueLow;
datetime t3p2DateTime;
double t3p2ValueHigh;
double t3p2ValueLow;
datetime t3p3DateTime;
double t3p3ValueHigh;
double t3p3ValueLow;
datetime t3p4DateTime;
double t3p4ValueHigh;
double t3p4ValueLow;
datetime t3p5DateTime;
double t3p5ValueHigh;
double t3p5ValueLow;
datetime t3HighestHighVLineDateTime;
datetime t3LowestLowVLineDateTime;
datetime t3EndDateTime;

int t3SemiTrendDirection;
int t3trendDirection;
string t3FiboLevelsArray[];
int t3MovementLengthPoints;

bool t3ObjectHasChanged;
bool t4ObjectHasChanged;

// Alerts
bool sendAlerts;
double t3AlertRegressionChannelLevel;
double t3AlertFiboRetracementLevel;
bool t3IsBuyRegressionAlertSendable;
bool t3IsBuyRegressionAlertSended;
bool t3IsSellRegressionAlertSendable;
bool t3IsSellRegressionAlertSended;
bool t3IsBidStopLossLineOffsetAlertSendable;
bool t3IsBidStopLossLineOffsetAlertSended;
bool t3AlertDisableTradeableButtonSended;
bool t3alertBidIsInSignalAreaSended;
bool t3alertBidAgainInHighVolumeAreaSended;
bool t3alertMAChangedSended;
bool t3AlertT3TrendBrokenSended;
bool t3AlertT3P5CreatedTT4MissingSended;
bool t3AlertT3VLineOn0Sended;

// INSignal
double t3InSignalFiboLevelAreaMinStartValue;
double t3InSignalFiboLevelAreaMinEndValue;
double t3InSignalFiboLevelAreaMaxStartValue;
double t3InSignalFiboLevelAreaMaxEndValue;
double t3InSignalRegressionChannelAreaMinStartValue;
double t3InSignalRegressionChannelAreaMinEndValue;
double t3InSignalRegressionChannelAreaMaxStartValue;
double t3InSignalRegressionChannelAreaMaxEndValue;

// HighVolumeArea
double t3MinHighVolumeAreaLevel;
double t3MaxHighVolumeAreaLevel;
bool   t3HighestHighIsInSignalArea;
bool   t3LowestLowIsInSignalArea;

// OUTSIgnal
double t3MinProfitFiboRetracmentLevel;
bool   t3ProfitLevelGreaterMinProfitFiboRetracmentLevel;
double t3CurrentBidMAOffset;


double t3ReEntryAreaMinStartValue;
double t3ReEntryAreaMinEndValue;
double t3ReEntryAreaMaxStartValue;
double t3ReEntryAreaMaxEndValue;
bool   t3UseReEntryArea;

//SHORT
double      t3HighestHighValue;
datetime    t3HighestHighDateTime;
double      t3ShortEntryValue;

// LONG
double      t3LowestLowValue;
datetime    t3LowestLowDateTime;
double      t3LongEntryValue;

double      t3OrderGridLimitOrderValuesArray[];
double      t3OrderGridStopOrderValuesArray[];

datetime    outSideBarDateTime;
double      t3StopLossValue;
double      t3TrailingStopLevel;

bool        t3ScreenshotT3P2CreatedBefore;
bool        t3ScreenshotT3P2CreatedAfter;
bool        t3ScreenshotT3P3CreatedBefore;
bool        t3ScreenshotT3P3CreatedAfter;
bool        t3ScreenshotT3P4CreatedBefore;
bool        t3ScreenshotT3P4CreatedAfter;
bool        t3ScreenshotT3P5CreatedBefore;
bool        t3ScreenshotT3P5CreatedAfter;
bool        t3ScreenshotT3BuildNewTrendBefore;
bool        t3ScreenshotT3BuildNewTrendAfter;
bool        t3ScreenshotT3TrendBrokenOnP1Before;
bool        t3ScreenshotT3TrendBrokenOnP1After;
bool        t3ScreenshotT3TrendBrokenOnP3Before;
bool        t3ScreenshotT3TrendBrokenOnP3After;

//+------------------------------------------------------------------+
