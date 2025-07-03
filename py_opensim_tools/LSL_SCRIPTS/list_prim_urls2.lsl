//cs
// kinoc test script
integer picindex=0;

LSL_Types.list urlarray = [] ; 


public void default_event_state_entry()
{
llSay( 0, "cs osSetDynamicTextureURL Tester");
urlarray.Add("http://www.goes.noaa.gov/FULLDISK/GEVS.JPG");
urlarray.Add("http://www.goes.noaa.gov/FULLDISK/MTVS.JPG");
urlarray.Add("http://www.goes.noaa.gov/FULLDISK/GIVS.JPG");
urlarray.Add("http://www.goes.noaa.gov/FULLDISK/GMVS.JPG");
urlarray.Add("http://www.osei.noaa.gov/IOD/OSEIiod.jpg");
urlarray.Add("http://internettrafficreport.com/gifs/tr_map_global.gif");

llSetTimerEvent( 30); // create a "timer event" every 20 seconds. 

}

public void default_event_timer(){
// do these instructions every time the timer event occurs.

// llSay( 0, "Fetching.");
string dynamicID="";
integer refreshRate = 600;
string contentType="image";
picindex = (picindex+1) % urlarray.Length;
string srcURL = urlarray.GetSublist(picindex,picindex).ToString(); // URL
string URLTexture=osSetDynamicTextureURL(dynamicID, contentType ,srcURL , "", refreshRate ); 
if (llStringLength(URLTexture)>0) 
{
//llSay(0,"URLTexture = "+srcURL);
llSetTexture(URLTexture, ALL_SIDES);
}
}
