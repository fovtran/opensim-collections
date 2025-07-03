

float speed=0.2;
rotation rot;
float locx;
float locy;
vector pos;
default
{ touch_start(integer total_number)
{llRequestPermissions(llDetectedKey(0), PERMISSION_TAKE_CONTROLS);}
run_time_permissions(integer perm)
{if(PERMISSION_TAKE_CONTROLS & perm)
{llTakeControls(
CONTROL_FWD |
CONTROL_BACK |
CONTROL_LEFT |
CONTROL_RIGHT |
CONTROL_ROT_LEFT |
CONTROL_ROT_RIGHT | 
CONTROL_UP |
0, TRUE, FALSE);
}} control(key id, integer button, integer edge){ 

if (button==CONTROL_UP) {llSay(0,"Controls Released!");llReleaseControls( );}

if (button&CONTROL_ROT_LEFT) {rot = llGetRot();
rotation delta = llEuler2Rot(<0,0,(1 * PI)/45>);
rot = delta * rot;
llSetRot(rot);}

if (button&CONTROL_ROT_RIGHT) {rot = llGetRot();
rotation delta = llEuler2Rot(<0,0,(-1 * PI)/45>);
rot = delta * rot;
llSetRot(rot);}

if (button&CONTROL_FWD){vector rotvec = llRot2Euler (llGetRot());
pos = llGetPos();
locx = (llCos(rotvec.z))*speed;
locy = (llSin(rotvec.z))*speed;
pos = pos + (<locx,locy,0>);
llSetPos(pos);}
}}