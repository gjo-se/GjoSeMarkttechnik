//+------------------------------------------------------------------+
//|                                                     T3Inputs.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

input group             "---------------------------------------------------------------"
input group             "------------------------------ T3 -----------------------------"
input group             "---------------------------------------------------------------"

input group             "------------------------------ T3 LEVELS ----------------------"
input int               InpT3AlertOnFiboRetracmentLevel = 50; // T3 Alert on Fibo Level
input int               InpT3MinFiboRetracmentLevel = 62; // T3 Min Fibo
input int               InpT3MaxFiboRetracmentLevel = 110; // T3 Max Fibo

input group             "------------------------------ T3 TRAILING --------------------"
input int               InpT3MinProfitFiboRetracmentLevel = -10; // T3 TrailingStop Start Level
input int               InpT3TrailingStopOffset = 0; // T3 TrailingStop Offset
input ENUM_TIMEFRAMES   InpT3trailingStopMATimeframe = PERIOD_M10; // T3 MA TrailingStop Timeframe
input string            InpT3trailingStopMAPeriods = "200, 150, 100, 50, 10"; // T3 MA TrailingStop Periods

input group             "------------------------------ T3 MONEY -----------------------"
input double            InpMaxPositionRiskPercent = 1; // T3 & T4 max Position Risk %
input int               InpT3OrderGridCount = 5; // T3 Anzahl Grid Orders


// ****************  INTERN **************** //

//input group             "------------------------------ T3 Alerts ---------------------------"
int               InpMaxSpread = 10; // T3 & T4 max Spread
int               InpT3AlertOnRegressionChannelLevel = 0;
int               InpT3MinRegressionChannelLevel = 0; // T3 Min RegressionChannel
int               InpT3MaxRegressionChannelLevel = 0; // T3 Max RegressionChannel
double            InpT3StopLossLineOffsetMulti = 1.1; // T3 StopLossLine Multi
double            InpT3StopLossMarketOffsetMulti = 1.2; // T3 StopLossMarket Multi
int               InpT3ChannelEndShift = 10; // T3 Anzahl Candles Offset RegressionChannel
bool              InpT3SetIsTradabelButtonStateAfterClose = false; // nach Close Button OFF
long              InpT3MagicNumber = 1619769103; // T3 MagicNumber
string            InpT3Comment = "T3 MarktTechnik"; // T3 Comment
long              InpMaxSlippage = 3; // T3 & T4 max Slippage
bool              InpT3ShowCommentDashboard = true;
bool              InpT3ObjectsShow = true;
ENUM_TIMEFRAMES   InpT3MaxTimeframe = PERIOD_H1;
string            InpT3FiboLevels = "10, 20, 30, 40, 50, 60, 70, 80, 90, 110";
color             InpT3RegressionChannelColor = clrBeige;
color             InpT3InSignalAreaColor = clrWheat;
color             InpT3TrendLineColor = clrDarkKhaki;
bool              InpPrintScreenshot = false;
//input group             "---------- InsideBar ---------"
double            InpInsideBarMinRange = 0;
ENUM_TIMEFRAMES   InpInsideBarTimeframe = PERIOD_CURRENT;
color             InpInsideBarLineColor = clrBlue;
color             InpT3TailingStopLineColor = clrRed;
bool              InpT3UseTrailingStopMarket = true;

//input group             "---------- StrategyTester ---------" // (Objects in Strategy Tester nicht vorhanden)
datetime          InpT3p1DateTime = D'2022.01.01 00:00';
datetime          InpT3p2DateTime = D'2022.01.01 00:00';
datetime          InpT3p3DateTime = D'2022.01.01 00:00';
datetime          InpT3p4DateTime = D'2022.01.01 00:00';

// ****************  RAUS **************** //
int               InpT3AlertOnBidStopLossLineOffset = 0;
int               InpT3MinReEntryRegressionChannelLevel = 0;
int               InpT3MinReEntryFiboRetracmentLevel = 0;
color             InpT3ReEntryMinRegressionColor = clrDarkKhaki;
color             InpT3ReEntryAreaColor = clrBeige;
