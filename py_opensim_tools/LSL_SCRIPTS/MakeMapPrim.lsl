default
{
    state_entry()
    {
        llSay(0, "Script running");
        llSetPrimitiveParams([
            7, <2.56,2.56,0.05>,
            9,0, 0, <0.0,1.0,0.0>, 0.0, <0.0,0.0,0.0>, <1.0,1.0,1.0>, <0.0,0.0,0.0>,
           27, "regionMap"]);
        llRemoveInventory(llGetScriptName());     
    }
}