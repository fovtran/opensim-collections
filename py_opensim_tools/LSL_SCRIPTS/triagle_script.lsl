// One time scale and shear script
// 2007 Copyright by Shine Renoir (fb@frank-buss.de)
// Use it for whatever you want, but keep this copyright notice
// and credit my name in notecards etc., if you use it in
// closed source objects
// Modified by Adelle Fitzgerald for OpenSim

integer handle;

default
{
    state_entry()
    {
        handle = llListen(-42, "", NULL_KEY, "" );
    }
    
    listen(integer channel, string name, key id, string message)
    {
        list tokens = llCSV2List(message);
        vector size = (vector) llList2String(tokens, 0);
        float shear = (float) llList2String(tokens, 1);
        llSetPrimitiveParams([
            PRIM_TYPE, PRIM_TYPE_BOX,
            0,  // hollow shape
            <0.0, 1.0, 0.0>,  // cut
            0.0,  // hollow
            <0.0, 0.0, 0.0>,  // twist
            <0.0, 1.0, 0.0>,  // taper
            <shear, 0.0, 0.0>,  // top shear
            PRIM_SIZE, size
        ]);
        llListenRemove(handle);
        llSleep(2);
        llRemoveInventory(llGetScriptName());
    }
    
    on_rez(integer param) {
        llResetScript();
    }
}