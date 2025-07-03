// TouchST Map List Builder - v1.0
// Author: Warin Cascabel
//
// Drop the script into a prim, give it a command to start recording, then click pairs of points on the prim to define areas
// (e.g. the edges of buttons on a texture mapped on the face). Give it another command to stop recording, and it will spit
// out a line of code which can be used to detect which button was pressed (see TouchST Map List Example script for how to
// do that).

integer CommChannel = 10; // Accepts commands on channel 10. Change that if you prefer a different channel, but please,
                          // not channel 0. Nobody wants to hear you talking to inanimate objects. Seriously.


// Internal variables; do not modify.
//
integer begun = 0;
integer point1 = 0;
vector FirstPoint;
list PointList = [];

// Usage() provides some simple help text.
//
Usage()
{
    llOwnerSay( "Type \"/" + (string) CommChannel + " start\" to begin, \"/" + (string) CommChannel + " end\" when done." );
}

default
{
    state_entry()
    {
        llListen( CommChannel, "", llGetOwner(), "" );  // Listen for chat from our owner, on the above-defined channel.
        Usage();
    }
    
    touch_start( integer foo )
    {
        if (llDetectedKey( 0 ) != llGetOwner()) return; // Only respond to touches from our owner.
        if (!begun) {                                   // If we haven't begun recording yet,
            Usage();                                    //    tell our owner how to use us
            return;                                     //    and quit
        }
        if (point1)                                     // If we already have the starting point in memory
        {
            vector SecondPoint = llDetectedTouchST( 0 );//    get the position of the second point
            float f;
            if (FirstPoint.x > SecondPoint.x)           //    Make sure the first x coordinate is less than the second
            {                                           //    If not, swap them.
                f = FirstPoint.x;
                FirstPoint.x = SecondPoint.x;
                SecondPoint.x = f;
            }
            if (FirstPoint.y > SecondPoint.y)           //    Make sure the first y coordinate is less than the second
            {                                           //    If not, swap them.
                f = FirstPoint.y;
                FirstPoint.y = SecondPoint.y;
                SecondPoint.y = f;
            }
            PointList += [ FirstPoint, SecondPoint ];   //    Add these points to our list
            point1 = 0;                                 //    Clear out the point1 flag
            llOwnerSay( "Click the next starting point, or type \"/" + (string) CommChannel + " end\" to finish." );
        }
        else                                            // This is the first point of the pair
        {
            FirstPoint = llDetectedTouchST( 0 );        // Get its coordinate
            point1 = 1;                                 // Set the point1 flag
            llOwnerSay( "Click the ending point, type \"/" + (string) CommChannel + " undo\" to undo the starting point, or type \"/" + (string) CommChannel + " end\" to abort this square and finish." );
        }
    }
    
    listen( integer channel, string who, key id, string message )
    {
        if (id != llGetOwner()) return;                 // Ignore any chat apart from our owners
        message = llToLower( message );                 // Convert the message to all lowercase
        if (message == "start")                         // start recording
        {
            begun = 1;                                  // set the begun flag
            PointList = [];                             // clear out the point list
            llOwnerSay( "Click the first starting point." );  // provide some help text
        }
        else if (message == "end")                      // stop recording
        {
            llOwnerSay( "\nlist ButtonCoords = [ " + llList2CSV( PointList ) + " ];" ); // Set our output string
            begun = 0;                                  // clear the begun flag
        }
        else if (message == "undo")                     // undo the starting point
        {
            point1 = 0;                                 // clear the point1 flag
            llOwnerSay( "Box canceled." );              // Provide feedback
        }
    }
}