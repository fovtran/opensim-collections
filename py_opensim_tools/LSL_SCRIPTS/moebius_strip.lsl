///////////////////////////////////////////////////////////////////
  2 //
  3 //                   CLONE PRIMITIVE  v 2.31
  4 //
  5 //
  6 //   This script chats out lines of text that can be pasted back 
  7 //   into a blank script to clone the original prim.
  8 //
  9 //   It also produces codeblocks optimized for automated transforms.
 10 //
 11 //    
 12  ////////////////////////////////////////////////////////////////////
 13 //
 14 //                    HOW TO USE
 15 //
 16 //
 17 //   Drag 'n Drop this script into the prim you want to copy.   
 18 //
 19 //   It will output a complete script for replicating the object
 20 //   in Owner-Only chat.  Then it will delete itself.
 21 //  
 22 //   Copy and paste the chatted script into a *completly blank*
 23 //   new script
 24 //
 25 //   Then use the  Search/Replace function under the Edit menu 
 26 //   to replace the "[HH:MM]  :" line prefixes with a blank.
 27 //
 28 //   Just hit the 'Replace All' button.
 29 //
 30 //   It can take 2 minutes or more to print out, so you may have to 
 31 //   do this a few times.
 32 //
 33 //
 34 //   The Primitve Paramaters will be chatted out in the oder that 
 35 //   they're featured on the offical Wiki:
 36 //
 37 //   http://wiki.secondlife.com/wiki/LlGetPrimitiveParams   
 38 //
 39  ///////////////////////////////////////////////////////////////////
 40 //
 41 //                       WHY?
 42 //
 43 //   Chances are you're not going to need an end-to-end
 44 //   script to dupe your prim. Shift-drag copy is a lot easier.
 45 //
 46 //   But if you're reading this you probably want some of the code,
 47 //   so carve out what you need from the output.
 48 //
 49 //   The output code is also commented where appropriate. If you want 
 50 //   To know more about what's going on, read the comments here and 
 51 //   check out the wiki.  The wiki's good.
 52 //
 53 //   Many advanced items on the grid transform from one object to 
 54 //   another.  Builders have used scrips like this to generate the 
 55 //   code that goes into those products.
 56 //
 57 //   Consider the use of both of llSetPrimitiveParams([]) and 
 58 //   llSetLinkPrimitiveParams([]).  A multi-prim prim object can be 
 59 //   metamorphed with a single scipt.
 60 //
 61 //   In my experience you can pack five complete primitive trans-
 62 //   formations into one script before you run out of bytes.
 63 //
 64  ///////////////////////////////////////////////////////////////////
 65 //
 66 //              Released nder the terms of the 
 67 //              GNU General Public Liscence v3
 68 //
 69 //  This source code is free to use / modify / resell 
 70 //  with the following restrictions:
 71 //
 72 //  If you include any portion of -this- script in a product you 
 73 //  distribute you must make the script fully mod/copy/trans for 
 74 //  the next user/owner.  You must also liscence it under the GPL 
 75 //  and give attribution to the contributors.
 76 //
 77 //  This does not extend to the code this script generates.  That
 78 //  is yours to liscense as you see fit.
 79 //
 80 //             No warantee expressed or implied.
 81 //   
 82 //  For more info see http://www.gnu.org/copyleft/gpl.html
 83 //
 84  ///////////////////////////////////////////////////////////////////
 85 //
 86 //      Written by          
 87 //      Clarknova Helvetic [2008.01.04]
 88 //      w/ thanks to Bopete Yossarian
 89 //
 90 ////////////////////////////////////////////////////////////////////
 91  
 92  
 93 ///  Global Functions & Vars to make life easier
 94  
 95  
 96 float   pause   =   .1  ; //// Change this to change the delay between each printed line.
 97                           //// The laggier the server the more delay you'll need to 
 98                           //// prevent line mix-up.
 99  
