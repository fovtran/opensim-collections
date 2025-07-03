integer auto;
  2 float speed;
  3 default
  4 {
  5    on_rez(integer start_param)
  6    {
  7        llResetScript();
  8 }
  9 state_entry()
 10 {
 11     speed = 30;
 12     llListen(0,"",llGetOwner(),"");
 13     llRequestPermissions(llGetOwner(),PERMISSION_TRIGGER_ANIMATION|PERMISSION_TAKE_CONTROLS);
 14    
 15 }
 16 listen(integer channel, string name, key id, string message)
 17 {
 18  if(message == ".a on")
 19  {
 20      llOwnerSay("Semi-Auto On.");
 21      auto = 1;
 22     }
 23     if(message == ".a off")
 24  {
 25      llOwnerSay("Semi-Auto Off.");
 26      auto = 0;
 27     }
 28      if(llSubStringIndex(message,".speed ") != -1)
 29      {
 30          speed = (float)llGetSubString(message,7,llStringLength(message));
 31 llOwnerSay("Speed Now Set To " + (string)speed);
 32  {
 33     } 
 34 }
 35 }
 36 run_time_permissions(integer perm)
 37 {
 38     if(perm)
 39     {
 40    llTakeControls(CONTROL_ML_LBUTTON,TRUE,TRUE);  
 41 }
 42 }
 43 control(key id, integer level, integer edge)
 44 {
 45      if(level & CONTROL_ML_LBUTTON && auto == 1)
 46      {
 47         
 48           llRezObject("bullet",llGetPos(),llRot2Fwd(llGetRot())*speed,ZERO_ROTATION,0); 
 49 }
 50 if(level & edge & CONTROL_ML_LBUTTON && auto == 0)
 51      {
 52         
 53           llRezObject("bullet",llGetPos(),llRot2Fwd(llGetRot())*speed,ZERO_ROTATION,0); 
 54         }
 55     }
 56 }