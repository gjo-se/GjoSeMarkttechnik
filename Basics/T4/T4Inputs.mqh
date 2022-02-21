//+------------------------------------------------------------------+
//|                                                       Inputs.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

input group             "------------------------------ PRIO A je Symbol ---------------------------"
input int               InpT4StopLoss = 200; // StopLoss
input int               InpT4AlertOnBidStopLossLineOffset = 0;

input group             "------------------------------ Order Grid ---------------------------"
input int               InpT4OrderGridCount = 5; // Anzahl Grid Orders

input group             "------------------------------ T4 + T4 RegressionChannel ----------------"
input int               InpT4AlertOnRegressionChannelLevel = 0;
input int               InpT4MinRegressionChannelLevel = 70;
input int               InpT4MaxRegressionChannelLevel = 110;
input int               InpT4ChannelEndShift = 10;

input group             "---------------------- FiboRetracement - T4 ---------------------------"
input int               InpT4AlertOnFiboRetracmentLevel = 0;
input int               InpT4MinFiboRetracmentLevel = 0;
input int               InpT4MaxFiboRetracmentLevel = 0;

input group             "---------------------- T4 - ReEntry ---------------------------"
input int               InpT4MinReEntryRegressionChannelLevel = 0;
input int               InpT4MinReEntryFiboRetracmentLevel = 0;
input color             InpT4ReEntryMinRegressionColor = clrDarkKhaki;
input color             InpT4ReEntryAreaColor = clrBeige;

input group             "------------------------------ T4 Show Objects ---------------------------"
input bool              InpT4ObjectsShow = true;
input ENUM_TIMEFRAMES   InpT4MaxTimeframe = PERIOD_H1;
input string            InpT4FiboLevels = "10, 20, 30, 40, 50, 60, 70, 80, 90, 110";

input group             "------------------------------ T4 Regression TS ---------------------------"
input bool              InpT4RegressionChannelShow = false;
input ENUM_TIMEFRAMES   InpT4RegressionChannelTimeframe = PERIOD_M10;
input int               InpT4RegressionChannelEndShift = 20;
input int               InpT4StopLossOnRegressionChannelLevel = 120;
input double            InpT4TrendOKOnMulti = 1.5;

input group             "------------------------ T4 Colors -----------------------------"
input color             InpT4RegressionChannelColor = clrSilver;
input color             InpT4InSignalAreaColor = clrDarkGray;
input color             InpT4TrendLineColor = clrBlack;

input group             "---------- SL & TP ---------"
input int               InpT4TakeProfit = 0; // TakeProfit
input bool              InpT4SetIsTradabelButtonStateAfterClose = false; // nach Close Button OFF

input group             "---------- Trailing ---------"
input color             InpT4TailingStopLineColor = clrRed;


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
input group             "---------- Basics (Fix) ---------"
input string            InpT4Comment = "MarktTechnik EA"; // Comment

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
input group             "---------- StrategyTester ---------" // (Objects in Strategy Tester nicht vorhanden)
input datetime          InpT4p1DateTime = D'2022.01.01 00:00';
input datetime          InpT4p2DateTime = D'2022.01.01 00:00';
input datetime          InpT4p3DateTime = D'2022.01.01 00:00';
input datetime          InpT4p4DateTime = D'2022.01.01 00:00';
//+------------------------------------------------------------------+
