 string name = "Data_Default";
  2  
  3 integer numberOfNotes;
  4 key     qid;
  5 integer line = 0;
  6 integer lineTotal = 0;
  7 integer prims;
  8 list    totalLines;
  9 integer totalLinesTotal;
 10  
 11 string hexDigits = "0123456789ABCDEF";
 12  
 13 integer rand;
 14  
 15 integer whichNote;
 16  
 17 vector start;
 18  
 19 get() {
 20     if(whichNote == 0) {
 21         qid = llGetNotecardLine(name, line);
 22     } else {
 23         qid = llGetNotecardLine(name + " " + (string)whichNote, line);
 24     }
 25  
 26 }
 27  
 28 rezObj(vector pos, string num) {
 29     while(llVecDist(llGetPos(), start-pos) > .001) llSetPos(start-pos);
 30     llRezObject("HoloBox", llGetPos(), <0,0,0>, <0,0,0,0>, hex2int(num) + rand);
 31 }
 32  
 33 integer hex2int(string hex) {
 34     integer p1 = llSubStringIndex(hexDigits, llGetSubString(hex, 0, 0));
 35     integer p2 = llSubStringIndex(hexDigits, llGetSubString(hex, 1, 1));
 36     integer data = p2 + (p1 << 4);
 37     return data;
 38 }
 39  
 40 default {
 41     touch_start(integer i) {
 42         llSetText("Starting Up... (1/4)", <1,1,1>, 1);
 43         numberOfNotes = llGetInventoryNumber(INVENTORY_NOTECARD);
 44  
 45         qid = llGetNumberOfNotecardLines(name);
 46     }
 47     dataserver(key queryId, string data) {
 48         if(queryId == qid)  {
 49             totalLines += data;
 50             totalLinesTotal += (integer)data;
 51             ++whichNote;
 52             if(whichNote < numberOfNotes) {
 53                 llOwnerSay(name + " " + (string)whichNote);
 54                 qid = llGetNumberOfNotecardLines(name + " " + (string)whichNote);
 55             } else {
 56                 state rez;
 57             }
 58         }
 59     }
 60 }
 61  
 62 state rez {
 63     state_entry() {
 64         start = llGetPos();
 65         rand = (integer)llFrand(0x6FFFFFFF) + 0x10000000;
 66         llOwnerSay("Start");
 67         line = 0;
 68         qid = llGetNotecardLine(name, line); 
 69         whichNote = 0;
 70     }
 71     dataserver(key queryId, string data) {
 72         if(queryId == qid)  {
 73             if(data != EOF) {
 74                 data = llList2String(llParseString2List(data, ["-----: "], []), 1);
 75                 if(llGetSubString(data, 0, 3) == "#NEW") {
 76                     string num = llGetSubString(data, 5, 6);
 77                     vector pos = (vector)llGetSubString(data, 8, -1);
 78                     rezObj(pos, num);
 79                 }
 80                 llSetText("Rezing Prims: " + (string)((integer)(100*lineTotal/totalLinesTotal)) + "% (2/4)", <1,1,1>, 1);
 81                 line += 1;
 82                 lineTotal += 1;
 83                 get();
 84             } else {
 85                 whichNote++;
 86                 if(whichNote < numberOfNotes) {
 87                     line = 0;
 88                     get();
 89                 } else {
 90                     state run;
 91                 }
 92             }
 93         }
 94     }
 95 }
 96  
 97 state run {
 98     state_entry() {
 99         line = 0;
100         lineTotal = 0;
101         qid = llGetNotecardLine(name, line); 
102         whichNote = 0;
103     }
104     dataserver(key queryId, string data) {
105         if(queryId == qid)  {
106             if(data != EOF) {
107                 data = llList2String(llParseString2List(data, ["-----: "], []), 1);
108                 if(llGetSubString(data, 0, 3) != "#NEW") {
109                     list parts = llParseString2List(data, [":::"], []);
110                     integer prim = hex2int(llList2String(parts, 0));
111                     llRegionSay(rand + prim, llList2String(parts, 1));
112                 }
113                 llSetText("Sending Data: " + (string)((integer)(100*lineTotal/totalLinesTotal)) + "% (3/4)", <1,1,1>, 1);
114                 line += 1;
115                 lineTotal += 1;
116                 get();
117             } else {
118                 whichNote++;
119                 if(whichNote < numberOfNotes) {
120                     line = 0;
121                     get();
122                 } else {
123                     llSetText("Cleaning Up... (4/4)", <1,1,1>, 1);
124                     integer i = 0;
125                     while(i < 256) {
126                         llRegionSay(rand + i, "Finish");
127                         ++i;
128                     }
129                     llSetTimerEvent(3);
130                 }
131             }
132         }
133     }
134     timer() {
135         llSetText("Finished.", <1,1,1>, 1);
136         llOwnerSay("Done");
137         llSetTimerEvent(0);
138         llResetScript();
139     }
140 }
Object_to_Data_back_to_Object_v13
Replicate Main (Script)
Category: Building
By : Xaviar Czervik
Created: 2011-01-22 Edited: 2011-01-22
Worlds: Second Life

  1 default {
  2     state_entry() {
  3         llOwnerSay("Place the 'Object to Data' script in me.");
  4     }
  5     changed(integer num) {
  6         if(llGetInventoryType("Object to Data") != -1) {
  7             state run;
  8         }
  9     }
 10 }
 11  
 12  
 13 state run {
 14     state_entry() {
 15         llOwnerSay("Deploying scripts... Please wait. This may take some time.");
 16         llSetText("Loading...", <1,1,1>, 1);
 17         integer num = llGetNumberOfPrims();
 18         list lst;
 19         integer i = 1;
 20         while(i <= num) {
 21             lst += llGetLinkKey(i);
 22             i++;
 23         }
 24         llSetScriptState("Object to Data", 0);
 25         i = 0;
 26         while(i < num) {
 27             llSetText((string)(((float)i*100.0)/((float)num)) + "% finished.", <1,1,1>, 1);
 28             llGiveInventory(llList2Key(lst, i), "Object to Data");
 29             i++;
 30         }
 31         llSetScriptState("Object to Data", 0);
 32         llSetText("", <1,1,1>, 1);
 33         llOwnerSay("Re-Rez this object and then go to 'Tools' -> 'Set Scripts to Running in Selection', and then Re-Rez this object again.");
 34         llRemoveInventory(llGetScriptName());
 35     }
 36 }
