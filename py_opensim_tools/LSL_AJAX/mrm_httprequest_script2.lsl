//MRM:C#
using System.Xml;
using OpenSim.Region.OptionalModules.Scripting.Minimodule;
using OpenMetaverse;

namespace OpenSim{
   class MiniModule : MRMBase
   {
      public override void Start() { Host.Object.OnTouch += OnTouched; Host.Object.Say("(MRM) Script ready."); }
   
      void OnTouched(IObject sender, TouchEventArgs e)
        {          
           try
            {
                // Retrieve XML document  
                XmlTextReader reader = new XmlTextReader("http://www.nanonull.com/TimeService/TimeService.asmx/getCityTime?city=London");  
                // Skip non-significant whitespace  
                reader.WhitespaceHandling = WhitespaceHandling.Significant;  
                reader.MoveToContent();
                Host.Object.Say(reader.ReadElementString("string"));
            }
            catch (XmlException) { Host.Object.Say("Exception occured"); }                                             
        }

      public override void Stop() { }  
   }   
} 