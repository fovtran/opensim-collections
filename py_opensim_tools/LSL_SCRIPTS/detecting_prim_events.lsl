default
{
    changed(integer change)
    {
        //note that it's & and not &&... it's bitwise!
        if (change & CHANGED_INVENTORY)         
        {
            llOwnerSay("The inventory has changed.");
        }
        if (change & CHANGED_COLOR) 
        {
            llOwnerSay("The color or alpha changed.");
        }
        if (change & CHANGED_SHAPE) 
        {
            llOwnerSay("The prims shape has changed.");
        }
        if (change & CHANGED_SCALE) 
        {
            llOwnerSay("The prims size has changed.");
        }
        if (change & CHANGED_TEXTURE) 
        {
            llOwnerSay("The prims texture or texture attributes have changed.");
        }
        if (change & CHANGED_LINK) 
        {
            llOwnerSay("The number of links have changed.");
        }
        if (change & CHANGED_ALLOWED_DROP) 
        {
            llOwnerSay("The inventory has changed as a result of a user without mod permissions "+
                       "dropping an item on the prim and it being allowed by the script.");
        }
        if (change & CHANGED_OWNER) 
        {
            llOwnerSay("The owner of the object has changed.");
        }
        if (change & CHANGED_REGION) 
        {
            llOwnerSay("The region the object is in has changed.");
        }
        if (change & CHANGED_TELEPORT) 
        {
            llOwnerSay("The object has been teleported while attached.");
        }
    }
}
