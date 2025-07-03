// ----------------------------------------------------------------
// Script Title:    Give-All_Contents PLUS
// Created by:       WhiteStar Magic 
// Creation Date:   May.20.2009
// Platforms:
//    OpenSim:       Y
//
// Revision:        0.3
// Revision History: Revised with correct working fuctions as of above date
//
// Revision Contributors:
//
//
//
// Conditions:
// Please maintain this header. If you modify the script indicate your
// revision details / enhancements
//
//
// Licensing:  Open Source under CC 3.0 (PROVISION = This Header MUST remain)
//
// Support:  No Support or Warranty is expressed or implied.  Feel free to contact 
//           the author or revisor if you have problems or issues with this item and they
//           may assist you at their discretion. 
//
// --------- Creative Commons Licence 3.0 for Open Source ---------
// IF APPLICABLE see link povided
// http://creativecommons.org/licenses/by/3.0
// ================================================================
// ** SCRIPT NOTES **
//
// This is a simple script that gives everything in a box to the person who clicked.  
// THIS IS NOT A VENDING SCRIPT.  It gives items away, it does NOT SELL THEM.  
// NOTE:  PERMISSION CHECKING IS DONE.  All Items MUST be COPY/TRANSFER or they will NOT BE GIVEN
// HVRtext: is also used as Folder Name for Items delivered to Touching Avatar
//================================================================
// === GLOBAL VARIABLES
//
string HVRtext = "My Free Products";  // [MODIFY THIS] The Hovertext that appears above the Prim
//
// Colours that can be used in Hovertext  SET COLOR in that state_entry
vector black        = <0.0,0.0,0.0> ;
vector white        = <1.0,1.0,1.0> ;
vector grey         = <0.5,0.5,0.5> ;
vector red          = <1.0,0.0,0.0> ;
vector yellow       = <1.0,1.0,0.0> ;
vector green        = <0.0,1.0,0.0> ;
vector turquoise    = <0.0,1.0,1.0> ;
vector blue         = <0.0,0.0,1.0> ;
vector purple       = <1.0,0.0,1.0> ;
vector orange       = <1.0,0.5,0.0> ;
vector brown        = <0.5,0.25,0.0>;
vector pink         = <1.0,0.0,0.5> ;
//
vector HVRcolor;          // set your colour in the State_Entry Section of the script.  
list INVENTORY_list =[];  // Inventory contained to give out
//
GET_inv() // Get Inventory
{
    // NOTE HERE
    // This is for ALL Inventory types.  IF you are not going to give out a certain INVENTORY_type 
    // remove it from the list.
    // The list below reflects such  The FULL List is Commented below this NOTE for reference.
    list INV_types = [INVENTORY_BODYPART, INVENTORY_CLOTHING, INVENTORY_LANDMARK, INVENTORY_NOTECARD, INVENTORY_OBJECT, INVENTORY_SOUND, INVENTORY_TEXTURE, INVENTORY_ANIMATION]; //INVENTORY_SCRIPT (removed from list, put scripts in prims!)
    //
    INVENTORY_list =[]; // clearing list, just in case
    integer total_number = (llGetInventoryNumber(INVENTORY_ALL)-1); // subtracting 1 for the existing script
    llOwnerSay("Total Inventory Contained = "+(string)total_number);
    if(total_number>0)
    {
        integer INV_count = llGetListLength(INV_types);
        integer j;
        integer k;
        integer type;
        integer ITM_count;
        string THISscript = llGetScriptName();
        string ITM_name;
        for (j=0; j<INV_count;j++)
        {
            type = llList2Integer(INV_types,j); // get the next inventory type from the list
            ITM_count = llGetInventoryNumber(type);   // how many of that kind of inventory is in the box?
            if (ITM_count > 0)
            {
                for (k=0; k<ITM_count;k++)
                {
                    ITM_name = llGetInventoryName(type,k);
                    if (ITM_name != THISscript)        // don't give THIS SCRIPT out
                    {
                        if(llGetInventoryPermMask(ITM_name, MASK_OWNER) & PERM_COPY)
                        {
                            INVENTORY_list += ITM_name; // Build the List of Contents, excluding this script
                        }
                        else
                        {
                            // failed because perms are incorrect, transfer(if non-owner)_or_ no-copy as it would be lost
                            llOwnerSay("Permissions Denied to give \""+ITM_name+"\".\nPossible Cause = No Copy And/Or No Transfer");
                        }
                    }
                }            
            }
        }
    }
    else llOwnerSay("There is No Available Inventory to give at this time");
}
//
GIVE_inv(key id)
{
    // Uses HVRtext As Folder name where inventory is deposited.
    llGiveInventoryList(id, HVRtext, INVENTORY_list);
    llInstantMessage(id,"The Items have been delivered to the "+HVRtext+" Folder in your Inventory"); //Tell Avatar whereit went!
}
// === Program Start ===
default
{
    on_rez(integer start_param)
    {
        llResetScript();
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
    state_entry()
    {
        GET_inv();
        HVRcolor = blue;                 // Change according to the colour you wish to use, defined above.
        llSetText(HVRtext, HVRcolor, 1);    // Displays the Desired TEXT in the COLOUR as defined
    }
    //
    touch_end(integer total_number)
    {
        GIVE_inv(llDetectedKey(0));
    }
}
