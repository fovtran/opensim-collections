  1 //Follow Camera by Ariane Brodie
  2 
  3 //Dump it in any prim an attach it as a HUD;
  4 //touching once will start a dynamic camera that lags behind
  5 //touching again will go back to default
  6 
  7 //This is great for using older vehicles that lock the camera down
  8 
  9 
 10 key agent;
 11 integer permissions;
 12 
 13 default
 14 {
 15     state_entry()
 16     {
 17         agent=llGetOwner();
 18         llSetText("",<0,0,0>,0);
 19         llSetCameraParams([CAMERA_ACTIVE, 0]); // 1 is active, 0 is inactive
 20         llReleaseCamera(agent);
 21         llSetPrimitiveParams([
 22             PRIM_TEXTURE, ALL_SIDES, "05e736d6-fc50-cc61-ea97-51993ec47c24",
 23             <0.4,0.1,0>, <0.2,0.41,0>, 0.0]);
 24     }
 25 
 26     touch_start(integer total_number)
 27     {
 28         state follow_cam;
 29     }
 30 }
 31 
 32 state follow_cam
 33 {
 34     state_entry()
 35     {
 36         llRequestPermissions(llGetOwner(), PERMISSION_CONTROL_CAMERA);
 37         llSetPrimitiveParams([
 38             PRIM_TEXTURE, ALL_SIDES, "91a0e647-a69e-f13c-ed93-9bb84d7e790d",
 39             <0.4,0.1,0>, <0.2,0.41,0>, 0.0]);
 40     }
 41     
 42     touch_start(integer total_number)
 43     {
 44         if(permissions&PERMISSION_CONTROL_CAMERA) {
 45             llSetCameraParams([CAMERA_ACTIVE, FALSE]);
 46             state default;
 47         }
 48     }
 49 
 50     run_time_permissions(integer perm)
 51     {
 52         permissions = perm;
 53         if(PERMISSION_CONTROL_CAMERA) {
 54             llSetCameraParams([
 55                 CAMERA_ACTIVE, 1, // 1 is active, 0 is inactive
 56                 CAMERA_BEHINDNESS_ANGLE, 2.0, // (0 to 180) degrees
 57                 CAMERA_BEHINDNESS_LAG, 0.2, // (0 to 3) seconds
 58                 CAMERA_DISTANCE, 8.0, // ( 0.5 to 10) meters
 59                 //CAMERA_FOCUS, <0,0,5>, // region relative position
 60                 CAMERA_FOCUS_LAG, 0.02 , // (0 to 3) seconds
 61                 CAMERA_FOCUS_LOCKED, FALSE, // (TRUE or FALSE)
 62                 CAMERA_FOCUS_THRESHOLD, 0.0, // (0 to 4) meters
 63                 PITCH" title="View Definition"  class="tooltip">CAMERA_PITCH, 0.0, // (-45 to 80) degrees
 64                 //CAMERA_POSITION, <0,0,0>, // region relative position
 65                 CAMERA_POSITION_LAG, 0.15, // (0 to 3) seconds
 66                 CAMERA_POSITION_LOCKED, FALSE, // (TRUE or FALSE)
 67                 CAMERA_POSITION_THRESHOLD, 0.0, // (0 to 4) meters
 68                 CAMERA_FOCUS_OFFSET, <0,0,1> // <-10,-10,-10> to <10,10,10> meters
 69             ]);
 70         }
 71     }
 72 }
