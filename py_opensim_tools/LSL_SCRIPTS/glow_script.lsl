//// "Glow" EFFECT TEMPLATE v1 - by Jopsy Pendragon - 4/8/2008
//// You are free to use this script as you please, so long as you include this line:
//** The original 'free' version of this script came from THE PARTICLE LABORATORY. **//

// SETUP:  Drop one optional particle texture and this script into a prim.
// Particles should start automatically. (Reset) the script if you insert a
// particle texture later on.  Add one or more CONTROLLER TEMPLATES to any
// prims in the linked object to control when particles turn ON and OFF.

// Rotate the prim to direction of spray.

// Customize the particle_parameter values below to create your unique 
// particle effect and click SAVE.  Values are explained along with their
// min/max and default values further down in this script.

// PURPOSE:  This script will start a client side "spin" effect on any prim it's
// added to.  (the whole object will spin if added to root prim).
// This is an 'illusionary' effect, not a physical one.

// !!! NOTE !!! -->  This is not a PARTICLE effect!  This sets GLOW on the faces of a prim! =)
// Setting GLOW on a prim is a very new LSL feature.  This script may become obsolete
// if there are changes in LSL to how GLOW is set.


integer side = ALL_SIDES; // replace with a digit to affect one side of the prim.
float intensity = 0.50; // 0.00(no-glow) to 1.00(max)

string  CONTROLLER_ID = "A"; // See comments at end regarding CONTROLLERS.
integer AUTO_START = FALSE;   // Optionally FALSE only if using CONTROLLERS.


default {
    state_entry() {
        
        if ( AUTO_START ) llSetPrimitiveParams( [25, ALL_SIDES, 0.0 ]);  
        
    }
    
    link_message( integer sibling, integer num, string mesg, key target_key ) {
        if ( mesg != CONTROLLER_ID ) { // this message isn't for me.  Bail out.
            return;
        } else if ( num == 0 ) { // Message says to turn particles OFF:
            
            llSetPrimitiveParams( [PRIM_GLOW, side, 0.0 ]);  
            
        } else if ( num == 1 ) { // Message says to turn particles ON:
            
            llSetPrimitiveParams( [PRIM_GLOW, side, intensity ]);  
        
        } else { // bad instruction number
            // do nothing.
        }            
    }
        
}

// for more on setting prim attributes, visit:

// http://rpgstats.com/wiki/index.php?title=LlSetPrimitiveParams
// http://wiki.secondlife.com/wiki/LlSetPrimitiveParams
// http://lslwiki.net/lslwiki/wakka.php?wakka=llSetPrimitiveParams