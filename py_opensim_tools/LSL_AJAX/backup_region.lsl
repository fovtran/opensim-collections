//***** Backups the current region to OAR ********
//   - Current script may be activated by the prim owner  
//   - Requires OSSL functions treat level set to "Severe"
//file extension of the OAR file
string OAR_FILE_EXT= ".oar";  
// FALSE will generate unique archive name ( based on the current time:  [regionname][datetime].[OAR_FILE_EXT])
// TRUE will overwrite the last arhcive (filename: [regionname].[OAR_FILE_EXT]
integer OVERWRITE_OLD_OARS = FALSE; 

default
{
    state_entry(){}    
    touch_start(integer num)
    {
        if(llDetectedKey(0)==llGetOwner())
        {
          string regionName = llGetRegionName();         
          llOwnerSay("Archiving region "+regionName);
          integer res = osConsoleCommand("change region "+regionName); 
          if(res==FALSE) { llOwnerSay("Unable to execute commnand 'change region'"); }          
          string oarName = regionName+OAR_FILE_EXT;
          if(OVERWRITE_OLD_OARS==FALSE)          
          {
              string time = llGetTimestamp();
              list l = llParseString2List(time,":","");
              oarName=regionName+llList2String(l,0)+llList2String(l,1)+OAR_FILE_EXT;
          }
          res = osConsoleCommand("save oar "+oarName);
          if(res==FALSE) { llOwnerSay("Unable to execute commnand 'save oar'"); }
          
        }
        else
        {
            llSay(0,"Access denied!");
        }
    }
}