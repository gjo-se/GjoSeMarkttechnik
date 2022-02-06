//+------------------------------------------------------------------+
//|                                                       Inputs.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

input group             "------------------------------ Trend - T3 ---------------------------"
input bool              InpT3ObjectsShow = true;
input ENUM_TIMEFRAMES   InpT3MaxTimeframe = PERIOD_H1;
input color             InpT3RegressionChannelColor = clrSnow;
input string            InpT3FiboLevels = "10, 20, 30, 40, 50, 60, 70, 80, 90, 110";
input color             InpT3FiboLevelsColor = clrTomato;
input color             InpT3TrendLineColor = clrTomato;
input color             InpT3MinMaxRegressionColor = clrBlue;
input int               InpT3ChannelEndShift = 10;

input group             "------------------------------ Alert - T3 ---------------------------"
input bool              InpT3AlertOn = true;
input int               InpT3AlertOnRegressionChannelLevel = 60;
input int               InpT3AlertOnFiboRetracmentLevel = 40;

input group             "------------------------------ INSignal - T3 ---------------------------"
input int               InpT3MinRegressionChannelLevel = 70;
input int               InpT3MaxRegressionChannelLevel = 110;
input int               InpT3MinFiboRetracmentLevel = 50;
input int               InpT3MaxFiboRetracmentLevel = 80;
input color             InpT3InSignalAreaColor = clrPaleGreen;

input group             "------------------------------ ReEntry - T3 ---------------------------"
input int               InpT3MinReEntryRegressionChannelLevel = 20;
input int               InpT3MinReEntryFiboRetracmentLevel = 20;
input color             InpT3ReEntryMinRegressionColor = clrDarkKhaki;
input color             InpT3ReEntryAreaColor = clrBeige;

input group             "---------- SL & TP ---------"
input int               InpStopLoss = 200; // StopLoss
input color             InpStopLossLineColor = clrRed;
input int               InpTakeProfit = 90; // TakeProfit

input group             "---------- MoneyManagement ---------"
input bool              InpUseMoneyManagement = true; // Use Money Management
input double            InpLotsPerEquity = 0; // Lots per 1000 Equity
input double            InpFixedVolume = 0; // Fixe Lotgröße
input double            InpMaxPositionRiskPercent = 1; // max Position Risk %

input group             "---------- Break Even ---------"
input bool              InpUseBreakEven = true;
input int               InpBreakEvenProfit = 50;
input int               InpLockProfit = 10;

input group             "---------- InsideBar ---------"
input color             InpInsideBarLineColor = clrBlue;
input ENUM_TIMEFRAMES   InpInsideBarTimeframe = PERIOD_CURRENT;
input double            InpInsideBarMinRange = 200;
input double            InpInsideBarMaxStopLossMulti = 0.5;


input group             "---------- Trailing ---------"
input bool              InpUseTrailing = true;
input color             InpT3TailingStopLineColor = clrRed;


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
input group             "---------- Basics (Fix) ---------"
input long              InpMagicNumber = 1619769100; // MagicNumber (TODO: Logik bauen: SymbolPaar, Strategy, Version)
input string            InpComment = "MarktTechnik EA"; // Comment
input long              InpMaxSlippage = 3; // max Slippage (TODO: Funktionlität klären)
input int               InpMaxSpread = 10; // max Spread

input group             "---------- StrategyTester ---------" // (Objects in Strategy Tester nicht vorhanden)
input datetime          InpT3p1DateTime = D'2022.01.01 00:00';
input datetime          InpT3p2DateTime = D'2022.01.01 00:00';
input datetime          InpT3p3DateTime = D'2022.01.01 00:00';
input datetime          InpT3p4DateTime = D'2022.01.01 00:00';