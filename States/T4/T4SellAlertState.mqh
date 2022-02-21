/*

   SellAlertState
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

   Beschreibung
   ===============

*/

bool getT4SellAlertRegressionSignal() {

   bool signal = false;

   if(getT4SellRegressionIsGreaterAlertOnRegressionChannelSignal()) signal = true;
   if(getT4TrendIsNotShortFilter() == true) signal = false;

   //if(signal) Print("getT4SellAlertRegressionSignal: " + signal);


   return(signal);

}

bool getT4SellRegressionIsGreaterAlertOnRegressionChannelSignal() {

   bool     signal = false;

   if(Bid() > t4AlertRegressionChannelLevel || Bid() > t4AlertFiboRetracementLevel) {
      signal = true;
   } else {
      t4IsSellRegressionAlertSendable = true;
   }

   return signal;
}

bool getT4TrendIsNotShortFilter() {

   bool filter = false;

   if(t4trendDirection != TREND_DIRECTION_SHORT) filter = true;

   return (filter);
}
//+------------------------------------------------------------------+
