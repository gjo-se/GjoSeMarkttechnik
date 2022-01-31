//+------------------------------------------------------------------+
//|                                                   FiboLevels.mqh |
//|                                       Copyright 2022, Gregory Jo |
//+------------------------------------------------------------------+

void createT3FiboRetracement() {

   datetime t3EndDatetime = 0;
   if(getVlineDatetimeByText(T3_END_VLINE) != 0) {
      t3EndDatetime = getVlineDatetimeByText(T3_END_VLINE);
   } else {
      t3EndDatetime = iTime(Symbol(), PERIOD_CURRENT, InpT3ChannelEndShift);
   }

   createTrendLine(T3_FIBO_LEVELS + "100", t3p3DateTime, getP3HighLowValueByTrendDirection(), iTime(Symbol(), PERIOD_CURRENT, 0), getP3HighLowValueByTrendDirection(), InpT3FiboLevelsColor, 2, STYLE_SOLID, " 100%");
   createTrendLine(T3_FIBO_LEVELS + "0", t3p3DateTime, getP4HighLowValueByTrendDirection(), iTime(Symbol(), PERIOD_CURRENT, 0), getP4HighLowValueByTrendDirection(), InpT3FiboLevelsColor, 2, STYLE_SOLID, " 0%");

   for( int t3FiboLevelsId = 0; t3FiboLevelsId < ArraySize(t3FiboLevelsArray); t3FiboLevelsId++) {
      double level = (double)t3FiboLevelsArray[t3FiboLevelsId];
      double t3FiboLevelValue = getP4HighLowValueByTrendDirection() + (getP3HighLowValueByTrendDirection() - getP4HighLowValueByTrendDirection()) / 100 * level  ;
      int    lineWidth = 1;
      color  levelColor = InpT3FiboLevelsColor;
    ENUM_LINE_STYLE style = STYLE_SOLID;

    if(level == InpT3AlertOnFiboRetracmentLevel && InpT3AlertOn == true) {
      lineWidth = 1;
      style = STYLE_DASH;
      levelColor = InpT3MinMaxRegressionColor;
      alertFiboRetracementLevel = t3FiboLevelValue;
    }

      if(level == InpT3MinFiboRetracmentLevel || level == InpT3MaxFiboRetracmentLevel) {
         lineWidth = 2;
         levelColor = InpT3MinMaxRegressionColor;
      }
      createTrendLine(T3_FIBO_LEVELS + DoubleToString(level, 1), t3p3DateTime, t3FiboLevelValue, iTime(Symbol(), PERIOD_CURRENT, 0), t3FiboLevelValue, levelColor, lineWidth, style, " " + DoubleToString(level, 1) + "%");
   }

}

void deleteFiboLevelsObject(const string pDimension) {

   long chartId = ChartID();
   int objectsTotal = ObjectsTotal(chartId, 0, -1);

   string objectName;
   for(int i = objectsTotal; i >= 0; i--) {
      objectName = ObjectName(chartId, i);
      if ( StringFind(objectName, pDimension) != -1 ) {
         ObjectDelete(chartId, objectName);
      }
   }
}
//+------------------------------------------------------------------+
