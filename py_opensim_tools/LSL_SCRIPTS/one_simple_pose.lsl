// The most basic of pose scripts

// change to the name of animation contained within your sittable object
string pose = "tpose2";

// change to x,y,z offset of object center where you want to appear (never all 0)
vector target = <0.0, 0.0, 1.5>;

// optional sit text to appear over object
string text = "T-Pose";

default {
    state_entry()
    {
        llSitTarget(target, ZERO_ROTATION);
        llSetSitText(text);
        llSetText(text,<1.0,0.0,0.0>,1.0);
    }

    changed(integer change)
    {
        if (change & CHANGED_LINK)
        {
            if (llAvatarOnSitTarget() != NULL_KEY)
            {
                llRequestPermissions(llAvatarOnSitTarget(), PERMISSION_TRIGGER_ANIMATION);
                llStopAnimation("sit");
                llStartAnimation(pose);
                llSetText("",<1.0,0.0,0.0>,1.0);
            }
            else
            {
                llStopAnimation(pose);
                llSetText(text,<1.0,0.0,0.0>,1.0);
            }
        }
    }
}