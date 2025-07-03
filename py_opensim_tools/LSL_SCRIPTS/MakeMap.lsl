integer gOn = FALSE;

list gAvatarList = [];

integer gAvatars = 0;
integer gAvatar = 0;

addBlip()
{
    if (gAvatar < gAvatars)
    {
        string dataString = "";
        
        dataString = llList2String(gAvatarList, gAvatar * 3) + "*";
        dataString = dataString + llList2String(gAvatarList, gAvatar * 3 + 1) + "*";
        dataString = dataString + llList2String(gAvatarList, gAvatar * 3 + 2);
                        
        llMessageLinked( LINK_SET, 0, dataString, "");
        
        gAvatar++;
        
        if (gAvatar < gAvatars) { llRezObject( "Blip", llGetPos(), ZERO_VECTOR, ZERO_ROTATION, 1); }
    }
}

default
{
    on_rez(integer rezzed) { do { llSay(0, "resetting now"); llResetScript(); } while (TRUE); }
    
    changed(integer change)
    {
        if (change & (CHANGED_REGION_RESTART | CHANGED_REGION_START))
            do { llOwnerSay("Reseting..."); llResetScript(); } while (TRUE);
    }

    state_entry()
    {
        llSetTexture(osGetMapTexture(),0);
        llRequestPermissions(llGetOwner(), PERMISSION_CHANGE_LINKS);
    }
    
    run_time_permissions(integer perm)
    {
        if (perm & PERMISSION_CHANGE_LINKS) { state running; }
        else { llOwnerSay("Sorry, without this permissiom I cannot run."); }
    }
}

state running
{
    on_rez(integer rezzed) { do { llSay(0, "resetting now"); llResetScript(); } while (TRUE); }
    
    touch_start(integer touched)
    {
        if (gOn)
        {
            llSetTimerEvent(0);
            llBreakAllLinks();
        }
        
        gAvatar = 0;

        //  gAvatarList = osGetAvatarList();
        // Test Data remove and uncomment the line above.
        gAvatarList = ["000000-0000-0000-0000-000000000000", <llFrand(256.0), llFrand(256.0), llFrand(256.0)>, "Avatar-00",
                       "000000-0000-0000-0000-000000000000", <llFrand(256.0), llFrand(256.0), llFrand(256.0)>, "Avatar-01",
                       "000000-0000-0000-0000-000000000000", <llFrand(256.0), llFrand(256.0), llFrand(256.0)>, "Avatar-02",
                       "000000-0000-0000-0000-000000000000", <llFrand(256.0), llFrand(256.0), llFrand(256.0)>, "Avatar-03",
                       "000000-0000-0000-0000-000000000000", <llFrand(256.0), llFrand(256.0), llFrand(256.0)>, "Avatar-04"];
        // End Test Data
        
        if (gAvatarList == []) { llOwnerSay("No one detected."); }
        else
        {
            gOn = TRUE;
            llSetTimerEvent(300.0);
            gAvatars = llGetListLength(gAvatarList) / 3;
            llRezObject( "Blip", llGetPos(), ZERO_VECTOR, ZERO_ROTATION, 1);
        }
    }
    
    object_rez(key id)
    {
        llCreateLink(id, TRUE);
        addBlip();
    }
    
    timer()
    {
        llSetTimerEvent(0);
        llBreakAllLinks();
        gOn = FALSE;
    }
}