100  
101 // Object-Specific parameters 2 string
102 string osp(integer p) {return llDumpList2String(llGetPrimitiveParams([p]),","); }
103  
104 // Face-Specific parameters 2 string
105 string fsp(integer p, integer f) { return llDumpList2String(llGetPrimitiveParams([p,f]),","); }
106  
107 // Parameter prefixed and formatted for output
108 string param(string p , integer q) { return p + "," + osp(q); }
109  
110 // General owner chat w\ Sleep function to stop chat lag from  screwing up the line order
111 say(string c) { llSleep(pause); llOwnerSay(c); } 
112  
113 // Printing out next element to add to the parameter list
114 sayn(string c) { say("\t" + c + " , "); }
115  
116 // Printing out the last element to add to the parameter list
117 saynd(string c) { say("\t" + c + "\n\n\t];"); }
118  
119 // Print out the code to apply the parameters to the object
120 define() {  say("\tllSetPrimitiveParams(params);\n\tparams = [];"); }
121  
122 // Handle to insert comments
123 comment(string c) { say("\n\t// " + c ); }
124  
125  
126  
127 /// On with the show...
128  
129  
130  
131 default
132 {
133     state_entry()
134     {
135 
136 
137         say("COPY/PASTE THE CODE BELOW INTO A *BLANK* SCRIPT TO CLONE THIS PRIM: \n\n");  // Announce what we're doing
138 
139         // We're going to change the object's name to a null string to make the output easier to read.
140         string object_name = llGetObjectName(); // Store the object's name so we can set it back when done
141         llSetObjectName("");
142 
143         // Guess we should transfer the description too
144         string object_desc = llGetObjectDesc();
145 
146         //  Print the script header up to state_entry
147         say("\ndefault\n{\n\tstate_entry()\n\t{\n\tlist params;\n\t\n\n\t// If you are cutting code out to paste into custon functions\n\t// Define \"params\" as a global list and start cutting below this line.\n\n\tparams =");
148 
149 
150 
151 
152         // Add some comments to the script
153 
154         // [12:56]  Tali Rosca: It uses the C-style thing about an assignment also being an expression with a value.
155         // [12:56]  Tali Rosca: Why it actually saves memory still baffles my mind, though.
156 
157         // list of the the first: paramater constants as strings, then thier integer value.
158         list Param_Names = ["PRIM_TYPE",PRIM_TYPE,"PRIM_MATERIAL",PRIM_MATERIAL,"PRIM_PHYSICS",PRIM_PHYSICS,"PRIM_TEMP_ON_REZ",PRIM_TEMP_ON_REZ,"PRIM_PHANTOM",PRIM_PHANTOM,"PRIM_POSITION",PRIM_POSITION,"PRIM_ROTATION",PRIM_ROTATION,"PRIM_SIZE",PRIM_SIZE];
159 
160 
161         // ASIDE:
162         // Prim params are of two types: Object-Specific and Face-Specific.
163         //
164         // I'd Like to group them together according to type, but LsL doesn't
165         // nor does wiki.secondlife, and I am sworn to complete my destiny...
166         //
167         // This is probably for historical reasons (the param order, not my
168         // ultimate destiny).
169 
170 
171         integer i; // You're going to see a lot of use, integer i!
172         integer length; // So are you, integer length!
173 
174         length = (llGetListLength(Param_Names)); // I'm way lazy.  Let's make LsL do basic math for us.
175 
176         for ( i = 0 ; i < length ; i = i +2) // This is may answer to list strides.  Take that!
177         {
178             if(i > length -3 ) // If we're at the last stride
179             {
180                 saynd(param(llList2String(Param_Names,length -2), llList2Integer(Param_Names,length -1))) ; // Fecth the constants out of Param_Names.
181                 i = length;
182             }
183             else if(i == 0) // PRIM_TYPE is a special case.  But then what isn't?
184             {
185                 //  Checking if it's a sculptie in a rather extravagant way,
186                 //  but I also want to check my work.
187 
188                 integer j = llList2Integer(Param_Names,i+1); // What's the param we're checking?
189                 list r = llGetPrimitiveParams([j]); // What are its values?
190                 integer t = llList2Integer(r,0); // What's the first value?
191 
192                 if(t == 7) // if it's a sculptie
193                 {
194                     sayn("[\n\tPRIM_TYPE,"+ (string)t + ",\""+ llList2String(r,1) + "\"," + llList2String(r,2) );
195 
196                 }
197                 else sayn("[ \n \n \t" + param(llList2String(Param_Names,i), j));
198             }
199             else if(i < length -3 && i != length -6 ) sayn(param( llList2String(Param_Names,i), llList2Integer(Param_Names,i+1)) ) ;
200             else if(i < length -3 && i == length -6 )
201             {
202                 say("\t// It's probably not a god idea to have your new prim jump to the old one\n\t// " + param( llList2String(Param_Names,i), llList2Integer(Param_Names,i+1)) + " ] + (params = []) +");
203 
204             }
205         }
206 
207         Param_Names = []; // Free up some memory
208 
209         // I reallllly want our script to set all of the paramaters at once, with one llSetPrimitiveParams()
210         // call at the end of the script but we can't because of bugs in LsL.
211         //
212         // See  https://jira.secondlife.com/browse/SVC-38  for more info.  Please vote to fix it.\n\t
213 
214         say("");
215 
216         comment("Set all of the above paramaters as a group.");
217         define();
218 
219         say("");
220         comment("We are breaking the llSetPtimitiveParam([]) calls into blocks, because some params are incompatible with others \n\t// during the same call. This is an LsL bug.  See https://jira.secondlife.com/browse/SVC-38 for more info.\n\t// Please vote to fix it. \n");
221 
222 
223         //// Okay, now for the hard stuff: 4 out of 5 of the Face-Specific params, starting with the hardest:
224         //// PRIM_TEXTURE.  Why is PRIM_TEXTURE a pain?  Because llSetPrimitiveParams wants it in qoutes, but
225         //// llGetPrimitiveParams doesn't give it to us in quotes.  It's a pickle.
226         ////
227         //// The Face-Specific params each need thier own For loop because the number of faces is variable
228         //// from prim to prim.  A simple sphere only has one.  A tube can have up to 9.
229 
230 
231         integer sides = llGetNumberOfSides();  // So here we find out how many faces we've got
232 
233         comment("This prim has " + (string)sides + " faces.\n"); // Don't care enough to correct for the singular :)
234 
235 
236         ///  PRIM_TEXTURE ///
237 
238         say( "\tparams = \n\t[ \n \n ");
239         for (i = 0 ; i < sides ; ++i)
240         {
241 
242             list r =llGetPrimitiveParams([PRIM_TEXTURE,i]);
243             string s =
244                 "\""  + llList2String(r,0) + "\"" // First element is the texture key.
245                     + ","
246                 + llList2String(r,1)
247                 + ","
248                 + llList2String(r,2)
249                 + ","
250                 + llList2String(r,3) ;
251 
252             if(i < sides -1)  s = s + " , " ;
253             else if(i == sides -1)  s = s + "\n\n\t];";
254 
255             say("\tPRIM_TEXTURE," + (string)i + "," + s );
256 
257 
258             // Local variables aren't cleared when we leave thier scope.  Can you believe that crap?
259             r = []; s = "";
260 
261         }
262 
263 
264 
265         define();
266 
267         comment("Note that you -cannot- define textures and colors in the same call!\n\t// If you're cutting out these params for your custom code watch out for this.\n");
268 
269 
270         ///  PRIM_COLOR ///
271         say( "\tparams = \n\t[ \n \n ");
272         for (i = 0 ; i < sides ; ++i)
273         {
274 
275             if(i < sides -1 ) sayn("PRIM_COLOR," + (string)i + "," + fsp(PRIM_COLOR,i));
276             if(i == sides -1 ) saynd("PRIM_COLOR," + (string)i + "," + fsp(PRIM_COLOR,i));
277         }
278         define();
279 
280 
281         ///  PRIM_BUMP_SHINY ///
282         say( "\tparams = \n\t[ \n \n ");
283         for (i = 0 ; i < sides ; ++i)
284         {
285             if(i < sides -1 ) sayn("PRIM_BUMP_SHINY," + (string)i + "," + fsp(PRIM_BUMP_SHINY,i) );
286             if(i == sides -1 ) saynd("PRIM_BUMP_SHINY," + (string)i + "," + fsp(PRIM_BUMP_SHINY,i));
287 
288         }
289         define();
290 
291         ///  PRIM_FULLBRIGHT ///
292 
293 
294         say( "\tparams = \n\t[ \n \n ");
295         for (i = 0 ; i < sides ; ++i)
296         {
297             sayn("PRIM_FULLBRIGHT," + (string)i + "," + fsp(PRIM_FULLBRIGHT,i));
298 
299         }
300 
301 
302         ////   Now back to an Object-Specific paramaters : Flexible & Shadows
303         ////   Remember that I'm going in this screwy order so that our
304         ////   Code matches the table on http://wiki.secondlife.com/wiki/LlSetPrimitiveParams
305 
306 
307         sayn(param( "PRIM_FLEXIBLE",21));
308         sayn("// " + param( "PRIM_CAST_SHADOWS",24));
309 
310 
311 
312 
313 
314         //// Now for one more Face-Specific paramater
315 
316         ///  PRIM_TEXGEN ///
317 
318         // Planar mapping is for correcting the what circular surfaces do to textures
319         // The default value for all faces is 0 ( distored )
320         // So we will only uncomment lines that carry a value of 1 ( corrected )
321 
322         //  And we make a note of that in the output script here
323         comment("Planar mapping (PRIM_TEXGEN) is for correcting the what circular surfaces do to textures.\n\t// Most builds don't use it, so it's commented out to save bytes in auto-transform code.\n\t// The default value is 1 (distorted).\n\t// if you are metamorphing an object that already had planar mapping (rare)\n\t// uncomment those 0 lines.\n\t// This may not seem like much savings\n\t//  but if your script is trying to metamorph between as many as five objects\n\t// those few bytes saved might come in handy at the end.\n\n\t// If your textures are coming out with the offsets all wrong, try uncommenting them.");
324         for (i = 0 ; i < sides ; ++i)
325         {
326             list r = llGetPrimitiveParams([PRIM_TEXGEN,i]);
327             if(llList2Integer(r,-1) == 0) say("\t// PRIM_TEXGEN," + (string)i + "," + llDumpList2String(r," , ") + " , ");
328             if(llList2Integer(r,-1) == 1) say("\tPRIM_TEXGEN," + (string)i + "," + llDumpList2String(r," , ") + " , ");
329         }
330 
331         /// The last paramater is Object-Specific
332 
333 
334         saynd("PRIM_POINT_LIGHT," + osp(PRIM_POINT_LIGHT) );
335 
336         say("\tllSetPrimitiveParams(params);\tparams = [];");  //  Print the final function call, braces & some blank lines
337 
338         say("\n\n\t// If you were cut/pasting this code into a custom transform function\n\t// end your cut above this comment.\n\t// Otherwise ignore this.\n\n\tllSetObjectName(\"" + object_name + "\");\n");  // Make the target's name match this one
339         say("\n\tllSetObjectDesc(\"" + object_name + "\");\n");  // Make the target's desc match this one
340 
341         comment("This next line deletes the script.  Comment it out if you want the script to persist");
342 
343         say("\n\tllRemoveInventory(llGetScriptName());\n\t}\n}\n\n\n");  // Remove the cloning script when done
344 
345 
346         llSetObjectName(object_name); // Change our object's name back.
347 
348         say("Don't forget to remove the \"[HH:MM]  :\" timestamp at the beginning of each line.  Use Find/Replace  :)"); // Remind us to remove prefixes.)
349         llRemoveInventory(llGetScriptName());  // Delete this script.
350     }
351 }
Clone_Prim
Sample Output 

