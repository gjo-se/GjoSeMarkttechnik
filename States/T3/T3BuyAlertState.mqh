/*

   BuyAlertState
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

   Beschreibung
   ===============

*/

bool getT3BuyAlertRegressionSignal() {

   bool signal = false;

   if(getT3BuyRegressionIsGreaterAlertOnRegressionChannelSignal()) signal = true;
   if(getT3TrendIsNotLongFilter() == true) signal = false;

   return(signal);

}

bool getT3BuyRegressionIsGreaterAlertOnRegressionChannelSignal() {

   bool     signal = false;

   if(Bid() < t3AlertRegressionChannelLevel || Bid() < t3AlertFiboRetracementLevel){
        signal = true;
   } else{
        t3IsBuyRegressionAlertSendable = true;
   }

    return signal;
}

bool getT3TrendIsNotLongFilter() {

   bool filter = false;

   if(t3trendDirection != TREND_DIRECTION_LONG) filter = true;

   return (filter);
}

