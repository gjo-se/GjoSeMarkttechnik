//+------------------------------------------------------------------+
//|                                               OpenBuyActions.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
void openBuyOrderAction() {

   Trade.FillType(SYMBOL_FILLING_FOK);
   Trade.Buy(Symbol(), getBuyVolume(), getBuyStopLoss(), getBuyTakeProfit(), InpComment);

   cleanPositionTicketsArrayAction(positionTickets, InpMagicNumber);
   buyPositionIsOpen = true;
   useReEntryArea = true;

}

double getBuyTakeProfit() {

   double takeProfit = 0;

   if(takeProfit > 0) AdjustAboveStopLevel(Symbol(), takeProfit);

   return takeProfit;
}

double getBuyStopLoss() {

   double stopLoss = 0;

   stopLoss = BuyStopLoss(Symbol(), InpStopLoss, Ask());

   // Varainten in Settings setzen:
   // Fix: in Punkten (InpStopLoss) // von Points in Level umrechnen:

   if(stopLoss > 0) AdjustAboveStopLevel(Symbol(), stopLoss);

   createStopLossTrendline(stopLoss);

   return stopLoss;
}

double getBuyVolume() {

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
// TODO: auslagern, für buy & Sell
double getPointValueBySymbol(string pPositionSymbol) {
   return SymbolInfoDouble(Symbol(), SYMBOL_TRADE_TICK_VALUE) / SymbolInfoDouble(Symbol(), SYMBOL_TRADE_TICK_SIZE) * Point();
}
//+------------------------------------------------------------------+
