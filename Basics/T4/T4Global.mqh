//+------------------------------------------------------------------+
//|                                                      Global.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

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

// INSignal
double t4InSignalFiboLevelAreaMinStartValue;
double t4InSignalFiboLevelAreaMinEndValue;
double t4InSignalFiboLevelAreaMaxStartValue;
double t4InSignalFiboLevelAreaMaxEndValue;
double t4InSignalRegressionChannelAreaMinStartValue;
double t4InSignalRegressionChannelAreaMinEndValue;
double t4InSignalRegressionChannelAreaMaxStartValue;
double t4InSignalRegressionChannelAreaMaxEndValue;

double t4InSignalAreaMinStartValue;
double t4InSignalAreaMinEndValue;
double t4InSignalAreaMaxStartValue;
double t4InSignalAreaMaxEndValue;

bool   t4IsBidLowerInSignalAreaMinEndValue;
bool   t4IsBidLowerInSignalAreaMaxEndValue;
bool   t4IsBidHigherInSignalAreaMinEndValue;
bool   t4IsBidHigherInSignalAreaMaxEndValue;
bool   t4HighestHighIsInSignalArea;
bool   t4LowestLowIsInSignalArea;

double t4ReEntryAreaMinStartValue;
double t4ReEntryAreaMinEndValue;
double t4ReEntryAreaMaxStartValue;
double t4ReEntryAreaMaxEndValue;
bool   t4UseReEntryArea;

//SHORT
double      t4HighestHighValue;
datetime    t4HighestHighDateTime;
double      t4ShortEntryValue;
bool        t4ShortIsTradable;

// LONG
double      t4LowestLowValue;
datetime    t4LowestLowDateTime;
double      t4LongEntryValue;
bool        t4LongIsTradable;

double      t4OrderGridLimitOrderValuesArray[];
double      t4OrderGridStopOrderValuesArray[];

double      t4StopLossLineLevel;
double      t4TrailingStopLevel;

double      t4RegressionChannelStopLossLineLevel;

//+------------------------------------------------------------------+
