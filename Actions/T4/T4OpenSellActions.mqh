//+------------------------------------------------------------------+
//|                                              OpenSellActions.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
void openT4SellOrderAction() {

   Trade.MagicNumber(InpT4MagicNumber);
   Trade.FillType(SYMBOL_FILLING_FOK);
   Trade.Sell(Symbol(), VerifyVolume(Symbol(), getT4SellVolume()), t4StopLossValue, getT4SellTakeProfit(), InpT4Comment);
}

double getT4SellTakeProfit() {

   double takeProfit = 0;

   if(takeProfit > 0) AdjustBelowStopLevel(Symbol(), takeProfit);

   return takeProfit;
}

double getT4SellVolume() {

   double maxPositionRiskValue = 0;
   double positionPointRisk = 0;

   if(t4ShortEntryValue != 0 && t4StopLossValue != 0) {
      maxPositionRiskValue = AccountInfoDouble(ACCOUNT_BALANCE) * InpMaxPositionRiskPercent / 100 / InpT4OrderGridCount;
      positionPointRisk = (t4StopLossValue - t4ShortEntryValue) / Point() * getPointValueBySymbol(Symbol());
      t4LotSize = maxPositionRiskValue / positionPointRisk;
   } else {
      t4LotSize = 0;
   }

   return t4LotSize;
}
//+------------------------------------------------------------------+
