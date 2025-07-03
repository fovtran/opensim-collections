// Basic dialog script

integer CHANNEL = 42; // dialog channel
list MENU_MAIN = ["Color", "Alpha"]; // the main menu
list MENU_OPTIONS = ["Red", "Green", "Blue", "...Back"]; // a submenu
list MENU_ALPHA = ["Clear", "Translucent", "Opaque", "...Back"];

default
{
    state_entry()
    {
        llListen(CHANNEL, "", NULL_KEY, ""); // listen for dialog answers (from multiple users)
        llSetText("Dialog Test",<1,1,1>,1.0);
    }
    touch_start(integer total_number)
    {
        llDialog(llDetectedKey(0), "What do you want to do?", MENU_MAIN, CHANNEL); // present dialog on click
    }
    listen(integer channel, string name, key id, string message)
    {
        if (message == "Color")
        {
            llDialog(id, "Pick a color", MENU_OPTIONS, CHANNEL); // present submenu on request
        }
        else if (message == "Alpha")
        {
            llDialog(id, "Pick alpha", MENU_ALPHA, CHANNEL);
        }
        else if (message == "...Back")
        {
            llDialog(id, "Select option", MENU_MAIN, CHANNEL); // present main menu on request to go back
        }
        else if (message == "Red")
        {
            llSetColor(<1,0,0>,ALL_SIDES);
        }
        else if (message == "Green")
        {
            llSetColor(<0,1,0>,ALL_SIDES);
        }
        else if (message == "Blue")
        {
            llSetColor(<0,0,1>,ALL_SIDES);
        }
        else if (message == "Clear")
        {
            llSetAlpha(0.0, ALL_SIDES);
        }
        else if (message == "Translucent")
        {
            llSetAlpha(0.5, ALL_SIDES);
        }
        else if (message == "Opaque")
        {
            llSetAlpha(1.0, ALL_SIDES);
        }
    }
}