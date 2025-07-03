
  2 // butterflap
  3 
  4 default
  5 { 
  6     on_rez(integer startparam)
  7     {
  8         integer color = startparam & 0xf;
  9         
 10         string aname  = "wing" + (string) color;
 11         string abody  = "body" + (string) color;
 12         llSetTexture(aname,ALL_SIDES);
 13          llMessageLinked(LINK_SET,0,abody,"");
 14         //llSetLinkPrimitiveParams( 2,[ PRIM_TEXTURE, ALL_SIDES, abody, <1,1,0>,<0,0,0>, 0 ]  );  
 15     }
 16 }
Butterflies
Butterflies
Category: Butterflies
By : Ferd Frederix
Created: 2013-09-06 Edited: 2013-09-04
Worlds: Second Life


This script by Ferd Frederix may be used in any manner, modified, and republished.  Unless specified otherwise, my scripts are always free and open source.  Objects made with these scripts may be sold with no restrictions.  All I ask is that you point others to this location should they ask you about it and to not sell this script, unless it is for $0 L. Please help improve my work by reporting bugs and improvements.

  1 
  2 // color change
  3 
  4 integer count = 0;
  5 
  6 default
  7 {
  8     touch_start(integer total_number)
  9     {
 10         string aname  = "wing" + (string) count;
 11         string abody  = "body" + (string) count;
 12         llSetTexture(aname,ALL_SIDES);
 13         llMessageLinked(LINK_SET,0,abody,"");
 14         count++;
 15         if(count >9)
 16             count = 0;
 17     }
 18 }
Butterflies
Butterflies
Category: Butterflies
By : Ferd Frederix
Created: 2013-09-06 Edited: 2013-09-04
Worlds: Second Life


This script by Ferd Frederix may be used in any manner, modified, and republished.  Unless specified otherwise, my scripts are always free and open source.  Objects made with these scripts may be sold with no restrictions.  All I ask is that you point others to this location should they ask you about it and to not sell this script, unless it is for $0 L. Please help improve my work by reporting bugs and improvements.

  1 
  2 // flight
  3 
  4 ////////////////////////////////////////////
  5 // Follow Me Script segment
  6 //
  7 // Written by Ferd Frederix
  8 ///////////////////////////////////////// ///
  9 float RADIUS = 2.0;
 10 
 11 /////////////// CONSTANTS ///////////////////
 12 string  FWD_DIRECTION   = "-x";
 13 
 14 vector START;
 15 float distance = 5;
 16 float   MOVEfTO_INCREMENT    = 1;
 17 float timerval  = .5;
 18 
 19 float   gTau = .2;   // move
 20 float rTau = 1;   // rotation
 21 vector Pos; 
 22 integer height = 1;
 23 /////////// END GLOBAL VARIABLES /////////////
 24 
 25 
 26 NewPos()
 27 {   
 28     Pos.x  = START.x + llFrand(distance*2)- distance;
 29     Pos.y  = START.y + llFrand(distance*2)- distance;
 30     Pos.z  = START.z + llFrand(height); 
 31 }
 32 
 33 default 
 34 {
 35     state_entry() 
 36     {
 37         llSetStatus(STATUS_PHYSICS, FALSE);
 38         llCollisionSound("",0.0);
 39     }
 40     
 41                     
 42     on_rez(integer startparam)
 43     {   
 44         llStopMoveToTarget();
 45         distance = (startparam >> 4) & 0xff;
 46         height = (startparam >> 16) & 0xff;
 47         
 48         llSetStatus(STATUS_PHYSICS, TRUE);
 49         
 50         START = llGetPos();
 51         Pos = START;
 52     
 53         NewPos();    
 54         llSetTimerEvent(timerval);
 55     }
 56     
 57     timer() 
 58     {   
 59         vector up = llRot2Up(  llGetRot() );
 60         llLookAt(Pos, gTau * 5.0, gTau);
 61         if(llVecDist(llGetPos(),Pos) < 0.5)
 62             NewPos();
 63         
 64         vector Dest = llGetPos() + llVecNorm(Pos - llGetPos()) * (llFrand(0.5) + .2);
 65         llMoveToTarget(Dest, gTau);
 66     }
 67 }
