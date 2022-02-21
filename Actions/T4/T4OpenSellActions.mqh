//+------------------------------------------------------------------+
//|                                              OpenSellActions.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
void openT4SellOrderAction() {

   Trade.FillType(SYMBOL_FILLING_FOK);
   Trade.Sell(Symbol(), VerifyVolume(Symbol(), getT4SellVolume()), getT4SellStopLoss(), getT4SellTakeProfit(), InpT4Comment);

   cleanPositionTicketsArrayAction(positionTickets, InpMagicNumber);
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

   double stopLoss = t4HighestHighValue;

   if(stopLoss > 0) AdjustBelowStopLevel(Symbol(), stopLoss);

   createT4StopLossTrendline(stopLoss);

   return stopLoss;
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
   positionPointRisk = (t4HighestHighValue - pLevel) / Point() * getPointValueBySymbol(Symbol());
   volume = maxPositionRiskValue / positionPointRisk;

   return volume;
}
//+------------------------------------------------------------------+
