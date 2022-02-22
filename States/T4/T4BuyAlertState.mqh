/*

   BuyAlertState
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

   Beschreibung
   ===============

*/

bool getT4BuyAlertRegressionSignal() {

   bool signal = false;

   if(getT4BuyRegressionIsGreaterAlertOnRegressionChannelSignal()) signal = true;
   if(getT4TrendIsNotLongFilter() == true) signal = false;

   return(signal);

}

bool getT4BuyRegressionIsGreaterAlertOnRegressionChannelSignal() {

   bool     signal = false;

   if(Bid() < t4AlertRegressionChannelLevel || Bid() < t4AlertFiboRetracementLevel){
        signal = true;
   } else{
        t4IsBuyRegressionAlertSendable = true;
   }

    return signal;
}

bool getT4TrendIsNotLongFilter() {

   bool filter = false;

   if(t4trendDirection != TREND_DIRECTION_LONG) filter = true;

   return (filter);
}

