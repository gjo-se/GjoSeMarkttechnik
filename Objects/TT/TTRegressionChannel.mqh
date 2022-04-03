//+------------------------------------------------------------------+
//|                                          TTRegressionChannel.mqh |
//|                                       Copyright 2021, Gregory Jo |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

void createTT3RegressionChannel() {

     bool filled = false;
     ENUM_LINE_STYLE style = STYLE_SOLID;
     int width = 2;

    if(tt3p1DateTime != 0 && tt3p6DateTime != 0 ){
        createRegressionChannel(TT3_REGRESSION_CHANNEL, tt3p1DateTime, tt3p6DateTime, InpT3RegressionChannelColor, filled, style, width);
    }
}

void createTT4RegressionChannel() {

     bool filled = false;
     ENUM_LINE_STYLE style = STYLE_SOLID;
     int width = 2;

    if(tt4p1DateTime != 0 && tt4p6DateTime != 0 ){
        createRegressionChannel(TT4_REGRESSION_CHANNEL, tt4p1DateTime, tt4p6DateTime, InpT4RegressionChannelColor, filled, style, width);
    }
}