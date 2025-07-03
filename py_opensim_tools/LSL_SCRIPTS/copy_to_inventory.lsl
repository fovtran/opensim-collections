default
{
    state_entry()
    {
        llSleep(2.0);
        llOwnerSay("Stand close to " + (string)llGetObjectName() + " at: " + (string)llGetPos() + " You will recieve your purchased items shortly!");
        integer i = 0;
        
        while (i < llGetInventoryNumber(INVENTORY_ALL))
        {
            if (llGetInventoryName (INVENTORY_ALL, i) != llGetScriptName() )
            {
                   llGiveInventory(llGetOwner(), llGetInventoryName (INVENTORY_ALL, i));
            }
            ++i; 
        }
        llOwnerSay("If you havent recieved any contents, click the prim to execute another try.");
    }
    touch_start(integer total_number)
    {
        llSleep(2.0);
        llOwnerSay((string)llGetObjectName() + " will try to deliver your purchased items again. Please make sure you stand close to this object at: " + (string)llGetPos());
        integer i = 0;
        
        while (i < llGetInventoryNumber(INVENTORY_ALL))
        {
            if (llGetInventoryName (INVENTORY_ALL, i) != llGetScriptName() )
            {
                   llGiveInventory(llDetectedKey(0), llGetInventoryName (INVENTORY_ALL, i));
            }
            ++i; 
        }
        llOwnerSay("If you still havent recieved your items, please contact the support at: " + (string)llGetObjectDesc());
    }
}