Object_to_Data_back_to_Object_v13
Object To Data (Script)
Category: Building
By : Xaviar Czervik
Created: 2011-01-22 Edited: 2011-01-22
Worlds: Second Life

  1 string hexc="0123456789ABCDEF";//faster
  2  
  3 string Float2Hex(float input)
  4 {// Copyright Strife Onizuka, 2006-2007, LGPL, http://www.gnu.org/copyleft/lesser.html
  5     if((integer)input != input)//LL screwed up hex integers support in rotation & vector string typecasting
  6     {//this also keeps zero from hanging the zero stripper.
  7         float unsigned = llFabs(input);//logs don't work on negatives.
  8         integer exponent = llFloor(llLog(unsigned) / 0.69314718055994530941723212145818);//floor(log2(b)) + rounding error
  9         integer mantissa = (integer)((unsigned / (float)("0x1p"+(string)(exponent -= (exponent == 128)))) * 0x1000000);//shift up into integer range
 10         integer index = (integer)(llLog(mantissa & -mantissa) / 0.69314718055994530941723212145818);//index of first 'on' bit
 11         string str = "p" + (string)((exponent += index) - 24);
 12         mantissa = mantissa >> index;
 13         do
 14             str = llGetSubString(hexc,15&mantissa,15&mantissa) + str;
 15         while(mantissa = mantissa >> 4);
 16         if(input < 0)
 17             return "-0x" + str;
 18         return "0x" + str;
 19     }//integers pack well so anything that qualifies as an integer we dump as such, supports netative zero
 20     return llDeleteSubString((string)input,-7,-1);//trim off the float portion, return an integer
 21 }
 22  
 23  
 24 string safeVector(vector v) {
 25     return "<"+safeFloat(v.x)+","+safeFloat(v.y)+","+safeFloat(v.z)+">";
 26 }
 27  
 28 string safeRotation(rotation v) {
 29     return "<"+safeFloat(v.x)+","+safeFloat(v.y)+","+safeFloat(v.z)+","+safeFloat(v.s)+">";
 30 }
 31  
 32 string safeFloat(float f) {
 33     return Float2Hex(f);
 34 }
 35  
 36 string list2string(list l) {
 37     string ret;
 38     integer len = llGetListLength(l);
 39     integer i;
 40  
 41     while(i < len) {
 42         integer type = llGetListEntryType(l, i);
 43         if(type == 1) {
 44             ret += "#I"+(string)llList2Integer(l, i);
 45         } else if(type == 2) {
 46             ret += "#F"+safeFloat(llList2Float(l, i));
 47         } else if(type == 3) {
 48             ret += "#S"+llList2String(l, i);
 49         } else if(type == 4) {
 50             ret += "#K"+(string)llList2Key(l, i);
 51         } else if(type == 5) {
 52             ret += "#V"+safeVector(llList2Vector(l, i));        
 53         } else if(type == 6) {
 54             ret += "#R"+safeRotation(llList2Rot(l, i));
 55         }
 56         ret += "-=-";
 57         i++;
 58     }
 59     return ret;
 60 }
 61  
 62 string getTexture() {
 63     string ret;
 64  
 65     integer sides = llGetNumberOfSides();
 66  
 67     integer same = 1;
 68     list texture;
 69     list repeat;
 70     list offset;
 71     list rot;
 72  
 73     integer i = 0;
 74     while(i < sides) {
 75         list side  = llGetPrimitiveParams([PRIM_TEXTURE, i]);
 76         texture += llList2String(side, 0);
 77         repeat  += llList2Vector(side, 1);
 78         offset  += llList2Vector(side, 2);
 79         rot     += llList2Float(side, 3);
 80  
 81         if(!(llList2String(texture, i) == llList2String(texture, i-1) && llList2Vector(repeat, i) == llList2Vector(repeat, i-1) &&
 82             llList2Vector(offset, i) == llList2Vector(offset, i-1) && llList2Float(rot, i) == llList2Float(rot, i-1))) {
 83                 same = 0;
 84         }
 85         i++;
 86     }
 87  
 88     if(same) {
 89         ret += list2string([PRIM_TEXTURE, ALL_SIDES, llList2String(texture, 0), llList2Vector(repeat, 0), llList2Vector(offset, 0), llList2Float(rot, 0)]);
 90     } else {
 91         integer j = 0;
 92         while(j < llGetListLength(texture)) {
 93             ret += list2string([PRIM_TEXTURE, j, llList2String(texture, j), llList2Vector(repeat, j), llList2Vector(offset, j), llList2Float(rot, j)]);
 94             j++;
 95         }
 96     }        
 97  
 98     return ret;
 99 }
