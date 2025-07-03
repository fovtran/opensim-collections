//c# justincc's short test script
string message = "Hello avatar!";
string xml = "<tag>ribbit</tag>";
public void default_event_state_entry() { llSay(0, message); }
public void default_event_touch_start( LSL_Types.LSLInteger total_number) 
{
    System.IO.StringReader sr = new System.IO.StringReader(xml);
    System.Xml.XmlTextReader reader = new System.Xml.XmlTextReader(sr);
    llSay(0, reader.ReadElementString("tag"));
}