Here's an example of the output. This will make a shiny, metallic mobius strip.
Category: Building
By : Clarknova Helvetic
Created: 2010-01-10 Edited: 2010-01-10
Worlds: Second Life

  1 default
  2 {
  3     state_entry()
  4         {
  5          list params;
  6  
  7  
  8          // If you are cutting code out to paste into custon functions
  9          // Define "params" as a global list and start cutting below this line.
 10  
 11          params =
 12  
 13          [
 14          PRIM_TYPE,4,0,<0.000000, 1.000000, 0.000000>,0.000000,<0.500000, -0.500000, 0.000000>,<0.250000, 0.050000, 0.000000>,<0.000000, -0.100000, 0.000000>,<0.000000, 1.000000, 0.000000>,<0.000000, 0.000000, 0.000000>,1.000000,0.000000,0.000000 , 
 15          PRIM_MATERIAL,2 , 
 16          PRIM_PHYSICS,0 , 
 17          PRIM_TEMP_ON_REZ,0 , 
 18          PRIM_PHANTOM,2 , 
 19          // It's probably not a god idea to have your new prim jump to the old one
 20         // PRIM_POSITION,<84.270088, 36.444294, 231.487076> ] + (params = []) +
 21          PRIM_ROTATION,<-0.363768, 0.720439, 0.134244, 0.574995> , 
 22          PRIM_SIZE,<1.072797, 1.206897, 1.072797>
 23         ];
 24  
 25  
 26        // Set all of the above paramaters as a group.
 27          llSetPrimitiveParams(params);
 28         params = [];
 29  
 30  
 31        // We are breaking the llSetPtimitiveParam([]) calls into blocks, because some params are incompatible with others 
 32        // during the same call. This is an LsL bug.  See https://jira.secondlife.com/browse/SVC-38 for more info.
 33        // Please vote to fix it. 
 34  
 35  
 36        // This prim has 3 faces.
 37  
 38        params =
 39         [
 40  
 41         PRIM_TEXTURE,0,"5748decc-f629-461c-9a36-a35a221fe21f",<1.000000, 1.000000, 0.000000>,<0.000000, 0.000000, 0.000000>,0.000000 , 
 42         PRIM_TEXTURE,1,"5748decc-f629-461c-9a36-a35a221fe21f",<1.000000, 1.000000, 0.000000>,<0.000000, 0.000000, 0.000000>,0.000000 , 
 43         PRIM_TEXTURE,2,"5748decc-f629-461c-9a36-a35a221fe21f",<1.000000, 1.000000, 0.000000>,<0.000000, 0.000000, 0.000000>,0.000000
 44         ];
 45          llSetPrimitiveParams(params);
 46         params = [];
 47  
 48        // Note that you -cannot- define textures and colors in the same call!
 49       // If you're cutting out these params for your custom code watch out for this.
 50  
 51        params =
 52         [
 53  
 54          PRIM_COLOR,0,<0.054902, 0.654902, 0.062745>,1.000000 , 
 55          PRIM_COLOR,1,<0.054902, 0.654902, 0.062745>,1.000000 , 
 56          PRIM_COLOR,2,<0.054902, 0.654902, 0.062745>,1.000000
 57         ];
 58          llSetPrimitiveParams(params);
 59         params = [];
 60        params =
 61         [
 62  
 63          PRIM_BUMP_SHINY,0,3,0 , 
 64          PRIM_BUMP_SHINY,1,3,0 , 
 65          PRIM_BUMP_SHINY,2,3,0
 66         ];
 67          llSetPrimitiveParams(params);
 68         params = [];
 69        params =
 70       [
 71  
 72          PRIM_FULLBRIGHT,0,1 , 
 73          PRIM_FULLBRIGHT,1,1 , 
 74          PRIM_FULLBRIGHT,2,1 , 
 75          PRIM_FLEXIBLE,0,2,0.300000,2.000000,0.000000,1.000000,<0.000000, 0.000000, 0.000000> , 
 76          // PRIM_CAST_SHADOWS,1 , 
 77  
 78        // Planar mapping (PRIM_TEXGEN) is for correcting the what circular surfaces do to textures.
 79        // Most builds don't use it, so it's commented out to save bytes in auto-transform code.
 80         // The default value is 1 (distorted).
 81        // if you are metamorphing an object that already had planar mapping (rare)
 82        // uncomment those 0 lines.
 83        // This may not seem like much savings
 84        //  but if your script is trying to metamorph between as many as five objects
 85        // those few bytes saved might come in handy at the end.
 86  
 87        // If your textures are coming out with the offsets all wrong, try uncommenting them.
 88          // PRIM_TEXGEN,0,0 , 
 89          // PRIM_TEXGEN,1,0 , 
 90          // PRIM_TEXGEN,2,0 , 
 91          PRIM_POINT_LIGHT,1,<1.000000, 1.000000, 1.000000>,0.200000,20.000000,0.000000
 92         ];
 93          llSetPrimitiveParams(params);        params = [];
 94  
 95  
 96          // If you were cut/pasting this code into a custom transform function
 97          // end your cut above this comment.
 98          // Otherwise ignore this.
 99  
100         llSetObjectName("Mobius Torus");
101  
102  
103         llSetObjectDesc("Mobius Torus");
104  
105  
106        // This next line deletes the script.  Comment it out if you want the script to persist
107  
108         llRemoveInventory(llGetScriptName());
109      }
110 }