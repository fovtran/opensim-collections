 1 // 
  2 // This formula: vector avDivPos = (avPos - rPos) * 0.010417; Takes the (avatars position - position of scanner) & multiplies by (radius of the distance you want the balls to go(2 meter sphere = 1 meter radius)/scan range(96meters)):
  3 // 
  4 // 1/96 = approximately 0.010417. 
  5 
  6 //////////////////////////////////////////////////////////////////////////////////////////////////////
  7 //				3D Radar 2.5
  8 // 				"Oct 15 2008", "18:43:28"
  9 // 				Creator: Jesse Barnett
 10 //				Released into the Public Domain
 11 //////////////////////////////////////////////////////////////////////////////////////////////////////
 12  
 13 integer Scan = TRUE;
 14 string avKey;
 15 integer list_pos;
 16 list key_list;
 17 integer key_chan;	//Key channel is generated randomly and passed to the scan ball
 18 integer die_chan = -9423753;	//Hey pick your own channels and be sure to paste them into
 19 						//the scan balls too!
 20 integer key_rem_chan = -49222879;
 21 default {
 22 	state_entry() {
 23 		llSetObjectName("3D Radar");
 24 	}
 25 	touch_start(integer total_number) {
 26 		if(Scan) {
 27 			llSensorRepeat("", "", AGENT, 96, PI, 1);
 28 			key_list =[];
 29 			llListen(key_rem_chan, "", "", "");
 30 			llOwnerSay("on");
 31 			Scan = FALSE;
 32 		}
 33 		else {
 34 			llSensorRemove();
 35 			llRegionSay(die_chan, "die");
 36 			llOwnerSay("off");
 37 			Scan = TRUE;
 38 		}
 39 	}
 40 	sensor(integer iNum) {
 41 		integer p = 0;
 42 		for (p = 0; p < iNum; ++p) {
 43 			avKey = llDetectedKey(p);
 44 			list_pos = llListFindList(key_list, (list)avKey);
 45 			if(list_pos == -1) {
 46 				key_list += (list) avKey;
 47 				key_chan = (integer) llFrand(-1000000) - 1000000;
 48 				llRezObject("scan ball", llGetPos(), ZERO_VECTOR, ZERO_ROTATION, key_chan);
 49 				llSleep(.25);
 50 				llRegionSay(key_chan, avKey);
 51 			}
 52 		}
 53 	}
 54 	listen(integer c, string name, key id, string msg) {
 55 		integer r = llListFindList(key_list,[(key)msg]);
 56 		key_list = llDeleteSubList(key_list, r, r);
 57 	}
 58 }
3D_Radar
DESCRIPTION: []::Rezzes a ball for each avatar in range. Each ball tracks it's on AV and displays distance
Category: Radar
By : Jesse Barnett
Created: 2010-12-27 Edited: 2014-02-15
Worlds: Second Life

  1 // Place this script in a prim and then place the prim into the inventory of the Scanner/Rezzer. It will automatically name itself.// // Suggestion; Create a sphere prim of 0.05 diameter with glow set about .80. 
  2 //////////////////////////////////////////////////////////////////////////////////////////////////////
  3 //				3D Radar 2.5
  4 // 				"Oct 15 2008", "18:44:36"
  5 // 				Creator: Jesse Barnett
  6 //				Released into the Public Domain
  7 //////////////////////////////////////////////////////////////////////////////////////////////////////
  8  
  9 string avName;
 10 integer avDistance;
 11 key avKey;
 12 integer avListen;
 13 integer key_chan;
 14 integer die_chan = -9423753;
 15 integer key_rem_chan = -49222879;
 16 vector avPos;
 17 vector rPos;
 18 default {
 19 	state_entry() {
 20 		llSetObjectName("scan ball");
 21 	}
 22 	on_rez(integer start_param) {
 23 		rPos = llGetPos();
 24 		key_chan = start_param;
 25 		llListen(die_chan, "", "", "");
 26 		avListen = llListen(key_chan, "", "", "");
 27 	}
 28 	listen(integer c, string n, key id, string msg) {
 29 		if(c == die_chan)
 30 			llDie();
 31 		else {
 32 			avKey = (key) msg;
 33 			avName = llKey2Name(avKey);
 34 			llSensorRepeat("", avKey, AGENT, 96, PI, 1.0);
 35 			llListenRemove(avListen);
 36 		}
 37 	}
 38 	sensor(integer n) {
 39 		avPos = llDetectedPos(0);
 40 		vector avDivPos = (avPos - rPos) / (96 / 1);	//Scan range/Radius of large sphere
 41 		avDistance = (integer) llVecDist(rPos, llDetectedPos(0));
 42 		llSetPos(rPos + avDivPos);
 43 		llSetText(avName + "[" + (string) avDistance + "]", <1, 1, 1 >, 1);
 44 	}
 45 	no_sensor() {
 46 		llRegionSay(key_rem_chan, avKey);
 47 		llDie();
 48 	}
 49 }