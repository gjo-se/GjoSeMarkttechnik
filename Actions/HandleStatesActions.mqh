//+------------------------------------------------------------------+
//|                                             InitializeAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void handleStatesAction() {
   setAction();
   resetAction();
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void setAction() {
   if(maxBuyPositionsAreOpenState == true) {
      ArrayResize(orderGridStopOrderValuesArray, 0);
      t3LongIsTradable = false;
   }

   if(maxSellPositionsAreOpenState == true) {
      ArrayResize(orderGridStopOrderValuesArray, 0);
      t3ShortIsTradable = false;
   }
}

void resetAction() {

   if(allBuyPositionsAreClosedState) {
      maxBuyPositionsAreOpenState = false;
   }

   if(allSellPositionsAreClosedState) {
      maxSellPositionsAreOpenState = false;
   }
}

//+------------------------------------------------------------------+
