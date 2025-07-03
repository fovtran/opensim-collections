// Bezier Curve Demo 1.0.1
  2 // Catherine Omega Heavy Industries
  3 // Modified by Lionel Forager 29-12-2006: Added segment drawing between points. Corrected minor bugs.
  4 
  5 key gOwner; // object owner
  6 
  7 float diam=0.05; //diameter of line segments.
  8 
  9 list gPoints; // list of vectors to feed to bezier3
 10 string gObject="Point Mark"; // name of object to rez as the mark in each point
 11 string gSegment="Segment"; // name of object to rez as the mark in each point
 12 
 13 integer gNumSegments = 10; // number of segments to rez
 14 integer gMarks= TRUE; //Draw marks in the point positions.
 15 integer gLines= FALSE; //Don't draw segments between points.
 16 
 17 float gMu;
 18 vector gPos1;
 19 vector gPos2;
 20 vector gPos3;
 21 
 22 //codes a line number and a segment in a unique ID integer
 23 integer codeID(integer line, integer segment)
 24 {
 25     //Code de id: line# in 16 most significant bits, segment# in 16 less significant bits
 26     return ( (line << 16) + segment);
 27 }
 28 //Rezz a segment between 2 given points and assigning it to a line # and a segment #
 29 drawLineSegment(vector p1,vector p2,integer line,integer seg)
 30 {
 31     //Calc the position of the center of the segment
 32     vector center= (p1+p2)/2.;
 33     vector localZ= p2 - p1;
 34     //Get distance between points
 35     float distance= llVecMag(localZ);
 36     //Normalize the vector
 37     localZ= localZ / distance;
 38 
 39     vector xAxis;
 40     //Let's choose as x local axis the direction of a vector normal to localZ and
 41     //contained in the plain given by localZ and global X or global Y, the one that is less parallel to localZ
 42     if( localZ.x < localZ.y ) xAxis= <1.,0.,0.>;
 43     else xAxis= <0.,1.,0.>;
 44     //localX is the one contain in the plane given by localZ and xAxis that is normal to localZ.
 45     //that's it localX= xAxis - localZ*xaxis*localZ. We should normalize the vector to get a unitary one.
 46     vector localX= xAxis - (localZ * xAxis) * localZ;
 47     localX= llVecNorm(localX);
 48     //Now get the rotation to put axis Z oriented pointing to the direction between the two given points.
 49     rotation rot= llAxes2Rot(localX,localZ % localX, localZ);    
 50     //Crear el objeto en la posici?n del server.
 51     llRezObject(gSegment,center,ZERO_VECTOR,rot,codeID(line,seg));
 52     llSay(line,"segInit "+(string)seg+","+(string)diam+"," + (string)distance);
 53 
 54 }
 55 //Three control point Bezier interpolation
 56 //mu ranges from 0 to 1, start to end of the curve
 57 vector bezier3(vector p1, vector p2, vector p3, float mu)
 58 {
 59    float mum1;
 60    float mum12;
 61 
 62    float mu2;
 63    vector p;
 64 
 65    mu2 = mu * mu;
 66    mum1 = 1 - mu;
 67    mum12 = mum1 * mum1;
 68    
 69    // p= (1-mu)^2 p1 + 2*mu*(1-mu)*p2 + mu^2 * p3
 70    p.x = p1.x * mum12 + 2. * p2.x * mum1 * mu + p3.x * mu2;
 71    p.y = p1.y * mum12 + 2. * p2.y * mum1 * mu + p3.y * mu2;
 72    p.z = p1.z * mum12 + 2. * p2.z * mum1 * mu + p3.z * mu2;
 73 
 74    return(p);
 75 }
 76 
 77 start(integer segments)
 78 {
 79      if(gPos1 != ZERO_VECTOR && gPos2 != ZERO_VECTOR && gPos3 != ZERO_VECTOR)
 80     {
 81         gNumSegments = segments;
 82         float increment = 1.0 / gNumSegments;
 83         
 84         float current_mu;
 85         
 86         integer i;
 87         vector oldPos= gPos1;
 88         vector pos;
 89 
 90         //Render the mark at the position of the first point
 91         if( gMarks ) llRezObject(gObject,gPos1,ZERO_VECTOR,ZERO_ROTATION,0);
 92 
 93         for (i = 1; i <= gNumSegments; i++)
 94         {
 95             current_mu= i * increment;
 96             pos = bezier3(gPos1,gPos2,gPos3,current_mu);
 97             if(gMarks) llRezObject(gObject,pos,ZERO_VECTOR,ZERO_ROTATION,0);
 98             if( gLines ) drawLineSegment(oldPos,pos,1,i);
 99             oldPos= pos;
100         }
101     }
102 }
103 
104 updateText()
105 {
106     vector color = <1,0,0>;
107     if(gPos1 != ZERO_VECTOR && gPos2 != ZERO_VECTOR && gPos3 != ZERO_VECTOR)
108     {
109         color = <0,1,0>;
110     }
111     
112     string output = (string)gPos1 + "\n" + (string)gPos2  + "\n" + (string)gPos3;
113     llSetText(output, color, 1.0);
114 }
115 
116 // get gCommand and gSubCommand (now improved to handle null gSubCommands.)
117 string gCommand;
118 string gSubCommand;
119 
120 string gCommandLower;
121 string gSubCommandLower;
122 
123 parseCommands(string input, string divider)
124 {
125     integer command_divide = llSubStringIndex(input,divider);
126     if(command_divide == -1)
127     {
128         gCommand = llGetSubString(input, 0, command_divide);
129         gSubCommand = "";
130     }
131     else
132     {
133         gCommand = llGetSubString(input, 0, command_divide - 1);
134         gSubCommand = llGetSubString(input, command_divide + 1, llStringLength(input));
135     }
136     
137     gCommandLower = llToLower(gCommand);
138     gSubCommandLower = llToLower(gSubCommand);
139 }
140 
141 default
142 {
143     state_entry()
144     {
145         gOwner = llGetOwner();
146         //gObject = llGetInventoryName(INVENTORY_OBJECT,0);
147         
148         updateText();
149         
150         llListen(1,"","","");
151         llSay(0,"Online.");
152     }
153     
154     listen(integer channel, string name, key id, string m)
155     {
156         if(llGetOwnerKey(id) == gOwner)
157         {
158             if(id == gOwner)
159             {
160                 parseCommands(m," ");
161                 
162                 if(gCommandLower == "mu")
163                 {
164                     vector pos = bezier3(gPos1,gPos2,gPos3,(float)gSubCommand);
165                     llRezObject(gObject,pos,ZERO_VECTOR,ZERO_ROTATION,0);
166                 }
167                 
168                 else if(gCommandLower == "start")
169                 {
170                     start((integer)gSubCommand);
171                     
172                     llSay(0,"Done.");
173                 }
174                 
175                 else if(gCommandLower == "segments")
176                 {
177                     gNumSegments = (integer)gSubCommand;
178                 }
179                 else if(gCommandLower == "markers")
180                 {
181                     if( gSubCommand != "off" ) {
182                         gMarks= TRUE;
183                         llSay(0,"Markers on");
184                     }
185                     else {
186                         gMarks=FALSE;
187                         llSay(0,"Markers off");
188                     }
189 
190                 }
191                 else if(gCommandLower == "lines")
192                 {
193                     if( gSubCommand != "off" ) {
194                         gLines= TRUE;
195                         llSay(0,"Lines on");
196                     }
197                     else {
198                         gLines=FALSE;
199                         llSay(0,"Lines on");
200                     }
201                 }
202             }
203             
204             else
205             {
206                 // make sure it's actually a vector
207                 if((vector)m != ZERO_VECTOR)
208                 {
209                     if(llToLower(name) == "p1")
210                     {
211                         gPos1 = (vector)m;
212                         llSay(1,"clear");
213                         updateText();
214                         start(gNumSegments);
215                     }
216                     
217                     else if(llToLower(name) == "p2")
218                     {
219                         gPos2 = (vector)m;
220                         llSay(1,"clear");
221                         updateText();
222                         start(gNumSegments);                        
223                     }
224                     
225                     else if(llToLower(name) == "p3")
226                     {
227                         gPos3 = (vector)m;
228                         llSay(1,"clear");
229                         updateText();
230                         start(gNumSegments);
231                     }
232                 }
233             }
234         }
235     }
236     
237     on_rez(integer start_param)
238     {
239         llResetScript();
240     }
241 }
Bezier_Curve_Demo

Control Points 
Description 
//...
Category: Building
By : Lionel Forager
Created: 2010-01-10 Edited: 2010-01-10
Worlds: Second Life

  1 reportPos()
  2 {
  3     vector pos = llGetPos();
  4     llSay(1, (string)pos);
  5 }
  6 
  7 default
  8 {
  9     touch_start(integer total_number)
 10     {
 11         if(llDetectedKey(0) == llGetOwner())
 12         {
 13             reportPos();
 14         }
 15     }
 16     
 17     moving_end()
 18     {
 19         reportPos();
 20     }
 21 }