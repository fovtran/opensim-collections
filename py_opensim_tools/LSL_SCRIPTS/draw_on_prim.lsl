//cs
public void default_event_state_entry()
{
string drawList = "MoveTo 10,20; LineTo 240,20; ";

drawList += "MoveTo 50,100; Image 100,100,http://opensimulator.org/images/d/de/Opensim_Wright_Plaza.jpg;" ;

drawList += "PenSize 1; ";
drawList += "MoveTo 50,70; Ellipse 20,20; ";
drawList += "MoveTo 90,70; Rectangle 20,20; ";
drawList += "MoveTo 130,70; FillRectangle 20,20; ";
drawList += "FontSize 12; ";
drawList += "MoveTo 15,32; Text Hello and welcome to " + llGetRegionName() +"; ";
drawList += "FontSize 7; MoveTo 70,220; Text The End; ";

osSetDynamicTextureData("", "vector", drawList, "", 0);
}

