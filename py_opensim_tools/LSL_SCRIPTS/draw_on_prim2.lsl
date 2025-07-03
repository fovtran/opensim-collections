string osMovePen(string drawList, int x, int y);
string osDrawLine(string drawList, int startX, int startY, int endX, int endY);
string osDrawLine(string drawList, int endX, int endY);
string osDrawText(string drawList, string text);
string osDrawEllipse(string drawList, int width, int height);
string osDrawRectangle(string drawList, int width, int height);
string osDrawFilledRectangle(string drawList, int width, int height);
string osSetFontSize(string drawList, int fontSize);
string osSetPenSize(string drawList, int penSize);
string osSetPenColour(string drawList, string colour);
string osDrawImage(string drawList, int width, int height, string imageUrl);

//cs
public void default_event_state_entry()
{
string drawList = "";

drawList = osDrawLine (drawList, 10,20,240,20);
drawList = osMovePen (drawList, 50,100); 
drawList = osDrawImage(drawList, 100,100,"http://opensimulator.org/images/d/de/Opensim_Wright_Plaza.jpg" );
drawList = osSetPenSize (drawList, 1); 
drawList = osMovePen (drawList, 50,70);
drawList = osDrawEllipse (drawList, 20,20);
drawList = osMovePen(drawList, 90,70); 
drawList = osDrawRectangle (drawList, 20,20 );
drawList = osMovePen (drawList,130,70); 
drawList = osDrawFilledRectangle(drawList, 20,20);
drawList = osSetFontSize (drawList, 12 );
drawList = osMovePen (drawList,15,32); 

string regionName = llGetRegionName();
drawList = osDrawText (drawList, "Hello and welcome to " + regionName );

drawList = osSetFontSize (drawList, 7); 
drawList = osSetPenColour (drawList, "blue");
drawList = osMovePen (drawList, 70,220);
drawList = osDrawText (drawList, "The End");
osSetDynamicTextureData("", "vector", drawList, "", 0);
}
