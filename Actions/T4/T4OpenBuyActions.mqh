//+------------------------------------------------------------------+
//|                                               OpenBuyActions.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
void openT4BuyOrderAction() {

   Trade.FillType(SYMBOL_FILLING_FOK);
   Trade.Buy(Symbol(), VerifyVolume(Symbol(), getT4BuyVolume()), getT4BuyStopLoss(), getT4BuyTakeProfit(), InpT4Comment);

   cleanPositionTicketsArrayAction(positionTickets, InpMagicNumber);
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

   double stopLoss = t4LowestLowValue;

   if(stopLoss > 0) AdjustAboveStopLevel(Symbol(), stopLoss);

   createT4StopLossTrendline(stopLoss);

   return stopLoss;
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
   positionPointRisk = (pLevel - t4LowestLowValue) / Point() * getPointValueBySymbol(Symbol());
   volume = maxPositionRiskValue / positionPointRisk;

   return volume;
}


//+------------------------------------------------------------------+
