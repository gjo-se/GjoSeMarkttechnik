/*

   BuyAlertState
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

   Beschreibung
   ===============

*/

bool getBuyAlertRegressionSignal() {

   bool signal = false;

   if(getBuyRegressionIsGreaterAlertOnRegressionChannelSignal()) signal = true;
   if(getT3TrendIsNotLongFilter() == true) signal = false;

   return(signal);

}

bool getBuyRegressionIsGreaterAlertOnRegressionChannelSignal() {

   bool     signal = false;

   if(Bid() < alertRegressionChannelLevel || Bid() < alertFiboRetracementLevel){
        signal = true;
   } else{
        isBuyRegressionAlertSendable = true;
   }

    return signal;
}

bool getT3TrendIsNotLongFilter() {

   bool filter = false;

   if(t3trendDirection != TREND_DIRECTION_LONG) filter = true;

   return (filter);
}

