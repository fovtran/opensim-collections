// Script Title:    Menu-Driven Giver (SIMPLE)
// Created by:       WhiteStar Magic 
// Creation Date:   May.10.2009
// Platforms:
//    OpenSim:       Y
// Revision:        0.2
// Revision History:
// Revision Contributors:
//
// Conditions:
// Please maintain this header. If you modify the script indicate your
// revision details / enhancements
//
// Licensing:  Open Source under CC 3.0 (PROVISION = This Header MUST remain)
// Support:  No Support or Warranty is expressed or implied.  Feel free to contact 
//           the author or revisor if you have problems or issues with this item and they
//           may assist you at their discretion. 
//
// --------- Creative Commons Licence 3.0 for Open Source ---------
// IF APPLICABLE see link povided
// http://creativecommons.org/licenses/by/3.0
// ================================================================
// ** SCRIPT NOTES **
// - This only handles 22 items for the menu.
// - This is a GIVER and NOT a Vendor
// - Only Gives ONE item at a time
// - ITEM NAME can only be a MAXIMUM of 24 Characters / Only 12 Characters are shown in Menu
// - Button Sorting is done to keep buttons in Sequence with << or >> at Bottom Right Position
//================================================================
// === GLOBAL VARIABLES
list MenuA = [];
list MenuB = [];
integer listener;
integer CHANNEL;
// 
// Basic Colours that can be used in Hovertext
// Un-Comment the one you wish to use & change the llSetText line in State_entry()
//vector black        = <0.0,0.0,0.0> ;
//vector white        = <1.0,1.0,1.0> ;
//vector grey         = <0.5,0.5,0.5> ;
//vector red          = <1.0,0.0,0.0> ;
vector yellow       = <1.0,1.0,0.0> ;
//vector green        = <0.0,1.0,0.0> ;
//vector turquoise    = <0.0,1.0,1.0> ;
//vector blue         = <0.0,0.0,1.0> ;
//vector purple       = <1.0,0.0,1.0> ;
//vector orange       = <1.0,0.5,0.0> ;
//vector brown        = <0.5,0.25,0.0> ;
//vector pink         = <1.0,0.0,0.5> ;
//
//list INV_types = [  //OPENSIM NOTE:  Numeric Values do not work at this time. Must use Full Name as noted below
//"INVENTORY_TEXTURE",
//"INVENTORY_SOUND",
//"INVENTORY_LANDMARK",
//"INVENTORY_CLOTHING",
//"INVENTORY_OBJECT",
//"INVENTORY_NOTECARD",
//"INVENTORY_BODYPART",
//"INVENTORY_ANIMATION",
//"INVENTORY_GESTURE"]; 
// INVENTORY_SCRIPT removed.  Would be BAD to have scripts in a giver system.  
//Put them in a Box contained inside device
//
GET_inv()
{
    integer i = 0;
    MenuA = [];
    MenuB = [];
    integer c = llGetInventoryNumber(INVENTORY_OBJECT);
    if (c <= 12)
    {
        for (i=0; i < c; ++i)
            MenuA += llGetInventoryName(INVENTORY_OBJECT, i);
    }
    else
    {        
        for (i=0; i < 11; ++i)
            MenuA += llGetInventoryName(INVENTORY_OBJECT, i);
        if(c > 22)
            c = 22;
        for (i=11; i < c; ++i)
            MenuB += llGetInventoryName(INVENTORY_OBJECT, i); 
        MenuA += ">>";
        MenuB += "<<";                          
    }
}
// == Open Communications ==
OPEN_comms()
{
    llListenRemove(listener);
    CHANNEL = (integer)(llFrand(-1000.0) - 1000.0);  // RANDOM Negative Channel
    listener = llListen(CHANNEL, "", NULL_KEY, "");
}
//== Order the Buttons into right sequence for DIALOG MENUS
list btn_sort(list btns)
{
    return llList2List(btns, -3, -1) + llList2List(btns, -6, -4)
        + llList2List(btns, -9, -7) + llList2List(btns, -12, -10);
}
// == DISPLAY A MENU DIALOG ==
MENU(key id, list menu)
{
    OPEN_comms();
    llSetTimerEvent(45.0);
    llDialog(id, "Select Item From List ", 
    btn_sort(menu), CHANNEL);
}
// ===========================
// == MAIN PROGRAM ROUTINE ==
default
{
    on_rez(integer num) { llResetScript(); }
    state_entry()
    {
        string ObjDesc = llGetObjectDesc();    // get the Objects Description Field to Display as Hovertext
        // HOVERTEXT display's description in Selected Colour
        llSetText(ObjDesc+"\nTouch for Menu", yellow, 1); 
        //
        GET_inv();
    }
    changed(integer change) // something changed, take action
    {
        if(change & CHANGED_INVENTORY)
        {
            GET_inv();
        }
        else if(change & CHANGED_OWNER)
        {
            llOwnerSay("Owner Changed, Resetting Script");
            llResetScript();
        }
    }
    //
    touch_start(integer number) { OPEN_comms(); MENU(llDetectedKey(0), MenuA); }
    //
    timer()
    {
        //kill left over listen
        llSetTimerEvent(0.0); // shutoff timer event
        llSay(0,"Menu Timed-Out, Please click again to get new menu");
        llListenRemove(listener);  
    }
    //
    listen(integer channel, string name, key id, string message) 
    {
        if (channel == CHANNEL)
        {
            llListenRemove(listener);
            llSetTimerEvent(0.0);  // no need for it, they answered
            if (message == ">>") { MENU(id, MenuB); }
                else if (message == "<<") { MENU(id, MenuA); }        
            else                    
            {
                // Give the User their single selection
                llGiveInventory(id,message);
            }      
        }
    }  
}