3_scripts_for_Fun_With_Dynamic_Came
A popular use for these cameras is to detach the camera from yourself, and see through nearby walls. The first scripts for these dynamic cameras allow you to steer your camera around, using arrow keys (forward, back, turn left, turn right) and page up/page down (up and down). I rewrote parts of the script to work like a HUD. Click blue to enable the camera, click red to return to default camera.
Category: Camera
By : Ariane Brodie
Created: 2010-01-10 Edited: 2014-02-15
Worlds: Second Life

  1 
  2 // ControlCam script, by Azurei Ash, feel free to use and distribute
  3 // To be used as a HUD attachment, touch to turn on, touch again to turn off
  4 // HUD toggle by Ariane Brodie
  5 // Rev 1.1 8-17-2013 Patched to compile by Ferd Frederix, un-initted owner vs llGetOwner()
  6 
  7 // Initial camera position relative to avatar
  8 // <1,0,.75> = 1 meter forward, 0 meters left, .75 meters up
  9 vector CAMOFFSET=<1,0,.75>;
 10 
 11 // camera is moved MOVERATE meters each control event for movement
 12 // used by these controls: forward, back, left, right, up, down
 13 // lower is slower/smoother, higher is faster/jumpier
 14 float MOVERATE=0.5;
 15 
 16 // camera is rotated SPINRATE degrees each control event for rotation
 17 // used by these controls: rotate left, rotate right
 18 // lower is slower/smoother, higher is faster/jumpier
 19 // also a good idea to have this number divide 360 evenly
 20 float SPINRATE=6.0;
 21 
 22 // The above MOVERATE/SPINRATE will be multiplied by their corresponding
 23 // LFACTOR while the left mouse button is held down
 24 // LFACTORM corresponds to MOVERATE
 25 // LFACTORS corresponds to SPINRATE
 26 float LFACTORM=0.5;
 27 float LFACTORS=0.5;
 28 
 29 // maximum distance the camera can move away from the user, currently (SL1.9) this is 50m
 30 float MAXDIST=50.0;
 31 
 32 // ==================== SCRIPTERS ONLY BELOW THIS POINT! ;) ==================== //
 33 
 34 integer permissions=FALSE;
 35 
 36 
 37 vector position;
 38 rotation facing;
 39 
 40 
 41 updateCamera()
 42 {
 43     vector focus=position+llRot2Fwd(facing);
 44     // The camera was turned on earlier, the position and focus also locked
 45     llSetCameraParams([
 46         CAMERA_FOCUS, focus, // region relative position
 47         CAMERA_POSITION, position // region relative position
 48     ]);
 49 }
 50 
 51 default
 52 {
 53 
 54     state_entry()
 55     {
 56         llSetPrimitiveParams([
 57             PRIM_TEXTURE, ALL_SIDES, "05e736d6-fc50-cc61-ea97-51993ec47c24",
 58             <0.4,0.1,0>, <0.2,0.41,0>, 0.0]);
 59         if(permissions&PERMISSION_CONTROL_CAMERA)
 60             llSetCameraParams([CAMERA_ACTIVE, FALSE]);
 61         llReleaseControls();
 62     }
 63     
 64     touch_start(integer n)
 65     {
 66         state cam_on;
 67     }
 68 }
 69     
 70 state cam_on
 71 {
 72     state_entry()
 73     {
 74         llSetPrimitiveParams([
 75             PRIM_TEXTURE, ALL_SIDES, "91a0e647-a69e-f13c-ed93-9bb84d7e790d",
 76             <0.4,0.1,0>, <0.2,0.41,0>, 0.0]);
 77         llRequestPermissions(llGetOwner(), PERMISSION_TAKE_CONTROLS|PERMISSION_CONTROL_CAMERA);
 78     }
 79     
 80     touch_start(integer n)
 81     {
 82         state default;
 83     }
 84 
 85     run_time_permissions(integer perm)
 86     {
 87         permissions=perm;
 88         if(permissions)
 89         {
 90             llClearCameraParams();
 91             // These camera parameters will be constant, so set them only once
 92             llSetCameraParams([
 93                 CAMERA_ACTIVE, 1, // 1 is active, 0 is inactive
 94                 CAMERA_FOCUS_LOCKED, TRUE, // (TRUE or FALSE)
 95                 CAMERA_POSITION_LOCKED, TRUE // (TRUE or FALSE)
 96             ]);
 97 
 98             // level out their rotation
 99             vector rot=llRot2Euler(llGetRot());
100             rot.x = rot.y = 0;
101             facing = llEuler2Rot(rot);
102 
103             // offset and update the camera position
104             position = llGetPos()+CAMOFFSET*facing;
105             updateCamera();
106             llTakeControls(CONTROL_LBUTTON|CONTROL_FWD|CONTROL_BACK|CONTROL_ROT_LEFT|CONTROL_ROT_RIGHT|CONTROL_UP|CONTROL_DOWN|CONTROL_LEFT|CONTROL_RIGHT, TRUE, FALSE);
107         }
108     }
109 
110     control(key id, integer held, integer change)
111     {
112         // adjust the LFACTORs in response to changes in LBUTTON
113         if(change&CONTROL_LBUTTON)
114         {
115             if(held&CONTROL_LBUTTON) // LBUTTON pressed
116             {
117                 MOVERATE *= LFACTORM;
118                 SPINRATE *= LFACTORS;
119             }
120             else // LBUTTON released
121             {
122                 MOVERATE /= LFACTORM;
123                 SPINRATE /= LFACTORS;
124             }
125         }
126 
127         // Only continue if some key is held, other than the left mouse button
128         // Mouselook will override the scripted camera, so don't move the camera if in mouselook
129         if((held&~CONTROL_LBUTTON) && !(llGetAgentInfo(llGetOwner())&AGENT_MOUSELOOK))
130         {
131             // Temporary position used, updated position may be out of range
132             vector pos=position;
133     
134             // react to any held controls
135             if(held&CONTROL_ROT_LEFT)
136             {
137                 facing *= llAxisAngle2Rot(<0,0,1>, SPINRATE*DEG_TO_RAD);
138             }
139             if(held&CONTROL_ROT_RIGHT)
140             {
141                 facing *= llAxisAngle2Rot(<0,0,1>, -SPINRATE*DEG_TO_RAD);
142             }
143             if(held&CONTROL_FWD)
144             {
145                 pos += MOVERATE*llRot2Fwd(facing);
146             }
147             if(held&CONTROL_BACK)
148             {
149                 pos -= MOVERATE*llRot2Fwd(facing);
150             }
151             if(held&CONTROL_UP)
152             {
153                 pos += MOVERATE*llRot2Up(facing);
154             }
155             if(held&CONTROL_DOWN)
156             {
157                 pos -= MOVERATE*llRot2Up(facing);
158             }
159             if(held&CONTROL_LEFT)
160             {
161                 pos += MOVERATE*llRot2Left(facing);
162             }
163             if(held&CONTROL_RIGHT)
164             {
165                 pos -= MOVERATE*llRot2Left(facing);
166             }
167     
168             // only update position with the new one if it is in range
169             if(llVecDist(pos, llGetPos()) <= MAXDIST)
170                 position = pos;
171     
172             updateCamera();
173         }
174     }
175 }
3_scripts_for_Fun_With_Dynamic_Came
Now one of the things I like to do in SL is hang out in clubs and go to parties, and I like to see who is all there and put faces with names. So here is a script to "scan the room" at parties and point the camera directly at the closest 16 people in the room. Just create a prim, put this script in it, and attach it as a HUD. Click to start the room scan, click again to pause. Once it is done scanning, it will return to default.
Category: Camera
By : Ariane Brodie
Created: 2010-01-10 Edited: 2014-02-15
Worlds: Second Life

  1 //scan the room script by Ariane Brodie
  2 
  3 //Dump it in any prim an attach it as a HUD;
  4 //touching once will start a scan of the surrounding areas and 
  5 //point the camera at each person in the room
  6 //touch to pause the scan, touch again to continue.
  7 //when the tour is done, the camera will return to default
  8 
  9 key agent;
 10 vector pos; 
 11 vector rotz;
 12 integer permissions;
 13 list whoishere;
 14 
 15 default
 16 {
 17     state_entry()
 18     {
 19         agent=llGetOwner();
 20         llSetText("",<0,0,0>,0);
 21         whoishere = [];
 22         llSetCameraParams([CAMERA_ACTIVE, 0]); // 1 is active, 0 is inactive
 23         llReleaseCamera(agent);
 24     }
 25 
 26     touch_start(integer total_number)
 27     {
 28         state cam_on;
 29     }
 30 }
 31 
 32 state cam_on
 33 {
 34     state_entry()
 35     {
 36         llSensorRepeat("","",AGENT, 90, PI,5);
 37     }
 38     
 39     touch_start(integer total_number)
 40     {
 41         llSensorRemove();
 42         state pause;
 43     }
 44 
 45     sensor(integer n) 
 46     { 
 47         integer i; 
 48         integer j;
 49         rotation rot;
 50         list temp;
 51         string iSee = "";
 52         string newpeople = "";
 53         integer FoundOne = FALSE;
 54         for(i=0;(i<n && FoundOne == FALSE);i++)
 55         { 
 56             if(llDetectedKey(i) != llGetOwner())
 57             {
 58                 pos = llDetectedPos(i); 
 59                 rot = llDetectedRot(i);
 60                 rotz = llRot2Fwd(rot);
 61                     rotz.x = rotz.x * 2;
 62                     rotz.y = rotz.y * 2;
 63                     rotz.z = 1;
 64                 iSee = llDetectedName(i);
 65                 temp = llParseString2List(iSee,[],[]);
 66                 j = llListFindList(whoishere,temp);
 67                 if(j < 0) {
 68                     whoishere = llListInsertList(temp,whoishere,0);
 69                     FoundOne = TRUE;
 70                 }
 71                 else {
 72                     iSee = "";
 73                 }
 74             } 
 75         }
 76         if(iSee != "") {
 77             llOwnerSay(iSee);
 78             llSetText(iSee,<1,1,1>,1.0);
 79             llRequestPermissions(llGetOwner(), PERMISSION_CONTROL_CAMERA);
 80         }
 81         else {
 82             llOwnerSay("no more found");
 83             llSetText("",<1,1,1>,1.0);
 84             state default;
 85         }
 86     }
 87     
 88     no_sensor()
 89     {
 90         llOwnerSay("none found");
 91         llSetText("",<1,1,1>,1.0);
 92         state default;
 93     }
 94     
 95     run_time_permissions(integer perm) {
 96         permissions = perm;
 97         if((perm & PERMISSION_CONTROL_CAMERA) == PERMISSION_CONTROL_CAMERA) {
 98         llSetCameraParams([
 99         CAMERA_ACTIVE, 1, // 1 is active, 0 is inactive
100         CAMERA_BEHINDNESS_ANGLE, 0.0, // (0 to 180) degrees
101         CAMERA_BEHINDNESS_LAG, 0.0, // (0 to 3) seconds
102         CAMERA_DISTANCE, 0.0, // ( 0.5 to 10) meters
103         CAMERA_FOCUS, pos, // region relative position
104         CAMERA_FOCUS_LAG, 0.0 , // (0 to 3) seconds
105         CAMERA_FOCUS_LOCKED, TRUE, // (TRUE or FALSE)
106         CAMERA_FOCUS_THRESHOLD, 0.0, // (0 to 4) meters
107 //        PITCH" title="View Definition"  class="tooltip">CAMERA_PITCH, 80.0, // (-45 to 80) degrees
108         CAMERA_POSITION, pos + rotz, // region relative position
109         CAMERA_POSITION_LAG, 0.0, // (0 to 3) seconds
110         CAMERA_POSITION_LOCKED, TRUE, // (TRUE or FALSE)
111         CAMERA_POSITION_THRESHOLD, 0.0, // (0 to 4) meters
112         CAMERA_FOCUS_OFFSET, ZERO_VECTOR // <-10,-10,-10> to <10,10,10> meters
113 
114         ]);
115         }
116     }
117 }
118 
119 
120 state pause
121 {
122     touch_start(integer total_number)
123     {
124         state cam_on;
125     }
126 }