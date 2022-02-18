//+------------------------------------------------------------------+
//|                                              OpenSellActions.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
void openSellOrderAction() {

   Trade.FillType(SYMBOL_FILLING_FOK);
   Trade.Sell(Symbol(), VerifyVolume(Symbol(), getSellVolume()), getSellStopLoss(), getSellTakeProfit(), InpComment);

   cleanPositionTicketsArrayAction(positionTickets, InpMagicNumber);
   useReEntryArea = true;

   handleScreenshotAction();

}

double getSellTakeProfit() {

   double takeProfit = 0;

   if(takeProfit > 0) AdjustBelowStopLevel(Symbol(), takeProfit);

   return takeProfit;
}

double getSellStopLoss() {

   // Varainten in Settings setzen:
   // Fix: in Punkten (InpStopLoss) // von Points in Level umrechnen:

   double stopLoss = t3HighestHighValue;

   if(stopLoss > 0) AdjustBelowStopLevel(Symbol(), stopLoss);

   createStopLossTrendline(stopLoss);

   return stopLoss;
}

double getSellVolume(double pLevel = 0) {

   // TODO: Varianten laut Settings bauen
   //  Fix:
   // Risk % Balance
   // getTradeSize(InpUseMoneyManagement, InpLotsPerEquity, InpFixedVolume);

   double volume = 0;
   double maxPositionRiskValue = 0;
   double positionPointRisk = 0;

   if(pLevel == 0) pLevel = Bid();

   // % Risk per Balance
   maxPositionRiskValue = AccountInfoDouble(ACCOUNT_BALANCE) * InpMaxPositionRiskPercent / 100 / InpOrderGridCount;
   positionPointRisk = (t3HighestHighValue - pLevel) / Point() * getPointValueBySymbol(Symbol());
   volume = maxPositionRiskValue / positionPointRisk;

   return volume;
}
//+------------------------------------------------------------------+
