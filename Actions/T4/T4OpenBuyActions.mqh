//+------------------------------------------------------------------+
//|                                               OpenBuyActions.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
void openT4BuyOrderAction() {

   Trade.MagicNumber(InpT4MagicNumber);
   Trade.FillType(SYMBOL_FILLING_FOK);
   Trade.Buy(Symbol(), VerifyVolume(Symbol(), getT4BuyVolume()), t4StopLossValue, getT4BuyTakeProfit(), InpT4Comment);

   t4UseReEntryArea = true;
}

double getT4BuyTakeProfit() {

   double takeProfit = 0;

   if(takeProfit > 0) AdjustAboveStopLevel(Symbol(), takeProfit);

   return takeProfit;
}

double getT4BuyVolume() {

   double maxPositionRiskValue = 0;
   double positionPointRisk = 0;

   if(t4LongEntryValue != 0 && t4StopLossValue != 0) {
      maxPositionRiskValue = AccountInfoDouble(ACCOUNT_BALANCE) * InpMaxPositionRiskPercent / 100 / InpT4OrderGridCount;
      positionPointRisk = (t4LongEntryValue - t4StopLossValue) / Point() * getPointValueBySymbol(Symbol());
      t4LotSize = maxPositionRiskValue / positionPointRisk;
   } else {
      t4LotSize = 0;
   }

   return t4LotSize;
}

// TODO: auslagern, für buy & Sell
double getPointValueBySymbol(string pPositionSymbol) {
   return SymbolInfoDouble(Symbol(), SYMBOL_TRADE_TICK_VALUE) / SymbolInfoDouble(Symbol(), SYMBOL_TRADE_TICK_SIZE) * Point();
}

//+------------------------------------------------------------------+
