using System;
using System.IO;
using System.Collections.Generic;
using System.Text;
using OpenMetaverse;

//c#
// displays the contents of an RSS 2.0 feed

public class rssfeed
{
	string URL = “http://robsmart.co.uk/feed”;
	System.Xml.XmlDocument xDoc = new System.Xml.XmlDocument();
	LSL_Types.LSLString requestID;

	public void default_event_state_entry()
	{
		llSay(0,”RSS reader current Feed is ” + URL);
		getFeedContent();
	}

	public void getFeedContent()
	{
		requestID = llHTTPRequest(URL, new LSL_Types.list(), “” );
	}

	public void default_event_touch_start(LSL_Types.LSLInteger total_number)
	{
		// read out the RSS feed.
		displayFeed();
	}

	public void displayFeed()
	{
		System.Xml.XmlNodeList items = xDoc.GetElementsByTagName(“item”);

		for(int i=0;i < items.Count ; i++)
		{
			string title = items[i].SelectSingleNode(“title”).InnerXml;
			string link = items[i].SelectSingleNode(“link”).InnerXml;
			string description=”no description available”;

		if(items[i].SelectSingleNode(“description”)!=null)
			description = items[i].SelectSingleNode(“description”).InnerXml;

			llSay(0,title + “\n” + description + “\n”);
		}
	}

	public void default_event_http_response(LSL_Types.LSLString request_id, LSL_Types.LSLInteger status, 		LSL_Types.list metadata, LSL_Types.LSLString body)
		{
		if (requestID == request_id)
		{
			// store the xml
			xDoc.LoadXml(body);

			// process the xml
			llOwnerSay(“loaded feed”);
		}
		}
}