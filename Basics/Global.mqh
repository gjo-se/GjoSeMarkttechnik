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
datetime t3StartDateTime;
datetime t3EndDateTime;

int t3trendDirection;

string t3FiboLevelsArray[];

double alertRegressionChannelLevel;
double alertFiboRetracementLevel;

bool isBuyRegressionAlertSendable;
bool isBuyRegressionAlertSended;
bool isSellRegressionAlertSendable;
bool isSellRegressionAlertSended;

bool bidGreaterLowestLowAndOffsetSignal;
bool bidLowerHighestHighAndOffsetSignal;

bool buyPositionIsOpen;
bool sellPositionIsOpen;

long  positionTickets[];