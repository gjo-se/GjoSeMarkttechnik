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
double      trailingStopMABuffer[];
int         trailingStopMAHandle;

bool isNewCurrentBar;
string comment;

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
datetime t3HighestHighVLineDateTime;
datetime t3LowestLowVLineDateTime;
datetime t3EndDateTime;

int t3trendDirection;
string t3FiboLevelsArray[];

bool t3ObjectHasChanged;
bool t4ObjectHasChanged;

// Alerts
double t3AlertRegressionChannelLevel;
double t3AlertFiboRetracementLevel;
bool t3IsBuyRegressionAlertSendable;
bool t3IsBuyRegressionAlertSended;
bool t3IsSellRegressionAlertSendable;
bool t3IsSellRegressionAlertSended;
bool t3IsBidStopLossLineOffsetAlertSendable;
bool t3IsBidStopLossLineOffsetAlertSended;

// INSignal
double t3InSignalFiboLevelAreaMinStartValue;
double t3InSignalFiboLevelAreaMinEndValue;
double t3InSignalFiboLevelAreaMaxStartValue;
double t3InSignalFiboLevelAreaMaxEndValue;
double t3InSignalRegressionChannelAreaMinStartValue;
double t3InSignalRegressionChannelAreaMinEndValue;
double t3InSignalRegressionChannelAreaMaxStartValue;
double t3InSignalRegressionChannelAreaMaxEndValue;

double t3InSignalAreaMinStartValue;
double t3InSignalAreaMinEndValue;
double t3InSignalAreaMaxStartValue;
double t3InSignalAreaMaxEndValue;

bool   t3IsBidLowerInSignalAreaMinEndValue;
bool   t3IsBidLowerInSignalAreaMaxEndValue;
bool   t3IsBidHigherInSignalAreaMinEndValue;
bool   t3IsBidHigherInSignalAreaMaxEndValue;
bool   t3HighestHighIsInSignalArea;
bool   t3LowestLowIsInSignalArea;

// OUTSIgnal
double t3MinProfitFiboRetracmentLevel;
bool   t3ProfitLevelGreaterMinProfitFiboRetracmentLevel;

double t3ReEntryAreaMinStartValue;
double t3ReEntryAreaMinEndValue;
double t3ReEntryAreaMaxStartValue;
double t3ReEntryAreaMaxEndValue;
bool   t3UseReEntryArea;

//SHORT
double      t3HighestHighValue;
datetime    t3HighestHighDateTime;
double      t3ShortEntryValue;
bool        t3ShortIsTradable;

// LONG
double      t3LowestLowValue;
datetime    t3LowestLowDateTime;
double      t3LongEntryValue;
bool        t3LongIsTradable;

double      t3OrderGridLimitOrderValuesArray[];
double      t3OrderGridStopOrderValuesArray[];

datetime    outSideBarDateTime;
double      t3StopLossLineLevel;
double      t3TrailingStopLevel;

long  positionTickets[];
//+------------------------------------------------------------------+
