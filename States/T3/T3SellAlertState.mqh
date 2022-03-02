/*

   SellAlertState
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

   Beschreibung
   ===============

*/

bool getT3SellAlertRegressionSignal() {

   bool signal = false;

   if(getT3SellRegressionIsGreaterAlertOnRegressionChannelSignal()) signal = true;
   if(getT3TrendIsNotShortFilter() == true) signal = false;

   return(signal);

}

bool getT3SellRegressionIsGreaterAlertOnRegressionChannelSignal() {

   bool     signal = false;

   if(Bid() > t3AlertRegressionChannelLevel || Bid() > t3AlertFiboRetracementLevel) {
      signal = true;
   } else {
      t3IsSellRegressionAlertSendable = true;
   }

   return signal;
}

bool getT3TrendIsNotShortFilter() {

   bool filter = false;

   if(t3trendDirection != TREND_DIRECTION_SHORT) filter = true;

   return (filter);
}
//+------------------------------------------------------------------+
