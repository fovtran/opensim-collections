// This GetGridname Script is provided by GridBay, use at own risk.
//
// This code can be used to receive the Gridname via script.
// More information can be found at http://www.gridbay.de/viewtopic.php?f=2&t=39

key http_request_id;

string grid = "unknown";
integer gridcheck = FALSE;

key g_quary_grid;
list requests;

default
{
    state_entry()
    {
        llOwnerSay( "Checking Grid ...");
        http_request_id = llHTTPRequest("http://62.75.177.153/server/gridcheck.php?mode=GET_GRIDLIST", [],""); 
    }
    dataserver(key queryid, string data)
    {
        if ( llListFindList(requests, [ queryid ]) != FALSE)
        {
            gridcheck = FALSE;
            http_request_id = llHTTPRequest("http://62.75.177.153/server/gridcheck.php?mode=GETGRIDNAME&namecheck=" + llEscapeURL(data), [],""); 
        }
    }

    http_response(key id, integer status, list meta, string body)
    {
        if (status == 499)
        {
            llOwnerSay( "ERROR 499");
        }
        else if (status != 200 )
        {
            llOwnerSay( "Page not found");
        }
        else if (id == http_request_id)
        {
            list n = llParseString2List(body, ["|"], []);
            if(llList2String(n,0) == "GRIDCHECK")
            {
                requests = [];
                integer i = 1;
                gridcheck = TRUE;
                while(i < llGetListLength(n) && gridcheck == TRUE)
                {
                    requests += llRequestAgentData(llList2Key(n, i), DATA_NAME);
                    i++;
                }
                gridcheck = FALSE;
            }
            else if(llList2String(n,0) == "GRIDNAME")
            {
                grid = llList2String(n,1);
                llOwnerSay("Welcome to " + grid);
            }
        }
    }
}