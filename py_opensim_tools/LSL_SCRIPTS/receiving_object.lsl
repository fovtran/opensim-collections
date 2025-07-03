default
{
    state_entry()
    {
        llListen(1234, "", NULL_KEY, "");
    }

    on_rez(integer param)
    {
        llResetScript();
    }

    listen(integer channel, string name, key id, string msg)
    {
        llOwnerSay("Reveived message: " + msg);
    }
}