//+------------------------------------------------------------------+
//|                                             InitializeAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

void handleStatesAction() {
   setAction();
   resetAction();
}

void setAction() {
    if(getFirstBuyPositionIsOpened()) t3LongEntryIsTriggert = true;
    if(getFirstSellPositionIsOpened()) t3ShortEntryIsTriggert = true;
}

void resetAction() {
    if(allBuyPositionsAreClosedState) t3LongEntryIsTriggert = false;
    if(allSellPositionsAreClosedState) t3ShortEntryIsTriggert = false;
}

