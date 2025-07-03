//MRM:C#
using OpenSim.Region.OptionalModules.Scripting.Minimodule;

namespace OpenSim{
   class MiniModule : MRMBase
   {
      public override void Start()
        {
            Host.Object.Say("Starting up script...(MRM)");
            Host.Object.OnTouch += OnTouched;
            Host.Object.Text = "MRM : Say Creator and Owner";
        }
        
       void OnTouched(IObject sender, TouchEventArgs e)
       {
           Host.Object.Say("I was Created by : " + Host.Object.CreatorID);
           Host.Object.Say("My Owner is      : " + Host.Object.OwnerID);
        }

        public override void Stop() { }
   }
}