//+------------------------------------------------------------------+
//|                                              OpenSellActions.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
void openT4SellOrderAction() {

   Trade.MagicNumber(InpT4MagicNumber);
   Trade.FillType(SYMBOL_FILLING_FOK);
   Trade.Sell(Symbol(), VerifyVolume(Symbol(), getT4SellVolume()), getT4SellStopLoss(), getT4SellTakeProfit(), InpT4Comment);

   t4UseReEntryArea = true;
}

double getT4SellTakeProfit() {

   double takeProfit = 0;

   if(takeProfit > 0) AdjustBelowStopLevel(Symbol(), takeProfit);

   return takeProfit;
}

double getT4SellStopLoss() {

// Varainten in Settings setzen:
// Fix: in Punkten (InpT4StopLoss) // von Points in Level umrechnen:

   double minRegressionPoints = (t4HighestHighValue / Point() - getT4P4HighLowValueByTrendDirection() / Point()) * InpT4MinRegressionPercent / 100;
   double stopLossLineValue = t4ShortEntryValue + minRegressionPoints * InpT4StopLossLineMulti * Point() ;
   double stopLossMarketValue = t4ShortEntryValue + minRegressionPoints * InpT4StopLossMarketMulti * Point() ;

   if(stopLossLineValue > 0) AdjustBelowStopLevel(Symbol(), stopLossLineValue);
   if(stopLossMarketValue > 0) AdjustBelowStopLevel(Symbol(), stopLossMarketValue);

   createT4StopLossTrendline(stopLossLineValue);

   return stopLossMarketValue;
}

double getT4SellVolume(double pLevel = 0) {

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
   double minRegressionPoints = (t4HighestHighValue / Point() - getT4P4HighLowValueByTrendDirection() / Point()) * InpT4MinRegressionPercent / 100;
   double stopLossLineValue = t4ShortEntryValue + minRegressionPoints * InpT4StopLossLineMulti * Point() ;
   positionPointRisk = (stopLossLineValue - pLevel) / Point() * getPointValueBySymbol(Symbol());
   volume = maxPositionRiskValue / positionPointRisk;

   return volume;
}
//+------------------------------------------------------------------+
