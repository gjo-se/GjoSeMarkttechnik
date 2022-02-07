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

bool isNewCurrentBar;

bool  isTradabelButtonState;

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
datetime t3HhDateTime;
datetime t3LlDateTime;
datetime t3EndDateTime;

int t3trendDirection;

string t3FiboLevelsArray[];

bool objectHasChanged;

// Alerts
double alertRegressionChannelLevel;
double alertFiboRetracementLevel;
bool isBuyRegressionAlertSendable;
bool isBuyRegressionAlertSended;
bool isSellRegressionAlertSendable;
bool isSellRegressionAlertSended;
bool isBidStopLossLineOffsetAlertSendable;
bool isBidStopLossLineOffsetAlertSended;

// INSignal
double inSignalAreaMinStartValue;
double inSignalAreaMinEndValue;
double inSignalAreaMaxStartValue;
double inSignalAreaMaxEndValue;
double reEntryAreaMinStartValue;
double reEntryAreaMinEndValue;
double reEntryAreaMaxStartValue;
double reEntryAreaMaxEndValue;
bool   useReEntryArea;

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

//bool bidGreaterLowestLowAndOffsetSignal;
//bool bidLowerHighestHighAndOffsetSignal;

bool buyPositionIsOpen;
bool sellPositionIsOpen;

datetime    outSideBarDateTime;
double      t3StopLossLineLevel;
double      t3TrailingStopLevel;

long  positionTickets[];
//+------------------------------------------------------------------+
