default
{
    state_entry()
    {
        llSetTimerEvent(300.0);
    }
    timer()
    {
        llInstantMessage(llGetOwner(), llGetRegionName() + " currently replies following: " + " Current Time = " + (string)llGetTimestamp() + " SIM FPS = " + (string)llGetRegionFPS() + " Time Dilation = " + (string)llGetRegionTimeDilation() + " Current Agentcount = " + (string)llGetRegionAgentCount());
    }
    touch_start(integer touches)
    {
        llInstantMessage(llGetOwner(), llGetRegionName() + " currently replies following: " + " Current Time = " + (string)llGetTimestamp() + " SIM FPS = " + (string)llGetRegionFPS() + " Time Dilation = " + (string)llGetRegionTimeDilation() + " Current Agentcount = " + (string)llGetRegionAgentCount());
    }
}