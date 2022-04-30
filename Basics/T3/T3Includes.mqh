//+------------------------------------------------------------------+
//|                                                     Includes.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Includes                                                         |
//+------------------------------------------------------------------+
#include "T3Inputs.mqh"
#include "T3Const.mqh"

#include <Mql5Book\TradeHedge.mqh>
#include <Mql5Book\Pending.mqh>
#include <Mql5Book\Price.mqh>
#include <Mql5Book\MoneyManagement.mqh>
#include <Mql5Book\TrailingStops.mqh>
#include <Mql5Book\Timer.mqh>

#include "T3Global.mqh"
#include "..\\..\\Actions\\T3\\T3AlertActions.mqh"
#include "..\\..\\Actions\\T3\\T3HandleIndicators.mqh"
#include "..\\..\\Actions\\T3\\T3HandleObjectAction.mqh"
#include "..\\..\\Actions\\T3\\T3HandleTrendDetectionActions.mqh"
#include "..\\..\\Actions\\T3\\T3InitializeActions.mqh"
#include "..\\..\\Actions\\T3\\T3ScreenshotActions.mqh"

#include "..\\..\\States\\T3\\T3BuyAlertState.mqh"
#include "..\\..\\States\\T3\\T3SellAlertState.mqh"

#include <GjoSe\\Utilities\\InclBasicUtilities.mqh>
#include <GjoSe\\Objects\\InclHLine.mqh>
#include <GjoSe\\Objects\\InclVLine.mqh>
#include <GjoSe\\Objects\\InclTrendLine.mqh>
#include <GjoSe\\Objects\\InclRegressionChannel.mqh>
#include <GjoSe\\Objects\\InclChannel.mqh>
#include <GjoSe\\Objects\\InclButton.mqh>
#include <GjoSe\\Objects\\InclLabel.mqh>

#include "..\\..\\Objects\\T3\\T3RegressionChannel.mqh"
#include "..\\..\\Objects\\T3\\T3FiboRetracement.mqh"
#include "..\\..\\Objects\\T3\\T3VLines.mqh"
#include "..\\..\\Objects\\T3\\T3TrendLines.mqh"
#include "..\\..\\Objects\\T3\\T3Channel.mqh"
#include "..\\..\\Objects\\T3\\T3Button.mqh"
#include "..\\..\\Objects\\T3\\T3Labels.mqh"


//+------------------------------------------------------------------+
