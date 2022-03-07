//+------------------------------------------------------------------+
//|                                               OpenBuyActions.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
void openT4BuyOrderAction() {

   Trade.MagicNumber(InpT4MagicNumber);
   Trade.FillType(SYMBOL_FILLING_FOK);
   Trade.Buy(Symbol(), VerifyVolume(Symbol(), getT4BuyVolume()), getT4BuyStopLoss(), getT4BuyTakeProfit(), InpT4Comment);

   t4UseReEntryArea = true;
}

double getT4BuyTakeProfit() {

   double takeProfit = 0;

   if(takeProfit > 0) AdjustAboveStopLevel(Symbol(), takeProfit);

   return takeProfit;
}

double getT4BuyStopLoss() {

// Varainten in Settings setzen:
// Fix: in Punkten (InpT4StopLoss) // von Points in Level umrechnen:

   double minRegressionPoints = (getT4P4HighLowValueByTrendDirection() / Point() - t4LowestLowValue / Point()) * InpT4MinRegressionPercent / 100;
   double stopLossLineValue = t4LongEntryValue - minRegressionPoints * InpT4StopLossLineOffsetMulti * Point() ;
   double stopLossMarketValue = t4LongEntryValue - minRegressionPoints * InpT4StopLossMarketOffsetMulti * Point() ;

   if(stopLossLineValue > 0) AdjustBelowStopLevel(Symbol(), stopLossLineValue);
   if(stopLossMarketValue > 0) AdjustBelowStopLevel(Symbol(), stopLossMarketValue);

   createT4StopLossTrendline(stopLossLineValue);

   return stopLossMarketValue;
}

double getT4BuyVolume(double pLevel = 0) {

// TODO: Varianten laut Settings bauen
//  Fix:
// Risk % Balance
// getTradeSize(InpUseMoneyManagement, InpLotsPerEquity, InpFixedVolume);

   double volume = 0;
   double maxPositionRiskValue = 0;
   double positionPointRisk = 0;

   if(pLevel == 0) pLevel = Bid();

// % Risk per Balance
   maxPositionRiskValue = AccountInfoDouble(ACCOUNT_BALANCE) * InpMaxPositionRiskPercent / 100 / InpT4OrderGridCount;
   double minRegressionPoints = (getT4P4HighLowValueByTrendDirection() / Point() - t4LowestLowValue / Point()) * InpT4MinRegressionPercent / 100;
   double stopLossLineValue = t4LongEntryValue - minRegressionPoints * InpT4StopLossLineOffsetMulti * Point() ;
   positionPointRisk = (pLevel - stopLossLineValue) / Point() * getPointValueBySymbol(Symbol());
   volume = maxPositionRiskValue / positionPointRisk;

   return volume;
}


//+------------------------------------------------------------------+
