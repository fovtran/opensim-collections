//Staff Bell by Lila Magenta. Uncomment if more staff is used, insert keys.
key staff1 = "";
//key staff2 = "";
//key staff3 = "";
default 
{
    state_entry()
    {
        llSetText("If Staff is not around click me!", <0,0,0>, 10.0);
    }
    touch_start(integer touches)
    {
        if (llDetectedKey(0) != llGetOwner())
        if (llDetectedKey(0) != staff1)
        //if (llDetectedKey(0) != staff2)
        //if (llDetectedKey(0) != staff3)
        {
            llWhisper(0, "Staff contacted, if available, will arrive shortly!");
            llInstantMessage(llGetOwner(), llDetectedName(0) + " rang the bell at " + llGetRegionName());
            llInstantMessage(staff1, llDetectedName(0) + " rang the bell at " + llGetRegionName());
            //llInstantMessage(staff2, llDetectedName(0) + " rang the bell at " + llGetRegionName());
            //llInstantMessage(staff3, llDetectedName(0) + " rang the bell at " + llGetRegionName());
        }
    }
}