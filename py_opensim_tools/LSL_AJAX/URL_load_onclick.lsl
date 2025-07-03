string site;
string onload_mess;
default {
    state_entry() {
        site = "http://"+llGetObjectDesc();//This makes the string "site" to what is after the =. To change the site change the objects description.
        onload_mess = "Would you like to go to\n"+site+" ?";//Thisis the message that is displayed when the llloadURL function is used.
        llSetText("Touch me to go to "+site,<0,0,1>, 1);///This creates the hovering text above it.
    }
    touch_start(integer total_number) {//When the object is touch this event is called
        llLoadURL(llDetectedKey(0),onload_mess,site);//This makes the blue popup appear that has the option to go to the website
    }
    changed(integer change) {//If the object has changed
        if(change & CHANGED_OWNER) {//If the object has changed its owner.
            llResetScript();//Reset script
        }
    }
}