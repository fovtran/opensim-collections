// This script is written as an example use of the osParseJSON method
// it uses the Google translate API
LSL_Types.key requestID;
string sourceLang = "en";
string targetLang = "fr";

public void default_event_state_entry()
{
    llSay(0,"translator running say '/1 sentence' to translate something");
    llSay(0,"translator running say '/2 source langage' to change target language e.g. '/2 fr'");
    llSay(0,"translator running say '/3 target langage' to change source language e.g. '/3 en'");
    llSay(0,"translator running say '/4 help', to list languages");
    llListen(1, "", NULL_KEY, "");
    llListen(2, "", NULL_KEY, "");
    llListen(3, "", NULL_KEY, "");
    llListen(4, "", NULL_KEY, "");
}

public void default_event_touch_start(LSL_Types.LSLInteger total_number)
{
    llSay(0,"translator running say '/1 sentence' to translate something");
    llSay(0,"translator running say '/2 source langage' to change target language e.g. '/2 fr'");
    llSay(0,"translator running say '/3 target langage' to change source language e.g. '/3 en'");
    llSay(0,"translator running say '/4 help', to list languages");
}

public void default_event_http_response(LSL_Types.LSLString request_id, LSL_Types.LSLInteger status, LSL_Types.list metadata, LSL_Types.LSLString body)
{
    if (requestID == request_id)
    {
        // the Google JSON string returned wil be of the format
        // {"responseData": {"translatedText":"Bonjour"}, "responseDetails": null, "responseStatus": 200}
        // call the osParseJSON method so we can read the contents
        System.Collections.Hashtable response = (System.Collections.Hashtable) osParseJSON(body);
        System.Collections.Hashtable responsedata = (System.Collections.Hashtable) response["responseData"];
        llSay(0,(string)responsedata["translatedText"]);
    }
}

public void default_event_listen(LSL_Types.LSLInteger channelIn, LSL_Types.LSLString name, LSL_Types.LSLString id, LSL_Types.LSLString message)
{
    if(channelIn==1)
    {
        string toTranslate = (string) message;
        requestID = llHTTPRequest( "http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q="+toTranslate+"&langpair="+sourceLang+"%7C"+targetLang, new LSL_Types.list(), "" );
    }
    else if(channelIn==2)
    {
        sourceLang = (string) message;
    }
    else if(channelIn==3)
    {
        targetLang = (string)message;
    }
    else if(channelIn==4)
    {
        llOwnerSay("LANGUAGE (CODE)");
        llOwnerSay("* Arabic (ar)");
        llOwnerSay("* Bulgarian (bg)");
        llOwnerSay("* Chinese (zh)");
        llOwnerSay("* Croatian (hr)");
        llOwnerSay("* Czech (cs)");
        llOwnerSay("* Danish (da)");
        llOwnerSay("* Dutch (nl)");
        llOwnerSay("* English (en)");
        llOwnerSay("* Finnish (fi)");
        llOwnerSay("* French (fr)");
        llOwnerSay("* German (de)");
        llOwnerSay("* Greek (el)");
        llOwnerSay("* Hindi (hi)");
        llOwnerSay("* Italian (it)");
        llOwnerSay("* Japanese (ja)");
        llOwnerSay("* Korean (ko)");
        llOwnerSay("* Norwegian(no) ");
        llOwnerSay("* Polish (pl)");
        llOwnerSay("* Portuguese (pt-PT)");
        llOwnerSay("* Romanian (ro)");
        llOwnerSay("* Russian (ru)");
        llOwnerSay("* Spanish (es)");
        llOwnerSay("* Swedish (sv)");
    }
}