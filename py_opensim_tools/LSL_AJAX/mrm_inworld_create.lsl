//MRM:C#
using System;
using OpenMetaverse;
using OpenSim.Region.OptionalModules.Scripting.Minimodule;

namespace OpenSim{
   class MiniModule : MRMBase
   {    
    private Vector3 new_pos = new Vector3(0.0f,0.0f,0.0f);   
    private Vector3 dftl_scale = new Vector3(0.5f,0.5f,0.5f);

      public override void Start()
        {
            Host.Object.Say("Starting up script...(MRM)");
            Host.Object.OnTouch += OnTouched;
            Host.Object.Text = "MRM : touch to create an Object";
        }
               
       void OnTouched(IObject sender, TouchEventArgs e)
       {
           Host.Object.Say("Creating a new Object...");
           new_pos = Host.Object.WorldPosition;
           new_pos.Z += 1.0F;
           IObject newobj = World.Objects.Create(new_pos);
           
           //Important, as new Object is created with Size 0...
           newobj.Scale = dftl_scale;
          
        }
        public override void Stop() { }
   }
}
//Important, as new Object is created with Size 0...
newobj.Scale = dftl_scale;