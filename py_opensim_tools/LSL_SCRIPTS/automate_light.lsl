//// "Night Sensor" CONTROLLER TEMPLATE v1 - by Jopsy Pendragon - 4/8/2008
//// You are free to use this script as you please, so long as you include this line:
//** The original 'free' version of this script came from THE PARTICLE LABORATORY. **//

// EFFECT: Checks sun's position once a minute to see if it is NIGHTTIME.

// SETUP: Drop this CONTROLLER TEMPLATE script into the same object with
// your PARTICLE TEMPLATE. It will detect day or night in 60 seconds.

integer ON_AT_NIGHT = TRUE; // Set to FALSE for on during the day & off at night.

vector sunpos;
integer mode;
integer last_check=-1;

string CONTROLLER_ID = "A"; // see more about CONTROL TEMPLATES at end.

default {
state_entry() {
// Don't be a lagtard! Checking more than every 60 seconds is greedy:
llSetTimerEvent(60.0);
}

timer() {
sunpos = llGetSunDirection();

if ( sunpos.z < 0.0 )
mode = ON_AT_NIGHT;
else
mode = ! ON_AT_NIGHT;

if ( mode != last_check ) {
llMessageLinked( LINK_SET, mode, CONTROLLER_ID, NULL_KEY ); // send command
last_check = mode;
}
}
}

//========================================================================
//======================== USING CONTROL TEMPLATES =======================
//
// To use: Drop this CONTROLLER TEMPLATE script into the same object with
// your PARTICLE TEMPLATE. It should be operational immediately.
//
// By default, control templates will turn EVERY particle template in the
// same object ON or OFF. If you want particle templates to only listen
// to specific controller templates, then give both matching CONTROLLER_ID's,
// (something other than "A", like: "B" for example).

//======================================== END ===============================