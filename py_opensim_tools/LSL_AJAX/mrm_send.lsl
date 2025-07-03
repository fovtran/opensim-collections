/*
OpenSim.ini Settings
{L_CODE}:
[MRM]
     Enabled = true
     Sandboxed = false   ; default true
     SandboxLevel = "Internet"
     OwnerOnly = true
*/
//MRM:C#
using OpenSim.Region.OptionalModules.Scripting.Minimodule;

namespace OpenSim{
   class MiniModule : MRMBase
   {
      int chan = 9299;
      public override void Start()
        {   
            Host.Object.OnTouch += OnTouched;
            Host.Object.Say("Starting up script....(MRM)"); 
            Host.Object.Text = "MRM: Touch to make Object talk on channel " + chan;  
        }

      void OnTouched(IObject sender, TouchEventArgs e) { Host.Object.Say("Hello, I was Touched!",chan); }
      public override void Stop() {}   
   }
} 