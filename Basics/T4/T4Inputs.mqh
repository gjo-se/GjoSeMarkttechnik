//+------------------------------------------------------------------+
//|                                                     T4Inputs.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

input group             "------------------------------ T4 PRIO A ---------------------------"
input int               InpT4MinRegressionChannelLevel = 0; // T4 Min RegressionChannel
input int               InpT4MaxRegressionChannelLevel = 0; // T4 Max RegressionChannel
input int               InpT4MinFiboRetracmentLevel = 0; // T4 Min FiboRetracment
input int               InpT4MaxFiboRetracmentLevel = 0; // T4 Max FiboRetracment
input int               InpT4MinProfitFiboRetracmentLevel = 0; // T4 Min Profit FiboRetracment Level
input int               InpT4StopLoss = 0; // T4 StopLoss
input int               InpT4MinRegressionPercent = 20; // T4 % minRegression for EntryLevel
input double            InpT4StopLossLineMulti = 1.2; // T4 StopLossLine Multi
input double            InpT4StopLossMarketMulti = 1.3; // T4 StopLossMarket Multi

input group             "------------------------------ T4 Alerts ---------------------------"
input int               InpT4AlertOnRegressionChannelLevel = 0;
input int               InpT4AlertOnFiboRetracmentLevel = 0;
input int               InpT4AlertOnBidStopLossLineOffset = 0;

input group             "------------------------------ T4 PRIO B ---------------------------"
input int               InpT4ChannelEndShift = 10;
input int               InpT4OrderGridCount = 5; // Anzahl T4 Grid Orders
input bool              InpT4SetIsTradabelButtonStateAfterClose = false; // nach Close Button OFF

input group             "------------------------------ T4 PRIO C ----------------"
input string            InpT4Comment = "T4 MarktTechnik"; // T4 Comment
input long              InpT4MagicNumber = 1619769104; // T4 MagicNumber
input bool              InpT4ShowCommentDashboard = false;
input bool              InpT4ObjectsShow = true;
input ENUM_TIMEFRAMES   InpT4MaxTimeframe = PERIOD_H1;
input string            InpT4FiboLevels = "10, 20, 30, 40, 50, 60, 70, 80, 90, 110";
input color             InpT4RegressionChannelColor = clrSilver;
input color             InpT4InSignalAreaColor = clrDarkGray;
input color             InpT4TrendLineColor = clrBlack;

input group             "------------------------------ T4 PRIO D - nicht in Gebrauch ---------------------------"
input group             "---------- SL & TP ---------"
input int               InpT4TakeProfit = 0; // T4 TakeProfit
input group             "---------------------- T4 - ReEntry ---------------------------"
input int               InpT4MinReEntryRegressionChannelLevel = 0;
input int               InpT4MinReEntryFiboRetracmentLevel = 0;
input color             InpT4ReEntryMinRegressionColor = clrDarkKhaki;
input color             InpT4ReEntryAreaColor = clrBeige;
input group             "------------------------------ T4 Regression TS ---------------------------"
input bool              InpT4RegressionChannelShow = false;
input ENUM_TIMEFRAMES   InpT4RegressionChannelTimeframe = PERIOD_M10;
input int               InpT4RegressionChannelEndShift = 20;
input int               InpT4StopLossOnRegressionChannelLevel = 120;
input double            InpT4TrendOKOnMulti = 1.5;
input group             "---------- Trailing ---------"
input bool              InpT4UseMarketTrailingStop = true;
input double            InpT4MarketTrailingStopMulti = 1.5;
input color             InpT4TailingStopLineColor = clrRed;
input ENUM_TIMEFRAMES   InpT4trailingStopMATimeframe = PERIOD_M1;
input int               InpT4trailingStopMAPeriod = 50;
input group             "---------- StrategyTester ---------" // (Objects in Strategy Tester nicht vorhanden)
input datetime          InpT4p1DateTime = D'2022.01.01 00:00';
input datetime          InpT4p2DateTime = D'2022.01.01 00:00';
input datetime          InpT4p3DateTime = D'2022.01.01 00:00';
input datetime          InpT4p4DateTime = D'2022.01.01 00:00';
//+------------------------------------------------------------------+
