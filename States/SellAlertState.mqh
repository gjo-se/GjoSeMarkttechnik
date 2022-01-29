/*

   SellAlertState
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

   Beschreibung
   ===============

*/

bool getSellAlertRegressionSignal() {

   bool signal = false;

   if(getSellRegressionIsGreaterAlertOnRegressionChannelSignal()) signal = true;
   if(getT3TrendIsNotShortFilter() == true) signal = false;

   //if(signal) Print("getSellAlertRegressionSignal: " + signal);


   return(signal);

}

bool getSellRegressionIsGreaterAlertOnRegressionChannelSignal() {

   bool     signal = false;

   if(Bid() > alertRegressionChannelLevel || Bid() > alertFiboRetracementLevel) {
      signal = true;
   } else {
      isSellRegressionAlertSendable = true;
   }

   return signal;
}

bool getT3TrendIsNotShortFilter() {

   bool filter = false;

   if(t3trendDirection != TREND_DIRECTION_SHORT) filter = true;

   return (filter);
}
//+------------------------------------------------------------------+
