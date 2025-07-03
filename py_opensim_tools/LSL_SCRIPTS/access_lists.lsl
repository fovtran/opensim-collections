list access_list_low = [""];
list access_list_high = [""];
float delay = 3;  //  How often the sensor scans in seconds.
float range = 94;  //  Sensor range in meters. Max is 96
integer stated = TRUE;

default
{
    state_entry()
    {
        llSetObjectName("Security System");
        llSensorRepeat("","",AGENT,range,PI,delay);
        llListen(2627, "",llGetOwner(),"");
    }
    listen(integer channel, string name, key id, string message)
    {
        if (llToLower(message) == "secure high")
        {
            llInstantMessage(llGetOwner(), "Security Setting is set to High");
            stated = FALSE;
        }
        else if (llToLower(message) == "secure low")
        {
            llInstantMessage(llGetOwner(), "Security Setting is set to Low");
            stated = TRUE;
        }
            
    }
    sensor(integer number)
    {
        if (stated == TRUE)
        {
            if(llListFindList(access_list_low, (list)llKey2Name(llDetectedKey(0))) == -1)
            {
                llInstantMessage(llDetectedKey(0),"\nUnathorized access.\nSending you home in 5 seconds.");
                llSleep(1.0);
                llTeleportAgentHome(llDetectedKey(0));
            }
        }
        else if (stated == FALSE)
        {
            if(llListFindList(access_list_high, (list)llKey2Name(llDetectedKey(0))) == -1)
            {
                llInstantMessage(llDetectedKey(0),"\nUnathorized access.\nSending you home in 5 seconds.");
                llSleep(1.0);
                llTeleportAgentHome(llDetectedKey(0));
            }
        }
    }
}