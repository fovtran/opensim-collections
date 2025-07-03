//MRM:C#
using OpenSim.Region.OptionalModules.Scripting.Minimodule;

namespace OpenSim{
   class MiniModule : MRMBase
   {
      public override void Start()
        {
            Host.Object.Say("Starting script...(MRM)");
            Host.Object.OnTouch += OnTouched;
            Host.Object.Text = "MRM : show Args deliverd by touch event..";
        }
                
       void OnTouched(IObject sender, TouchEventArgs e)
       {
           Host.Object.Say("TouchEventArgs :\n");
           Host.Object.Say(e.Avatar.Name + " " + e.Avatar.WorldPosition);
           Host.Object.Say("BiNormal : " + e.TouchBiNormal);
           Host.Object.Say("MaterialIndex : " + e.TouchMaterialIndex);
           Host.Object.Say("Normal : " + e.TouchNormal);
           Host.Object.Say("Position : " + e.TouchPosition);
           Host.Object.Say("TouchST : " + e.TouchST);
           Host.Object.Say("TouchUV : " + e.TouchUV);
        }

        public override void Stop() {}
   }
}