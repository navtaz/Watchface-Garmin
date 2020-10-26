//navtaz 2019.06.09 Consolas basic watchface


using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Application as App;
using Toybox.Time as Tim;
using Toybox.Time.Gregorian as Gre;

class watchface_10View extends Ui.WatchFace {

   function initialize() {
        WatchFace.initialize();
    }

	var customFont = null;
	var consolasSmall = null;	
	var consolasHalf = null;
 
 
  	function onLayout(dc) {
   		customFont = Ui.loadResource(Rez.Fonts.customFont);					 
		consolasSmall = Ui.loadResource(Rez.Fonts.consolasSmall);	  
		consolasHalf = Ui.loadResource(Rez.Fonts.consolasHalf);	
	}
 

 	function onUpdate(dc) {
        
        dc.setColor (Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();

 //date
   	var today_MED = Gre.info(Tim.now(), Tim.FORMAT_MEDIUM);
   	var today_SH = Gre.info(Tim.now(), Tim.FORMAT_SHORT);
   	var dateString = Lang.format("$1$ $2$.$3$.$4$",[today_MED.day_of_week, today_SH.year, today_SH.month.format("%02d"), today_SH.day.format("%02d")]);
   	var clockTime = System.getClockTime();
 	
 //battery  
	var myBatt = Sys.getSystemStats().battery;
	var battstring = Lang.format("$1$ $2$$3$", ["batt:", myBatt.format("%02d"),"%"]);

 //time
	var hour = clockTime.hour;
	 	if (!Sys.getDeviceSettings().is24Hour){
	 		hour = hour % 12;
	 		if (hour == 0){
	 			hour = 12;
	 		}
	 	}
   
    var hourdig = hour.format("%02d");
    var mindig = clockTime.min.format("%02d");
    var timeString = Lang.format("$1$:$2$", [hourdig.toString(), mindig.toString()]);
    
 //print time
 
		dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_BLACK);
 		dc.drawText(dc.getWidth()/2, 35, consolasSmall, dateString, Gfx.TEXT_JUSTIFY_CENTER);
 		
		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
 		dc.drawText(94, 79, customFont,timeString , Gfx.TEXT_JUSTIFY_CENTER);

       	dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_BLACK);
 		dc.drawText(dc.getWidth()/2, 182, consolasSmall,battstring , Gfx.TEXT_JUSTIFY_CENTER);
        
    }
 
  function onPartialUpdate(dc) {
  		
  		var clockTime = System.getClockTime();       
    	var secdig =  clockTime.sec.format("%02d");       
        
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
 		dc.drawText(240, 103,  consolasHalf, secdig.toString(), Gfx.TEXT_JUSTIFY_RIGHT);
 }
 
    function onShow() {
    }

    function onHide() {
    }

    function onExitSleep() {
    }

    function onEnterSleep() {
    }

}
