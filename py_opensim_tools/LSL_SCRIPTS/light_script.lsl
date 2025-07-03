//// "Light" EFFECT TEMPLATE v1 - by Jopsy Pendragon - 4/8/2008
//// You are free to use this script as you please, so long as you include this line:
//** The original 'free' version of this script came from THE PARTICLE LABORATORY. **//

// SETUP: Use with particle lab Controller Templates to activate/deactivate.

// Causes the prim to emit light, illuminating nearby avatars, prims and ground.

// Customize the particle_parameter values below to create your unique
// effect and click SAVE.

// PURPOSE: This script will enable/disable and adjust the LIGHT emitted by a prim.

// NOTE: This is not a particle effect.

vector color = <1.00,0.50,0.50>; // red, green and blue values 0.00(dark) to 1.00(bright)
float intensity = 0.75; // % brightness: 0.0 to 1.0
float radius = 10.00; // range/distance of light: 0.0 to 20.0 meters
float falloff = 0.5; // % brightness at max distance 0.00 to 1.00

string CONTROLLER_ID = "A"; // See comments at end regarding CONTROLLERS.
integer AUTO_START = FALSE; // Optionally FALSE only if using CONTROLLERS.

rotation adjustment = ZERO_ROTATION;

default {
state_entry() {

if ( AUTO_START )
llSetPrimitiveParams( [PRIM_POINT_LIGHT, TRUE, color , intensity, radius, falloff]);

}

link_message( integer sibling, integer num, string mesg, key target_key ) {
if ( mesg != CONTROLLER_ID ) { // this message isn't for me. Bail out.
return;
} else if ( num == 0 ) { // Message says to turn particles OFF:
llSetPrimitiveParams( [PRIM_POINT_LIGHT, FALSE, ZERO_VECTOR , 0.0, 0.0, 0.0 ]);
} else if ( num == 1 ) { // Message says to turn particles ON:
llSetPrimitiveParams( [PRIM_POINT_LIGHT, TRUE, color , intensity, radius, falloff]);
} else { // bad instruction number
// do nothing.
}
}

}

// for more visit:

// http://rpgstats.com/wiki/index.php?title=LlSetPrimitiveParams
// http://wiki.secondlife.com/wiki/LlSetPrimitiveParams
// http://lslwiki.net/lslwiki/wakka.php?wakka=llSetPrimitiveParams