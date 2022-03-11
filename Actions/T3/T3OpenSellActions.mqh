//+------------------------------------------------------------------+
//|                                              OpenSellActions.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
void openT3SellOrderAction() {

   Trade.MagicNumber(InpT3MagicNumber);
   Trade.FillType(SYMBOL_FILLING_FOK);
   Trade.Sell(Symbol(), VerifyVolume(Symbol(), getT3SellVolume()), getT3SellStopLoss(), getT3SellTakeProfit(), InpT3Comment);

   t3UseReEntryArea = true;
}

double getT3SellTakeProfit() {

   double takeProfit = 0;

   if(takeProfit > 0) AdjustBelowStopLevel(Symbol(), takeProfit);

   return takeProfit;
}

double getT3SellStopLoss() {

// Varainten in Settings setzen:
// Fix: in Punkten (InpT3StopLoss) // von Points in Level umrechnen:
   double gridSize = InpT3MinHighVolumeAreaLevel / Point() - InpT3MaxHighVolumeAreaLevel / Point();
   double stopLossLineValue = InpT3MinHighVolumeAreaLevel + gridSize * InpT3StopLossLineOffsetMulti * Point() ;
   double stopLossMarketValue = InpT3MinHighVolumeAreaLevel + gridSize * InpT3StopLossMarketOffsetMulti * Point() ;

   if(stopLossLineValue > 0) AdjustBelowStopLevel(Symbol(), stopLossLineValue);
   if(stopLossMarketValue > 0) AdjustBelowStopLevel(Symbol(), stopLossMarketValue);

   createT3StopLossTrendline(stopLossLineValue);

   return stopLossMarketValue;
}

double getT3SellVolume(double pLevel = 0) {

// TODO: Varianten laut Settings bauen
//  Fix:
// Risk % Balance
// getTradeSize(InpUseMoneyManagement, InpLotsPerEquity, InpFixedVolume);

   double volume = 0;
   double maxPositionRiskValue = 0;
   double positionPointRisk = 0;

   if(pLevel == 0) pLevel = Bid();

// % Risk per Balance
   maxPositionRiskValue = AccountInfoDouble(ACCOUNT_BALANCE) * InpMaxPositionRiskPercent / 100 / InpT3OrderGridCount;
   double gridSize = InpT3MinHighVolumeAreaLevel / Point() - InpT3MaxHighVolumeAreaLevel / Point();
   double stopLossLineValue = InpT3MinHighVolumeAreaLevel + gridSize * InpT3StopLossLineOffsetMulti * Point() ;
   positionPointRisk = (stopLossLineValue - pLevel) / Point() * getPointValueBySymbol(Symbol());
   volume = maxPositionRiskValue / positionPointRisk;

   return volume;
}
//+------------------------------------------------------------------+
