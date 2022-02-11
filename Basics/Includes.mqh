//+------------------------------------------------------------------+
//|                                                     Includes.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Includes                                                         |
//+------------------------------------------------------------------+
#include "Inputs.mqh"
#include "Const.mqh"

#include <Mql5Book\TradeHedge.mqh>
#include <Mql5Book\Pending.mqh>
#include <Mql5Book\Price.mqh>
#include <Mql5Book\MoneyManagement.mqh>
#include <Mql5Book\TrailingStops.mqh>
#include <Mql5Book\Timer.mqh>

#include "Global.mqh"
#include "..\\Actions\\AlertActions.mqh"
#include "..\\Actions\\CloseActions.mqh"
#include "..\\Actions\\HandleObjectAction.mqh"
#include "..\\Actions\\InitializeActions.mqh"
#include "..\\Actions\\OpenBuyActions.mqh"
#include "..\\Actions\\OpenSellActions.mqh"
#include "..\\Actions\\TrailingActions.mqh"
#include "..\\Actions\\ScreenshotActions.mqh"

#include "..\\States\\BuyAlertState.mqh"
#include "..\\States\\BuyInState.mqh"
#include "..\\States\\SellAlertState.mqh"
#include "..\\States\\SellInState.mqh"

#include <GjoSe\\Utilities\\InclBasicUtilities.mqh>
#include <GjoSe\\Objects\\InclHLine.mqh>
#include <GjoSe\\Objects\\InclVLine.mqh>
#include <GjoSe\\Objects\\InclTrendLine.mqh>
#include <GjoSe\\Objects\\InclRegressionChannel.mqh>
#include <GjoSe\\Objects\\InclChannel.mqh>
#include <GjoSe\\Objects\\InclButton.mqh>

#include "..\\Objects\\RegressionChannel.mqh"
#include "..\\Objects\\FiboRetracement.mqh"
#include "..\\Objects\\VLines.mqh"
#include "..\\Objects\\TrendLines.mqh"
#include "..\\Objects\\Channel.mqh"
#include "..\\Objects\\Button.mqh"


//+------------------------------------------------------------------+
