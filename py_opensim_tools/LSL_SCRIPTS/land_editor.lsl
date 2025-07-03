integer CHANNEL;
integer ACTION;
integer SIZE;

string MAIN_MENU_STRING;
string SIZE_MENU_STRING;

list MAIN_MENU = [ "Level", "Raise", "Lower", "Smooth", "Noise", "Revert", "Size", "Stop", "Help", "Ground"];
list SIZE_MENU = [ "Small (2x2)", "Medium (4x4)", "Large (8x8)", "Back" ];

default
{
state_entry()
{

llSetPrimitiveParams([PRIM_COLOR, ALL_SIDES, <1, 0, 0>, 0.5, PRIM_SIZE, <3, 3, 0.5>]);
//ACTION = LAND_LEVEL;
//SIZE = LAND_SMALL_BRUSH;
MAIN_MENU_STRING = "Pick a tool or size of tool";
SIZE_MENU_STRING = "Pick size of tool or back to return";
CHANNEL = llFloor(llFrand(100000.0)) + 1000;
llListen(CHANNEL, "", NULL_KEY, "");
}

touch_start(integer num_detected)
{
if (llDetectedOwner(0) == llGetOwner())
{
llDialog(llDetectedKey(0), MAIN_MENU_STRING, MAIN_MENU, CHANNEL);
}
}

listen(integer CHANNEL, string name, key id, string message)
{
if (llListFindList(MAIN_MENU + SIZE_MENU, [message]) != -1) // verify dialog choice
{
if (message == "Size")
{
llDialog(id, SIZE_MENU_STRING, SIZE_MENU, CHANNEL);
}

if (message == "Help")
{
llGiveInventory(id, "Land Leveller");
}

if (message == "Level")
{
ACTION = LAND_LEVEL;
llSetTimerEvent(0.1);
}

if (message == "Raise")
{
ACTION = LAND_RAISE;
llSetTimerEvent(0.1);
}

if (message == "Lower")
{
ACTION = LAND_LOWER;
llSetTimerEvent(0.1);
}

if (message == "Smooth")
{
ACTION = LAND_SMOOTH;
llSetTimerEvent(0.1);
}

if (message == "Noise")
{
ACTION = LAND_NOISE;
llSetTimerEvent(0.1);
}

if (message == "Revert")
{
ACTION = LAND_REVERT;
llSetTimerEvent(0.1);
}

if (message == "Small (2x2)")
{
SIZE = LAND_SMALL_BRUSH;
llSetPrimitiveParams([PRIM_COLOR, ALL_SIDES, <1, 0, 0>, 0.5, PRIM_SIZE, <3, 3, 0.5>]);
}

if (message == "Medium (4x4)")
{
SIZE = LAND_MEDIUM_BRUSH;
llSetPrimitiveParams([PRIM_COLOR, ALL_SIDES, <0, 1, 0>, 0.5, PRIM_SIZE, <5, 5, 0.5>]);
}

if (message == "Large (8x8)")
{
SIZE = LAND_LARGE_BRUSH;
llSetPrimitiveParams([PRIM_COLOR, ALL_SIDES, <0, 0, 1>, 0.5, PRIM_SIZE, <9, 9, 0.5>]);
}

if (message == "Stop")
{
llSetTimerEvent(0);
}

if (message == "Ground")
{
// THIS PORTION BY STRIFE ONIZUKA //
float height = llGround(ZERO_VECTOR);
vector pos = llGetPos();
integer count = llCeil(llFabs(height - pos.z) / 10.0);
pos.z = height;
//for(;count;--count)
llSetPos(pos);
// THANK YOU STRIFE! //
llSay(0, "Now at ground level");
ACTION = LAND_LEVEL;
llSetTimerEvent(0.1);
}
}
}

timer()
{
llModifyLand((integer)ACTION, (integer)SIZE);
llSetTimerEvent(0.1);
}
}