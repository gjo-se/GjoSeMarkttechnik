//+------------------------------------------------------------------+
//|                                                      Global.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

// Indicators
int         t4TrailingStopMAActive;
double      t4TrailingStopMALevel;
string      t4trailingStopMAPeriodsArray[];
double      t4TrailingStopMABuffer00[];
int         t4TrailingStopMAHandle00;
int         t4TrailingStopMAPeriod00;
double      t4TrailingStopMABuffer01[];
int         t4TrailingStopMAHandle01;
int         t4TrailingStopMAPeriod01;
double      t4TrailingStopMABuffer02[];
int         t4TrailingStopMAHandle02;
int         t4TrailingStopMAPeriod02;
double      t4TrailingStopMABuffer03[];
int         t4TrailingStopMAHandle03;
int         t4TrailingStopMAPeriod03;
double      t4TrailingStopMABuffer04[];
int         t4TrailingStopMAHandle04;
int         t4TrailingStopMAPeriod04;
double      t4TrailingStopMABuffer05[];
int         t4TrailingStopMAHandle05;
int         t4TrailingStopMAPeriod05;

string t4comment;

bool  t4IsTradabelButtonState;

bool  buyT4PositionIsOpenState;
bool  maxT4BuyPositionsAreOpenState;
bool  allT4BuyPositionsAreClosedState;

bool  sellT4PositionIsOpenState;
bool  maxT4SellPositionsAreOpenState;
bool  allT4SellPositionsAreClosedState;

datetime t4StartDateTime;
datetime t4p1DateTime;
double t4p1ValueHigh;
double t4p1ValueLow;
datetime t4p2DateTime;
double t4p2ValueHigh;
double t4p2ValueLow;
datetime t4p3DateTime;
double t4p3ValueHigh;
double t4p3ValueLow;
datetime t4p4DateTime;
double t4p4ValueHigh;
double t4p4ValueLow;
datetime t4HighestHighVLineDateTime;
datetime t4LowestLowVLineDateTime;
datetime t4EndDateTime;

int t4trendDirection;
string t4FiboLevelsArray[];

datetime t4OKDateTime;

// Alerts
double t4AlertRegressionChannelLevel;
double t4AlertFiboRetracementLevel;
bool t4IsBuyRegressionAlertSendable;
bool t4IsBuyRegressionAlertSended;
bool t4IsSellRegressionAlertSendable;
bool t4IsSellRegressionAlertSended;
bool t4IsBidStopLossLineOffsetAlertSendable;
bool t4IsBidStopLossLineOffsetAlertSended;
bool t4AlertDisableTradeableButtonSended;
bool t4alertMAChangedSended;

// INSignal
double t4InSignalFiboLevelAreaMinStartValue;
double t4InSignalFiboLevelAreaMinEndValue;
double t4InSignalFiboLevelAreaMaxStartValue;
double t4InSignalFiboLevelAreaMaxEndValue;
double t4InSignalRegressionChannelAreaMinStartValue;
double t4InSignalRegressionChannelAreaMinEndValue;
double t4InSignalRegressionChannelAreaMaxStartValue;
double t4InSignalRegressionChannelAreaMaxEndValue;

// HighVolumeArea
double t4MinHighVolumeAreaLevel;
double t4MaxHighVolumeAreaLevel;
bool   t4HighestHighIsInSignalArea;
bool   t4LowestLowIsInSignalArea;

// OUTSIgnal
double t4MinProfitFiboRetracmentLevel;
bool   t4ProfitLevelGreaterMinProfitFiboRetracmentLevel;
double t4CurrentBidMAOffset;

double t4ReEntryAreaMinStartValue;
double t4ReEntryAreaMinEndValue;
double t4ReEntryAreaMaxStartValue;
double t4ReEntryAreaMaxEndValue;
bool   t4UseReEntryArea;

//SHORT
double      t4HighestHighValue;
datetime    t4HighestHighDateTime;
double      t4ShortEntryValue;

// LONG
double      t4LowestLowValue;
datetime    t4LowestLowDateTime;
double      t4LongEntryValue;

double      t4OrderGridLimitOrderValuesArray[];
double      t4OrderGridStopOrderValuesArray[];

double      t4StopLossLineLevel;
double      t4TrailingStopLevel;

double      t4RegressionChannelStopLossLineLevel;

//+------------------------------------------------------------------+