Butterflies
Butterflies
Category: Butterflies
By : Ferd Frederix
Created: 2013-09-06 Edited: 2013-09-04
Worlds: Second Life


This script by Ferd Frederix may be used in any manner, modified, and republished.  Unless specified otherwise, my scripts are always free and open source.  Objects made with these scripts may be sold with no restrictions.  All I ask is that you point others to this location should they ask you about it and to not sell this script, unless it is for $0 L. Please help improve my work by reporting bugs and improvements.

  1 
  2 // rezzer & controller
  3 
  4 integer startup = 0x050;    // 10 meters, color 0
  5 integer counter = 0;
  6 integer selected = 0;
  7 float range = 20;           // sensor range
  8 integer distance = 5;       // roaming range
  9 integer timetick = 5;
 10 integer listener;
 11 integer wanted;
 12 integer asensor = FALSE;
 13 integer on_off;
 14 integer bcolor = 0;
 15 integer color = -1; // =1 = all
 16 integer height = 1;
 17 
 18 Rez()
 19 {
 20     if(color == -1)
 21     {
 22         bcolor++;
 23         if(bcolor > 9)
 24             bcolor = 0;
 25     }
 26     else
 27         bcolor = color;
 28         
 29     startup = (height << 16) + (distance << 4) + bcolor;
 30     
 31     //llOwnerSay("Distance:" + (string) distance);
 32     //llOwnerSay("Color:" + (string) color);
 33     
 34     llRezObject(llGetInventoryName(INVENTORY_OBJECT,0), llGetPos() + <0.0,0.0,0.5>, <0.0,0.0,0.0>, <0.0,0.0,0.0,1.0>, startup);
 35 }
 36 
 37 MakeMenu()
 38 {
 39     integer channel = llCeil(llFrand(1000) + 9000);
 40     string msg = "Select an item:\nOn|Off - enable or disable\nSensor = Only run when Avatars are in range\nDistance  - Set roaming and range\nMore - Increase the number of butterflies\nLess - decrease the number of butterflies\nColor - pick a color\nHeight - How hi they fly";
 41     list menu = ["Off","Sensor Off","Less","On","Sensor On","More","Distance","Color","Height"];
 42     listener = llListen(channel,"","","");
 43     llDialog(llGetOwner(),msg,menu,channel);
 44     
 45 }
 46 
 47  
 48 MenuDistance(string msg)
 49 {
 50     integer channel = llCeil(llFrand(1000) + 9000);
 51     list menu = ["1","5","10","15","20","25","30","45","96"];
 52     listener = llListen(channel,"","","");
 53     llDialog(llGetOwner(),msg,menu,channel);
 54 }
 55 
 56 MenuColor(string msg)
 57 {
 58     integer channel = llCeil(llFrand(1000) + 9000);
 59     list menu = ["0","1","2","3","4","5","6","7","8","9","All"];
 60     listener = llListen(channel,"","","");
 61     llDialog(llGetOwner(),msg,menu,channel);
 62 }
 63 
 64 MenuHeight(string msg)
 65 {
 66     integer channel = llCeil(llFrand(1000) + 9000);
 67     list menu = ["0","1","2","3","4","5","6","7","8","9","10","15"];
 68     listener = llListen(channel,"","","");
 69     llDialog(llGetOwner(),msg,menu,channel);
 70 }
 71 
 72 default
 73 {
 74     
 75     listen(integer channel,string name,key id, string msg)
 76     {
 77         
 78         llListenRemove(listener);
 79         if(msg == "On")
 80         {
 81             llSetTimerEvent(1.0);
 82             on_off= TRUE;
 83             llSetAlpha(0,ALL_SIDES);
 84         }
 85         else if(msg == "Off")
 86         {
 87             llSetTimerEvent(0);
 88             on_off= FALSE;
 89             llSensorRemove();
 90             llOwnerSay("Butterflies are stopped");
 91             llSetAlpha(1,ALL_SIDES);
 92         }
 93         else if(msg == "Sensor On")
 94         {
 95             llSetTimerEvent(0);
 96             wanted = 1;
 97             MenuDistance("Pick how far to detect avatars");            
 98         }
 99         else if(msg == "Sensor Off")
100         {
101             MakeMenu();
102             llSensorRemove();
103             llOwnerSay("Butterflies are stopped");
104             asensor = FALSE;
105             llSetAlpha(1,ALL_SIDES);
106         }
107         else if(msg == "Distance")
108         {
109             wanted = 2;
110             MenuDistance("Pick the distance that the butterflies will roam");
111         }
112         else if(msg == "Color")
113         {
114             wanted = 3;
115             MenuColor("Pick a color number");
116         }
117         else if(msg == "Height")
118         {
119             wanted = 4;
120             MenuHeight("Pick a maximum height for flight");
121         }
122         else if(msg == "More")
123         {
124             timetick -=1;
125             if(timetick <= 0)
126                 timetick = 1; 
127             integer count = llCeil(60/timetick);
128             llOwnerSay((string) count + " butterflies");;
129             MakeMenu();
130         }
131         else if(msg == "Less")
132         {
133             timetick +=1;
134             integer count = (integer) (60/timetick);
135             llOwnerSay((string) count + " butterflies");
136             MakeMenu();
137         }
138         else
139         {
140             if(wanted == 4 )
141             {
142                 height = (integer) msg;
143                 llOwnerSay("Butterfly height is " + (string) height+ " meters");
144                 MakeMenu();
145             }
146             if(wanted == 3 )
147             {
148                 if(msg == "All")
149                 {
150                     color = -1;
151                     llOwnerSay("Butterfly color is is all colors");
152                 }
153                 else
154                 {
155                     color = (integer) msg;
156                     llOwnerSay("Butterfly color is is " + (string) color );
157                 }
158                 
159                 MakeMenu();
160             }
161             if(wanted == 2 )
162             {
163                 distance = (integer) msg;
164                 llOwnerSay("Butterfly roaming range is " + (string) distance + " meters");
165                 integer count = (integer) (60/timetick);
166                 MakeMenu();
167             }
168             else if(wanted == 1 )
169             {
170                 range = (integer) msg;
171                 llOwnerSay("Avatar detection range is " + (string) range + " meters");
172                 asensor = TRUE;
173                 llSensorRepeat("","",AGENT,range,PI,timetick);
174                 llOwnerSay("Butterflies should appear every " + (string) timetick + " seconds");
175                 integer count = (integer) (60/timetick);
176                 MakeMenu();
177                 llSetAlpha(0,ALL_SIDES);
178             }
179         }
180         
181         
182         
183     }
184     
185     state_entry()
186     {
187         MakeMenu();
188         llSetAlpha(1,ALL_SIDES);
189     }
190 
191     touch_start(integer total_number)
192     {
193         if(llDetectedKey(0) != llGetOwner())
194         {
195             return;
196         }
197         if(asensor)
198         {
199             llOwnerSay("Avatar detection range is " + (string) range + " meters");    
200         }
201         if(on_off)
202         {
203             llOwnerSay("Butterflies are on" );        
204         }
205         else
206         {
207             llOwnerSay("Butterflies are off" );        
208         }
209         
210         llOwnerSay("Butterfly roaming range is " + (string) distance + " meters");
211         integer count = (integer) (60/timetick);
212         llOwnerSay("About " + (string) count + " butterflies a minute");
213         if(llDetectedKey(0) == llGetOwner())
214             MakeMenu();
215     }
216     
217     
218     timer()
219     {
220         llSetTimerEvent(timetick);
221         Rez();
222     }
223     
224     sensor(integer num_detected)
225     {
226         Rez();
227     }
228     
229     on_rez(integer startparam)
230     {
231         llResetScript();
232     }
233 }