vector closed = <2,-0.5,0>;
integer open = FALSE;
string password = "furry";
integer chann = 66;
integer listener = TRUE;
default
{
    touch_start(integer num_detected)
    {
        if (open == FALSE)
        {
            llInstantMessage(llDetectedKey(0) , "Say Password in channel " + chann);
            llListen(chann, "","","");
            listener = TRUE;
            llSetTimerEvent(5.0);
        }
        else if (open == TRUE)
        {
            llSetPos(llGetPos() - closed);
            open = FALSE;
            llListenRemove(1);
            listener = FALSE;
        }
    }
    listen(integer channel, string name, key id, string message)
    {
        if (open == FALSE)
        {
            if (llToLower(message) == password)
            {
                llSetPos(llGetPos() + closed);
                open = TRUE;
                llListenRemove(1);
                listener = FALSE;
            }
            else if (llToLower(message) != password)
            {
                llWhisper(0, "Invalid password");
                llListenRemove(1);
                listener = FALSE;
            }
        }
    }
    timer()
    {
        if (listener == TRUE)
        {
            llListenRemove(1);
            llWhisper(0, "Timeout.");
            listener = FALSE;
            llSetTimerEvent(0.0);
        }
        else if (listener == FALSE)
        {
            llSetTimerEvent(0.0);
        }
    }
}