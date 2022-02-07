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
      positionPipRisk = InpStopLoss / 10 * getPipValueBySymbol(Symbol());
      volume = maxPositionRiskValue / positionPipRisk;

      return VerifyVolume(Symbol(), volume);
}

double getPipValueBySymbol(string pPositionSymbol) {

   double pipValue = 0;
   string symbolAgainst = StringSubstr(pPositionSymbol, 3, 3);

   if(symbolAgainst == "AUD") pipValue =  10 / SymbolInfoDouble("EURAUD", SYMBOL_BID);
   if(symbolAgainst == "CAD") pipValue =  10 / SymbolInfoDouble("EURCAD", SYMBOL_BID);
   if(symbolAgainst == "CHF") pipValue =  10 / SymbolInfoDouble("EURCHF", SYMBOL_BID);
   if(symbolAgainst == "GBP") pipValue =  10 / SymbolInfoDouble("EURGBP", SYMBOL_BID);
   if(symbolAgainst == "JPY") pipValue =  1000 / SymbolInfoDouble("EURJPY", SYMBOL_BID);
   if(symbolAgainst == "NZD") pipValue =  10 / SymbolInfoDouble("EURNZD", SYMBOL_BID);
   if(symbolAgainst == "USD") pipValue =  10 / SymbolInfoDouble("EURUSD", SYMBOL_BID);

   //TODO: Werte für Indezes hinterlegen
   // AUD
   if(pPositionSymbol == "AUD200") pipValue =  0.10 / SymbolInfoDouble("EURAUD", SYMBOL_BID);
   // CAD
   if(pPositionSymbol == "CA60") pipValue =  0.10 / SymbolInfoDouble("EURCAD", SYMBOL_BID);
   // CHF
   if(pPositionSymbol == "SWI20") pipValue =  0.10 / SymbolInfoDouble("EURCHF", SYMBOL_BID);
   // EUR
   if(pPositionSymbol == "DE40") pipValue =  0.10;
   if(pPositionSymbol == "ES35") pipValue =  0.10;
   if(pPositionSymbol == "NETH25") pipValue =  0.10;
   if(pPositionSymbol == "TecDE30") pipValue =  0.10;
   // GBP
   if(pPositionSymbol == "UK100") pipValue =  0.10 / SymbolInfoDouble("EURGBP", SYMBOL_BID);
   // HKD
   if(pPositionSymbol == "CHINAH") pipValue =  0.10 / SymbolInfoDouble("EURHKD", SYMBOL_BID);
   // JPY
   if(pPositionSymbol == "JP225") pipValue =  0.10 / SymbolInfoDouble("EURJPY", SYMBOL_BID);
   // NOK
   if(pPositionSymbol == "NOR25") pipValue =  0.10 / SymbolInfoDouble("EURNOK", SYMBOL_BID);
   // USD
   if(pPositionSymbol == "CHINA50") pipValue =  0.10 / SymbolInfoDouble("EURUSD", SYMBOL_BID);
   if(pPositionSymbol == "US2000") pipValue =  0.10 / SymbolInfoDouble("EURUSD", SYMBOL_BID);
   if(pPositionSymbol == "US30") pipValue =  0.10 / SymbolInfoDouble("EURUSD", SYMBOL_BID);
   if(pPositionSymbol == "USTEC") pipValue =  0.10 / SymbolInfoDouble("EURUSD", SYMBOL_BID);
   // SEK
   if(pPositionSymbol == "SE30") pipValue =  0.10 / SymbolInfoDouble("EURSEK", SYMBOL_BID);
   // ZAR
   if(pPositionSymbol == "SA40") pipValue =  0.10 / SymbolInfoDouble("EURZAR", SYMBOL_BID);

   return pipValue;

}
//+------------------------------------------------------------------+
