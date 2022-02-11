//+------------------------------------------------------------------+
//|                                              OpenSellActions.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
void openSellOrderAction() {

   Trade.FillType(SYMBOL_FILLING_FOK);
   Trade.Sell(Symbol(), getSellVolume(), getSellStopLoss(), getSellTakeProfit(), InpComment);

   cleanPositionTicketsArrayAction(positionTickets, InpMagicNumber);
   sellPositionIsOpen = true;
   useReEntryArea = true;
}

double getSellTakeProfit() {

   double takeProfit = 0;

   // Varainten in Settings setzen:
   // Fix: in Punkten (InpTakeProfit) // von Points in Level umrechnen:
//    takeProfit = BuyTakeProfit(Symbol(), takeProfit, Ask());

   // auf den p4High
   //takeProfit = p4Low;

   //Print("takeProfit: " + takeProfit);

   if(takeProfit > 0) AdjustBelowStopLevel(Symbol(), takeProfit);

   return takeProfit;
}

double getSellStopLoss() {

   double stopLoss = 0;

   stopLoss = SellStopLoss(Symbol(), InpStopLoss, Bid());

   // Varainten in Settings setzen:
   // Fix: in Punkten (InpStopLoss) // von Points in Level umrechnen:

   if(stopLoss > 0) AdjustBelowStopLevel(Symbol(), stopLoss);

   createStopLossTrendline(stopLoss);

   return stopLoss;
}

double getSellVolume() {

   // TODO: Varianten laut Settings bauen
   //  Fix:
   // Risk % Balance
   // getTradeSize(InpUseMoneyManagement, InpLotsPerEquity, InpFixedVolume);

   double volume = 0;
   double maxPositionRiskValue = 0;
   double positionPipRisk = 0;

   // % Risk per Balance
   maxPositionRiskValue = AccountInfoDouble(ACCOUNT_BALANCE) * InpMaxPositionRiskPercent / 100;
   positionPipRisk = InpStopLoss * getPointValueBySymbol(Symbol());
   volume = VerifyVolume(Symbol(), maxPositionRiskValue / positionPipRisk);

   return volume;
}
//+------------------------------------------------------------------+
