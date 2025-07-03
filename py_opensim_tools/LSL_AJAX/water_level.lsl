//----    Water level script by Mircea Kitsune, V1.0    ----
// Configuration:
float initialwaterlevel = 20; // Initial water level, best left at 20.
float targetwaterlevel = 40; // Level the water goes to. Can be anything bigger or smaller then the initial level.
float waterraisespeed = 0.15; // How fast the water goes up.
float waterlowerspeed = 0.15; // How fast the water goes down.

float flux = FALSE; // If FALSE the water moves when the object is touched by an avatar. If TRUE the flux and reflux happen at random intervals.
float fluxtimemin = 30; // If flux is TRUE, the minimum number of secconds in which a flux / reflux can take place.
float fluxtimemax = 120; // If flux is TRUE, the maximum number of secconds in which a flux / reflux can take place.
float owneronly = TRUE; // Only the owner can trigger by touching (if flux = FALSE).

float notices = 1; // Enable echoing of messages. 0 disables, 1 enables notices on flux / reflux, 2 also prints the water position each loop.
string message1 = " raises the water level."; // Message when an avatar triggers a flux. Is used as 'avatar name + message'.
string message2 = " lowers the water level."; // Message when an avatar triggers a reflux. Is used as 'avatar name + message'.
string message3 = "A flux has started."; // Message when a timed flux takes place (for flux = TRUE).
string message4 = "A reflux has started."; // Message when a timed reflux takes place (for flux = TRUE).

string sound = "Waterfall"; // Sound to play as the water lowers / raises. Set to "" to disable.
float soundvol = 1; // Volume of the sound.
// End of configuration.

movewaterto()
{
    float i;
    llSetTimerEvent(0); // Make sure the timer doesn't execute if shorter then the loop time, otherwise it causes glitches.
    llLoopSound(sound, soundvol);
    if(targetwaterlevel > initialwaterlevel)
    {
        for(i = initialwaterlevel; i <= targetwaterlevel; i+=waterraisespeed)
        {
            osSetRegionWaterHeight(i);
            if(notices > 1)
                llSay(0, "Water position at " + (string)i + " meters.");
        }
    }
    else if(targetwaterlevel < initialwaterlevel)
    {
        for(i = initialwaterlevel; i >= targetwaterlevel; i-=waterlowerspeed)
        {
            osSetRegionWaterHeight(i);
            if(notices > 1)
                llSay(0, "Water position at " + (string)i + " meters.");
        }
    }
    llStopSound();
    state atcustomlevel;
}

movewaterfrom()
{
    float i;
    llSetTimerEvent(0); // Make sure the timer doesn't execute if shorter then the loop time, otherwise it causes glitches.
    llLoopSound(sound, soundvol);
    if(targetwaterlevel > initialwaterlevel)
    {
        for(i = targetwaterlevel; i >= initialwaterlevel; i-=waterlowerspeed)
        {
            osSetRegionWaterHeight(i);
            if(notices > 1)
                llSay(0, "Water position at " + (string)i + " meters.");
        }
    }
    else if(targetwaterlevel < initialwaterlevel)
    {
        for(i = targetwaterlevel; i <= initialwaterlevel; i+=waterraisespeed)
        {
            osSetRegionWaterHeight(i);
            if(notices > 1)
                llSay(0, "Water position at " + (string)i + " meters.");
        }
    }
    llStopSound();
    state default;
}

default
{
    state_entry()
    {
        osSetRegionWaterHeight(initialwaterlevel);
        //llPreloadSound(sound);
        if(flux == TRUE)
        {
            float fluxtime = llFrand(fluxtimemax - fluxtimemin) + fluxtimemin;
            llSetTimerEvent(fluxtime);
        }
        else
            llSetTimerEvent(0);
    }

    touch_start(integer num_detected)
    {
        if(flux != TRUE)
        {
            if(owneronly == TRUE & llDetectedKey(0) != llGetOwner())
                return;
            else
            {
                if(notices > 0)
                    if(targetwaterlevel > initialwaterlevel)
                        llSay(0, llDetectedName(0) + message1);
                    else if(targetwaterlevel < initialwaterlevel)
                        llSay(0, llDetectedName(0) + message2);
                movewaterto();
            }
        }
    }

    timer()
    {
        if(notices > 0)
            if(targetwaterlevel > initialwaterlevel)
                llSay(0, llDetectedName(0) + message3);
            else if(targetwaterlevel < initialwaterlevel)
                llSay(0, llDetectedName(0) + message4);
        movewaterto();
    }
}

state atcustomlevel
{
    state_entry()
    {
        osSetRegionWaterHeight(targetwaterlevel);
        //llPreloadSound(sound);
        if(flux == TRUE)
        {
            float fluxtime = llFrand(fluxtimemax - fluxtimemin) + fluxtimemin;
            llSetTimerEvent(fluxtime);
        }
        else
            llSetTimerEvent(0);
    }

    touch_start(integer num_detected)
    {
        if(flux != TRUE)
        {
            if(owneronly == TRUE & llDetectedKey(0) != llGetOwner())
                return;
            else
            {
                if(notices > 0)
                    if(targetwaterlevel > initialwaterlevel)
                        llSay(0, llDetectedName(0) + message2);
                    else if(targetwaterlevel < initialwaterlevel)
                        llSay(0, llDetectedName(0) + message1);
                movewaterfrom();
            }
        }
    }

    timer()
    {
        if(notices > 0)
            if(targetwaterlevel > initialwaterlevel)
                llSay(0, llDetectedName(0) + message4);
            else if(targetwaterlevel < initialwaterlevel)
                llSay(0, llDetectedName(0) + message3);
        movewaterfrom();
    }
}

//Allow_osSetRegionWaterHeight = 0dc66107-d6a7-4cd4-892f-f74226054d0f
// (replace 0dc66107-d6a7-4cd4-892f-f74226054d0f with your avatar's UUID.)
// Allow_osSetRegionWaterHeight = ESTATE_OWNER