// One-prim Plaza Teleport System
// Author: Warin Cascabel
//
// NOTE: This script requires osTeleportAgent() to be enabled in OpenSim.ini. If you do not want to enable
// that function, comment out the osTeleportAgent() line, and uncomment the llMapDestination() line.
//
list ButtonCoords = [ <0.040404,0.572013,0.000000>, <0.445333,0.714434,0.000000>, <0.040740,0.324040,0.000000>, <0.445979,0.468508,0.000000>,
                               <0.040887,0.079658,0.000000>, <0.446032,0.222644,0.000000>, <0.548612,0.572047,0.000000>, <0.952732,0.714478,0.000000>,
                               <0.548699,0.324969,0.000000>, <0.953914,0.468322,0.000000>, <0.549857,0.079893,0.000000>, <0.953868,0.223173,0.000000> ];
list RegionNames = [ "Bade Plaza", "Lbsa Plaza", "SeaPrior Plaza", "Teravus Plaza", "Wright Plaza", "Zaius Plaza" ];
list LandingSpots = [ <92.0,115.0,41.0>, <127.0,128.0,22.0>, <69.0,202.0,21.0>, <113.0,126.0,35.0>, <128.0,126.0,22.0>, <127.0,127.0,22.0> ];
list LookAts = [ <1.0,0.0,0.0>, <1.0,0.0,0.0>, <1.0,0.0,0.0>, <1.0,0.0,0.0>, <1.0,0.0,0.0>, <1.0,0.0,0.0> ];

integer FindTouchedRegion( vector v )
{
    integer j = llGetListLength( ButtonCoords );
    integer i;
    for (i = 0; i < j; i += 2)
    {
        vector llc = llList2Vector( ButtonCoords, i );
        vector urc = llList2Vector( ButtonCoords, i+1 );
        if ((v.x >= llc.x) && (v.x <= urc.x) && (v.y >= llc.y) && (v.y <= urc.y))
            return i >> 1;
    }
    return -1;
}


default
{
    state_entry()
    {
        llOwnerSay( "Online" );
    }
    
    touch_start(integer num_detected)
    {
        while (num_detected--)
        {
            if (llDetectedTouchFace( num_detected ) == 4) // only detect touches on the front face
            {
                vector v = llDetectedTouchST( num_detected );  // Get the point where the user touched
                integer WhichButton = FindTouchedRegion( llDetectedTouchST( num_detected )); // which button was it?
                if (WhichButton > -1)
                {
                    string DestinationName = llList2String( RegionNames, WhichButton ); // Get the region name
                    vector DestinationPos = llList2Vector( LandingSpots, WhichButton ); // Get the landing spot
                    vector DestinationLook = llList2Vector( LookAts, WhichButton );     // Get the lookat vector
                    key AgentToTeleport = llDetectedKey( num_detected );
//                    llMapDestination( DestinationName, DestinationPos, DestinationLook );  // use this if osTeleportAgent() is not enabled
                    osTeleportAgent( AgentToTeleport, DestinationName, DestinationPos, DestinationLook );
                }
            }
        }
    }
}