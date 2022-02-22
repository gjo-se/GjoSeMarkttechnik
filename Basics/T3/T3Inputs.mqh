//+------------------------------------------------------------------+
//|                                                     T3Inputs.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

input group             "------------------------------ T3 PRIO A ---------------------------"
input int               InpT3MinRegressionChannelLevel = 0; // T3 Min RegressionChannel
input int               InpT3MaxRegressionChannelLevel = 0; // T3 Max RegressionChannel
input int               InpT3MinFiboRetracmentLevel = 0; // T3 Min FiboRetracment
input int               InpT3MaxFiboRetracmentLevel = 0; // T3 Max FiboRetracment
input int               InpT3StopLoss = 0; // StopLoss

input group             "------------------------------ T3 Alerts ---------------------------"
input int               InpT3AlertOnRegressionChannelLevel = 0;
input int               InpT3AlertOnFiboRetracmentLevel = 0;
input int               InpT3AlertOnBidStopLossLineOffset = 0;

input group             "------------------------------ T3 PRIO B ---------------------------"
input int               InpT3ChannelEndShift = 10; // T3 Anzahl Candles Offset RegressionChannel
input double            InpMaxPositionRiskPercent = 1; // T3 & T4 max Position Risk %
input int               InpT3OrderGridCount = 5; // T3 Anzahl Grid Orders
input bool              InpT3SetIsTradabelButtonStateAfterClose = false; // nach Close Button OFF

input group             "------------------------------ T3 PRIO C ---------------------------"
input long              InpMagicNumber = 1619769100; // T3 & T4 MagicNumber
input string            InpT3Comment = "T3 MarktTechnik"; // T3 Comment
input long              InpMaxSlippage = 3; // T3 & T4 max Slippage
input bool              InpT3ShowCommentDashboard = true;
input bool              InpT3ObjectsShow = true;
input ENUM_TIMEFRAMES   InpT3MaxTimeframe = PERIOD_H1;
input string            InpT3FiboLevels = "10, 20, 30, 40, 50, 60, 70, 80, 90, 110";
input color             InpT3RegressionChannelColor = clrBeige;
input color             InpT3InSignalAreaColor = clrWheat;
input color             InpT3TrendLineColor = clrDarkKhaki;

input group             "------------------------------ T3 PRIO D - nicht in Gebrauch ---------------------------"
input group             "---------- SL & TP ---------"
input int               InpT3TakeProfit = 0; // T3 TakeProfit
input group             "---------------------- T3 - ReEntry ---------------------------"
input int               InpT3MinReEntryRegressionChannelLevel = 0;
input int               InpT3MinReEntryFiboRetracmentLevel = 0;
input color             InpT3ReEntryMinRegressionColor = clrDarkKhaki;
input color             InpT3ReEntryAreaColor = clrBeige;
input group             "---------- MoneyManagement ---------"
input bool              InpUseMoneyManagement = true; // T3 & T4 Use Money Management
input double            InpLotsPerEquity = 0; // T3 & T4 Lots per 1000 Equity
input double            InpFixedVolume = 0; // T3 & T4 Fixe Lotgröße
input int               InpMaxSpread = 10; // T3 & T4 max Spread
input group             "---------- Break Even ---------"
input bool              InpUseBreakEven = false;
input int               InpBreakEvenProfit = 0;
input int               InpLockProfit = 0;
input group             "---------- InsideBar ---------"
input double            InpInsideBarMinRange = 200;
input ENUM_TIMEFRAMES   InpInsideBarTimeframe = PERIOD_CURRENT;
input color             InpInsideBarLineColor = clrBlue;
input double            InpInsideBarMaxStopLossMulti = 0.5;
input group             "---------- Trailing ---------"
input bool              InpUseTrailing = false;
input color             InpT3TailingStopLineColor = clrRed;
input group             "---------- StrategyTester ---------" // (Objects in Strategy Tester nicht vorhanden)
input datetime          InpT3p1DateTime = D'2022.01.01 00:00';
input datetime          InpT3p2DateTime = D'2022.01.01 00:00';
input datetime          InpT3p3DateTime = D'2022.01.01 00:00';
input datetime          InpT3p4DateTime = D'2022.01.01 00:00';