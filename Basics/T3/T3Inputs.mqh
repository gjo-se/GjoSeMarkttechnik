//+------------------------------------------------------------------+
//|                                                     T3Inputs.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

input group             "---------------------------------------------------------------"
input group             "------------------------------ T3 -----------------------------"
input group             "---------------------------------------------------------------"

input group             "------------------------------ T3 LEVELS ----------------------"
input int               InpT3MinMovementLengthBasedOnTT3MovementPercent = 66; // T3 MIN Movement % on Template
input int               InpT3MinRegressionLengthBasedOnTT3RegressionPercent = 33; // T3 MIN Regression % on Template
input double            InpT3MaxHighVolumeAreaLevel = 0; // T3 Max HighVolume Area Level
input double            InpT3MinHighVolumeAreaLevel = 0; // T3 Min HighVolume Area Level
input int               InpT3AlertOnFiboRetracmentLevel = 0; // T3 Alert on Fibo Level

input group             "------------------------------ T3 TRAILING --------------------"
input int               InpT3TrailingStopOffset = 0; // T3 TrailingStop Offset
input ENUM_TIMEFRAMES   InpT3trailingStopMATimeframe = PERIOD_M10; // T3 MA TrailingStop Timeframe
input string            InpT3trailingStopMAPeriods = "200, 150, 100, 50, 10"; // T3 MA TrailingStop Periods

input group             "------------------------------ T3 MONEY -----------------------"
input double            InpMaxPositionRiskPercent = 1; // T3 & T4 max Position Risk %

// ****************  INTERN **************** //

//input group             "------------------------------ T3 Alerts ---------------------------"
int               InpT3MinFiboRetracmentLevel = 0; // T3 Min Fibo if Level 0
int               InpT3MaxFiboRetracmentLevel = 0; // T3 Max Fibo if Level 0
int               InpMaxSpread = 10; // T3 & T4 max Spread
int               InpT3AlertOnRegressionChannelLevel = 0;
int               InpT3MinRegressionChannelLevel = 0; // T3 Min RegressionChannel
int               InpT3MaxRegressionChannelLevel = 0; // T3 Max RegressionChannel
double            InpT3StopLossLineOffsetMulti = 1.1; // T3 StopLossLine Multi
double            InpT3StopLossMarketOffsetMulti = 2.0; // T3 StopLossMarket Multi
int               InpT3ChannelEndShift = 10; // T3 Anzahl Candles Offset RegressionChannel
bool              InpT3DisableTradabelButtonStateAfterClose = true; // nach Close Button OFF
long              InpT3MagicNumber = 1619769103; // T3 MagicNumber
string            InpT3Comment = "T3 MarktTechnik"; // T3 Comment
long              InpMaxSlippage = 3; // T3 & T4 max Slippage
bool              InpT3ShowCommentDashboard = true;
bool              InpT3ObjectsShow = true;
string            InpT3FiboLevels = "25,50,75";
int               InpT3TrendBrokeOnFiboLevel = 120;
color             InpT3InSignalAreaColor = clrWheat;
bool              InpPrintScreenshot = false;
//input group             "---------- InsideBar ---------"
double            InpInsideBarMinRange = 0;
ENUM_TIMEFRAMES   InpInsideBarTimeframe = PERIOD_CURRENT;
color             InpInsideBarLineColor = clrBlue;
color             InpT3TailingStopLineColor = clrRed;
bool              InpT3UseTrailingStopMarket = true;

//input group             "---------- T3 Object-Styles ---------"
int               InpT3LineWidth = 3;
ENUM_LINE_STYLE   InpT3LineStyle = STYLE_SOLID;
int               InpT3VisibleTimeframes = OBJ_PERIOD_H1|OBJ_PERIOD_M10|OBJ_PERIOD_M1;

color             InpT3DefaultColor = clrDarkKhaki;
color             InpT3VLineColor = clrMoccasin;
color             InpT3TLineZigZagTrendLongColor = clrGreen;
color             InpT3TLineZigZagTrendShortColor = clrRed;




color             InpT3TrendLineColor = clrDarkKhaki;


//input group             "---------- StrategyTester ---------" // (Objects in Strategy Tester nicht vorhanden)
datetime          InpT3p1DateTime = D'2022.01.01 00:00';
datetime          InpT3p2DateTime = D'2022.01.01 00:00';
datetime          InpT3p3DateTime = D'2022.01.01 00:00';
datetime          InpT3p4DateTime = D'2022.01.01 00:00';
bool              InpT3TesterHideIndicators = false;
bool              InpDevMode = false;
bool              InpSendPushOnTester = true;
