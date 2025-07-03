
//listen switch

default

{
state_entry()
{
llListen(0, "", NULL_KEY, ""); // start listening
}

listen(integer channel, string name, key id, string message)
{
if (message == "off") {

llSetColor(<0,0,0>,ALL_SIDES); //turn off stuff here
}
else {
if (message == "on")
llSetColor(<1,1,1>,ALL_SIDES); //turn on stuff here

}
}
}