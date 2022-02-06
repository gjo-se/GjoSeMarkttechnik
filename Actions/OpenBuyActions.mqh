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

   double volume = 0;
   double maxPositionRiskValue = 0;
   double positionPipRisk = 0;

   // TODO: Variante einbauen
   // getTradeSize(InpUseMoneyManagement, InpLotsPerEquity, InpFixedVolume);

   maxPositionRiskValue = AccountInfoDouble(ACCOUNT_BALANCE) * InpMaxPositionRiskPercent / 100;
   positionPipRisk = InpStopLoss / 10 * getPipValueBySymbol(Symbol());

   // TODO: Nachkommastellen je Symboleigenschaften anpassen
   volume = NormalizeDouble(maxPositionRiskValue / positionPipRisk, 0);

//   Print("SymbolInfoDouble(SYMBOL_VOLUME_STEP);: " + SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_STEP));

   // Symbole haben unterschiedliche Anforderungen ans Limit
   // - SYMBOL_VOLUME_MIN - Minimale Volumen für Dealsabschluss
   // - SYMBOL_VOLUME_MAX - Maximales Volumen für Dealsabschluss
   // - SYMBOL_VOLUME_STEP - Minimaler Schritt der Volumenveränderung für Dealsabschluss
   // - SYMBOL_VOLUME_LIMIT - Die maximale zulässige gesamte Volumen von einer offenen Position und schwebende Ordern in einer Richtung (Kauf oder Verkauf) für das Symbol. Zum Beispiel mit der Begrenzung von 5 Lots, können Sie eine offene Kaufposition mit dem Volumen von 5 Lots haben und eine schwebende Order Sell Limit mit dem Volumen von 5 Lots stellen. Aber in diesem Fall können Sie nicht Buy Limit (seit dem Gesamtvolumen in eine Richtung wird die Begrenzung überschreiten) oder Sell Limit mit dem Volumen von mehr als 5 Lots stellen.



   return volume;
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

   //TODO: Werte für Idezes hinterlegen
   // SYMBOL_CURRENCY_BASE
   // AUD
   // AUD200
   // CAD
   // CA60
   // HKD
   // CHINAH
   // NOK
   // NOR25
   // ZAR
   // SA40
   // SEK
   // SE30
   // CHF
   // SWI20

   // EUR
   // TecDE30
   if(pPositionSymbol == "DE40") pipValue =  0.10;
   // ES35
   // NETH25

   // GBP
   // UK100
   // JPY
   // JP225
   // USD
   // CHINA50
   // US2000
   // US30
   // USTEC

   return pipValue;

}
//+------------------------------------------------------------------+
