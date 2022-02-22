//+------------------------------------------------------------------+
//|                                              OpenSellActions.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
void openT3SellOrderAction() {

   Trade.FillType(SYMBOL_FILLING_FOK);
   Trade.Sell(Symbol(), VerifyVolume(Symbol(), getT3SellVolume()), getT3SellStopLoss(), getT3SellTakeProfit(), InpT3Comment);

   cleanPositionTicketsArrayAction(positionTickets, InpMagicNumber);
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

   double stopLoss = t3HighestHighValue;

   if(stopLoss > 0) AdjustBelowStopLevel(Symbol(), stopLoss);

   createT3StopLossTrendline(stopLoss);

   return stopLoss;
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
   positionPointRisk = (t3HighestHighValue - pLevel) / Point() * getPointValueBySymbol(Symbol());
   volume = maxPositionRiskValue / positionPointRisk;

   return volume;
}
//+------------------------------------------------------------------+
