//+------------------------------------------------------------------+
//|                                               OpenBuyActions.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
void openT3BuyOrderAction() {

   Trade.FillType(SYMBOL_FILLING_FOK);
   Trade.Buy(Symbol(), VerifyVolume(Symbol(), getT3BuyVolume()), getT3BuyStopLoss(), getT3BuyTakeProfit(), InpT3Comment);

   cleanPositionTicketsArrayAction(positionTickets, InpMagicNumber);
   t3UseReEntryArea = true;
}

double getT3BuyTakeProfit() {

   double takeProfit = 0;

   if(takeProfit > 0) AdjustAboveStopLevel(Symbol(), takeProfit);

   return takeProfit;
}

double getT3BuyStopLoss() {

   // Varainten in Settings setzen:
   // Fix: in Punkten (InpT3StopLoss) // von Points in Level umrechnen:

   double stopLoss = t3LowestLowValue;

   if(stopLoss > 0) AdjustAboveStopLevel(Symbol(), stopLoss);

   createT3StopLossTrendline(stopLoss);

   return stopLoss;
}

double getT3BuyVolume(double pLevel = 0) {

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
   positionPointRisk = (pLevel - t3LowestLowValue) / Point() * getPointValueBySymbol(Symbol());
   volume = maxPositionRiskValue / positionPointRisk;

   return volume;
}

// TODO: auslagern, für buy & Sell
double getPointValueBySymbol(string pPositionSymbol) {
   return SymbolInfoDouble(Symbol(), SYMBOL_TRADE_TICK_VALUE) / SymbolInfoDouble(Symbol(), SYMBOL_TRADE_TICK_SIZE) * Point();
}