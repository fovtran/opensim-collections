// Space builder
  2 //
  3 // 2007 Copyright by Shine Renoir (fb@frank-buss.de)
  4 // Use it for whatever you want, but keep this copyright notice
  5 // and credit my name in notecards etc., if you use it in
  6 // closed source objects
  7 //
  8 default
  9 {
 10     state_entry()
 11     {
 12         llSitTarget(<0, 0, 0.5>, ZERO_ROTATION);
 13     }
 14 
 15     changed(integer change)
 16     {
 17         // if someone sits down
 18         if(change & CHANGED_LINK) {
 19             key av = llAvatarOnSitTarget();
 20             if(av) {
 21                 vector start = llGetPos();
 22                 llOwnerSay("space lift engaged, destination: 2,000 m");
 23                 llSetBuoyancy(2.0);
 24                 llSetStatus(STATUS_PHYSICS, TRUE);
 25                 vector pos = llGetPos();
 26                 while(pos.z < 2000.0) {
 27                     pos = llGetPos();
 28                 }
 29                 llSetStatus(STATUS_PHYSICS, FALSE);
 30                 pos = llGetPos();
 31                 llRezObject("Sky Platform", pos, ZERO_VECTOR, ZERO_ROTATION, 0);
 32                 llSleep(0.1);
 33                 llUnSit(av);
 34                 llDie();
 35                 float delta = 1.0;
 36                 while(delta > 0.1) {
 37                     llSetPos(start);
 38                     pos = llGetPos();
 39                     delta = pos.z - start.z;
 40                 }
 41             }
 42         }
 43     }
 44 }
Hi_riseelevator_script
For moving up to the platform, you could use a space elevator. Move it along the x-axis beside the platform on ground. On sit up it pushs you a bit, which moves you on the platform.
Category: Building
By : Shine Renoir
Created: 2010-01-10 Edited: 2010-01-10
Worlds: Second Life

  1 // Space elevator
  2 //
  3 // 2007 Copyright by Shine Renoir (fb@frank-buss.de)
  4 // Use it for whatever you want, but keep this copyright notice
  5 // and credit my name in notecards etc., if you use it in
  6 // closed source objects
  7 
  8 // direction and power to push after sit up
  9 vector push = <50.0, 0.0, 0.0>;
 10 
 11 // target height
 12 float height = 2005.0;
 13 
 14 default
 15 {
 16     state_entry()
 17     {
 18         llSitTarget(<0, 0, 0.5>, ZERO_ROTATION);
 19     }
 20 
 21     changed(integer change)
 22     {
 23         // if someone sits down
 24         if(change & CHANGED_LINK) {
 25             key av = llAvatarOnSitTarget();
 26             if(av) {
 27                 vector start = llGetPos();
 28                 llOwnerSay("space lift engaged, destination: 2,000 m");
 29                 llSetBuoyancy(2.0);
 30                 llSetStatus(STATUS_PHYSICS, TRUE);
 31                 vector pos = llGetPos();
 32                 while(pos.z < height) {
 33                     pos = llGetPos();
 34                 }
 35                 llSetStatus(STATUS_PHYSICS, FALSE);
 36                 pos = llGetPos();
 37                 llSleep(0.1);
 38                 llUnSit(av);
 39                 llPushObject(av, push, ZERO_VECTOR, FALSE);
 40                 float delta = 1.0;
 41                 while(delta > 0.1) {
 42                     llSetPos(start);
 43                     pos = llGetPos();
 44                     delta = pos.z - start.z;
 45                 }
 46             }
 47         }
 48     }
 49 }