// YouTube Player (Version 1.0.0)
// By Extrems for OSGrid simulator.
//  http://www.extremscorner.co.cc/
// This script is licensed under:
// Creative Commons Attribution-Share Alike 3.0 Unported -- http://creativecommons.org/licenses/by-sa/3.0/
// Documentation:
//  http://www.extremscorner.co.cc/?page=content&name=docs/youtube
// * Constants
integer INTEGER_MAX = 2147483647;

integer LEVEL_NOTICE = 0x00;
integer LEVEL_WARNING = 0x01;
integer LEVEL_ERROR = 0x02;

float fltPassTimer = 60.0;
float fltPoolTimer = 5.0;

string strYtBase = "http://www.youtube.com/watch?v=";
string strAddress = "http://backend.cgetechnologies.co.cc:8080/directvid.php";
list lstHttpParams = [HTTP_METHOD, "POST", HTTP_MIMETYPE, "application/x-www-form-urlencoded"];

// * Variables
string strLastDesc;
key keyRequest;

key keyThumbnail;
string strVideoID;
string strContainer;
integer intMaxWidth;

integer intUnset;    // Part of osSetDynamicTextureURL workaround.

// * Functions
//  DebugSay: Just because I can.
DebugSay(string strMessage, integer intLevel)
{
    string strOutput = "(";
    
    if (intLevel == LEVEL_WARNING) { strOutput += "Warning"; }
        else if (intLevel == LEVEL_ERROR) { strOutput += "Error"; }
            else { strOutput += "Notice"; }
    
    strOutput += ") " + strMessage;
    llOwnerSay(strOutput);
}

//  Refresh:
Refresh()
{
    if (strLastDesc)
    {
        integer intDotIndex = llSubStringIndex(strLastDesc, ".");
        
        if (intDotIndex >= 0)
        {
            strVideoID = llGetSubString(strLastDesc, 0, intDotIndex - 1);
            
            string strExtension = llGetSubString(strLastDesc, intDotIndex + 1, -1);
            integer intSlashIndex = llSubStringIndex(strExtension, "/");
            
            if (intSlashIndex >= 0)
            {
                strContainer = llGetSubString(strExtension, 0, intSlashIndex - 1);
                intMaxWidth = (integer)llGetSubString(strExtension, intSlashIndex + 1, -1);
            }
            else
            {
                strContainer = strExtension;
            }
            
            // Remove mentions of FLV if you're on Linux and got a plug-in for GStreamer.
            if (!strContainer || (strContainer == "flv"))
            {
                if (strContainer == "flv")
                {
                    DebugSay("The Flash Video container format is not supported by QuickTime.", LEVEL_WARNING);
                }
                
                DebugSay("Falling back to MPEG-4 Part 14.", LEVEL_NOTICE);
                strContainer = "mp4";    
            }
            
            // Who wrote this function?!
            // Seriously, what the fuck.
            keyThumbnail = osSetDynamicTextureURL("", "image", "http://i.ytimg.com/vi/" + strVideoID + "/default.jpg", "", INTEGER_MAX);
            intUnset = FALSE;
            
            if (keyThumbnail)
            {
                state active;
            }
            else
            {
                DebugSay("Couldn't load thumbnail image, video ID may be invalid.", LEVEL_ERROR);
            }
        }
    }
    else { DebugSay("Object's description is empty.", LEVEL_ERROR); }
    
    state idle;
}

// * States
//  default:
default
{
    state_entry() { strLastDesc = llGetObjectDesc(); Refresh(); }
    on_rez(integer start_param) { llResetScript(); }
}

//  active:
state active
{
    state_entry()
    {
        string strBody;
        strBody += "action=" + "verify";
        strBody += "&url=" + llEscapeURL(strYtBase + strVideoID);
        
        keyRequest = llHTTPRequest(strAddress, lstHttpParams, strBody);
        llSetTimerEvent(fltPassTimer);
    }
    
    touch_start(integer num_detected)
    {
        llSetPrimitiveParams([PRIM_TEXTURE, ALL_SIDES, keyThumbnail, <1.0, 1.0, 0.0>, <0.0, 0.0, 0.0>, 0.0, PRIM_FULLBRIGHT, ALL_SIDES, TRUE]);
        intUnset = TRUE;
        
        llParcelMediaCommandList([PARCEL_MEDIA_COMMAND_STOP, PARCEL_MEDIA_COMMAND_UNLOAD]);
        llParcelMediaCommandList([PARCEL_MEDIA_COMMAND_TEXTURE, keyThumbnail]);
        
        string strMediaURL = strAddress + "?";
        strMediaURL += "action=" + "play";
        strMediaURL += "&containers=" + strContainer;
        if (intMaxWidth) { strMediaURL += "&width=" + (string)intMaxWidth; }
        strMediaURL += "&url=" + llEscapeURL(strYtBase + strVideoID);
        
        llParcelMediaCommandList([PARCEL_MEDIA_COMMAND_URL, strMediaURL]);
        llParcelMediaCommandList([PARCEL_MEDIA_COMMAND_PLAY]);
    }
    
    on_rez(integer start_param) { llResetScript(); }
    
    timer()
    {
        string strCurDesc = llGetObjectDesc();        
        if (strLastDesc != strCurDesc) { llResetScript(); }        
        llSensor("", NULL_KEY, AGENT, 96.0, TWO_PI);
    }
    
    sensor(integer num_detected) { }

    no_sensor()
    {
        if (intUnset)
        {
            keyThumbnail = osSetDynamicTextureURL("", "image", "http://i.ytimg.com/vi/" + strVideoID + "/default.jpg", "", INTEGER_MAX);
            intUnset = FALSE;
        }
    }
    
    http_response(key request_id, integer status, list metadata, string body)
    {
        if (request_id == keyRequest)
        {
            if (llSubStringIndex(llGetSubString(body, 0, 30), "<") >= 0)
            {
                DebugSay("The DirectVid backend appears to be broken.", LEVEL_WARNING);
            }
            else if (llSubStringIndex(body, "http://") < 0)
            {
                DebugSay("Server returned: " + body, LEVEL_NOTICE);
            }
        }
    }
}

//  idle:
state idle
{
    state_entry() { llSetTimerEvent(fltPoolTimer); }
    on_rez(integer start_param) { llResetScript(); }
    
    timer()
    {
        string strCurDesc = llGetObjectDesc();
        if (strLastDesc != strCurDesc) { llResetScript(); }
    }
}