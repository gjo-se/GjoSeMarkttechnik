//
//--- Anzahl der Fenster auf dem Chart (es gibt immer mindestens ein Hauptfenster)
//      int windows = (int)ChartGetInteger(0, CHART_WINDOWS_TOTAL);
//      //--- für alle Fenster machen
//      for(int w = 0; w < windows; w++) {
//         //--- Anzahl der Indikatoren in diesem Fenster/Untenfenster
//         int total = ChartIndicatorsTotal(0, w);
//         //--- für alle Fenster machen
//         for(int i = 0; i < total; i++) {
//            //--- erhalten wir den kurzen Namen des Indikators
//            string name = ChartIndicatorName(0, w, i);
//            //--- erhalten wir Indikator-Handle
//            int handle = ChartIndicatorGet(0, w, name);
//            ChartIndicatorDelete(ChartID(), subWindow, name);
//            //--- In Log schreiben
//            PrintFormat("Window=%d,  index=%d,  Name=%s,  handle=%d",w,i,name,handle);
//            //--- sicherlich befreien wir den Indikatorhandle, wenn er nicht mehr benötigt wird
//            IndicatorRelease(handle);
//         }
//      }
