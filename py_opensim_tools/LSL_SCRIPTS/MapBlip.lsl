integer gUnSet = TRUE;
key gAvatar = "";
vector gPosition = ZERO_VECTOR;
string gName = "";

default
{
    link_message(integer source, integer num, string data, key id)
    {
        if (gUnSet)
        {
            gUnSet = FALSE;
            integer cut = llSubStringIndex(data,"*");
            gAvatar = (key)llGetSubString(data, 0, cut - 1);
            string dataString = llGetSubString(data, cut + 1, -1);
            cut = llSubStringIndex(dataString,"*");
            gPosition = (vector)llGetSubString(dataString, 0, cut - 1);
            gName = llGetSubString(dataString, cut + 1, -1);

            llSetPos(<-1.28 + (gPosition.x / 100), -1.28 + (gPosition.y / 100), 0.035 + (gPosition.z / 100)>);
                 
            llSetText(gName, <0.0, 0.0, 0.0>, 1.0);
        }
    }
    
    touch_start(integer touched)
    {
        if (llDetectedKey(0) == llGetOwner())
        {
            osTeleportAgent(llDetectedKey(0), llGetRegionName(), gPosition, ZERO_VECTOR);
        }
    }
    
    changed(integer change)
    {
        if (change & CHANGED_LINK)
        {
            if (llGetLinkNumber() == 0) { llDie(); }
        }
    }
}