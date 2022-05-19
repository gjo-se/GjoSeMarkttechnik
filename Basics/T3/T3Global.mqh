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
bool isNewD1Bar;
string t3comment;

bool  t3AutoButtonState;
bool  t3TMPButtonState;

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
datetime t3p6DateTime;
double t3p6ValueHigh;
double t3p6ValueLow;
datetime t3p7DateTime;
double t3p7ValueHigh;
double t3p7ValueLow;
datetime t3EndDateTime;

int t3SemiTrendDirection;
int t3trendDirection;
string t3FiboLevelsArray[];
double t3TrendBrokeOnFiboLevel;
int t3MovementLengthPoints;

// Alerts
bool sendAlerts;
double t3AlertRegressionChannelLevel;
double t3AlertFiboRetracementLevel;
bool t3IsBuyRegressionAlertSendable;
bool t3IsBuyRegressionAlertSended;
bool t3IsSellRegressionAlertSendable;
bool t3IsSellRegressionAlertSended;
bool t3AlertDisableTradeableButtonSended;
bool t3alertBidIsInSignalAreaSended;
bool t3alertBidAgainInHighVolumeAreaSended;
bool t3alertMAChangedSended;
bool t3AlertT3TrendBrokenSended;
bool t3AlertT3VLineOn0Sended;
bool t3AlertT3P6CreatedSended;
bool t3AlertT3P6CreatedTT4MissingSended;

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

// OUTSIgnal
double t3MinProfitFiboRetracmentLevel;
double t3CurrentBidMAOffset;

datetime    outSideBarDateTime;
double      t3StopLossValue;
double      t3TrailingStopLevel;

bool        t3ScreenshotT3BuildNewTrendBefore;
bool        t3ScreenshotT3TrendBrokenOnP1Before;
bool        t3ScreenshotT3TrendBrokenOnP3Before;

//+------------------------------------------------------------------+
