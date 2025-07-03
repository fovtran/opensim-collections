string anim ;
default
{
    changed(integer change)
    {
        if (change & CHANGED_LINK)
        {
            llSetAlpha(0.5,ALL_SIDES);
            anim = llGetInventoryName(INVENTORY_ANIMATION, 0);
            llSitTarget(<0,0,.1>, ZERO_ROTATION);
            key uuid = llAvatarOnSitTarget();
            if (uuid != NULL_KEY)
            {
                llRequestPermissions( uuid, PERMISSION_TRIGGER_ANIMATION );
            }
        }
    }
    run_time_permissions(integer change)
    {
        if (change & PERMISSION_TRIGGER_ANIMATION)
        {
            llSetAlpha(0.0,ALL_SIDES);
            llStopAnimation("sit");
            llStartAnimation(anim);
        }
    }
}