100  
101 string getColor() {
102     string ret;
103  
104     integer sides = llGetNumberOfSides();
105  
106     integer same = 1;
107     list color;
108     list alpha;
109  
110     integer i = 0;
111     while(i < sides) {
112         list side  = llGetPrimitiveParams([PRIM_COLOR, i]);
113         alpha += llList2Float(side, 1);
114         color  += llList2Vector(side, 0);
115  
116         if(!(llList2String(color, i) == llList2String(color, i-1) && llList2Vector(alpha, i) == llList2Vector(alpha, i-1))) {
117                 same = 0;
118         }
119         i++;
120     }
121  
122     if(same) {
123         ret += list2string([PRIM_COLOR, ALL_SIDES, llList2Vector(color, 0), llList2Float(alpha, 0)]);
124     } else {
125         integer j = 0;
126         while(j < llGetListLength(color)) {
127             ret += list2string([PRIM_COLOR, j, llList2Vector(color, j), llList2Float(alpha, j)]);
128             j++;
129         }
130     }        
131  
132     return ret;
133 }
134  
135 string getShiny() {
136     string ret;
137  
138     integer sides = llGetNumberOfSides();
139  
140     integer same = 1;
141     list shiny;
142     list bump;
143  
144     integer i = 0;
145     while(i < sides) {
146         list side  = llGetPrimitiveParams([PRIM_BUMP_SHINY, i]);
147         shiny += llList2Integer(side, 0);
148         bump += llList2Integer(side, 1);
149  
150         if(!(llList2Integer(shiny, i) == llList2Integer(shiny, i-1) && llList2Integer(bump, i) == llList2Integer(bump, i-1))) {
151                 same = 0;
152         }
153         i++;
154     }
155  
156     if(same) {
157         ret += list2string([PRIM_BUMP_SHINY, ALL_SIDES, llList2Integer(shiny, 0), llList2Integer(bump, 0)]);
158     } else {
159         integer j = 0;
160         while(j < llGetListLength(shiny)) {
161             ret += list2string([PRIM_BUMP_SHINY, j, llList2Integer(shiny, j), llList2Integer(bump, j)]);
162             j++;
163         }
164     }        
165  
166     return ret;
167 }
168  
169 string getBright() {
170     string ret;
171  
172     integer sides = llGetNumberOfSides();
173  
174     integer same = 1;
175     list fullbright;
176  
177     integer i = 0;
178     while(i < sides) {
179         list side  = llGetPrimitiveParams([PRIM_FULLBRIGHT, i]);
180         fullbright += llList2Integer(side, 0);
181  
182         if(!(llList2Integer(fullbright, i) == llList2Integer(fullbright, i-1))) {
183                 same = 0;
184         }
185         i++;
186     }
187  
188     if(same) {
189         ret += list2string([PRIM_FULLBRIGHT, ALL_SIDES, llList2Integer(fullbright, 0)]);
190     } else {
191         integer j = 0;
192         while(j < llGetListLength(fullbright)) {
193             ret += list2string([PRIM_FULLBRIGHT, j, llList2Integer(fullbright, j)]);
194             j++;
195         }
196     }        
197  
198     return ret;
199 }
200 string getGlow() {
201     string ret;
202  
203     integer sides = llGetNumberOfSides();
204  
205     integer same = 1;
206     list glow;
207  
208     integer i = 0;
209     while(i < sides) {
210         list side  = llGetPrimitiveParams([PRIM_GLOW, i]);
211         glow += llList2Integer(side, 0);
212  
213         if(!(llList2Integer(glow, i) == llList2Integer(glow, i-1))) {
214                 same = 0;
215         }
216         i++;
217     }
218  
219     if(same) {
220         ret += list2string([PRIM_GLOW, ALL_SIDES, llList2Integer(glow, 0)]);
221     } else {
222         integer j = 0;
223         while(j < llGetListLength(glow)) {
224             ret += list2string([PRIM_GLOW, j, llList2Integer(glow, j)]);
225             j++;
226         }
227     }        
228  
229     return ret;
230 }
231  
232 vector getPos() {
233     vector pos = llList2Vector(llGetPrimitiveParams([PRIM_POSITION]), 0);
234     pos -= llList2Vector(llGetObjectDetails(llGetLinkKey(0), [OBJECT_POS]), 0);
235     if(llGetLinkNumber() == 1) {
236         pos = <0,0,0>;
237     }
238     return pos;
239 }
240  
241 string getType() {
242     list type = [PRIM_TYPE] + llGetPrimitiveParams([PRIM_TYPE]);
243     type += [PRIM_PHYSICS] + llGetPrimitiveParams([PRIM_PHYSICS]);
244     type += [PRIM_MATERIAL] + llGetPrimitiveParams([PRIM_MATERIAL]);
245     type += [PRIM_TEMP_ON_REZ] + llGetPrimitiveParams([PRIM_TEMP_ON_REZ]);
246     type += [PRIM_PHANTOM] + llGetPrimitiveParams([PRIM_PHANTOM]);
247     type += [PRIM_ROTATION] + llGetPrimitiveParams([PRIM_ROTATION]);
248     type += [PRIM_SIZE] + llGetPrimitiveParams([PRIM_SIZE]);
249     type += [PRIM_FLEXIBLE] + llGetPrimitiveParams([PRIM_FLEXIBLE]);
250     type += [PRIM_POINT_LIGHT] + llGetPrimitiveParams([PRIM_POINT_LIGHT]);
251     return list2string(type);
252 }
253  
254  
255 string getPrimitiveParams() {
256     string ret;
257     ret += getType();
258     ret += getTexture();
259     ret += getShiny();
260     ret += getColor();
261     ret += getBright();
262     ret += getGlow();
263     return ret;
264 }
265  
266 string getMeta() {
267     return llDumpList2String([llGetObjectName(), llGetObjectDesc()], "-=-");
268 }
269  
270 string int2hex(integer num) {
271     integer p1 = num & 0xF;
272     integer p2 = (num >> 4) & 0xF;
273     string data = llGetSubString(hexc, p2, p2) + llGetSubString(hexc, p1, p1);
274     return data;
275 }
276  
277 string meta;
278  
279  
280 default {
281     on_rez(integer i) {
282         meta = getMeta();
283         llSetObjectName("-----");
284         llOwnerSay("#NEW " + int2hex(llGetLinkNumber()) + " " + safeVector(llGetRootPosition()-llGetPos()));
285         string data = getPrimitiveParams();
286         llOwnerSay(int2hex(llGetLinkNumber()) + ":::0"+meta);
287         integer i = 0;
288         integer num = 1;
289         while(i < llStringLength(data)) {
290             llOwnerSay(int2hex(llGetLinkNumber()) + ":::" + (string)num + "" + (string)llGetSubString(data, i, i+199));
291             i += 200;
292             llSleep(.1);
293             num++;
294         }
295         llRemoveInventory(llGetScriptName());
296     }
297 }
Object_to_Data_back_to_Object_v13
Holo Box (Script)
Category: Building
By : Xaviar Czervik
Created: 2011-01-22 Edited: 2011-01-22
Worlds: Second Life

  1 string meta;
  2 list data = ["", "", "", "", "", "", "", "", "", "", "", "", "", ""];
  3  
  4  
  5 setLink() {
  6     list m = llParseString2List(meta, ["-=-"], []);
  7     llSetObjectName(llList2String(m, 0));
  8     llSetObjectDesc(llList2String(m, 1));
  9  
 10     list l = llParseString2List((string)data, ["-=-"], []);
 11     list real;
 12     integer i = 0;
 13     while(i < llGetListLength(l)) {
 14         string this = llList2String(l, i);
 15         string thisPart = llGetSubString(this, 0, 1);
 16         if(thisPart == "#S") {
 17             real += (string)llGetSubString(this, 2, -1);
 18         } else if(thisPart == "#K") {
 19             real += (key)llGetSubString(this, 2, -1);
 20         } else if(thisPart == "#I") {
 21             real += (integer)llGetSubString(this, 2, -1);
 22         } else if(thisPart == "#F") {
 23             real += (float)llGetSubString(this, 2, -1);
 24         } else if(thisPart == "#V") {
 25             real += (vector)llGetSubString(this, 2, -1);
 26         } else if(thisPart == "#R") {
 27             real += (rotation)llGetSubString(this, 2, -1);
 28         }
 29         i++;
 30     }
 31     llSetPrimitiveParams(real);
 32 }
 33  
 34  
 35 default {
 36     on_rez(integer i) {
 37         llListen(i, "", "", "");
 38     }
 39     listen(integer i, string n, key id, string m) {
 40         if(m == "Finish") {
 41             setLink();
 42             llSleep(.5);
 43             llRemoveInventory(llGetScriptName());
 44         }
 45         integer num = (integer)llGetSubString(m, 0, 0);
 46         if(num == 0) {
 47             meta = llGetSubString(m, 1, -1);
 48         } else {
 49             num--;
 50             data = llListReplaceList(data, [llGetSubString(m, 1, -1)], num, num);
 51         }
 52     }
 53 }