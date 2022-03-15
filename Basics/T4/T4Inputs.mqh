//+------------------------------------------------------------------+
//|                                                     T4Inputs.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

input group             "---------------------------------------------------------------"
input group             "------------------------------ T4 -----------------------------"
input group             "---------------------------------------------------------------"

input group             "------------------------------ T4 LEVELS ----------------------"
input bool              InpT4ObjectsShow = true; // Show T4 Objects
input int               InpT4MinFiboRetracmentLevel = 62; // T4 Min Fibo
input int               InpT4MaxFiboRetracmentLevel = 110; // T4 Max Fibo
input int               InpT4MinRegressionPercent = 50; // T4 % MIN Regression for EntryLevel

input group             "------------------------------ T4 TRAILING --------------------"
input int               InpT4MinProfitFiboRetracmentLevel = 1; // T4 TrailingStop Start Level
input int               InpT4TrailingStopOffset = 0; // T4 TrailingStop Offset
input ENUM_TIMEFRAMES   InpT4trailingStopMATimeframe = PERIOD_M1; // T4 MA TrailingStop Timeframe
input string            InpT4trailingStopMAPeriods = "200, 150, 100, 50, 10"; // T4 MA TrailingStop Periods

input group             "------------------------------ T4 MONEY -----------------------"
input int               InpT4OrderGridCount = 5; // Anzahl T4 Grid Orders


//+------------------------------------------------------------------+

// ****************  INTERN **************** //
int               InpT4AlertOnFiboRetracmentLevel = 0;
int               InpT4MinRegressionChannelLevel = 0; // T4 Min RegressionChannel
int               InpT4MaxRegressionChannelLevel = 0; // T4 Max RegressionChannel
bool              InpT4UseTrailingStopMarket = true;
color             InpT4TailingStopLineColor = clrRed;
ENUM_TIMEFRAMES   InpT4MaxTimeframe = PERIOD_H1;
string            InpT4FiboLevels = "50";
color             InpT4RegressionChannelColor = clrSilver;
color             InpT4InSignalAreaColor = clrDarkGray;
color             InpT4TrendLineColor = clrBlack;
//group             "------------------------------ T4 PRIO C ----------------"
string            InpT4Comment = "T4 MarktTechnik"; // T4 Comment
long              InpT4MagicNumber = 1619769104; // T4 MagicNumber
bool              InpT4ShowCommentDashboard = true;
//group             "------------------------------ T4 PRIO B ---------------------------"
int               InpT4ChannelEndShift = 10;
bool              InpT4DisableTradabelButtonStateAfterClose = true; // nach Close Button OFF
//group             "------------------------------ T4 Alerts ---------------------------"
int               InpT4AlertOnRegressionChannelLevel = 0;
double            InpT4StopLossLineOffsetMulti = 1.2; // T4 StopLossLine Multi
double            InpT4StopLossMarketOffsetMulti = 1.3; // T4 StopLossMarket Multi

// group             "---------- StrategyTester ---------" // (Objects in Strategy Tester nicht vorhanden)
datetime          InpT4p1DateTime = D'2022.01.01 00:00';
datetime          InpT4p2DateTime = D'2022.01.01 00:00';
datetime          InpT4p3DateTime = D'2022.01.01 00:00';
datetime          InpT4p4DateTime = D'2022.01.01 00:00';
bool              InpT4TesterHideIndicators = true;

// ****************  RAUS **************** //

int               InpT4AlertOnBidStopLossLineOffset = 0;

// group             "------------------------------ T4 Regression TS ---------------------------"
bool              InpT4RegressionChannelShow = false;
ENUM_TIMEFRAMES   InpT4RegressionChannelTimeframe = PERIOD_M10;
int               InpT4RegressionChannelEndShift = 20;
int               InpT4StopLossOnRegressionChannelLevel = 120;
double            InpT4TrendOKOnMulti = 1.5;

// group             "---------------------- T4 - ReEntry ---------------------------"
int               InpT4MinReEntryRegressionChannelLevel = 0;
int               InpT4MinReEntryFiboRetracmentLevel = 0;
color             InpT4ReEntryMinRegressionColor = clrDarkKhaki;
color             InpT4ReEntryAreaColor = clrBeige;