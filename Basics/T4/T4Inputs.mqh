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
input int               InpT4MinMovementLengthBasedOnTT4MovementPercent = 66; // T4 MIN Movement % on Template
input int               InpT4MinRegressionLengthBasedOnTT4RegressionPercent = 66; // T4 MIN Regression % on Template
input int               InpT4AlertOnFiboRetracmentLevel = 0;

input group             "------------------------------ T4 TRAILING --------------------"
input int               InpT4MinProfitFiboRetracmentLevel = 0; // T4 TrailingStop Start Level
input int               InpT4TrailingStopOffset = 0; // T4 TrailingStop Offset
input ENUM_TIMEFRAMES   InpT4trailingStopMATimeframe = PERIOD_M1; // T4 MA TrailingStop Timeframe
input string            InpT4trailingStopMAPeriods = "200, 150, 100, 50, 10"; // T4 MA TrailingStop Periods

input group             "------------------------------ T4 MONEY -----------------------"
input int               InpT4OrderGridCount = 1; // Anzahl T4 Grid Orders


//+------------------------------------------------------------------+

// ****************  INTERN **************** //
int               InpT4MinRegressionPercent = 0; // T4 % MIN Regression for EntryLevel
int               InpT4MinFiboRetracmentLevel = 0; // T4 Min Fibo
int               InpT4MaxFiboRetracmentLevel = 0; // T4 Max Fibo
int               InpT4MinRegressionChannelLevel = 0; // T4 Min RegressionChannel
int               InpT4MaxRegressionChannelLevel = 0; // T4 Max RegressionChannel
bool              InpT4UseTrailingStopMarket = true;
color             InpT4TailingStopLineColor = clrRed;
string            InpT4FiboLevels = "25,50,75";
color             InpT4InSignalAreaColor = clrWheat;
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
double            InpT4StopLossMarketOffsetMulti = 2.0; // T4 StopLossMarket Multi
//group             "------------------------------ T4 TrendSize ---------------------------"
int               InpT4MaxMovementLengthBasedOnT3MovementPercent = 45;

//input group             "---------- T4 Object-Styles ---------"
int               InpT4LineWidth = 2;
ENUM_LINE_STYLE   InpT4LineStyle = STYLE_SOLID;
int               InpT4VisibleTimeframes = OBJ_PERIOD_M1;

color             InpT4DefaultColor = clrSilver;
color             InpT4InvisibleColor = clrWhite;
color             InpT4VLineColor = clrSilver;
color             InpT4TLineZigZagTrendLongColor = clrLightGreen;
color             InpT4TLineZigZagTrendShortColor = clrLightSalmon;





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